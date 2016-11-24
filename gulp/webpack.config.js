// 其中定义了getLoaders，getAlias，getPlugins，getPostcss函数
// 都是为了解决development配置和production配置的差异问题
// 既最大程度的复用配置，又允许差异的存在
var webpack = require('webpack');
var path = require('path');
var fs = require('fs');
var project = require('./lib/project')();
var config = require('./config.'+project+'.js').webpack;
var CommonsChunkPlugin = require("webpack/lib/optimize/CommonsChunkPlugin");
var libSrc = config.libSrc;
//获取多页面的每个入口文件，用于配置中的entry
function getEntry() {
    var jsPath = path.join(config.src, 'src');
    var dirs = fs.readdirSync(jsPath);
    var matchs = [], files = {};
    dirs.forEach(function (dir) {
        if(dir.indexOf('.') === 0){
            return;
        }
        var jsFiles = fs.readdirSync(path.join(jsPath, dir))
        jsFiles.forEach(function(item){
            matchs = item.match(/(.+)\.js$/);
            if(matchs){
                files[matchs[1]] = path.join(jsPath, dir, item);
            }
        })
    });
    // console.log(JSON.stringify(files));
    return files;
}


module.exports = function(env){
    return {
        entry: getEntry(),
        output: {
            path: config.jsDest,
            filename: '[name].bundle.js',
            publicPath: "dist/js/",
        },
        resolve: {
            alias: {
                jquery: libSrc + "/jquery/jquery-1.11.1.min",
                'jquery.layer': libSrc + '/jquery.layer/layer.min',
                underscore: libSrc + '/underscore/underscore-min',
                'jquery.lazyload': libSrc + '/jquery.lazyload/jquery.lazyload.min',
                'jquery.validation': libSrc + '/jquery.validation/jquery.validation.min',
                clipboard: libSrc + '/clipboard/clipboard.min',
                'jquery.slide': libSrc + '/jquery.slide/jquery.SuperSlide.2.1.1',
                'jquery.pagination': libSrc + '/jquery.pagination/jquery.pagination.min',
                scrolltofixed: libSrc + '/jquery.scrolltofixed/jquery.scrolltofixed.min',
                "jquery.imagezoom": libSrc + "/jquery.imagezoom/imagezoom.min",
                "jquery.fly": libSrc + "/jquery.fly/jquery.fly.min",
                "jquery.scrolltofixed": libSrc + "/jquery.scrolltofixed/jquery.scrolltofixed.min",
                "jquery.nanoscroller": libSrc + "/jquery.nanoscroller/jquery.nanoscroller.min",
                clipboard: libSrc + '/clipboard.js/clipboard.min',
                text: libSrc + '/require/plugins/text',
                datepick: libSrc + '/datepick/jquery.datepicker',
                'jquery.cookie': libSrc + '/jquery.cookie/jquery.cookie.min',
                common3: config.src + '/lib',
                api3: config.src + '/api',
                cms: 'http://www1.vvic.com/js'
            }
        },
        plugins: [
            new webpack.ProvidePlugin({
                $: 'jquery',
                jQuery: 'jquery',
                "window.jQuery": "jquery",
                _: 'underscore'
            }),
            new CommonsChunkPlugin('common.js'),
            // new uglifyJsPlugin({
            //     compress: {
            //         warnings: false
            //     }
            // })
        ]
    }
}
