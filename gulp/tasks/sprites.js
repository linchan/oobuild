// var spritesmith = require('gulp.spritesmith');
// var buffer = require('vinyl-buffer');
// var merge = require('merge2');
var gulp = require('gulp');
var fs = require('fs');
var crypto = require('crypto');
var path = require('path');
var del = require('del');
var spritesmith = require('gulp.spritesmith');
var buffer = require('vinyl-buffer');
var imagemin = require('gulp-imagemin');
var project = require('../lib/project')();
var config = require('../config.'+ project + '.js');
var spriteConfig = config.sprites;
var srcPath = config.srcPath;
var distPath = config.distPath;

var toMd5 = function(text) {
    return crypto.createHash('md5').update(text).digest('hex');
};

var _buildPng = function(spritePath, dir, has) {
    var _has = has ? has : toMd5(spritePath).substring(2, 10);
    return gulp.src(path.join(spritePath, '*.png')).pipe(spritesmith({
        // engine:'pngsmith',
        algorithm: 'binary-tree',
        padding: 5,
        imgName: 'sp_' + dir + '.png',
        cssName: dir + '.less',
        imgPath: 'sp/sp_' + dir + '.png?_' + _has,
        cssFormat: 'css',
        cssOpts: {
            cssSelector: function(item) {
                return '.icon-' + dir + '-' + item.name + '()';
            }
        }
    }));
};

// 构建雪碧图及雪碧图less
gulp.task('sprites', function() {
    var dirs = fs.readdirSync(spriteConfig.src);
    dirs.forEach(function(dir) {
        if (dir.indexOf('.') === 0) {
            return;
        }
        var stat = fs.statSync(path.join(spriteConfig.src, dir));
        if (stat.isDirectory()) {
            var pngPath = path.join(spriteConfig.imgDest, 'sp_' + dir + '.png');
            var spritePath = path.join(spriteConfig.src, dir);
            //雪碧图png文件是否存在的判断
            var _isPng = fs.existsSync(pngPath);
            if (_isPng) {
                var pngSource = fs.readFileSync(pngPath);
                var pngHas = toMd5(pngSource).substring(2, 10);
            }
            var spriteData = pngHas ? _buildPng(spritePath, dir, pngHas) : _buildPng(spritePath, dir);
            spriteData.img.pipe(buffer()).pipe(imagemin()).pipe(gulp.dest(spriteConfig.imgDest));
            spriteData.css.pipe(gulp.dest(spriteConfig.lessDest));
        }
    });
});




// 清理视图文件
gulp.task('clean:sprites', function() {
    return del([
        spriteConfig.lessDest + '/*.less',
        spriteConfig.imgDest + '/*.png'
    ], { force: true });
});
