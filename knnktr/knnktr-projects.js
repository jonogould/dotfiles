#!/usr/bin/env node

var program = require('commander');

program
  .version('0.0.1')
  .parse(process.argv);

// knnktr projects

var prompt = require('prompt')
	, color = require("ansi-color").set
	, shell = require('shelljs')
	, _ = require('underscore')
	, fs = require('fs')
	, directories = []
	, clients = []
	, success = false
	, ls
	;

process.on('exit', function () {
	if (success === false) {
		console.log('as you were...');
		process.exit(1);
	}
});

// config
var HOME = shell.exec('echo $HOME', {silent:true}).output.replace(/\n/, '')
	, projectsDir = HOME + '/knnktr';

shell.cd(projectsDir);

shell.ls().forEach(function (dir) {
	var projectDir = projectsDir + '/' + dir;
	try {
		var packageInfo = fs.readFileSync(projectDir + '/package.json', 'utf8')
			, path = projectDir;
		captureInfo(JSON.parse(packageInfo), path);
	} catch (e) {
	}
});

logProjects();

function captureInfo(packageInfo, path) {
	if ( ! packageInfo.client ) return;
	var label = packageInfo.label || packageInfo.name;
	var search = _.filter(clients, function(client){ return client.name === packageInfo.client; });
	if (search.length !== 1) {
		clients.push({name: packageInfo.client, projects: [{name: label, path: path}]});
	} else {
		search[0].projects.push({name: label, path: path});
	}
}

function logProjects() {
	var i = 0;
	//console.log('knnktr projects');
	_.each(clients, function (client) {
		console.log(color(client.name, 'blue'));
		_.each(client.projects, function (project) {
			console.log('  ' + color(i, 'red') + ' - ' + color(project.name, 'bold'));
			// save id's
			directories[i] = project.path;
			i++;
		});
	});
	ask();
}

function ask() {
	var args = [
		{
			name: 'project', 
			validator: /^[0-9]+$/,
			warning: 'Numbers only',
			empty: false
		}
	];
	prompt.start();
	prompt.get(args, function (err, result) {
		if (err) throw err;
		var dir = directories[result.project]
			, TEMP = HOME + '/.dotfiles/knnktr/.env'; 
		try {
			shell.rm(TEMP);
		} catch (e) {
		}
		fs.writeFileSync(TEMP, dir, 'utf8');
		success = true;
		process.exit(0);
	})
}
