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
	;

// reads package.json in current directory
try {
	var packageInfo = fs.readFileSync(shell.pwd() + '/package.json', 'utf8')
		, data = JSON.parse(packageInfo);

	//var msg = (data.client + ' - ' + data.name).replace(/./gi, '-');

	console.log(color('λ ', 'yellow') + color(data.client, 'blue') + ' - ' + color(data.label, 'red'));
	//shell.exec('git status');
	//console.log(msg);
} catch(e) {
	// um...
}
