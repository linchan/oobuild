var gulp = require('gulp');
var path = require('path');
var less = require('gulp-less');
var plumber = require('gulp-plumber');
var newer = require('gulp-newer');
var logger = require('gulp-logger');
var del = require('del');
var handleErrors = require('../lib/handleErrors');
var project = require('../lib/project')();
var config = require('../config.'+ project + '.js').css;


gulp.task('css', function() {
    gulp.src(config.src)
        .pipe(plumber())
        .pipe(logger({ showChange: true }))
        .pipe(less({
            compress: true
        }))
        //.pipe(minifycss({keepBreaks:false})) //keepBreaks:false,则为CSS不换行
        .pipe(gulp.dest(config.dest))
});


gulp.task('clean:css', function(){
    return del([
        config.dest + '/*.css'
    ], { force: true });
})
