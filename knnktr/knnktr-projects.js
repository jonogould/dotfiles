#!/usr/bin/env node

// knnktr projects
var program = require('commander');
var prompt = require('prompt');
var color = require("ansi-color").set;
var shell = require('shelljs');
var _ = require('underscore');
var fs = require('fs');
var directories = [];
var clients = [];
var success = false;
var ls;

program
  .version('0.0.1')
  .parse(process.argv);

process.on('exit', function () {
	if (success === false) {
		console.log('as you were...');
		process.exit(1);
	}
});

// config
var HOME = shell.exec('echo $HOME', {silent:true}).output.replace(/\n/, '');
var projectsDir = HOME + '/knnktr';

shell.cd(projectsDir);

shell.ls().forEach(function (dir) {
	if (dir !== 'archive') {
		var projectDir = projectsDir + '/' + dir;
		try {
			var packageInfo = fs.readFileSync(projectDir + '/package.json', 'utf8');
			var path = projectDir;
			captureInfo(JSON.parse(packageInfo), path);
		} catch (e) {
			// ...
		}
	}
});

function captureInfo(packageInfo, path) {
	if ( ! packageInfo.client ) return;
	var label = packageInfo.name;
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

logProjects();
