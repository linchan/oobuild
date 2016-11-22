var CommonsChunkPlugin = require("webpack/lib/optimize/CommonsChunkPlugin");
var path = require('path');
var webpack = require('webpack');
var fs = require('fs');
var uglifyJsPlugin = webpack.optimize.UglifyJsPlugin;

var srcDir = path.resolve(process.cwd(), 'src');
var libDir = srcDir + '/js/lib';
//获取多页面的每个入口文件，用于配置中的entry
function getEntry() {
    var jsPath = path.resolve(srcDir, 'js');
    var dirs = fs.readdirSync(jsPath);
    var matchs = [], files = {};
    dirs.forEach(function (item) {
        matchs = item.match(/(.+)\.js$/);
        // console.log(matchs);
        if (matchs) {
            files[matchs[1]] = path.resolve(srcDir, 'js', item);
        }
    });
    // console.log(JSON.stringify(files));
    return files;
}

module.exports = {
    cache: true,
    devtool: "source-map",
    entry: getEntry(),
    output: {
        path: path.join(__dirname, "dist/js/"),
        publicPath: "dist/js/",
        filename: "[name].bundle.js"
    },
    resolve: {
        alias: {
            jquery: libDir + "/jquery/jquery-1.11.1.min",
            layer: libDir + '/jquery.layer/layer.min',
            underscore: libDir + '/underscore/underscore-min',
            lazyload: libDir + '/jquery.lazyload/jquery.lazyload.min',
            validation: libDir + '/jquery.validation/jquery.validation.min',
            clipboard: libDir + '/clipboard/clipboard.min',
            slide: libDir + '/jquery.slide/jquery.SuperSlide.2.1.1',
            pagination: libDir + '/jquery.pagination/jquery.pagination.min',
            scrolltofixed: libDir + '/jquery.scrolltofixed/jquery.scrolltofixed.min',
            text: libDir + '/require/plugins/text',
            datepick: libDir + '/datepick/jquery.datepicker',
            cookie: libDir + '/jquery.cookie/jquery.cookie.min',
            common: srcDir + '/js/common'
        }
    },
    module: {
        loaders: [
            { test: /\.css$/, loader: "style!css" },
            { test: /\.css$/, loaders: ["style", "css"] }
        ]
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
};
