var pkg = require('./package.json'),
	gruntConfig = {
		pkg: pkg,
		watch: {
			styles: {
				files: pkg.sassPath + '/*.scss',
				tasks: ['compass:watch']
			},
		},
		compass: {
			watch: {
				options: {
					sassDir: pkg.sassPath,
					cssDir: pkg.cssPath,
					imagesDir: pkg.imgPath,
					outputStyle: 'expanded',
					noLineComments: false,
					environment: 'development',
					debugInfo: true,
					relativeAssets: true
				}
			},
			dev: {
				options: {
					sassDir: pkg.sassPath,
					cssDir: pkg.cssPath,
					imagesDir: pkg.imgPath,
					outputStyle: 'expanded',
					noLineComments: false,
					environment: 'development',
					debugInfo: true,
					relativeAssets: true,
					force: true
				}
			},
			prod: {
				options: {
					sassDir: pkg.sassPath,
					cssDir: pkg.cssPath + '/buid',
					imagesDir: pkg.imgPath,
					outputStyle: 'compressed',
					noLineComments: true,
					environment: 'production',
					relativeAssets: true,
					force: true
				}
			}
		}
	};

module.exports = function(grunt) {
	grunt.initConfig(gruntConfig);
	grunt.loadNpmTasks('grunt-contrib-compass');
	grunt.loadNpmTasks('grunt-contrib-clean');
	grunt.loadNpmTasks('grunt-contrib-jshint');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.registerTask('default', 'watch');
	grunt.registerTask('compile', ['compass:dev', 'clean']);
	grunt.registerTask('release', ['cssmin', 'uglify', 'compass:prod', 'clean']);
};