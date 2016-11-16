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
    crypto = require('crypto'),
    clean = require('gulp-clean'),
    spriter = require('gulp-css-spriter'),
    spritesmith = require('gulp.spritesmith'),
    base64 = require('gulp-css-base64'),
    fs = require('fs'),
    path = require('path'),
    webpack = require('webpack'),
    plumber = require('gulp-plumber'),
    webpackConfig = require('./webpack.config.js');

var _versonConfig = JSON.parse(fs.readFileSync(path.join(__dirname, 'verson.json')));
var VERSON = _versonConfig.verson;
var templatePath = 'E:/project/vvic/branches/website/'+VERSON+'/vvic-control/src/main/webapp';

var paths = {
    less: 'src/less/*.less',
    css: 'dist/css/*.css',
    sprite: 'src/sprite',
    template: 'src/template/view/**/**/*.jsp'
};

var toMd5 = function(text) {
    return crypto.createHash('md5').update(text).digest('hex');
};

// Task sprite
var _time_sprite;
gulp.task('sprite', function() {
    if (_time_sprite) {
        clearTimeout(_time_sprite);
    }
    _time_sprite = setTimeout(function() {
        var dirs = fs.readdirSync(path.join(__dirname, paths.sprite));
        dirs.forEach(function(dir) {
            if (dir.indexOf('.') === 0) {
                return;
            }
            var pngPatn = path.join(__dirname, paths.sprite, dir);
            var stat = fs.statSync(pngPatn);
            if (stat.isDirectory()) {
                var pngPath = path.join(__dirname, 'dist/css/img/sp_' + dir + '.png');
                var srcPath = path.join(__dirname, paths.sprite + '/' + dir);
                var _buildPng = function(has) {
                    var _has = has ? has : toMd5(srcPath).substring(2, 10);
                    return gulp.src(path.join(__dirname, paths.sprite + '/' + dir + '/*.png')).pipe(spritesmith({
                        // engine:'pngsmith',
                        algorithm: 'binary-tree',
                        padding: 5,
                        imgName: 'sp_' + dir + '.png',
                        cssName: dir + '.less',
                        imgPath: 'img/sp_' + dir + '.png?_' + _has,
                        cssFormat: 'css',
                        cssOpts: {
                            cssSelector: function(item) {
                                return '.icon-' + dir + '-' + item.name + '()';
                            }
                        }
                    }));
                };
                //雪碧图png文件是否存在的判断
                var _isPng = fs.existsSync(pngPath);
                if (_isPng) {
                    var pngSource = fs.readFileSync(pngPath);
                    var pngHas = toMd5(pngSource).substring(2, 10);
                }
                var spriteData = pngHas ? _buildPng(pngHas) : _buildPng();
                spriteData.img.pipe(gulp.dest('dist/css/img'));
                spriteData.css.pipe(gulp.dest('src/less/sp'));
            }
        });
    }, 200);
});

//压缩合并css, css中既有自己写的.less, 也有引入第三方库的.css
var _time_less;
gulp.task('lessmin', function (done) {
    if(_time_less){
        clearTimeout(_time_less)
    }
    _time_less = setTimeout(function(){
        gulp.src([path.join(__dirname,'src/less/*.less'), '!'+path.join(__dirname, 'src/less/_*.less')])
            .pipe(plumber())
            .pipe(less({
                compress: true,
                paths: [path.join(__dirname, 'css', 'less')]
            }))
            //这里可以加css sprite 让每一个css合并为一个雪碧图
            //.pipe(spriter({}))
            .pipe(gulp.dest(path.join(__dirname, 'dist/css')))
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
        .pipe(md5(10, path.join(templatePath, 'WEB-INF/view/**/*.jsp')))
        .pipe(gulp.dest('dist/js'))
        .on('end', done);
});

//将css加上10位md5，并修改html中的引用路径，该动作依赖sprite
gulp.task('md5:css', ['lessmin'], function (done) {
    gulp.src('dist/css/*.css')
        .pipe(md5(10, path.join(templatePath, 'WEB-INF/view/**/*.jsp')))
        .pipe(gulp.dest('dist/css'))
        .on('end', done);
});

gulp.task('clean', function (done) {
    gulp.src(['dist/css/*.css', 'dist/js', 'dist/view'])
        .pipe(clean())
        .on('end', done);
});

gulp.task('watch', function (done) {
    // gulp.watch(paths.script, ['build-js']);
    gulp.watch(path.join(__dirname, paths.sprite + '/**/*.png'), ['sprite']);
    gulp.watch(path.join(__dirname, paths.less), ['lessmin']);
    gulp.watch(paths.template, function(event, a){
        var _file = event.path;
        var _fileName = _file.split('template\\view\\')[1];
        var _dir = '';
        if(_fileName.indexOf('\\')!=-1){
            _dir = _fileName.split('\\')[0];
            _fileName = _fileName.split('\\')[1];
        }
        gulp.src(_file)
            .pipe(gulp.dest('dist/view/' + _dir))
            .on('end', function() {
                console.log('File ' + _fileName + ' was ' + event.type + ', copy file success');
            })
    });
});

var myDevConfig = Object.create(webpackConfig);

var devCompiler = webpack(myDevConfig);

//引用webpack对js进行操作
gulp.task("js", function(callback) {
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
            .pipe(gulp.dest(path.join(templatePath, 'WEB-INF/view')))
            .on('end', function() {
                console.log('copy files');
            })
    }, 400);
});

//发布
gulp.task('default', ['clean', 'sprite', 'template', 'md5:css', 'md5:js']);

//开发
gulp.task('dev', ['sprite', 'lessmin', 'template', 'js', 'watch']);
