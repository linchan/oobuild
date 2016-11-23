var gulp = require('gulp');
var less = require('gulp-less');
var uglify = require('gulp-uglify');
var spritesmith = require('gulp.spritesmith');
var concat = require('gulp-concat');
var path = require('path');
var fs = require('fs');
var fse = require('fs-extra');
var crypto = require('crypto');
var Transform = require('stream').Transform;
var iconv = require('iconv-lite');
var swig = require('swig');
var through2 = require('through2');
var plumber = require('gulp-plumber');
var replace = require('gulp-replace');
var batch = require('gulp-batch');
var rd = require('rd');

var debug = true;
// var debug = false

//配置文件
var _versonConfig = JSON.parse(fs.readFileSync(path.join(__dirname, 'verson.json')));
var VERSON = _versonConfig.verson;
//生成cssmap的物理路径
var build_path = 'E:/project/vvic/branches/website/'+VERSON+'/vvic-frontend/statics/build/v2';
var push_path = 'E:/project/vvic/branches/website/'+VERSON+'/vvic-control/src/main/webapp';
// var push_target_path = 'E:/project/vvic/branches/website/3.2.4/vvic-control/target/vvic-control-2.1.0-SNAPSHOT/WEB-INF/view';
var _config = JSON.parse(fs.readFileSync(path.join(build_path, 'js/ver_config.json')));

var cssmap_Path = path.join(push_path, 'static', 'config_css.txt');
var cfghas_Path = path.join(push_path, 'static', 'config_js.txt');

var paths = {
    less: 'less/*.less',
    css: '../../v2/css/*.css',
    sprite: 'sprite',
    script: [path.join(build_path, 'js/src/**/*.js'), path.join(build_path, 'js/config.json'), path.join(build_path, 'js/config.dev.json'), path.join(build_path, 'js/path.json'), path.join(build_path, 'js/shim.json')],
    img: 'img',
    dist: 'js/dist/*.js',
    optimize: 'js/src',
    template: 'template/view/**/**/*.jsp'
};
var pool = {};

var cfgtpl = 'require.config({{ cfg|json|raw }}); window._WEB_Cfg = {{ usercfg|json|raw }}';

//配置文件参数
var jsMapPath = path.join(build_path, '../../v2/js', 'js.map.json');
var pathPath = path.join(build_path, 'js', 'path.json');
var shimPath = path.join(build_path, 'js', 'shim.json');

var _buildCfg = function(ENV) {
    this.ENV = ENV || '';
    this.domain = ((_config[ENV].CDN == 'ON' && _config.CDNDomain != '') ? _config.CDNDomain : _config[ENV].domain);
    this.theme = _config.theme;
    this.staticDomain = ((_config[ENV].CDN == 'ON' && _config.CDNDomain != '') ? _config.CDNDomain : _config[ENV].staticDomain) + '/statics/';
    this.staticPath = ((_config[ENV].staticDomain != '') ? _config[ENV].staticDomain : '') + '/statics/' + _config.theme + '/';
    this.jsLibPath = (_config[ENV].CDN == 'ON' ? _config.CDNDomain : _config[ENV].staticDomain) + '/statics/lib/';
    this.apiUrl = _config[ENV].apiDomain;
    this.actUrl = _config[ENV].actDomain;
};

var md5 = function(text) {
    return crypto.createHash('md5').update(text).digest('hex');
};

var mixin = function(dest, source) {
    for (var p in source) {
        dest[p] = source[p];
    }
    return dest;
};

//同步删除目录
var rmdirSync = (function() {
    function iterator(url, dirs) {
        var stat = fs.statSync(url);
        if (stat.isDirectory()) {
            dirs.unshift(url); //收集目录
            inner(url, dirs);
        } else if (stat.isFile()) {
            fs.unlinkSync(url); //直接删除文件
        }
    }

    function inner(path, dirs) {
        var arr = fs.readdirSync(path);
        for (var i = 0, el; el = arr[i++];) {
            iterator(path + "/" + el, dirs);
        }
    }
    return function(dir, cb) {
        cb = cb || function() {};
        var dirs = [];

        try {
            iterator(dir, dirs);
            for (var i = 0, el; el = dirs[i++];) {
                fs.rmdirSync(el); //一次性删除所有收集到的目录
            }
            cb();
        } catch (e) { //如果文件或目录本来就不存在，fs.statSync会报错，不过我们还是当成没有异常发生
            e.code === "ENOENT" ? cb() : cb(e);
        }
    };
})();

//生成cssmap
var buildCssMap = function(uri) {
    var cssPath = path.join(build_path, '../../v2/css');
    var _uri = uri ? uri : cssPath;
    var _isCssMap = fs.existsSync(cssmap_Path);
    if (_isCssMap) {
        fs.unlinkSync(cssmap_Path);
    }
    var files = [];
    var phparr = [];
    fs.readdirSync(_uri).forEach(function(file) {
        var fullPath = path.join(_uri, file);
        var stat = fs.lstatSync(fullPath);
        if (stat !== undefined && file.indexOf('.css') !== -1 && false === stat.isDirectory()) {
            var soure = fs.readFileSync(fullPath);
            var _has = md5(soure).substring(0, 10);

            var _name = file.replace('.css', '');
            files.push('"' + _name + '":"' + _has + '"');
        }
    });
    fs.writeFileSync(cssmap_Path, '{' + files + '}', 'utf8');
};

// build config.js hash
var buildCfgJsHas = function() {
    var cfgjs_Path = path.join(build_path, '../../v2/js', 'config.js');
    var _isExist = fs.existsSync(cfgjs_Path);
    if (!_isExist) {
        fs.createReadStream(cfgjs_Path);
    }
    var soure = fs.readFileSync(cfgjs_Path);
    var _has = md5(soure);
    console.log('config ===> ' + _has);
    fs.writeFileSync(cfghas_Path, _has, 'utf8');
};

// Task sprite
var _time_sprite;
gulp.task('sprite', function() {
    if (_time_sprite) {
        clearTimeout(_time_sprite);
    }
    _time_sprite = setTimeout(function() {
        var dirs = fs.readdirSync(path.join(build_path, paths.sprite));
        dirs.forEach(function(dir) {
            if (dir.indexOf('.') === 0) {
                return;
            }
            var pngPatn = path.join(build_path, paths.sprite, dir);
            var stat = fs.statSync(pngPatn);

            if (stat.isDirectory()) {
                var pngPath = path.join(build_path, '../../v2/css/img/sp_' + dir + '.png');
                var srcPath = path.join(build_path, paths.sprite + '/' + dir);
                var _buildPng = function(has) {
                    var _has = has ? has : md5(srcPath).substring(2, 10);
                    return gulp.src(path.join(build_path, paths.sprite + '/' + dir + '/*.png')).pipe(spritesmith({
                        // engine:'pngsmith',
                        algorithm: 'binary-tree',
                        padding: 5,
                        imgName: 'sp_' + dir + '.png',
                        cssName: dir + '.less',
                        imgPath: 'img/sp_' + dir + '.png?_=' + _has,
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
                    var pngHas = md5(pngSource).substring(2, 10);
                }
                var spriteData = pngHas ? _buildPng(pngHas) : _buildPng();
                spriteData.img.pipe(gulp.dest(path.join(build_path, '../../v2/css/img')));
                spriteData.css.pipe(gulp.dest(path.join(build_path, 'less/sp')));
            }
        });
    }, 200);
});

var synchro = function(dir) {
    var js_file_name = dir + ".js";
    var js_fullPath = path.join(build_path, '../../v2/js/dist/' + js_file_name);
    var is_jsfile = fs.existsSync(js_fullPath);
    if (is_jsfile) {
        var js_soure = fs.readFileSync(js_fullPath);
        var js_hash = md5(js_soure);
    }
    return through2.obj(function(data, enc, cb) {
            pool.dev.cacheBust[dir] = js_hash;
            // pool.test.cacheBust[dir] = js_hash
            // pool.deploy.cacheBust[dir] = js_hash
            console.log("combined " + dir + " -> " + js_file_name + ' -> ' + js_hash);
            cb();
        },
        function() {
            if (++pool.checkcomplete == pool.count) {
                console.log("->generation is completed!");
                generate();
            }
        });
};

var buildCfg = function(name) {
    var cfg = new _buildCfg(name);
    pool["~" + name] = cfg;
    var _baseUrl = (name == "dev" && debug) ? (cfg.staticDomain + "build/v2/js/src") : cfg.staticPath + "js/dist";
    pool[name] = {
        baseUrl: _baseUrl,
        paths: (name == "dev" && debug) ? pool.trdPatryMap : pool.pathsMap,
        shim: pool.shimMap,
        cacheBust: {}
    };
};

var generateCfgs = function(name) {
    var __file = path.join(build_path, '../../v2/js', 'config' + (name != 'deploy' ? '.' + name : '') + '.js'),
        cfg = swig.render(cfgtpl, {
            locals: {
                cfg: pool[name],
                usercfg: pool["~" + name]
            }
        });
    // console.log(__file);
    fs.writeFileSync(__file, cfg);
};

var generate = function() {
    generateCfgs("dev");
    // generateCfgs("test")
    // generateCfgs("deploy")
};

// 合并包文件
var _time_script;
gulp.task('js', function() {
    //clear first
    pool = {};

    //automatic generate js.map.json
    var tmp = {};
    rd.eachSync(path.join(build_path, paths.optimize), function(f, s) {
        var file = fs.statSync(f);
        if (!file.isDirectory()) {
            var name = f.replace(path.join(build_path, paths.optimize), "");
            name = name.substr(1);
            name = name.substr(0, name.length - ".js".length);
            name = name.replace("\\", "/");
            tmp[name] = path.dirname(name);
        }
    });
    fs.writeFileSync(jsMapPath, JSON.stringify(tmp));
    console.log("-->generated js.map.json");
    tmp = null;
    //read pre-defined mapping from jsMapPath,pathPath, shimPath
    var userJsMap = JSON.parse(fs.readFileSync(jsMapPath, "utf-8")),
        trdPatryMap = JSON.parse(fs.readFileSync(pathPath, 'utf-8')),
        shimMap = JSON.parse(fs.readFileSync(shimPath, 'utf-8')),
        allIn = {};
    pool.trdPatryMap = trdPatryMap;
    //init pool variables
    allIn = mixin({}, trdPatryMap);
    mixin(allIn, userJsMap);
    pool.pathsMap = allIn;
    pool.shimMap = shimMap;
    userJsMap = trdPatryMap = shimMap = allIn = null;
    //build configurations and Hash
    buildCfg("dev");
    // buildCfg("test")
    // buildCfg("deploy")
    buildCfgJsHas();

    if (_time_script) {
        clearTimeout(_time_script);
    }
    _time_script = setTimeout(function() {
        var dirs = fs.readdirSync(path.join(build_path, paths.optimize));
        pool.count = dirs.length;
        pool.checkcomplete = 0;
        dirs.forEach(function(dir) {
            if (dir.indexOf('.') === 0) {
                return;
            }
            var stat = fs.statSync(path.join(build_path, paths.optimize, dir));
            if (stat.isDirectory()) {
                var distPath = path.join(build_path, '../../v2/js/dist')
                var stream = gulp.src(path.join(build_path, paths.optimize + '/' + dir + '/*.js'))
                    .pipe(concat(dir + '.js'))
                    .pipe(uglify())
                    .pipe(gulp.dest(distPath))
                    .pipe(synchro(dir));
            }
        });
    }, 200);
});

// Task less
var _time_less;
gulp.task('less', function() {
    if (_time_less) {
        clearTimeout(_time_less);
    }
    _time_less = setTimeout(function() {
        gulp.src([path.join(build_path,'less/*.less'), '!'+path.join(build_path, 'less/_*.less')])
            .pipe(plumber())
            .pipe(less({
                compress: true,
                paths: [path.join(build_path, 'css', 'less')]
            }))
            //.pipe(minifycss({keepBreaks:false})) //keepBreaks:false,则为CSS不换行
            .pipe(gulp.dest(path.join(build_path, '../../v2/css')))
            .on("end", function() {
                gulp.start('cssmap');
            });
    }, 400);
});

//优化雪碧图
gulp.task('imgmin', ['sp'], function() {
    return gulp.src(path.join(build_path, '../../v2/css/img/sp_*.png'))
        .pipe(imagemin({
            progressive: true,
            svgoPlugins: [{
                removeViewBox: false
            }],
            use: [pngcrush()]
        }))
        .pipe(gulp.dest(path.join(build_path, '../../v2/js/dist')));
});

// Task cssmap
var _time_cssmap;
gulp.task('cssmap', function() {
    if (_time_script) {
        clearTimeout(_time_script);
    }
    _time_script = setTimeout(function() {
        buildCssMap();
    }, 200);
});

var _time_template
gulp.task('template', function() {
    if (_time_template) {
        clearTimeout(_time_template)
    }
    _time_template = setTimeout(function() {
        gulp.src(path.join(build_path,paths.template))
            .pipe(gulp.dest(path.join(push_path, 'WEB-INF', 'view')))
            // .pipe(gulp.dest(path.join(push_target_path, _dir)))
            .on('end', function() {
                console.log('copy files');
            })
    }, 400);
});


// 生成批处理文件
gulp.task('bat', function() {
    var rootPath = path.join(__dirname);
    var disk = rootPath.split('')[0];
    if (disk !== '/') {
        var cmd = [disk + ':'];
        cmd.push('cd ' + rootPath);
        cmd.push('call gulp sprite');
        cmd.push('call gulp less');
        cmd.push('call gulp js');
        cmd.push('call gulp template');
        cmd.push('call gulp watch');
        fs.writeFileSync(path.join(__dirname, 'build.cmd'), cmd.join('\r\n'));
    } else {
        //      var sh = ['#!/bin/sh']
        //      var shFile = path.join(build_path, 'tool.sh')
        //      sh.push('gulp')
        //      fs.writeFileSync(shFile, sh.join('\n'))
        //      fs.chmodSync(shFile, 0755)
    }
});



// Rerun the task when a file changes
var _time_watch;
gulp.task('watch', function() {
    if (_time_watch) {
        clearTimeout(_time_watch);
    }
    _time_watch = setTimeout(function() {
        gulp.watch(paths.script, ['js']);
        gulp.watch(path.join(build_path, paths.sprite + '/**/*.png'), ['sprite']);
        gulp.watch(path.join(build_path, paths.less), ['less']);
        gulp.watch(path.join(build_path, paths.template), function(event, a){
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
    }, 500);
});


gulp.task('default', function(){
    if(gulp.env.svn){
        VERSON = gulp.env.svn;
        // console.log(VERSON);
        gulp.start('watch');
    }
})
