// webpack.config.js

var _ = require('lodash')
var path = require('path')
var webpack = require('webpack')
var ExtractTextPlugin = require('extract-text-webpack-plugin')

var autoprefixer = require('autoprefixer')
var flexibility = require('postcss-flexibility')
var autoprefixer = require('autoprefixer');
var flexibility = require('postcss-flexibility');
var sorting = require('postcss-sorting');
var color_rgba_fallback = require('postcss-color-rgba-fallback');
var opacity = require('postcss-opacity');
var pseudoelements = require('postcss-pseudoelements');
var will_change = require('postcss-will-change');
var cssnano = require('cssnano');

var project = require('./lib/project')();
var config = require('./config.' + project).webpack;

var srcDir = path.resolve(__dirname, '../src');
var libDir = path.resolve(__dirname, '../src/js/lib');

//获取多页面的每个入口文件，用于配置中的entry
var getEntry = function() {
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

// loaders配置
var getLoaders = function(env) {
    return [{
        test: /\.jsx?$/,
        exclude: /(node_modules|bower_components|vendor)/,
        loader: 'babel?presets[]=es2015&cacheDirectory=true!preprocess?PROJECT=' + project
    }, {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract("style-loader", "css-loader!postcss-loader")
    }, {
        test: /\.less$/,
        loader: ExtractTextPlugin.extract("style-loader", "css-loader!postcss-loader!less-loader")
    }, {
        test: /\/jquery\.js$/,
        loader: 'expose?$!expose?jQuery!expose?jquery'
    }, {
        test: /\.xtpl$/,
        loader: 'xtpl'
    }, {
        test: /\.modernizrrc$/,
        loader: "modernizr"
    }];
};

// 别名配置
var getAlias = function(env) {
    return {
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
        // 特殊
        'jquery': path.resolve(__dirname, '../src/vendor/jquery2/jquery.js'),

        // 正常第三方库
        'jquery.js': path.resolve(__dirname, '../src/vendor/jquery2/jquery.js'),
    };
};

// 插件配置
var getPlugins = function(env) {
    var defaultPlugins = [
        // 这个不仅是别名，还可以在遇到别名的时候自动引入模块
        new webpack.ProvidePlugin({
            '$': 'jquery',
            'jquery': 'jquery',
            'jQuery': 'jquery',
            '_': 'underscore'
        }),
        // 抽离公共模块
        new webpack.optimize.CommonsChunkPlugin('common', 'common.js'),
        // new uglifyJsPlugin({
        //     compress: {
        //         warnings: false
        //     }
        // })
    ];

    if (env == 'production') {
        // 线上模式的配置，去除依赖中重复的插件/压缩js/排除报错的插件
        plugins = _.union(defaultPlugins, [
            new webpack.optimize.DedupePlugin(),
            new webpack.optimize.UglifyJsPlugin({
                sourceMap: false,
                mangle: {
                    except: ['$', 'jQuery']
                }
            }),
            new webpack.NoErrorsPlugin()
        ]);
    } else {
        plugins = _.union(defaultPlugins, []);
    }

    return plugins;
};

// postcss配置
var getPostcss = function(env) {
    var postcss = [
        autoprefixer({ browers: ['last 2 versions', 'ie >= 9', '> 5% in CN'] }),
        flexibility,
        will_change,
        color_rgba_fallback,
        opacity,
        pseudoelements,
        sorting
    ];

    if (env == 'production') {
        // 线上模式的配置，css压缩
        return function() {
            return _.union([
                cssnano({
                    // 关闭cssnano的autoprefixer选项，不然会和前面的autoprefixer冲突
                    autoprefixer: false,
                    reduceIdents: false,
                    zindex: false,
                    discardUnused: false,
                    mergeIdents: false
                })
            ], postcss);
        };
    } else {
        return function() {
            return _.union([], postcss);
        }
    }
};


// 作为函数导出配置，代码更简洁
module.exports = function(env) {
    return {
        context: config.context,
        entry: getEntry(),
        output: {
            path: path.join(__dirname, "dist/js/"),
            filename: '[name].bundle.js',
            chunkFilename: '[name].[chunkhash:8].js',
            publicPath: '/assets/' + project + '/'
        },
        devtool: "eval",
        watch: false,
        profile: true,
        cache: true,
        module: {
            loaders: getLoaders(env)
        },
        resolve: {
            alias: getAlias(env)
        },
        plugins: getPlugins(env),
        postcss: getPostcss(env)
    };
}
