var gulp = require('gulp');


module.exports = function(){
    var project = 'dev';
    if(gulp.env){
        if(gulp.env.test){
            project = 'test'
        }else if(gulp.env.rc){
            project = 'rc'
        }else if(gulp.env.deploy){
            project = 'deploy'
        }
    }
    return project
}


