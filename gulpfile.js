/**
 Gulpfile for gulp-webpack-demo
 created by fwon
*/

var gulp = require('gulp'),
    os = require('os'),
    gutil = require('gulp-util'),
    less = require('gulp-less'),
    concat = require('gulp-concat'),
    uglify = require('gulp-uglify'),
    cssmin = require('gulp-cssmin'),
    md5 = require('gulp-md5-plus'),
    clean = require('gulp-clean'),
    spriter = require('gulp-css-spriter'),
    base64 = require('gulp-css-base64'),
    fs = require('fs'),
    path = require('path'),
    webpack = require('webpack'),
    plumber = require('gulp-plumber'),
    webpackConfig = require('./webpack.config.js');

//配置文件
var _versonConfig = JSON.parse(fs.readFileSync(path.join(__dirname, 'verson.json')));
var VERSON = _versonConfig.verson;
var build_path = 'E:/project/vvic/branches/website/'+VERSON+'/vvic-frontend/statics/build/v3';
// var push_path = 'E:/project/vvic/branches/website/'+VERSON+'/vvic-control/src/main/webapp';
var push_path = 'E:/project/vvic/branches/website/'+VERSON+'/vvic-frontend/statics/v3';
var paths = {
    less: 'less/*.less',
    css: '../../v3/css/*.css',
    sprite: 'sprite',
    script: [path.join(build_path, 'js/src/**/*.js'), path.join(build_path, 'js/config.json'), path.join(build_path, 'js/config.dev.json'), path.join(build_path, 'js/path.json'), path.join(build_path, 'js/shim.json')],
    img: 'img',
    dist: 'js/dist/*.js',
    optimize: 'js/src',
    template: path.join(build_path, 'template/view/**/**/*.jsp')
};


//压缩合并css, css中既有自己写的.less, 也有引入第三方库的.css
var _time_less;
gulp.task('lessmin', function (done) {
    if(_time_less){
        clearTimeout(_time_less)
    }
    _time_less = setTimeout(function(){
        gulp.src([path.join(build_path,'less/*.less'), '!'+path.join(build_path, 'less/_*.less')])
            .pipe(plumber())
            .pipe(less({
                compress: true,
                paths: [path.join(build_path, 'css', 'less')]
            }))
            //这里可以加css sprite 让每一个css合并为一个雪碧图
            //.pipe(spriter({}))
            .pipe(gulp.dest(path.join(build_path, '../../v3/css')))
            .on("end", function() {
                console.log('cssmap');
                done();
                // gulp.start('cssmap');
            });
    }, 400)

});

//将js加上10位md5,并修改html中的引用路径，该动作依赖build-js
gulp.task('md5:js', ['build-js'], function (done) {
    gulp.src('dist/js/*.js')
        .pipe(md5(10, 'dist/app/*.html'))
        .pipe(gulp.dest('dist/js'))
        .on('end', done);
});

//将css加上10位md5，并修改html中的引用路径，该动作依赖sprite
gulp.task('md5:css', ['sprite'], function (done) {
    gulp.src('dist/css/*.css')
        .pipe(md5(10, 'dist/app/*.html'))
        .pipe(gulp.dest('dist/css'))
        .on('end', done);
});

//雪碧图操作，应该先拷贝图片并压缩合并css
gulp.task('sprite', ['lessmin'], function (done) {
    var timestamp = +new Date();
    gulp.src('dist/css/style.min.css')
        .pipe(spriter({
            spriteSheet: 'dist/images/spritesheet' + timestamp + '.png',
            pathToSpriteSheetFromCSS: '../images/spritesheet' + timestamp + '.png',
            spritesmithOptions: {
                padding: 10
            }
        }))
        .pipe(base64())
        .pipe(cssmin())
        .pipe(gulp.dest('dist/css'))
        .on('end', done);
});

gulp.task('clean', function (done) {
    gulp.src(['dist'])
        .pipe(clean())
        .on('end', done);
});

gulp.task('watch', function (done) {
    gulp.watch(paths.script, ['build-js']);
    gulp.watch(path.join(build_path, paths.sprite + '/**/*.png'), ['sprite']);
    gulp.watch(path.join(build_path, paths.less), ['lessmin']);
    gulp.watch(paths.template, function(event, a){
        var _file = event.path;
        var _fileName = _file.split('template\\view\\')[1];
        var _dir = '';
        if(_fileName.indexOf('\\')!=-1){
            _dir = _fileName.split('\\')[0];
            _fileName = _fileName.split('\\')[1];
        }
        gulp.src(_file)
            .pipe(gulp.dest(path.join(push_path, 'WEB-INF', 'view', _dir)))
            // .pipe(gulp.dest(path.join(push_target_path, _dir)))
            .on('end', function() {
                console.log('File ' + _fileName + ' was ' + event.type + ', copy file success');
            })
    });
});

var myDevConfig = Object.create(webpackConfig);

var devCompiler = webpack(myDevConfig);

//引用webpack对js进行操作
gulp.task("build-js", function(callback) {
    devCompiler.run(function(err, stats) {
        if(err) throw new gutil.PluginError("webpack:build-js", err);
        gutil.log("[webpack:build-js]", stats.toString({
            colors: true
        }));
        callback();
    });
});

// 模板复制
var _time_template
gulp.task('template', function() {
    if (_time_template) {
        clearTimeout(_time_template)
    }
    _time_template = setTimeout(function() {
        gulp.src(paths.template)
            .pipe(gulp.dest(path.join(push_path, 'WEB-INF', 'view')))
            .on('end', function() {
                console.log('copy files');
            })
    }, 400);
});

//发布
gulp.task('default', ['md5:css', 'md5:js', 'template']);

//开发
gulp.task('dev', ['copy:images', 'lessmin', 'build-js', 'template', 'watch']);
