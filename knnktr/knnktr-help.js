#!/usr/bin/env node

var program = require('commander');
var color = require("ansi-color").set;

program
  .version('0.0.1')
  .parse(process.argv);

var log = console.log;

// ascii madness
log('    _/                            _/        _/                ');
log('   _/  _/    _/_/_/    _/_/_/    _/  _/  _/_/_/_/  _/  _/_/   ');
log('  _/_/      _/    _/  _/    _/  _/_/      _/      _/_/        ');
log(' _/  _/    _/    _/  _/    _/  _/  _/    _/      _/           ');
log('_/    _/  _/    _/  _/    _/  _/    _/    _/_/  _/            ');

log(color('knnktr commands', 'red'));
log('  ' + color('kp', 'blue') + '      knnktr projects');
//log('  ' + color('kn', 'blue') + '      TODO: create a new project');

log(color('project tools', 'red'));
log('  ' + color('build', 'blue') + '   runs make in project root directory');
log('  ' + color('deploy', 'blue') + '  runs deploy script in root directory');

log(color('project aliases', 'red'));
log('  ' + color('kk', 'blue') + '      return to current project root directory');
log('  ' + color('gg', 'blue') + '      same as kk');
log('  ' + color('css', 'blue') + '     css directory');
log('  ' + color('img', 'blue') + '     images directory');
log('  ' + color('js', 'blue') + '      javascript directory');
