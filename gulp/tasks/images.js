var gulp = require('gulp');
var plumber = require('gulp-plumber');
var imagemin = require('gulp-imagemin');
var newer = require('gulp-newer');
var logger = require('gulp-logger');
var del = require('del');
var handleErrors = require('../lib/handleErrors');
var project = require('../lib/project')();
var config = require('../config.'+project+'.js').images;

// 图片构建
gulp.task('images', function() {
    return gulp.src(config.src)
        .pipe(plumber(handleErrors))
        .pipe(newer(config.dest))
        .pipe(logger({ showChange: true }))
        // 压缩图片
        .pipe(imagemin())
        .pipe(gulp.dest(config.dest));
});

// 图片构建-build版本
gulp.task('build:images', ['images']);

// 清理图片
gulp.task('clean:images', function() {
    return del([
        config.dest
    ], { force: true });
});
