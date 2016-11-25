var gulp = require('gulp');
// 并行执行clean:sprites，clean:views，clean:webpack
gulp.task('clean', [
    'clean:images',
    'clean:sprites',
    'clean:css',
    'clean:views',
    'clean:webpack'
]);
