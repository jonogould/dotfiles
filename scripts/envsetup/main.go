// Command envsetup interactively fills a dotfiles .env file with a styled TUI.
//
// It parses variable names and placeholder defaults from a .env.example
// template, loads any existing values from the current .env, walks the user
// through each value in a Bubble Tea wizard (masking secret-looking keys), and
// writes the result back to .env atomically with 0600 permissions.
//
// It is invoked by install.sh after the matching prebuilt binary is fetched.
// Interaction happens over /dev/tty so it works even under `bash -c
// "$(curl ...)"`, where stdin is the curl pipe rather than the user's terminal.
//
// Exit codes:
//
//	0  success (.env written)
//	2  non-interactive: /dev/tty could not be opened (caller should fall back)
//	1  any other error or user cancel
package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"charm.land/bubbles/v2/progress"
	"charm.land/bubbles/v2/textinput"
	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"
)

// exitNonInteractive is the reserved code the bash caller checks to decide
// whether to fall back to the plain template copy.
const exitNonInteractive = 2

// envVar is one parsed entry from the .env.example template.
type envVar struct {
	key          string
	defaultValue string // placeholder from .env.example (quotes stripped)
}

func main() {
	examplePath, envPath := resolvePaths()

	vars, header, err := parseTemplate(examplePath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "envsetup: cannot read %s: %v\n", examplePath, err)
		os.Exit(1)
	}
	if len(vars) == 0 {
		fmt.Fprintf(os.Stderr, "envsetup: no variables found in %s\n", examplePath)
		os.Exit(1)
	}

	existing := parseExisting(envPath)

	// All interaction happens over /dev/tty; bail to the reserved code if we
	// cannot open it (CI / non-interactive) so the caller can fall back.
	tty, err := os.OpenFile("/dev/tty", os.O_RDWR, 0)
	if err != nil {
		fmt.Fprintln(os.Stderr, "envsetup: /dev/tty unavailable; skipping interactive setup")
		os.Exit(exitNonInteractive)
	}
	defer tty.Close()

	prog := tea.NewProgram(
		newModel(vars, header, envPath, existing),
		tea.WithInput(tty),
		tea.WithOutput(tty),
	)

	final, err := prog.Run()
	if err != nil {
		fmt.Fprintf(os.Stderr, "envsetup: %v\n", err)
		os.Exit(1)
	}

	m := final.(model)
	switch {
	case m.err != nil:
		fmt.Fprintf(os.Stderr, "envsetup: %v\n", m.err)
		os.Exit(1)
	case m.canceled:
		fmt.Fprintln(os.Stderr, "envsetup: canceled")
		os.Exit(1)
	}
}

// ---------------------------------------------------------------------------
// TUI model
// ---------------------------------------------------------------------------

type viewState int

const (
	stateInput viewState = iota
	stateReview
	stateDone
)

type model struct {
	vars     []envVar
	header   string
	envPath  string
	inputs   []textinput.Model
	secret   []bool
	index    int
	state    viewState
	progress progress.Model
	styles   styles
	width    int
	isDark   bool
	canceled bool
	err      error
}

func newModel(vars []envVar, header, envPath string, existing map[string]string) model {
	inputs := make([]textinput.Model, len(vars))
	secret := make([]bool, len(vars))

	for i, v := range vars {
		ti := textinput.New()
		ti.Prompt = "› "
		ti.SetVirtualCursor(true)
		ti.SetWidth(48)

		def, ok := existing[v.key]
		if !ok {
			def = v.defaultValue
		}
		ti.SetValue(def)

		if isSecretKey(v.key) {
			secret[i] = true
			ti.EchoMode = textinput.EchoPassword
			ti.EchoCharacter = '•'
			ti.Placeholder = "hidden"
		} else if v.defaultValue != "" {
			ti.Placeholder = v.defaultValue
		}
		inputs[i] = ti
	}

	prog := progress.New(progress.WithDefaultBlend())
	prog.SetWidth(40)

	m := model{
		vars:     vars,
		header:   header,
		envPath:  envPath,
		inputs:   inputs,
		secret:   secret,
		progress: prog,
		isDark:   true, // sensible default until the terminal tells us otherwise
	}
	m.styles = newStyles(m.isDark)
	return m
}

func (m model) Init() tea.Cmd {
	return tea.Batch(tea.RequestBackgroundColor, m.inputs[0].Focus())
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.WindowSizeMsg:
		m.width = msg.Width
		return m, nil

	case tea.BackgroundColorMsg:
		m.isDark = msg.IsDark()
		m.styles = newStyles(m.isDark)
		return m, nil

	case tea.KeyPressMsg:
		switch msg.String() {
		case "ctrl+c", "esc":
			m.canceled = true
			return m, tea.Quit
		}

		switch m.state {
		case stateInput:
			return m.updateInput(msg)
		case stateReview:
			return m.updateReview(msg)
		}
		return m, nil
	}

	// Forward everything else (cursor blink ticks, etc.) to the active input.
	if m.state == stateInput {
		var cmd tea.Cmd
		m.inputs[m.index], cmd = m.inputs[m.index].Update(msg)
		return m, cmd
	}
	return m, nil
}

func (m model) updateInput(msg tea.KeyPressMsg) (tea.Model, tea.Cmd) {
	switch msg.String() {
	case "enter", "tab", "down":
		if m.index < len(m.inputs)-1 {
			m.inputs[m.index].Blur()
			m.index++
			return m, m.inputs[m.index].Focus()
		}
		// Past the last field -> review screen.
		m.inputs[m.index].Blur()
		m.state = stateReview
		return m, nil

	case "shift+tab", "up":
		if m.index > 0 {
			m.inputs[m.index].Blur()
			m.index--
			return m, m.inputs[m.index].Focus()
		}
		return m, nil
	}

	var cmd tea.Cmd
	m.inputs[m.index], cmd = m.inputs[m.index].Update(msg)
	return m, cmd
}

func (m model) updateReview(msg tea.KeyPressMsg) (tea.Model, tea.Cmd) {
	switch msg.String() {
	case "enter":
		if err := writeEnvAtomic(m.envPath, m.header, m.vars, m.values()); err != nil {
			m.err = err
			return m, tea.Quit
		}
		m.state = stateDone
		return m, tea.Quit

	case "shift+tab", "up", "e", "backspace":
		// Back to editing the last field.
		m.state = stateInput
		m.index = len(m.inputs) - 1
		return m, m.inputs[m.index].Focus()
	}
	return m, nil
}

// values collects the current input values keyed by variable name.
func (m model) values() map[string]string {
	out := make(map[string]string, len(m.vars))
	for i, v := range m.vars {
		out[v.key] = m.inputs[i].Value()
	}
	return out
}

func (m model) View() tea.View {
	switch m.state {
	case stateReview:
		return tea.NewView(m.viewReview())
	case stateDone:
		return tea.NewView(m.viewDone())
	default:
		return tea.NewView(m.viewInput())
	}
}

// ---------------------------------------------------------------------------
// Views
// ---------------------------------------------------------------------------

func (m model) viewInput() string {
	var b strings.Builder
	b.WriteString(m.banner())
	b.WriteString("\n\n")

	pct := float64(m.index) / float64(len(m.vars))
	b.WriteString("  " + m.progress.ViewAs(pct))
	b.WriteString(m.styles.stepInfo.Render(fmt.Sprintf("  step %d of %d", m.index+1, len(m.vars))))
	b.WriteString("\n\n")

	// Key list with status markers.
	for i, v := range m.vars {
		marker := "•"
		labelStyle := m.styles.keyBlurred
		switch {
		case i < m.index:
			marker = "✓"
			labelStyle = m.styles.keyDone
		case i == m.index:
			marker = "›"
			labelStyle = m.styles.keyFocused
		}
		lock := ""
		if m.secret[i] {
			lock = m.styles.lock.Render(" ")
		}
		b.WriteString("  " + labelStyle.Render(marker+" "+v.key) + lock + "\n")
	}
	b.WriteString("\n")

	// Active field box.
	cur := m.vars[m.index]
	hint := "value will be written to .env"
	if m.secret[m.index] {
		hint = "secret — input hidden, stored locally in .env (0600)"
	}
	field := lipgloss.JoinVertical(lipgloss.Left,
		m.styles.fieldLabel.Render(cur.key),
		m.styles.hint.Render(hint),
		m.inputs[m.index].View(),
	)
	b.WriteString(m.styles.fieldBox.Render(field))
	b.WriteString("\n\n")
	b.WriteString(m.styles.footer.Render("enter/↓ next · ↑ back · esc cancel"))
	return m.styles.app.Render(b.String())
}

func (m model) viewReview() string {
	var b strings.Builder
	b.WriteString(m.banner())
	b.WriteString("\n\n")
	b.WriteString(m.styles.reviewTitle.Render("Review"))
	b.WriteString("\n\n")

	for i, v := range m.vars {
		val := m.inputs[i].Value()
		shown := val
		if m.secret[i] {
			shown = maskValue(val)
		}
		if shown == "" {
			shown = m.styles.empty.Render("(empty)")
		} else {
			shown = m.styles.reviewVal.Render(shown)
		}
		b.WriteString("  " + m.styles.reviewKey.Render(v.key) + "  " + shown + "\n")
	}
	b.WriteString("\n")
	b.WriteString(m.styles.footer.Render("enter write .env · ↑/e edit · esc cancel"))
	return m.styles.app.Render(b.String())
}

func (m model) viewDone() string {
	line := m.styles.success.Render("✓ Wrote ") + m.styles.successPath.Render(m.envPath)
	return m.styles.app.Render(m.banner() + "\n\n  " + line + "\n")
}

func (m model) banner() string {
	title := m.styles.title.Render(" dotfiles ")
	sub := m.styles.subtitle.Render(" environment setup ")
	return m.styles.bannerBox.Render(title + sub)
}

// ---------------------------------------------------------------------------
// Styles
// ---------------------------------------------------------------------------

type styles struct {
	app         lipgloss.Style
	bannerBox   lipgloss.Style
	title       lipgloss.Style
	subtitle    lipgloss.Style
	stepInfo    lipgloss.Style
	keyDone     lipgloss.Style
	keyFocused  lipgloss.Style
	keyBlurred  lipgloss.Style
	lock        lipgloss.Style
	fieldBox    lipgloss.Style
	fieldLabel  lipgloss.Style
	hint        lipgloss.Style
	footer      lipgloss.Style
	reviewTitle lipgloss.Style
	reviewKey   lipgloss.Style
	reviewVal   lipgloss.Style
	empty       lipgloss.Style
	success     lipgloss.Style
	successPath lipgloss.Style
}

func newStyles(isDark bool) styles {
	ld := lipgloss.LightDark(isDark)

	primary := lipgloss.Color("#7D56F4")
	accent := lipgloss.Color("#EE6FF8")
	green := lipgloss.Color("#04B575")
	fg := ld(lipgloss.Color("#1A1A1A"), lipgloss.Color("#FAFAFA"))
	muted := ld(lipgloss.Color("#6C6C6C"), lipgloss.Color("#9B9B9B"))
	faint := ld(lipgloss.Color("#9B9B9B"), lipgloss.Color("#626262"))

	return styles{
		app:       lipgloss.NewStyle().Padding(1, 2),
		bannerBox: lipgloss.NewStyle(),
		title: lipgloss.NewStyle().
			Bold(true).
			Foreground(lipgloss.Color("#FFFFFF")).
			Background(primary),
		subtitle: lipgloss.NewStyle().
			Foreground(lipgloss.Color("#FFFFFF")).
			Background(accent),
		stepInfo:   lipgloss.NewStyle().Foreground(muted),
		keyDone:    lipgloss.NewStyle().Foreground(green),
		keyFocused: lipgloss.NewStyle().Bold(true).Foreground(accent),
		keyBlurred: lipgloss.NewStyle().Foreground(faint),
		lock:       lipgloss.NewStyle().Foreground(muted),
		fieldBox: lipgloss.NewStyle().
			Border(lipgloss.RoundedBorder()).
			BorderForeground(primary).
			Padding(0, 1).
			MarginLeft(2),
		fieldLabel:  lipgloss.NewStyle().Bold(true).Foreground(fg),
		hint:        lipgloss.NewStyle().Italic(true).Foreground(muted),
		footer:      lipgloss.NewStyle().Foreground(faint),
		reviewTitle: lipgloss.NewStyle().Bold(true).Foreground(accent),
		reviewKey:   lipgloss.NewStyle().Bold(true).Foreground(fg),
		reviewVal:   lipgloss.NewStyle().Foreground(ld(lipgloss.Color("#3C3C3C"), lipgloss.Color("#DDDDDD"))),
		empty:       lipgloss.NewStyle().Italic(true).Foreground(faint),
		success:     lipgloss.NewStyle().Bold(true).Foreground(green),
		successPath: lipgloss.NewStyle().Foreground(fg),
	}
}

// ---------------------------------------------------------------------------
// Template parsing / writing (unchanged behavior)
// ---------------------------------------------------------------------------

// resolvePaths determines the .env.example and .env paths from args, falling
// back to env vars and then to sensible defaults relative to $DOTFILES.
func resolvePaths() (examplePath, envPath string) {
	args := os.Args[1:]

	if len(args) >= 1 && args[0] != "" {
		examplePath = args[0]
	} else if v := os.Getenv("ENV_EXAMPLE"); v != "" {
		examplePath = v
	}

	if len(args) >= 2 && args[1] != "" {
		envPath = args[1]
	} else if v := os.Getenv("ENV_FILE"); v != "" {
		envPath = v
	}

	base := os.Getenv("DOTFILES")
	if base == "" {
		base = os.Getenv("DOTFILES_DIR")
	}
	if base == "" {
		base = "."
	}
	if examplePath == "" {
		examplePath = filepath.Join(base, ".env.example")
	}
	if envPath == "" {
		envPath = filepath.Join(base, ".env")
	}
	return examplePath, envPath
}

// parseTemplate reads .env.example, returning the ordered variables and the
// leading contiguous comment/blank header (preserved verbatim in the output).
func parseTemplate(path string) (vars []envVar, header string, err error) {
	f, err := os.Open(path)
	if err != nil {
		return nil, "", err
	}
	defer f.Close()

	var headerLines []string
	headerDone := false

	scanner := bufio.NewScanner(f)
	scanner.Buffer(make([]byte, 0, 64*1024), 1024*1024)
	for scanner.Scan() {
		line := scanner.Text()
		key, value, ok := parseAssignment(line)
		if !ok {
			if !headerDone {
				headerLines = append(headerLines, line)
			}
			continue
		}
		headerDone = true
		vars = append(vars, envVar{key: key, defaultValue: value})
	}
	if err := scanner.Err(); err != nil {
		return nil, "", err
	}

	if len(headerLines) > 0 {
		header = strings.Join(headerLines, "\n") + "\n"
	}
	return vars, header, nil
}

// parseExisting loads KEY=value pairs from an existing .env (if present) so
// current values can be offered as defaults. Missing file -> empty map.
func parseExisting(path string) map[string]string {
	out := make(map[string]string)
	f, err := os.Open(path)
	if err != nil {
		return out
	}
	defer f.Close()

	scanner := bufio.NewScanner(f)
	scanner.Buffer(make([]byte, 0, 64*1024), 1024*1024)
	for scanner.Scan() {
		if key, value, ok := parseAssignment(scanner.Text()); ok {
			out[key] = value
		}
	}
	return out
}

// parseAssignment parses a single line of an env file. It handles optional
// `export ` prefixes, leading whitespace, and surrounding quotes on the value.
// It returns ok=false for blank lines and comments.
func parseAssignment(line string) (key, value string, ok bool) {
	trimmed := strings.TrimSpace(line)
	if trimmed == "" || strings.HasPrefix(trimmed, "#") {
		return "", "", false
	}
	trimmed = strings.TrimPrefix(trimmed, "export ")
	trimmed = strings.TrimSpace(trimmed)

	idx := strings.IndexByte(trimmed, '=')
	if idx <= 0 {
		return "", "", false
	}
	key = strings.TrimSpace(trimmed[:idx])
	if key == "" {
		return "", "", false
	}
	value = stripQuotes(strings.TrimSpace(trimmed[idx+1:]))
	return key, value, true
}

// stripQuotes removes one layer of matching surrounding single or double quotes.
func stripQuotes(s string) string {
	if len(s) >= 2 {
		if (s[0] == '"' && s[len(s)-1] == '"') || (s[0] == '\'' && s[len(s)-1] == '\'') {
			return s[1 : len(s)-1]
		}
	}
	return s
}

// isSecretKey reports whether a key name looks like it holds a secret.
func isSecretKey(key string) bool {
	upper := strings.ToUpper(key)
	for _, needle := range []string{"TOKEN", "KEY", "SECRET", "PASSWORD", "PAT"} {
		if strings.Contains(upper, needle) {
			return true
		}
	}
	return false
}

// maskValue renders an existing secret value for display, never in cleartext.
func maskValue(v string) string {
	switch {
	case v == "":
		return ""
	case len(v) <= 4:
		return "set"
	default:
		return "****" + v[len(v)-4:]
	}
}

// writeEnvAtomic writes the .env to a temp file in the same directory then
// renames it over the destination, so readers never see a partial file. The
// file is created 0600 because it holds secrets.
func writeEnvAtomic(envPath, header string, vars []envVar, values map[string]string) error {
	dir := filepath.Dir(envPath)

	tmp, err := os.CreateTemp(dir, ".env.tmp-*")
	if err != nil {
		return err
	}
	tmpName := tmp.Name()
	defer func() {
		if tmpName != "" {
			_ = os.Remove(tmpName)
		}
	}()

	if err := tmp.Chmod(0o600); err != nil {
		tmp.Close()
		return err
	}

	w := bufio.NewWriter(tmp)
	if header != "" {
		if _, err := w.WriteString(header); err != nil {
			tmp.Close()
			return err
		}
	}
	for _, v := range vars {
		if _, err := fmt.Fprintf(w, "export %s=\"%s\"\n", v.key, values[v.key]); err != nil {
			tmp.Close()
			return err
		}
	}
	if err := w.Flush(); err != nil {
		tmp.Close()
		return err
	}
	if err := tmp.Close(); err != nil {
		return err
	}

	if err := os.Rename(tmpName, envPath); err != nil {
		return err
	}
	tmpName = ""
	return nil
}
