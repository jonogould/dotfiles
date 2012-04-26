#!/usr/bin/env node

var program = require('commander');
var color = require("ansi-color").set;

program
  .version('0.0.1')
  .parse(process.argv);

                                                              
// ascii madness
console.log('    _/                            _/        _/                ');
console.log('   _/  _/    _/_/_/    _/_/_/    _/  _/  _/_/_/_/  _/  _/_/   ');
console.log('  _/_/      _/    _/  _/    _/  _/_/      _/      _/_/        ');
console.log(' _/  _/    _/    _/  _/    _/  _/  _/    _/      _/           ');
console.log('_/    _/  _/    _/  _/    _/  _/    _/    _/_/  _/            ');

console.log(color('knnktr commands', 'red'));
console.log('  ' + color('kp', 'blue') + '      knnktr projects');
console.log('  ' + color('kk', 'blue') + '      return to current project root directory');
console.log('  ' + color('kn', 'blue') + '      TODO: create a new project');

console.log(color('project tools', 'red'));
console.log('  ' + color('build', 'blue') + '   runs make in project root directory');
console.log('  ' + color('deploy', 'blue') + '  runs deploy script in root directory');

console.log(color('project aliases', 'red'));
console.log('  ' + color('css', 'blue') + '     css directory');
console.log('  ' + color('img', 'blue') + '     images directory');
console.log('  ' + color('js', 'blue') + '      javascript directory');
