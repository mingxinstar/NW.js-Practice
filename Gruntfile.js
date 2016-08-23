'use strict';

const readline = require('readline');
const rl = readline.createInterface({
    input : process.stdin,
    output : process.stdout
});

module.exports = function(grunt) {
    console.log('----------start grunt task----------');

    let pkg = grunt.file.readJSON('package.json');

    grunt.initConfig({
        replace : {
            version : {
                src : ['app/package.json', 'exeConfig.conf', 'updater.json'],
                overwrite : true,
                replacements : [{
                    from : /\d{1,2}[,|\.]\d{1,2}[,|\.]\d{1,2}[,|\.]\d{1,2}/g,
                    to : matchedWord => {
                        if (matchedWord.indexOf(',') > -1) {
                            return pkg.version.replace(/\./g, ',');
                        } else {
                            return pkg.version;
                        }
                    }
                }]
            }
        },
        shell : {
            start : {
                command : [
                    'cd app',
                    'nw.exe .'
                ].join('&&')
            },
            updateProject : {
                command : [
                    'git checkout .',
                    'git checkout master',
                    'git pull origin master'
                ].join('&&')
            },
            updateVersion : {
                command : 'ResourceHacker.exe -script E:/Workspace/MeMe-RIA/updateExeInfo.txt'
            },
            clearExe : {
                command : [
                    'cd build/Practice/win32',
                    'rm Practice.exe',
                    'mv Practice_new.exe Practice.exe'
                ].join('&&')
            },
            clearExeCMD : {
                command : [
                    'cd build/Practice/win32',
                    'del Practice.exe',
                    'move Practice_new.exe Practice.exe'
                ].join('&&')
            },
            clearChanged : {
                command : 'git checkout .'
            }
        },
        nwjs: {
            options: {
                version : '0.14.7',
                buildDir: './build', // Where the build version of my NW.js app is saved
                winIco: './app/icons/icon-32.ico', // Path to the Mac icon file
                platforms: ['win32'], // These are the platforms that we want to build
                appName : 'Practice',
                appVersion : pkg.version
            },
            src : ['./app/**/**/**/**/**/**/**/**/*']
        }
    });

    grunt.loadNpmTasks('grunt-text-replace');
    grunt.loadNpmTasks('grunt-nw-builder');
    grunt.loadNpmTasks('grunt-shell');

    let froms = [];

    function runBuild () {
        for (let i = 0; i < froms.length; i++) {
            let currFrom = froms[i];
            currFrom = currFrom === 'ria' ? currFrom : `ria_${currFrom}`;

            grunt.config.set(`replace.from_${currFrom}`, {
                src : ['app/scripts/config.js'],
                overwrite : true,
                replacements : [{
                    from : /ria\w*/g,
                    to : currFrom
                }]
            });

            grunt.config.set(`shell.nsis_${currFrom}`, {
                command : `makensis /Dversion="${pkg.version}" /Dfrom="${currFrom}" E:/Workspace/MeMe-RIA/install.nsi`
            });

            grunt.task.run(['replace:version', `replace:from_${currFrom}`, 'nwjs', 'shell:updateVersion', 'shell:clearExeCMD', `shell:nsis_${currFrom}`]);
        }
    }

    grunt.registerTask('ask', 'ask for from', function () {
        let done = this.async();

        rl.question('请输入渠道号，多个渠道请用,（英文逗号）进行分割: ', answer => {
            froms = answer ? answer.split(',') : ['ria'];

            grunt.log.writeln(froms);

            rl.close();

            grunt.task.run('shell:updateProject');

            runBuild();

            done();
        });
    });

    grunt.registerTask('start', ['replace', 'shell:start']);
    grunt.registerTask('build', ['shell:updateProject', 'ask']);
    grunt.registerTask('default', ['ask']);
};
