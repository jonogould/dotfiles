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

log('                                                     v0.1.1');

log(color('knnktr commands', 'red'));
log('  ' + color('kp', 'blue') + '      list knnktr projects');

log(color('project aliases', 'red'));
log('  ' + color('gg', 'blue') + '      return to current project root directory');
log('  ' + color('build', 'blue') + '   runs make in project root directory');
log('  ' + color('deploy', 'blue') + '  runs deploy script in root directory');
