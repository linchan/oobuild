/******/ (function(modules) { // webpackBootstrap
/******/ 	
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/ 	
/******/ 	// object to store loaded and loading chunks
/******/ 	// "0" means "already loaded"
/******/ 	// Array means "loading", array contains callbacks
/******/ 	var installedChunks = {
/******/ 		2:0
/******/ 	};
/******/ 	
/******/ 	// The require function
/******/ 	function require(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/ 		
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/ 		
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, require);
/******/ 		
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/ 		
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/******/ 	// This file contains only the entry chunk.
/******/ 	// The chunk loading function for additional chunks
/******/ 	require.e = function requireEnsure(chunkId, callback) {
/******/ 		// "0" is the signal for "already loaded"
/******/ 		if(installedChunks[chunkId] === 0)
/******/ 			return callback.call(null, require);
/******/ 		
/******/ 		// an array means "currently loading".
/******/ 		if(installedChunks[chunkId] !== undefined) {
/******/ 			installedChunks[chunkId].push(callback);
/******/ 		} else {
/******/ 			// start chunk loading
/******/ 			installedChunks[chunkId] = [callback];
/******/ 			var head = document.getElementsByTagName('head')[0];
/******/ 			var script = document.createElement('script');
/******/ 			script.type = 'text/javascript';
/******/ 			script.charset = 'utf-8';
/******/ 			script.src = require.p + "" + chunkId + "..bundle.js";
/******/ 			head.appendChild(script);
/******/ 		}
/******/ 	};
/******/ 	
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	require.modules = modules;
/******/ 	
/******/ 	// expose the module cache
/******/ 	require.cache = installedModules;
/******/ 	
/******/ 	// __webpack_public_path__
/******/ 	require.p = "dist/js/";
/******/ 	
/******/ 	// install a JSONP callback for chunk loading
/******/ 	window["webpackJsonp"] = function webpackJsonpCallback(chunkIds, moreModules) {
/******/ 		// add "moreModules" to the modules object,
/******/ 		// then flag all "chunkIds" as loaded and fire callback
/******/ 		var moduleId, chunkId, callbacks = [];
/******/ 		while(chunkIds.length) {
/******/ 			chunkId = chunkIds.shift();
/******/ 			if(installedChunks[chunkId])
/******/ 				callbacks.push.apply(callbacks, installedChunks[chunkId]);
/******/ 			installedChunks[chunkId] = 0;
/******/ 		}
/******/ 		for(moduleId in moreModules) {
/******/ 			modules[moduleId] = moreModules[moduleId];
/******/ 		}
/******/ 		while(callbacks.length)
/******/ 			callbacks.shift().call(null, require);
/******/ 		if(moreModules[0]) {
/******/ 			installedModules[0] = 0;
/******/ 			require(0);
/******/ 		}
/******/ 	};
/******/ })
/************************************************************************/
/******/ ([
/* 0 */,
/* 1 */
/***/ function(module, exports, require) {

	var $ = require(6);
	var api = require(3);
	var layer = require(15);
	var cookie = require(7);
	var qlogin = require(14);
	
	    var exports = {};
	    var LAYER_MSG_DEFAULT = {time: 1000};
	
	    if (!Array.prototype.indexOf) {
	        Array.prototype.indexOf = function (elt /*, from*/) {
	            var len = this.length >>> 0;
	            var from = Number(arguments[1]) || 0;
	            from = (from < 0)
	                ? Math.ceil(from)
	                : Math.floor(from);
	            if (from < 0)
	                from += len;
	            for (; from < len; from++) {
	                if (from in this &&
	                    this[from] === elt)
	                    return from;
	            }
	            return -1;
	        };
	    }
	
	    if (!Array.prototype.remove) {
	        Array.prototype.remove=function(dx){
	            if(isNaN(dx)||dx>this.length){return false;}
	            for(var i=0,n=0;i<this.length;i++)
	            {
	                if(this[i]!=this[dx]){
	                    this[n++]=this[i]
	                }
	            }
	            this.length-=1
	        }
	    }
	
	    // 对Date的扩展，将 Date 转化为指定格式的String
	    // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
	    // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
	    // 例子：
	    // (new Date()).format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
	    // (new Date()).format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
	    Date.prototype.format = function(fmt) { //author: meizz
	        var o = {
	            "M+" : this.getMonth()+1,                 //月份
	            "d+" : this.getDate(),                    //日
	            "h+" : this.getHours(),                   //小时
	            "m+" : this.getMinutes(),                 //分
	            "s+" : this.getSeconds(),                 //秒
	            "q+" : Math.floor((this.getMonth()+3)/3), //季度
	            "S"  : this.getMilliseconds()             //毫秒
	        };
	        if(/(y+)/.test(fmt)){
	            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
	        }
	        for(var k in o){
	            if(new RegExp("("+ k +")").test(fmt)){
	                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
	            }
	        }
	        return fmt;
	    };
	
	
	    _.mixin({
	        formatDate: function(string, fmt) {
	            //如果格式固定为yyyy-mm-dd hh:MM:ss
	            var ps = string.split(" ");
	            var pd = ps[0].split("-");
	            var pt = ps.length>1 ? ps[1].split(":"): [0,0,0];
	            var newDataString = new Date(pd[0],pd[1]-1,pd[2],pt[0],pt[1],pt[2]);
	            fmt = fmt || 'yyyy-MM-dd hh:mm';
	            return newDataString.format(fmt);
	        }
	    });
	
	
	
	
	    //继承
	    var __super,
	        __hasProp = {}.hasOwnProperty,
	        __extends = function (child, parent) {
	            for (var key in parent) {
	                if (__hasProp.call(parent, key)) child[key] = parent[key];
	            }
	            if (typeof parent === 'object') return;
	            function Ctor() {
	                this.constructor = child;
	            }
	
	            child.Init = function (o) {
	                this.init(o);
	            };
	            Ctor.prototype = parent.prototype;
	            child.fn = child.Init.prototype = child.prototype = new Ctor();
	            child.__super__ = parent.prototype;
	            return child;
	        };
	    /************************/
	    __super = (function () {
	        function __super() {
	        }
	
	        __super.prototype.init = function (o) {
	            this.init(o);
	        };
	        return __super;
	    })();
	
	    /**/
	    updateUserFavData = function (favType, op) {
	        $.cookie(favType, op, {expires: 365, path: '/', domain: '.vvic.com'});
	    };
	
	    //tab 组件
	    var tabs_defaults = {
	        container: null, //tab 最外层的 selecter
	        top: null, //包裹 topElem 的 selecter
	        topElem: 'a', //点击的元素 ,一定要有 href 属性, 对应切换容器的 id
	        activeClass: 'selected', // tabElem 选中的 className
	        events: 'click', //切换事件, 默认点击
	        callback: null // 切换回调
	    };
	
	    var tabs = (function (_super) {
	
	        __extends(tabs, _super);
	
	        function tabs(options) {
	            var opts = $.extend({}, tabs_defaults, options);
	            return new tabs.Init(opts);
	        }
	
	        $.extend(tabs.fn, {
	            init: function (options) {
	                var top = $(options.top, options.container),
	                    items = $(options.topElem, top),
	                    contents = [],
	                    _this = this;
	
	                items.each(function (i, item) {
	                    var str = $(item).attr('href');
	
	                    str = _this.clearHref(str);
	
	                    contents.push(str);
	                });
	
	                this.items = items;
	                this.contents = contents;
	                this.options = options;
	                this.bind();
	            },
	            clearHref: function (str) {
	                //fix ie7 :href 会带域名
	                var idx = str.indexOf('#');
	                if (idx != 0) {
	                    str = str.substring(idx);
	                }
	                return str;
	            },
	            trigger: function (href) {
	
	                if (href == undefined) {
	                    return;
	                }
	                var contents = this.contents,
	                    options = this.options,
	                    _this = this;
	
	                this.items.removeClass(options.activeClass);
	
	                $.each(this.items, function (index, el) {
	
	                    var str = _this.clearHref($(el).attr('href'));
	                    if (str == href) {
	
	                        $(el).addClass(options.activeClass);
	
	                    }
	                });
	
	                $.each(contents, function (index, item) {
	                    if (item == href) {
	                        $(item, options.container).show();
	                    } else {
	                        $(item, options.container).hide();
	                    }
	                });
	
	            },
	            bind: function () {
	                var contents = this.contents,
	                    options = this.options,
	                    callback = options.callback,
	                    _this = this;
	
	
	                this.items.on(options.events, function (evt) {
	
	                    var href = $(this).attr('href');
	                    href = _this.clearHref(href);
	
	                    $.each(contents, function (index, item) {
	                        if (item == href) {
	                            $(item, options.container).show();
	                        } else {
	                            $(item, options.container).hide();
	                        }
	                    });
	
	                    _this.items.removeClass(options.activeClass);
	                    $(this).addClass(options.activeClass);
	
	                    if (!!callback) {
	                        callback(href, this, _this);
	                    }
	                    evt.stopPropagation();
	                    evt.preventDefault();
	                });
	
	                if (options.events != 'click') {
	                    this.items.bind('click', function (evt) {
	                        evt.stopPropagation();
	                        evt.preventDefault();
	                    });
	                }
	
	            },
	            unbind: function () {
	                this.items.unbind();
	            }
	        });
	
	        return tabs;
	    })(__super);
	
	
	    var sub = (function () {
	
	        return function (str, data) {
	            return str.replace(/\${(.*?)}/igm, function ($, $1) {
	
	                if (typeof data == 'string') {
	                    return data;
	                }
	
	                if (typeof data[$1] == 'undefined') {
	                    return '';
	                }
	                return data[$1];
	            });
	        };
	
	    })();
	
	    var render = function (tpl, list) {
	
	        var _html = '';
	        $.each(list, function (index, item) {
	
	            if (!index) {
	                item.classname = 'selected';
	            }
	            item.index = index;
	            item.count = index + 1;
	
	            _html = _html + sub(tpl, item);
	        });
	        return _html;
	    };
	    /*
	     * 频率控制 返回函数连续调用时，fn 执行频率限定为每多少时间执行一次
	     * @param fn {function}  需要调用的函数
	     * @param delay  {number}    延迟时间，单位毫秒
	     * @param immediate  {bool} 给 immediate参数传递false 绑定的函数先执行，而不是delay后后执行。
	     * @return {function}	实际调用函数
	     */
	    var throttle = function (fn, delay, immediate, debounce) {
	        var curr = +new Date(),//当前时间
	            last_call = 0,
	            last_exec = 0,
	            timer = null,
	            diff, //时间差
	            context,//上下文
	            args,
	            exec = function () {
	                last_exec = curr;
	                fn.apply(context, args);
	            };
	        return function () {
	            curr = +new Date();
	            context = this,
	                args = arguments,
	                diff = curr - (debounce ? last_call : last_exec) - delay;
	            clearTimeout(timer);
	
	            if (debounce) {
	                if (immediate) {
	                    timer = setTimeout(exec, delay);
	                } else if (diff >= 0) {
	                    exec();
	                }
	            } else {
	                if (diff >= 0) {
	                    exec();
	                } else if (immediate) {
	                    timer = setTimeout(exec, -diff);
	                }
	            }
	
	            last_call = curr;
	        };
	    };
	
	    //频率控制
	    exports.throttle = throttle;
	    //tab 组件
	    exports.tabs = tabs;
	
	    //简单的模板
	    exports.render = render;
	
	    //防止被iframe
	    exports.refuseIframe = (function () {
	
	        function doit() {
	            try {
	                top.location.hostname;
	                if (top.location.hostname != window.location.hostname) {
	                    top.location.href = window.location.href;
	                }
	            }
	            catch (e) {
	                top.location.href = window.location.href;
	            }
	
	            return window;
	        }
	
	        return doit();
	    })();
	
	
	    exports.deepClone = function (obj) {
	        function Clone() {
	        }
	
	        Clone.prototype = obj;
	        var o = new Clone();
	        for (var a in o) {
	            if (typeof o[a] == "object") {
	                o[a] = deepClone(o[a]);
	            }
	        }
	        return o;
	    };
	
	    exports.getItemId = function () {
	        return location.href.match(/(\d)+/)[0];
	    };
	
	    exports.getQueryString = function (name) {
	        var r = window.location.search.substr(1).replace(/&amp;/g, '&');
	        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	        r = r.match(reg);
	        if (r != null) return decodeURIComponent(r[2]);
	        return null;
	    };
	
	    // var colletStatus = false;
	    var careMap = {},
	        favMap = {};
	    exports.onCollectProduct = function (id, _cb) {
	        if (favMap['f_' + id]) {
	            layer.msg('已收藏该商品', LAYER_MSG_DEFAULT);
	            return;
	        }
	        /*var uid = $.cookie('uid');
	        if (!uid) {
	            /!*location.href = _WEB_Cfg.domain + '/login.html?reurl=' + encodeURIComponent(location.href);
	            return false;*!/
	
	
	        }*/
	        //快捷登录
	        var uid = $.cookie('uid');
	        if(!uid){
	            qlogin.init();
	            return false;
	        }
	
	        api.service.user.favAdd({itemId: id}, function(data){
	            if (data.code == 200) {
	                layer.msg('收藏成功', LAYER_MSG_DEFAULT);
	                favMap['f_' + id] = true;
	                updateUserFavData('favGoods', data.data.count);
	                _cb && _cb(data);
	            } else if (data.code == 201) {
	                layer.msg('已收藏该商品', LAYER_MSG_DEFAULT);
	            } else {
	                layer.msg('网络异常，请重试', LAYER_MSG_DEFAULT);
	            }
	        });
	    };
	    exports.onCareShop = function (id, _cb) {
	        /*var uid = $.cookie('uid');
	        if (!uid) {
	            location.href = _WEB_Cfg.domain + '/login.html?reUrl=' + encodeURIComponent(location.href);
	            return false;
	        }*/
	        //快捷登录
	        var uid = $.cookie('uid');
	
	        if(!uid){
	            qlogin.init();
	            return false;
	        }
	
	        if (careMap['c_' + id]) {
	            layer.msg('已关注该档口', LAYER_MSG_DEFAULT);
	            return;
	        }
	        var _data = {
	            shopId: id
	        };
	        api.service.user.favShopAdd(_data, function(data){
	            if (data.code == 200) {
	                layer.msg('关注成功', LAYER_MSG_DEFAULT);
	                updateUserFavData('favShops', data.data.count);
	                careMap['c_' + id] = true;
	                _cb && _cb(data);
	            } else if (data.code == 201) {
	                layer.msg('已关注该档口', LAYER_MSG_DEFAULT);
	            } else {
	                layer.msg('网络异常，请重试', LAYER_MSG_DEFAULT);
	            }
	        });
	        return false;
	    };
	    exports.onCancelFav = function (id, _cb) {
	        var uid = $.cookie('uid');
	        if (!uid) {
	            location.href = _WEB_Cfg.domain + '/login.html?reurl=' + encodeURIComponent(location.href);
	            return false;
	        }
	
	        var fav = layer.confirm("确定不再收藏此商品？", {title: '取消收藏', btn: ['取消', '确定'], closeBtn: false}, function () {
	            layer.close(fav);
	        }, function () {
	            var that = this,
	                _data = {
	                    itemId: id
	                };
	            api.service.user.favCancel(_data, function(data){
	                layer.msg("已取消收藏！", LAYER_MSG_DEFAULT);
	                updateUserFavData('favGoods', data.data.count);
	                _cb && _cb();
	            });
	        });
	    };
	    exports.onCancelCare = function (id, _cb) {
	        var uid = $.cookie('uid');
	        if (!uid) {
	            location.href = _WEB_Cfg.domain + '/login.html?reurl=' + encodeURIComponent(location.href);
	            return false;
	        }
	
	        var fav = layer.confirm("确定不再关注此档口？", {title: '取消关注', btn: ['取消', '确定'], closeBtn: false}, function () {
	            layer.close(fav);
	        }, function () {
	            var that = this,
	                _data = {
	                    shopId: id
	                };
	            api.service.user.favShopCancel(_data, function(data){
	                updateUserFavData('favShops', data.data.count);
	                _cb && _cb(data);
	                layer.msg("已取消关注", LAYER_MSG_DEFAULT);
	            });
	        });
	    };
	
	    exports.upFileBox = function (id, vid) {
	        var _html = '<div class="layer-up-box">' +
	            '<div class="up-btn-list clearfix">' +
	            '<a href="javascript:;" data-href="http://tb.vvic.com/publish.aspx?id=' + vid + '&tid='+id+'&p=1" data-name="tb" class="tb chklog">淘宝</a>' +
	            '<a href="javascript:;" data-href="http://1688.vvic.com/publish.jsp?id=' + vid + '&p=1" data-name="ali" class="ali chklog">阿里巴巴</a>' +
	            '<a href="javascript:;" data-href="http://aliexpress.vvic.com/publish.jsp?id=' + vid + '" data-name="smt" class="smt chklog">速卖通</a>' +
	            '<a href="javascript:;" data-href="http://jd.vvic.com/publish.jsp?p=1&id=' + vid + '" data-name="jd" class="jd chklog">京东</a>' +
	            '<a data-style="visibility: hidden" > </a>' +
	            '<a href="javascript:;" data-href="http://mls.vvic.com/publish.jsp?id=' + vid + '&p=1" data-name="mls" class="mls chklog">美丽说</a>' +
	            '<a href="javascript:;" data-href="http://mgj.vvic.com/publish.jsp?p=1&id=' + vid + '" data-name="mgj" class="mgj chklog">蘑菇街</a>' +
	            '</div>' +
	            '<div class="msg clearfix">微信、天猫将于近期上线</div>' +
	            '</div>';
	
	        //自定页
	        layer.open({
	            type: 1,
	            skin: 'layui-layer-up', //样式类名
	            closeBtn: 1, //不显示关闭按钮
	            // shift: 2,
	            area: ['380px', '285px'],
	            title: '请选择要上架的平台',
	            shadeClose: true, //开启遮罩关闭
	            scrollbar:true,
	            content: _html,
	            end: function(){
	                // 解除事件绑定。
	                $(document).off("click", ".chklog");
	            }
	        });
	        $(document).on("click", ".chklog", function(){
	            var $this = $(this),
	                uid = $.cookie('uid'),
	                _href = $this.attr('data-href');
	            if (!uid) {
	                //layer.close(1);
	                $('.layui-layer-shade').remove();
	                layer.closeAll();
	                qlogin.init(_href);
	                return;
	            }else{
	                $this.attr({'href':_href,'target':'_blank'}).removeClass('chklog').click();
	                /*var _tag = window.open('about:blank');
	                 _tag.location.href = _href;*/
	            }
	        });
	    };
	
	    // lazyload
	    exports.fixLazyload = function () {
	        var dpr = window.devicePixelRatio,
	            effect = dpr > 1 ? 'show' : 'fadeIn';
	        $("img.lazy").lazyload({
	            threshold: 400,
	            effect: effect,
	            failure_limit: 1000
	        });
	        $('body,html').resize();
	    };
	
	    // 回到顶部
	    exports.initIconEvent = function () {
	        var serTime;
	        $(document).on("mouseenter", ".j-v-tip", function () {
	            var $this = $(this),
	                _type = $this.data('tip'),
	                _tips = {
	                    tx: ["档口承诺：未下架、非特价或过季商品，且不影响二次销售，可申请退现。<b>以下情况需先与档口确认是否可退：1、快递退货；2、特殊时间（如春节前、双十一）；3、售出太久（超过15天）；4、件数太多（超过10件）。</b>使用搜款网代发，可提高退现成功率。", "退现", "tx"],
	                    sp: ["档口承诺：档口 80% 商品为真实拍摄，本款商品是否为实拍，请在上款前联系档口确认。", "实拍", "sp"],
	                    df: ["档口承诺：从本店进货，可提供代发服务，且不收取代发费。", "一件代发", "df"],
	                    year: ['支付宝个人认证 ' + $this.data('date')],
	                    cert: ['档口已通过搜款网实名认证'],
	                    miao: ['档口上新实时同步到搜款网'],
	                    top: ['档口在沙河排名前 ' + $this.data('top')]
	                },
	                _typeString = ['tx', 'sp', 'df'];
	
	            serTime = setTimeout(function () {
	                if (_typeString.indexOf(_type) > -1 && !$this.hasClass('j-v-tip-item')) {
	                    var $li = $this.closest('li');
	                    $li.children('.service-tips').remove();
	                    $li.append('<div class="service-tips"><i class="' + _tips[_type][2] + '"></i><span>' + _tips[_type][1] + '</span><div class="clear"></div><p>' + _tips[_type][0] + '</p></div>');
	                } else {
	                    layer.tips(_tips[_type][0], $this, {tips: [3, '#ffffff'], skin: 'service-tips', time: 10000});
	                }
	            }, 300);
	
	            $this.closest('li').addClass('hover');
	
	        }).on("mouseleave", ".j-v-tip", function () {
	            var $this = $(this);
	            clearTimeout(serTime);
	            layer.closeAll('tips');
	            if (!$this.hasClass("j-v-tip-item"))
	                $this.closest('li').children('.service-tips').remove();
	
	            $this.closest('li').removeClass('hover');
	        });
	
	
	        $('.side-list,.goods-list').on('mouseenter', '.pos', function () {
	            $(this).closest('li').addClass('hover');
	        }).on('mouseleave', '.pos', function () {
	            $(this).closest('li').removeClass('hover');
	        });
	
	        $(document).on('mouseenter', '.j-img-view', function(){
	            var $this = $(this);
	            layer.tips('<img src="'+$this.attr('view-src')+'" width="230" height="230" />', $this, {tips: [2, '#ffffff'], skin: 'img-tips',area:['253px','250px'], time:10000});
	        }).on('mouseleave', '.j-img-view', function(){
	             layer.closeAll('tips');
	        });
	    };
	
	    exports.addCopyclipboard = function (events, content,selectText) {
	        var _content;
	        events = events || 'dblclick';
	
	        if ('clipboardData' in window) {
	            $(".j_clip_button").on(events, function () {
	                 _content = content || this.innerHTML.replace('#', '');
	                var art_no = $.trim(content);
	                window.clipboardData.setData("Text", art_no);
	            });
	        } else {
	            // var clipboard = require(['clipboard'], function (clipboard) {
	
	            //     $(document).off('copy', '.j_clip_button');
	
	            //     $(document).on('copy', '.j_clip_button', function (e) {
	            //          _content = content || e.target.innerHTML.replace(/\#/g, '');
	
	            //         var art_no = $.trim(_content);
	
	            //         if(selectText){
	            //             var target = e.target;
	            //             var s = window.getSelection();
	
	            //             if (s.rangeCount > 0) s.removeAllRanges();
	
	            //             var range = document.createRange();
	            //             range.selectNode(target);
	            //             s.addRange(range);
	            //         }
	
	            //         e.clipboardData.clearData();
	            //         e.clipboardData.setData("text/plain", art_no);
	
	            //         // console.log("copy success", art_no)
	            //         e.preventDefault();
	
	            //     });
	
	            // });
	
	        }
	
	    };
	    exports.addCopyclipboard(null,null,true);
	
	    // 公用下拉组件
	    exports.vSelect = function() {
	        $(document).on('click', '.j-v-select dt', function(){
	
	            var dl = $(this).parent('dl');
	
	            if(!dl.hasClass('dis')){
	                dl.addClass('showed');
	            }
	        });
	        $(document).on('mouseleave', '.j-v-select', function(){
	            $(this).removeClass('showed');
	        });
	
	        $(document).on('click', '.j-v-select-ul li', function(){
	            var $this = $(this);
	            if($this.hasClass('disabled')){
	                return false;
	            }
	            $this.addClass('selected').siblings().removeClass('selected');
	            var $dl =  $this.closest('dl');
	            $dl.removeClass('showed').find('dt span').html( $('span',$this).html() );
	        });
	    };
	
	    exports.initIconEvent();
	
	    module.exports = exports


/***/ },
/* 2 */,
/* 3 */
/***/ function(module, exports, require) {

	var $ = require(6);
	var cookie = require(7);
	
	    var apiExports = {},
	        _ERROR_CB_TXT = '服务器开小差了!, 请刷新重试';
	    //记录本页url作登录跳转
	    var h = location.href;
	
	    var goLogin = function () {
	        var dateTime = new Date(new Date() - 24 * 60 * 60 * 1000);
	        $.cookie('ut', '', {path: '/', expires: dateTime});
	        $.cookie('uid', '', {path: '/', domain: '.vvic.com', expires: dateTime});
	        $.cookie('umc', '', {path: '/', expires: dateTime});
	        $.cookie('mobile', '', { path: '/' , expires: _expires});
	        $.cookie('defaultShopId', '', {path: '/', expires: dateTime});
	        $.cookie('defaultShopName', '', {path: '/', expires: dateTime});
	        $.cookie('shopName', '', {path: '/', expires: dateTime});
	        $.cookie('shopId', '', {path: '/', expires: dateTime});
	        $.cookie('pn', '', {path: '/', expires: dateTime});
	        $.cookie('uno', '', {path: '/', expires: dateTime});
	        location.href = _WEB_Cfg.domain + '/login.html?reurl=' + encodeURIComponent(location.href);
	    };
	
	    var getData = function (url, method, data, successCallback, completeCallback) {
	        var _cCb = completeCallback || function () {
	                },
	            _sCb = successCallback || function () {
	                },
	            _url = url,
	            _method = method,
	            _data = data;
	        _url = _url.indexOf('http://') < 0 ? (window._WEB_Cfg.apiUrl + _url) : _url;
	        $.support.cors = true;
	        $.ajax({
	            url: _url,
	            type: _method,
	            dataType: "json",
	            data: _data,
	            // timeout:15000,
	            success: function (jsonData) {
	                if (jsonData) {
	                    if (jsonData.code == 401) {
	                        goLogin();
	                        return;
	                    }
	                    if (jsonData.code == 40102) {
	                        reLogin();
	                        // return;
	                    }
	                    _sCb(jsonData);
	                } else {
	                    // console.log(_ERROR_CB_TXT);
	                }
	            },
	            error: function (err) {
	                if (err.status == 401) {
	                    goLogin();
	                    return;
	                }
	                if (err.status == 40102) {
	                    reLogin();
	                    // return;
	                }
	                // console.log(_ERROR_CB_TXT);
	                return false;
	            },
	            complete: _cCb
	        });
	    };
	
	    var ajax_error = function(res){
	        throw Error('ajax请求报错');
	    };
	
	    var apiAjax = function(url, type, data, cb, error){
	        var self = this;
	        return $.ajax({
	            url: url,
	            type: type,
	            data: data,
	            success: cb,
	            error: error || ajax_error
	        });
	    };
	
	    var service = {
	        web: {
	            getItem: function(id, cb){
	                return apiAjax('/apic/item/' + id, 'GET', {}, cb);
	            }
	        },
	        user: {
	            // 个人中心
	            home: function(cb){
	                return apiAjax('/apic/user/userHomeAsy', 'GET', {}, cb);
	            },
	            //是否显示验证码
	            loginShowCode:function(data,cb){
	                return apiAjax('/apic/show', 'GET', data, cb);
	            },
	            // 账户余额
	            userMoney: function(cb){
	                return apiAjax('/apic/user/uMoney','GET',{}, cb);
	            },
	            // 个人中心 收藏商品分类
	            favCat: function (cb) {
	                return apiAjax('/apic/user/favoriteItem/itemCategory','GET',{},cb);
	            },
	            favAdd: function(data, cb) {
	                return apiAjax('/apic/user/favoriteItem/add', 'POST', data, cb);
	            },
	            // 个人中心 收藏商品列表
	            favList: function (data, cb, err) {
	                return apiAjax('/apic/user/favorite','GET',data,cb, err);
	            },
	            favDownList: function(data, cb) {
	                return apiAjax('/apic/user/favoriteItem/down/list','GET',data,cb);
	            },
	            favCancel: function(data, cb){
	                return apiAjax('/apic/user/favoriteItem/cancel','POST',data,cb);
	            },
	            favShopAdd: function(data, cb) {
	                return apiAjax('/apic/user/favoriteShop/add', 'POST', data, cb);
	            },
	            favShopCancel: function(data, cb){
	                return apiAjax('/apic/user/favoriteShop/cancel','POST',data,cb);
	            },
	            historyCat: function (cb) {
	                return apiAjax('/apic/user/favoriteItem/itemCategory','GET',{},cb);
	            },
	            historyList: function (data, cb, err) {
	                return apiAjax('/apic/user/favoriteUpload/list','GET',data,cb, err);
	            },
	            historyDownList: function(data, cb) {
	                return apiAjax('/apic/user/favoriteUpload/down/list','GET',data,cb);
	            },
	            historyCancel: function(data, cb){
	                return apiAjax('/apic/user/favoriteUpload/cancel', 'POST', data, cb);
	            }
	        },
	        account: {
	            // 登录
	            login: function(data, cb){
	                apiAjax('/apic/login', 'POST', data, cb);
	            },
	            // 邮箱激活
	            doActiveEmail: function(data, cb){
	                apiAjax('/apic/verifyEmailValidateCode', 'POST', data, cb);
	            },
	            // 发送绑定邮箱邮件
	            getBindEmail: function(data, cb){
	                apiAjax('/apic/activateEmail', 'POST', data, cb);
	            }
	        },
	        address: {
	            list: function(data, cb){
	                apiAjax('/apic/user/address/list', 'GET', data, cb);
	            },
	            save: function(data, cb){
	                apiAjax('/apic/user/address/save', 'POST', data, cb);
	            },
	            deletes: function(id, cb){
	                apiAjax('/apic/user/address/delete/' + id, 'POST', {}, cb);
	            },
	            setDefault: function(id, data, cb){
	                apiAjax('/apic/user/address/setDefault/' + id, 'POST', data, cb);
	            }
	        },
	        order: {
	            // 订单详情
	            detail: function(data, cb){
	                apiAjax('/apic/user/order_detail', 'GET', data, cb);
	            },
	            // 确认订单列表
	            confirmList: function(data, cb){
	                apiAjax('/apic/user/orderConfirmList', 'GET', data, cb);
	            },
	            // 异步调用提交订单
	            confirm: function (data, cb, error) {
	                apiAjax('/apic/user/order_confirm', 'POST', data, cb, error);
	            },
	            deletes: function(id, cb){
	                apiAjax('/apic/user/order_delete/' + id , 'POST', {}, cb);
	            },
	            // 个人中心 我的订单列表
	            list: function(data, cb) {
	                apiAjax('/apic/user/orders', 'GET', data, cb);
	            },
	            // 拿货记录信息
	            getTakeList: function(data, cb){
	                apiAjax('/apic/user/order_track_list', 'GET', data, cb);
	            },
	            // 余额支付
	            payByBalance: function(data, cb){
	                apiAjax('/apic/user/bzhifu', 'POST', data, cb);
	            }
	        },
	        // 档口中心
	        shop: {
	            list: function(cb){
	                apiAjax('/apic/user/shop/list', 'GET', {}, cb);
	            },
	            stockingList: function(shopId, cb){
	                apiAjax('/apic/user/pangge/stock/' + shopId, 'GET', {}, cb);
	            },
	            setStockSku: function(data, cb){
	                apiAjax('/apic/user/pangge/stock/set_status', 'POST', data, cb);
	            },
	            getFinancial: function(data, cb){
	                apiAjax('/apic/user/getFinancial', 'GET', data, cb);
	            },
	            saveFinancial: function(data, cb){
	                apiAjax('/apic/user/saveFinancial', 'POST', data, cb);
	            },
	            getItem: function(itemId, cb){
	                apiAjax('/apic/itemInfo/' + itemId, 'GET', {}, cb);
	            },
	            orderList: function(shopId, data, cb){
	                apiAjax('/apic/user/shopOrders/' + shopId, 'GET', data, cb);
	            },
	            updateItem: function(itemId, data, cb){
	                apiAjax('/apic/user/item/update/' + itemId, 'POST', data, cb);
	            }
	        },
	        // 退货退款
	        refund: {
	            list: function(data, cb){
	                apiAjax('/apic/user/order_refund_list', 'GET', data, cb);
	            },
	            add: function(data, cb){
	                apiAjax('/apic/user/order_refund_add', 'POST', data, cb);
	            },
	            payConfirm: function(data, cb){
	                apiAjax('/apic/user/refund_pay_confirm', 'GET', data, cb);
	            },
	            returnList: function(data, cb){
	                apiAjax('/apic/user/order_refund_record', 'GET', data, cb);
	            }
	        },
	        cms: {
	            getHelpPage: function(data, cb){
	                return $.ajax({
	                    url: _WEB_Cfg.actUrl + data.page,
	                    type: 'get',
	                    dataType: 'html',
	                    success: cb,
	                    error: this.ajax_error
	                });
	            },
	            getDataJsonp: function(data, cb){
	                return $.ajax({
	                    url: _WEB_Cfg.actUrl + '/data/' + data.page + '.jsonp',
	                    type: 'get',
	                    dataType: 'jsonp',
	                    jsonpCallback: data.page,
	                    success: cb,
	                    error: ajax_error
	                });
	            },
	            getSearchList: function(cb){
	                return $.ajax({
	                    url: _WEB_Cfg.actUrl + '/help/search.jsonp',
	                    type: 'get',
	                    success: cb,
	                    dataType: 'jsonp',
	                    jsonpCallback: 'jsonp1',
	                    error: ajax_error
	                });
	            }
	        },
	        cart: {
	            /*
	             * 购物车属性修改
	             * ?id=1586&item_id=2018630&color=黑色1&color_id=1627207:28341&size=S&size_id=20509:28314&vskuid=1
	             * */
	            updateProperty: function (data, cb) {
	                apiAjax('/apic/user/cart/updateProperty', 'POST', data, cb);
	            },
	                        /*
	             * 删除购物车*/
	            deletes: function (data, cb) {
	                apiAjax('/apic/user/cart/delete', 'POST', data, cb);
	            },
	                        /*
	             * 购物车移到收藏*/
	            move: function (data, cb) {
	                apiAjax('/apic/user/cart/move', 'POST', data, cb);
	            },
	                        /*
	             * 购物车修改数量*/
	            update: function (data, cb) {
	                apiAjax('/apic/user/cart/update', 'POST', data, cb);
	            },
	            /*
	             * 购物车列表*/
	            list: function (data, cb, errcb) {
	                apiAjax('/apic/user/cart/list', 'GET', data, cb, errcb);
	            },
	            /*
	             * 加密购物车ids
	             * ?ids=1,3,4
	             * */
	            eids: function (data, cb) {
	                apiAjax('/apic/user/eids', 'POST', data, cb);
	            }
	        },
	        purchase: {
	            /*
	             * 拿货单列表*/
	            list: function (data, cb, errcb) {
	                apiAjax('/apic/user/purchase/list', 'GET', {}, cb, errcb);
	            },
	            /*
	             * 拿货单修改数量*/
	            update: function (data, cb) {
	                apiAjax('/apic/user/purchase/update', 'POST', data, cb);
	            },
	            /*
	             * 拿货单属性修改
	             * */
	            updateProperty: function (data, cb) {
	                apiAjax('/apic/user/purchase/updateProperty', 'POST', data, cb);
	            },
	            /*
	             * 删除拿货单*/
	            deletes: function (data, cb) {
	                apiAjax('/apic/user/purchase/delete', 'POST', data, cb);
	            },
	            /*
	             * 拿货单移到收藏*/
	            move: function (data, cb) {
	                apiAjax('/apic/user/purchase/move', 'POST', data, cb);
	            }
	        },
	        // 潮流鞋靴-每日新款
	        shoesDayNewList: function(data, cb) {
	            return $.ajax({
	                url: '/apic/dayNewList',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 档口租赁
	        shopLeaseTop: function(data, cb) {
	            return $.ajax({
	                url: '/apic/shopLease/top',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        userShopLeaseRefresh: function(data, cb) {
	            return $.ajax({
	                url: '/apic/user/shopLease/refresh',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // bid, pageSize,currentPage
	        shopLeaseList: function(data, cb) {
	            return $.ajax({
	                url: '/apic/shopLease/list',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 个人中心 取消订单原因列表
	        orderCancelReasons: function(data, cb){
	            return $.ajax({
	                url: '/apic/orderCancelReasons',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 获取需要取消的订单的详情
	        orderCancelDetail: function(data, cb){
	            return $.ajax({
	                url: '/apic/user/order_cancel_details',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        userCancelOrder: function(data, cb){
	            return $.ajax({
	                url: '/apic/user/order_cancel_add',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 获取运费
	        userGetExpress: function(data, cb){
	            return $.ajax({
	                url: '/apic/user/queryExpressByOrder',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /// 个人中心 退货退款
	        // 是否支持退货
	        userRefundCheck: function(data, cb){
	            return $.ajax({
	                url: '/apic/user/canRefund',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /// 个人中心 退货退款
	        // 个人中心 获取商品sku
	        getGoodsSku: function(id, data, cb, err) {
	             return $.ajax({
	                 url: '/apic/getskumap/' + id,
	                 type: 'GET',
	                 data: data,
	                 success: cb,
	                 error: err
	             });
	         },
	        userConfirmGoods: function(data, cb) {
	            return $.ajax({
	                url: '/apic/user/confirm_goods',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 个人中心 个人价格模板获取
	        userPriceTemplate: function(data, cb) {
	            return $.ajax({
	                url: '/apic/uploadRecordDiscount/get',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 个人中心 个人价格模板设置
	        userPriceTemplateSet: function(data, cb) {
	            return $.ajax({
	                url: '/apic/uploadRecordDiscount/save',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 个人中心 数据包
	        userPacketList: function (cb) {
	            return $.ajax({
	                url: '/apic/user/csvRecord/list',
	                type: 'GET',
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 个人中心 数据包 商品列表
	        userPacketItemsList: function (data,cb) {
	            return $.ajax({
	                url: '/apic/user/csvRecord/list/'+ data.id,
	                type: 'GET',
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 个人中心 创建数据包商品详情
	        userPacketDetailList: function (data,cb) {
	            return $.ajax({
	                url: '/apic/getItems/'+ data.ids,
	                type: 'GET',
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /*
	         * 个人中心 创建数据包商品详情
	         * */
	        userPacketCreate: function(data, cb, complete){
	            return $.ajax({
	                url: 'http://shujubao.vvic.com/CsvMaker',
	                dataType: 'jsonp',
	                data: data,
	                success: cb,
	                error: ajax_error,
	                tjsonp:'callback'
	            });
	        },
	        // 个人中心 删除数据包
	        userPacketDelete: function(data, cb){
	            return $.ajax({
	                url: 'http://shujubao.vvic.com/CsvDelete',
	                type: 'post',
	                data: data,
	                success: cb,
	                error: ajax_error,
	                timeout: 120000
	            });
	        },
	        // 个人中心 交易记录
	        userBillList: function(data, cb){
	            return $.ajax({
	                url: '/apic/user/trade/trade_list',
	                type: 'get',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 登录详细信息
	        loginUMoreInfo: function (data,cb) {
	            return $.ajax({
	                url: '/apic/loginUMoreInfo',
	                type: 'GET',
	                data:data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 登录信息
	        // @return cart_amount 购物车数量
	        loginUinfo: function (data,cb) {
	            return $.ajax({
	                url: '/apic/loginUserInfo',
	                type: 'GET',
	                data:data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 查询快递类型
	        queryExpress: function (data,cb) {
	            return $.ajax({
	                url: '/apic/user/queryExpress',
	                type: 'GET',
	                data:data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 支付确认页面 orderId
	        userPayConfirm: function (data,cb) {
	            return $.ajax({
	                url: '/apic/user/pay_confirm',
	                type: 'POST',
	                data:data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 支付提交 orderId
	        userPaySubmit: function (data,cb) {
	            return $.ajax({
	                url: '/apic/user/pay_submit',
	                type: 'POST',
	                data:data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 异步调用提交修改订单
	        userOrderUpdate: function (data,cb) {
	            return $.ajax({
	                url: '/apic/user/order_update',
	                type: 'POST',
	                data:data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 个人中心 打印拿货单
	        // ?ids=40,41
	        userPrintList: function (data,cb) {
	            return $.ajax({
	                url: '/apic/user/purchase/plist',
	                type: 'GET',
	                data:data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /*
	         * 个人中心 关注档口
	         * */
	        userFollowList: function (data, cb) {
	            return $.ajax({
	                url: '/apic/user/favoriteShop/list',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /*
	         * 个人中心 取消关注档口
	         * shopId
	         * */
	        userFollowCancel: function (data, cb) {
	            return $.ajax({
	                url: '/apic/user/favoriteShop/cancel',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /*
	         * 个人中心 消息列表
	         * */
	        userMessageList: function (data, cb) {
	            return $.ajax({
	                url: '/apic/user/message/list',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /*
	         * 每日新款更新的数量*/
	        newamount: function (cb) {
	            return $.ajax({
	                url: '/apic/newamount',
	                type: 'GET',
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /*
	         * 档口下架商品*/
	        shopDown: function (data, cb) {
	            return $.ajax({
	                url: '/apic/shop/down/' + data.id,
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /*
	         * 档口上下架记录*/
	        shopRecordDetail: function (data, cb) {
	            return $.ajax({
	                url: '/apic/shop/record/detail/' + data.id,
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /*
	         * 搜索结果*/
	        searchAsy: function (data, cb) {
	            return $.ajax({
	                url: '/apic/searchAsy',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        /*
	         * 找同款结果*/
	        sameStyleAsy: function (data, cb) {
	            return $.ajax({
	                url: '/apic/samestyleAsy',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        renderShopData: function (data, cb) {
	            if (!$.cookie('uid')) {
	                return;
	            }
	            return $.ajax({
	                url: '/api/user/statShopDateData/list',
	                type: 'GET',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        getMessageUnRead: function (cb) {
	            if (!$.cookie('uid')) {
	                return;
	            }
	            return $.ajax({
	                url: '/api/user/getMessageUnRead',
	                type: 'GET',
	                success: cb,
	                error: ajax_error
	            });
	        },
	        logout: function (data, cb) {
	            return $.ajax({
	                url: '/apic/user/logout',
	                type: 'GET',
	                success: function (res) {
	                    if($.isFunction(cb)) {
	                        cb(res);
	                    }
	                    var dateTime = new Date(new Date() - 24 * 60 * 60 * 1000);
	                    $.cookie('ut', '', {path: '/', expires: dateTime});
	                    $.cookie('uid', '', {path: '/', domain: '.vvic.com', expires: dateTime});
	                    $.cookie('umc', '', {path: '/', expires: dateTime});
	                    $.cookie('defaultShopId', '', {path: '/', expires: dateTime});
	                    $.cookie('defaultShopName', '', {path: '/', expires: dateTime});
	                    $.cookie('shopName', '', {path: '/', expires: dateTime});
	                    $.cookie('shopId', '', {path: '/', expires: dateTime});
	                    $.cookie('pn', '', {path: '/', expires: dateTime});
	                    $.cookie('uno', '', {path: '/', expires: dateTime});
	                    location.href = '/login.html';
	
	                },
	                error: ajax_error
	            });
	        },
	        getSmsCode: function(data, cb){
	            apiAjax('/apic/user/getSmsCode', 'GET', data, cb);
	        },
	        getSmsPas: function(data, cb){
	            apiAjax('/apic/user/getSmsPas', 'GET', data, cb);
	        },
	        // 用户中心 添加提现账户
	        addWithdrawAccount: function(data, cb){
	            return $.ajax({
	                url: '/apic/user/add_bank_account',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        // 用户中心 修改提现账户
	        updateWithdrawAccount: function(data, cb){
	            return $.ajax({
	                url: '/apic/user/update_bank_account',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        comfirmWithdraw: function(data, cb){
	            return $.ajax({
	                url: '/apic/user/withdraws_cash_confirm',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        },
	        doWithdraw: function(data, cb){
	            return $.ajax({
	                url: '/apic/user/withdraws_cash_post',
	                type: 'POST',
	                data: data,
	                success: cb,
	                error: ajax_error
	            });
	        }
	    };
	
	    apiExports.service = service;
	
	    apiExports.getData = getData;
	    module.exports =  apiExports;


/***/ },
/* 4 */,
/* 5 */,
/* 6 */
/***/ function(module, exports, require) {

	var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;/*! jQuery v1.11.1 | (c) 2005, 2014 jQuery Foundation, Inc. | jquery.org/license */
	    !function(a,b){"object"==typeof module&&"object"==typeof module.exports?module.exports=a.document?b(a,!0):function(a){if(!a.document)throw new Error("jQuery requires a window with a document");return b(a)}:b(a)}("undefined"!=typeof window?window:this,function(a,b){var c=[],d=c.slice,e=c.concat,f=c.push,g=c.indexOf,h={},i=h.toString,j=h.hasOwnProperty,k={},l="1.11.1",m=function(a,b){return new m.fn.init(a,b)},n=/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g,o=/^-ms-/,p=/-([\da-z])/gi,q=function(a,b){return b.toUpperCase()};m.fn=m.prototype={jquery:l,constructor:m,selector:"",length:0,toArray:function(){return d.call(this)},get:function(a){return null!=a?0>a?this[a+this.length]:this[a]:d.call(this)},pushStack:function(a){var b=m.merge(this.constructor(),a);return b.prevObject=this,b.context=this.context,b},each:function(a,b){return m.each(this,a,b)},map:function(a){return this.pushStack(m.map(this,function(b,c){return a.call(b,c,b)}))},slice:function(){return this.pushStack(d.apply(this,arguments))},first:function(){return this.eq(0)},last:function(){return this.eq(-1)},eq:function(a){var b=this.length,c=+a+(0>a?b:0);return this.pushStack(c>=0&&b>c?[this[c]]:[])},end:function(){return this.prevObject||this.constructor(null)},push:f,sort:c.sort,splice:c.splice},m.extend=m.fn.extend=function(){var a,b,c,d,e,f,g=arguments[0]||{},h=1,i=arguments.length,j=!1;for("boolean"==typeof g&&(j=g,g=arguments[h]||{},h++),"object"==typeof g||m.isFunction(g)||(g={}),h===i&&(g=this,h--);i>h;h++)if(null!=(e=arguments[h]))for(d in e)a=g[d],c=e[d],g!==c&&(j&&c&&(m.isPlainObject(c)||(b=m.isArray(c)))?(b?(b=!1,f=a&&m.isArray(a)?a:[]):f=a&&m.isPlainObject(a)?a:{},g[d]=m.extend(j,f,c)):void 0!==c&&(g[d]=c));return g},m.extend({expando:"jQuery"+(l+Math.random()).replace(/\D/g,""),isReady:!0,error:function(a){throw new Error(a)},noop:function(){},isFunction:function(a){return"function"===m.type(a)},isArray:Array.isArray||function(a){return"array"===m.type(a)},isWindow:function(a){return null!=a&&a==a.window},isNumeric:function(a){return!m.isArray(a)&&a-parseFloat(a)>=0},isEmptyObject:function(a){var b;for(b in a)return!1;return!0},isPlainObject:function(a){var b;if(!a||"object"!==m.type(a)||a.nodeType||m.isWindow(a))return!1;try{if(a.constructor&&!j.call(a,"constructor")&&!j.call(a.constructor.prototype,"isPrototypeOf"))return!1}catch(c){return!1}if(k.ownLast)for(b in a)return j.call(a,b);for(b in a);return void 0===b||j.call(a,b)},type:function(a){return null==a?a+"":"object"==typeof a||"function"==typeof a?h[i.call(a)]||"object":typeof a},globalEval:function(b){b&&m.trim(b)&&(a.execScript||function(b){a.eval.call(a,b)})(b)},camelCase:function(a){return a.replace(o,"ms-").replace(p,q)},nodeName:function(a,b){return a.nodeName&&a.nodeName.toLowerCase()===b.toLowerCase()},each:function(a,b,c){var d,e=0,f=a.length,g=r(a);if(c){if(g){for(;f>e;e++)if(d=b.apply(a[e],c),d===!1)break}else for(e in a)if(d=b.apply(a[e],c),d===!1)break}else if(g){for(;f>e;e++)if(d=b.call(a[e],e,a[e]),d===!1)break}else for(e in a)if(d=b.call(a[e],e,a[e]),d===!1)break;return a},trim:function(a){return null==a?"":(a+"").replace(n,"")},makeArray:function(a,b){var c=b||[];return null!=a&&(r(Object(a))?m.merge(c,"string"==typeof a?[a]:a):f.call(c,a)),c},inArray:function(a,b,c){var d;if(b){if(g)return g.call(b,a,c);for(d=b.length,c=c?0>c?Math.max(0,d+c):c:0;d>c;c++)if(c in b&&b[c]===a)return c}return-1},merge:function(a,b){var c=+b.length,d=0,e=a.length;while(c>d)a[e++]=b[d++];if(c!==c)while(void 0!==b[d])a[e++]=b[d++];return a.length=e,a},grep:function(a,b,c){for(var d,e=[],f=0,g=a.length,h=!c;g>f;f++)d=!b(a[f],f),d!==h&&e.push(a[f]);return e},map:function(a,b,c){var d,f=0,g=a.length,h=r(a),i=[];if(h)for(;g>f;f++)d=b(a[f],f,c),null!=d&&i.push(d);else for(f in a)d=b(a[f],f,c),null!=d&&i.push(d);return e.apply([],i)},guid:1,proxy:function(a,b){var c,e,f;return"string"==typeof b&&(f=a[b],b=a,a=f),m.isFunction(a)?(c=d.call(arguments,2),e=function(){return a.apply(b||this,c.concat(d.call(arguments)))},e.guid=a.guid=a.guid||m.guid++,e):void 0},now:function(){return+new Date},support:k}),m.each("Boolean Number String Function Array Date RegExp Object Error".split(" "),function(a,b){h["[object "+b+"]"]=b.toLowerCase()});function r(a){var b=a.length,c=m.type(a);return"function"===c||m.isWindow(a)?!1:1===a.nodeType&&b?!0:"array"===c||0===b||"number"==typeof b&&b>0&&b-1 in a}var s=function(a){var b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u="sizzle"+-new Date,v=a.document,w=0,x=0,y=gb(),z=gb(),A=gb(),B=function(a,b){return a===b&&(l=!0),0},C="undefined",D=1<<31,E={}.hasOwnProperty,F=[],G=F.pop,H=F.push,I=F.push,J=F.slice,K=F.indexOf||function(a){for(var b=0,c=this.length;c>b;b++)if(this[b]===a)return b;return-1},L="checked|selected|async|autofocus|autoplay|controls|defer|disabled|hidden|ismap|loop|multiple|open|readonly|required|scoped",M="[\\x20\\t\\r\\n\\f]",N="(?:\\\\.|[\\w-]|[^\\x00-\\xa0])+",O=N.replace("w","w#"),P="\\["+M+"*("+N+")(?:"+M+"*([*^$|!~]?=)"+M+"*(?:'((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\"|("+O+"))|)"+M+"*\\]",Q=":("+N+")(?:\\((('((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\")|((?:\\\\.|[^\\\\()[\\]]|"+P+")*)|.*)\\)|)",R=new RegExp("^"+M+"+|((?:^|[^\\\\])(?:\\\\.)*)"+M+"+$","g"),S=new RegExp("^"+M+"*,"+M+"*"),T=new RegExp("^"+M+"*([>+~]|"+M+")"+M+"*"),U=new RegExp("="+M+"*([^\\]'\"]*?)"+M+"*\\]","g"),V=new RegExp(Q),W=new RegExp("^"+O+"$"),X={ID:new RegExp("^#("+N+")"),CLASS:new RegExp("^\\.("+N+")"),TAG:new RegExp("^("+N.replace("w","w*")+")"),ATTR:new RegExp("^"+P),PSEUDO:new RegExp("^"+Q),CHILD:new RegExp("^:(only|first|last|nth|nth-last)-(child|of-type)(?:\\("+M+"*(even|odd|(([+-]|)(\\d*)n|)"+M+"*(?:([+-]|)"+M+"*(\\d+)|))"+M+"*\\)|)","i"),bool:new RegExp("^(?:"+L+")$","i"),needsContext:new RegExp("^"+M+"*[>+~]|:(even|odd|eq|gt|lt|nth|first|last)(?:\\("+M+"*((?:-\\d)?\\d*)"+M+"*\\)|)(?=[^-]|$)","i")},Y=/^(?:input|select|textarea|button)$/i,Z=/^h\d$/i,$=/^[^{]+\{\s*\[native \w/,_=/^(?:#([\w-]+)|(\w+)|\.([\w-]+))$/,ab=/[+~]/,bb=/'|\\/g,cb=new RegExp("\\\\([\\da-f]{1,6}"+M+"?|("+M+")|.)","ig"),db=function(a,b,c){var d="0x"+b-65536;return d!==d||c?b:0>d?String.fromCharCode(d+65536):String.fromCharCode(d>>10|55296,1023&d|56320)};try{I.apply(F=J.call(v.childNodes),v.childNodes),F[v.childNodes.length].nodeType}catch(eb){I={apply:F.length?function(a,b){H.apply(a,J.call(b))}:function(a,b){var c=a.length,d=0;while(a[c++]=b[d++]);a.length=c-1}}}function fb(a,b,d,e){var f,h,j,k,l,o,r,s,w,x;if((b?b.ownerDocument||b:v)!==n&&m(b),b=b||n,d=d||[],!a||"string"!=typeof a)return d;if(1!==(k=b.nodeType)&&9!==k)return[];if(p&&!e){if(f=_.exec(a))if(j=f[1]){if(9===k){if(h=b.getElementById(j),!h||!h.parentNode)return d;if(h.id===j)return d.push(h),d}else if(b.ownerDocument&&(h=b.ownerDocument.getElementById(j))&&t(b,h)&&h.id===j)return d.push(h),d}else{if(f[2])return I.apply(d,b.getElementsByTagName(a)),d;if((j=f[3])&&c.getElementsByClassName&&b.getElementsByClassName)return I.apply(d,b.getElementsByClassName(j)),d}if(c.qsa&&(!q||!q.test(a))){if(s=r=u,w=b,x=9===k&&a,1===k&&"object"!==b.nodeName.toLowerCase()){o=g(a),(r=b.getAttribute("id"))?s=r.replace(bb,"\\$&"):b.setAttribute("id",s),s="[id='"+s+"'] ",l=o.length;while(l--)o[l]=s+qb(o[l]);w=ab.test(a)&&ob(b.parentNode)||b,x=o.join(",")}if(x)try{return I.apply(d,w.querySelectorAll(x)),d}catch(y){}finally{r||b.removeAttribute("id")}}}return i(a.replace(R,"$1"),b,d,e)}function gb(){var a=[];function b(c,e){return a.push(c+" ")>d.cacheLength&&delete b[a.shift()],b[c+" "]=e}return b}function hb(a){return a[u]=!0,a}function ib(a){var b=n.createElement("div");try{return!!a(b)}catch(c){return!1}finally{b.parentNode&&b.parentNode.removeChild(b),b=null}}function jb(a,b){var c=a.split("|"),e=a.length;while(e--)d.attrHandle[c[e]]=b}function kb(a,b){var c=b&&a,d=c&&1===a.nodeType&&1===b.nodeType&&(~b.sourceIndex||D)-(~a.sourceIndex||D);if(d)return d;if(c)while(c=c.nextSibling)if(c===b)return-1;return a?1:-1}function lb(a){return function(b){var c=b.nodeName.toLowerCase();return"input"===c&&b.type===a}}function mb(a){return function(b){var c=b.nodeName.toLowerCase();return("input"===c||"button"===c)&&b.type===a}}function nb(a){return hb(function(b){return b=+b,hb(function(c,d){var e,f=a([],c.length,b),g=f.length;while(g--)c[e=f[g]]&&(c[e]=!(d[e]=c[e]))})})}function ob(a){return a&&typeof a.getElementsByTagName!==C&&a}c=fb.support={},f=fb.isXML=function(a){var b=a&&(a.ownerDocument||a).documentElement;return b?"HTML"!==b.nodeName:!1},m=fb.setDocument=function(a){var b,e=a?a.ownerDocument||a:v,g=e.defaultView;return e!==n&&9===e.nodeType&&e.documentElement?(n=e,o=e.documentElement,p=!f(e),g&&g!==g.top&&(g.addEventListener?g.addEventListener("unload",function(){m()},!1):g.attachEvent&&g.attachEvent("onunload",function(){m()})),c.attributes=ib(function(a){return a.className="i",!a.getAttribute("className")}),c.getElementsByTagName=ib(function(a){return a.appendChild(e.createComment("")),!a.getElementsByTagName("*").length}),c.getElementsByClassName=$.test(e.getElementsByClassName)&&ib(function(a){return a.innerHTML="<div class='a'></div><div class='a i'></div>",a.firstChild.className="i",2===a.getElementsByClassName("i").length}),c.getById=ib(function(a){return o.appendChild(a).id=u,!e.getElementsByName||!e.getElementsByName(u).length}),c.getById?(d.find.ID=function(a,b){if(typeof b.getElementById!==C&&p){var c=b.getElementById(a);return c&&c.parentNode?[c]:[]}},d.filter.ID=function(a){var b=a.replace(cb,db);return function(a){return a.getAttribute("id")===b}}):(delete d.find.ID,d.filter.ID=function(a){var b=a.replace(cb,db);return function(a){var c=typeof a.getAttributeNode!==C&&a.getAttributeNode("id");return c&&c.value===b}}),d.find.TAG=c.getElementsByTagName?function(a,b){return typeof b.getElementsByTagName!==C?b.getElementsByTagName(a):void 0}:function(a,b){var c,d=[],e=0,f=b.getElementsByTagName(a);if("*"===a){while(c=f[e++])1===c.nodeType&&d.push(c);return d}return f},d.find.CLASS=c.getElementsByClassName&&function(a,b){return typeof b.getElementsByClassName!==C&&p?b.getElementsByClassName(a):void 0},r=[],q=[],(c.qsa=$.test(e.querySelectorAll))&&(ib(function(a){a.innerHTML="<select msallowclip=''><option selected=''></option></select>",a.querySelectorAll("[msallowclip^='']").length&&q.push("[*^$]="+M+"*(?:''|\"\")"),a.querySelectorAll("[selected]").length||q.push("\\["+M+"*(?:value|"+L+")"),a.querySelectorAll(":checked").length||q.push(":checked")}),ib(function(a){var b=e.createElement("input");b.setAttribute("type","hidden"),a.appendChild(b).setAttribute("name","D"),a.querySelectorAll("[name=d]").length&&q.push("name"+M+"*[*^$|!~]?="),a.querySelectorAll(":enabled").length||q.push(":enabled",":disabled"),a.querySelectorAll("*,:x"),q.push(",.*:")})),(c.matchesSelector=$.test(s=o.matches||o.webkitMatchesSelector||o.mozMatchesSelector||o.oMatchesSelector||o.msMatchesSelector))&&ib(function(a){c.disconnectedMatch=s.call(a,"div"),s.call(a,"[s!='']:x"),r.push("!=",Q)}),q=q.length&&new RegExp(q.join("|")),r=r.length&&new RegExp(r.join("|")),b=$.test(o.compareDocumentPosition),t=b||$.test(o.contains)?function(a,b){var c=9===a.nodeType?a.documentElement:a,d=b&&b.parentNode;return a===d||!(!d||1!==d.nodeType||!(c.contains?c.contains(d):a.compareDocumentPosition&&16&a.compareDocumentPosition(d)))}:function(a,b){if(b)while(b=b.parentNode)if(b===a)return!0;return!1},B=b?function(a,b){if(a===b)return l=!0,0;var d=!a.compareDocumentPosition-!b.compareDocumentPosition;return d?d:(d=(a.ownerDocument||a)===(b.ownerDocument||b)?a.compareDocumentPosition(b):1,1&d||!c.sortDetached&&b.compareDocumentPosition(a)===d?a===e||a.ownerDocument===v&&t(v,a)?-1:b===e||b.ownerDocument===v&&t(v,b)?1:k?K.call(k,a)-K.call(k,b):0:4&d?-1:1)}:function(a,b){if(a===b)return l=!0,0;var c,d=0,f=a.parentNode,g=b.parentNode,h=[a],i=[b];if(!f||!g)return a===e?-1:b===e?1:f?-1:g?1:k?K.call(k,a)-K.call(k,b):0;if(f===g)return kb(a,b);c=a;while(c=c.parentNode)h.unshift(c);c=b;while(c=c.parentNode)i.unshift(c);while(h[d]===i[d])d++;return d?kb(h[d],i[d]):h[d]===v?-1:i[d]===v?1:0},e):n},fb.matches=function(a,b){return fb(a,null,null,b)},fb.matchesSelector=function(a,b){if((a.ownerDocument||a)!==n&&m(a),b=b.replace(U,"='$1']"),!(!c.matchesSelector||!p||r&&r.test(b)||q&&q.test(b)))try{var d=s.call(a,b);if(d||c.disconnectedMatch||a.document&&11!==a.document.nodeType)return d}catch(e){}return fb(b,n,null,[a]).length>0},fb.contains=function(a,b){return(a.ownerDocument||a)!==n&&m(a),t(a,b)},fb.attr=function(a,b){(a.ownerDocument||a)!==n&&m(a);var e=d.attrHandle[b.toLowerCase()],f=e&&E.call(d.attrHandle,b.toLowerCase())?e(a,b,!p):void 0;return void 0!==f?f:c.attributes||!p?a.getAttribute(b):(f=a.getAttributeNode(b))&&f.specified?f.value:null},fb.error=function(a){throw new Error("Syntax error, unrecognized expression: "+a)},fb.uniqueSort=function(a){var b,d=[],e=0,f=0;if(l=!c.detectDuplicates,k=!c.sortStable&&a.slice(0),a.sort(B),l){while(b=a[f++])b===a[f]&&(e=d.push(f));while(e--)a.splice(d[e],1)}return k=null,a},e=fb.getText=function(a){var b,c="",d=0,f=a.nodeType;if(f){if(1===f||9===f||11===f){if("string"==typeof a.textContent)return a.textContent;for(a=a.firstChild;a;a=a.nextSibling)c+=e(a)}else if(3===f||4===f)return a.nodeValue}else while(b=a[d++])c+=e(b);return c},d=fb.selectors={cacheLength:50,createPseudo:hb,match:X,attrHandle:{},find:{},relative:{">":{dir:"parentNode",first:!0}," ":{dir:"parentNode"},"+":{dir:"previousSibling",first:!0},"~":{dir:"previousSibling"}},preFilter:{ATTR:function(a){return a[1]=a[1].replace(cb,db),a[3]=(a[3]||a[4]||a[5]||"").replace(cb,db),"~="===a[2]&&(a[3]=" "+a[3]+" "),a.slice(0,4)},CHILD:function(a){return a[1]=a[1].toLowerCase(),"nth"===a[1].slice(0,3)?(a[3]||fb.error(a[0]),a[4]=+(a[4]?a[5]+(a[6]||1):2*("even"===a[3]||"odd"===a[3])),a[5]=+(a[7]+a[8]||"odd"===a[3])):a[3]&&fb.error(a[0]),a},PSEUDO:function(a){var b,c=!a[6]&&a[2];return X.CHILD.test(a[0])?null:(a[3]?a[2]=a[4]||a[5]||"":c&&V.test(c)&&(b=g(c,!0))&&(b=c.indexOf(")",c.length-b)-c.length)&&(a[0]=a[0].slice(0,b),a[2]=c.slice(0,b)),a.slice(0,3))}},filter:{TAG:function(a){var b=a.replace(cb,db).toLowerCase();return"*"===a?function(){return!0}:function(a){return a.nodeName&&a.nodeName.toLowerCase()===b}},CLASS:function(a){var b=y[a+" "];return b||(b=new RegExp("(^|"+M+")"+a+"("+M+"|$)"))&&y(a,function(a){return b.test("string"==typeof a.className&&a.className||typeof a.getAttribute!==C&&a.getAttribute("class")||"")})},ATTR:function(a,b,c){return function(d){var e=fb.attr(d,a);return null==e?"!="===b:b?(e+="","="===b?e===c:"!="===b?e!==c:"^="===b?c&&0===e.indexOf(c):"*="===b?c&&e.indexOf(c)>-1:"$="===b?c&&e.slice(-c.length)===c:"~="===b?(" "+e+" ").indexOf(c)>-1:"|="===b?e===c||e.slice(0,c.length+1)===c+"-":!1):!0}},CHILD:function(a,b,c,d,e){var f="nth"!==a.slice(0,3),g="last"!==a.slice(-4),h="of-type"===b;return 1===d&&0===e?function(a){return!!a.parentNode}:function(b,c,i){var j,k,l,m,n,o,p=f!==g?"nextSibling":"previousSibling",q=b.parentNode,r=h&&b.nodeName.toLowerCase(),s=!i&&!h;if(q){if(f){while(p){l=b;while(l=l[p])if(h?l.nodeName.toLowerCase()===r:1===l.nodeType)return!1;o=p="only"===a&&!o&&"nextSibling"}return!0}if(o=[g?q.firstChild:q.lastChild],g&&s){k=q[u]||(q[u]={}),j=k[a]||[],n=j[0]===w&&j[1],m=j[0]===w&&j[2],l=n&&q.childNodes[n];while(l=++n&&l&&l[p]||(m=n=0)||o.pop())if(1===l.nodeType&&++m&&l===b){k[a]=[w,n,m];break}}else if(s&&(j=(b[u]||(b[u]={}))[a])&&j[0]===w)m=j[1];else while(l=++n&&l&&l[p]||(m=n=0)||o.pop())if((h?l.nodeName.toLowerCase()===r:1===l.nodeType)&&++m&&(s&&((l[u]||(l[u]={}))[a]=[w,m]),l===b))break;return m-=e,m===d||m%d===0&&m/d>=0}}},PSEUDO:function(a,b){var c,e=d.pseudos[a]||d.setFilters[a.toLowerCase()]||fb.error("unsupported pseudo: "+a);return e[u]?e(b):e.length>1?(c=[a,a,"",b],d.setFilters.hasOwnProperty(a.toLowerCase())?hb(function(a,c){var d,f=e(a,b),g=f.length;while(g--)d=K.call(a,f[g]),a[d]=!(c[d]=f[g])}):function(a){return e(a,0,c)}):e}},pseudos:{not:hb(function(a){var b=[],c=[],d=h(a.replace(R,"$1"));return d[u]?hb(function(a,b,c,e){var f,g=d(a,null,e,[]),h=a.length;while(h--)(f=g[h])&&(a[h]=!(b[h]=f))}):function(a,e,f){return b[0]=a,d(b,null,f,c),!c.pop()}}),has:hb(function(a){return function(b){return fb(a,b).length>0}}),contains:hb(function(a){return function(b){return(b.textContent||b.innerText||e(b)).indexOf(a)>-1}}),lang:hb(function(a){return W.test(a||"")||fb.error("unsupported lang: "+a),a=a.replace(cb,db).toLowerCase(),function(b){var c;do if(c=p?b.lang:b.getAttribute("xml:lang")||b.getAttribute("lang"))return c=c.toLowerCase(),c===a||0===c.indexOf(a+"-");while((b=b.parentNode)&&1===b.nodeType);return!1}}),target:function(b){var c=a.location&&a.location.hash;return c&&c.slice(1)===b.id},root:function(a){return a===o},focus:function(a){return a===n.activeElement&&(!n.hasFocus||n.hasFocus())&&!!(a.type||a.href||~a.tabIndex)},enabled:function(a){return a.disabled===!1},disabled:function(a){return a.disabled===!0},checked:function(a){var b=a.nodeName.toLowerCase();return"input"===b&&!!a.checked||"option"===b&&!!a.selected},selected:function(a){return a.parentNode&&a.parentNode.selectedIndex,a.selected===!0},empty:function(a){for(a=a.firstChild;a;a=a.nextSibling)if(a.nodeType<6)return!1;return!0},parent:function(a){return!d.pseudos.empty(a)},header:function(a){return Z.test(a.nodeName)},input:function(a){return Y.test(a.nodeName)},button:function(a){var b=a.nodeName.toLowerCase();return"input"===b&&"button"===a.type||"button"===b},text:function(a){var b;return"input"===a.nodeName.toLowerCase()&&"text"===a.type&&(null==(b=a.getAttribute("type"))||"text"===b.toLowerCase())},first:nb(function(){return[0]}),last:nb(function(a,b){return[b-1]}),eq:nb(function(a,b,c){return[0>c?c+b:c]}),even:nb(function(a,b){for(var c=0;b>c;c+=2)a.push(c);return a}),odd:nb(function(a,b){for(var c=1;b>c;c+=2)a.push(c);return a}),lt:nb(function(a,b,c){for(var d=0>c?c+b:c;--d>=0;)a.push(d);return a}),gt:nb(function(a,b,c){for(var d=0>c?c+b:c;++d<b;)a.push(d);return a})}},d.pseudos.nth=d.pseudos.eq;for(b in{radio:!0,checkbox:!0,file:!0,password:!0,image:!0})d.pseudos[b]=lb(b);for(b in{submit:!0,reset:!0})d.pseudos[b]=mb(b);function pb(){}pb.prototype=d.filters=d.pseudos,d.setFilters=new pb,g=fb.tokenize=function(a,b){var c,e,f,g,h,i,j,k=z[a+" "];if(k)return b?0:k.slice(0);h=a,i=[],j=d.preFilter;while(h){(!c||(e=S.exec(h)))&&(e&&(h=h.slice(e[0].length)||h),i.push(f=[])),c=!1,(e=T.exec(h))&&(c=e.shift(),f.push({value:c,type:e[0].replace(R," ")}),h=h.slice(c.length));for(g in d.filter)!(e=X[g].exec(h))||j[g]&&!(e=j[g](e))||(c=e.shift(),f.push({value:c,type:g,matches:e}),h=h.slice(c.length));if(!c)break}return b?h.length:h?fb.error(a):z(a,i).slice(0)};function qb(a){for(var b=0,c=a.length,d="";c>b;b++)d+=a[b].value;return d}function rb(a,b,c){var d=b.dir,e=c&&"parentNode"===d,f=x++;return b.first?function(b,c,f){while(b=b[d])if(1===b.nodeType||e)return a(b,c,f)}:function(b,c,g){var h,i,j=[w,f];if(g){while(b=b[d])if((1===b.nodeType||e)&&a(b,c,g))return!0}else while(b=b[d])if(1===b.nodeType||e){if(i=b[u]||(b[u]={}),(h=i[d])&&h[0]===w&&h[1]===f)return j[2]=h[2];if(i[d]=j,j[2]=a(b,c,g))return!0}}}function sb(a){return a.length>1?function(b,c,d){var e=a.length;while(e--)if(!a[e](b,c,d))return!1;return!0}:a[0]}function tb(a,b,c){for(var d=0,e=b.length;e>d;d++)fb(a,b[d],c);return c}function ub(a,b,c,d,e){for(var f,g=[],h=0,i=a.length,j=null!=b;i>h;h++)(f=a[h])&&(!c||c(f,d,e))&&(g.push(f),j&&b.push(h));return g}function vb(a,b,c,d,e,f){return d&&!d[u]&&(d=vb(d)),e&&!e[u]&&(e=vb(e,f)),hb(function(f,g,h,i){var j,k,l,m=[],n=[],o=g.length,p=f||tb(b||"*",h.nodeType?[h]:h,[]),q=!a||!f&&b?p:ub(p,m,a,h,i),r=c?e||(f?a:o||d)?[]:g:q;if(c&&c(q,r,h,i),d){j=ub(r,n),d(j,[],h,i),k=j.length;while(k--)(l=j[k])&&(r[n[k]]=!(q[n[k]]=l))}if(f){if(e||a){if(e){j=[],k=r.length;while(k--)(l=r[k])&&j.push(q[k]=l);e(null,r=[],j,i)}k=r.length;while(k--)(l=r[k])&&(j=e?K.call(f,l):m[k])>-1&&(f[j]=!(g[j]=l))}}else r=ub(r===g?r.splice(o,r.length):r),e?e(null,g,r,i):I.apply(g,r)})}function wb(a){for(var b,c,e,f=a.length,g=d.relative[a[0].type],h=g||d.relative[" "],i=g?1:0,k=rb(function(a){return a===b},h,!0),l=rb(function(a){return K.call(b,a)>-1},h,!0),m=[function(a,c,d){return!g&&(d||c!==j)||((b=c).nodeType?k(a,c,d):l(a,c,d))}];f>i;i++)if(c=d.relative[a[i].type])m=[rb(sb(m),c)];else{if(c=d.filter[a[i].type].apply(null,a[i].matches),c[u]){for(e=++i;f>e;e++)if(d.relative[a[e].type])break;return vb(i>1&&sb(m),i>1&&qb(a.slice(0,i-1).concat({value:" "===a[i-2].type?"*":""})).replace(R,"$1"),c,e>i&&wb(a.slice(i,e)),f>e&&wb(a=a.slice(e)),f>e&&qb(a))}m.push(c)}return sb(m)}function xb(a,b){var c=b.length>0,e=a.length>0,f=function(f,g,h,i,k){var l,m,o,p=0,q="0",r=f&&[],s=[],t=j,u=f||e&&d.find.TAG("*",k),v=w+=null==t?1:Math.random()||.1,x=u.length;for(k&&(j=g!==n&&g);q!==x&&null!=(l=u[q]);q++){if(e&&l){m=0;while(o=a[m++])if(o(l,g,h)){i.push(l);break}k&&(w=v)}c&&((l=!o&&l)&&p--,f&&r.push(l))}if(p+=q,c&&q!==p){m=0;while(o=b[m++])o(r,s,g,h);if(f){if(p>0)while(q--)r[q]||s[q]||(s[q]=G.call(i));s=ub(s)}I.apply(i,s),k&&!f&&s.length>0&&p+b.length>1&&fb.uniqueSort(i)}return k&&(w=v,j=t),r};return c?hb(f):f}return h=fb.compile=function(a,b){var c,d=[],e=[],f=A[a+" "];if(!f){b||(b=g(a)),c=b.length;while(c--)f=wb(b[c]),f[u]?d.push(f):e.push(f);f=A(a,xb(e,d)),f.selector=a}return f},i=fb.select=function(a,b,e,f){var i,j,k,l,m,n="function"==typeof a&&a,o=!f&&g(a=n.selector||a);if(e=e||[],1===o.length){if(j=o[0]=o[0].slice(0),j.length>2&&"ID"===(k=j[0]).type&&c.getById&&9===b.nodeType&&p&&d.relative[j[1].type]){if(b=(d.find.ID(k.matches[0].replace(cb,db),b)||[])[0],!b)return e;n&&(b=b.parentNode),a=a.slice(j.shift().value.length)}i=X.needsContext.test(a)?0:j.length;while(i--){if(k=j[i],d.relative[l=k.type])break;if((m=d.find[l])&&(f=m(k.matches[0].replace(cb,db),ab.test(j[0].type)&&ob(b.parentNode)||b))){if(j.splice(i,1),a=f.length&&qb(j),!a)return I.apply(e,f),e;break}}}return(n||h(a,o))(f,b,!p,e,ab.test(a)&&ob(b.parentNode)||b),e},c.sortStable=u.split("").sort(B).join("")===u,c.detectDuplicates=!!l,m(),c.sortDetached=ib(function(a){return 1&a.compareDocumentPosition(n.createElement("div"))}),ib(function(a){return a.innerHTML="<a href='#'></a>","#"===a.firstChild.getAttribute("href")})||jb("type|href|height|width",function(a,b,c){return c?void 0:a.getAttribute(b,"type"===b.toLowerCase()?1:2)}),c.attributes&&ib(function(a){return a.innerHTML="<input/>",a.firstChild.setAttribute("value",""),""===a.firstChild.getAttribute("value")})||jb("value",function(a,b,c){return c||"input"!==a.nodeName.toLowerCase()?void 0:a.defaultValue}),ib(function(a){return null==a.getAttribute("disabled")})||jb(L,function(a,b,c){var d;return c?void 0:a[b]===!0?b.toLowerCase():(d=a.getAttributeNode(b))&&d.specified?d.value:null}),fb}(a);m.find=s,m.expr=s.selectors,m.expr[":"]=m.expr.pseudos,m.unique=s.uniqueSort,m.text=s.getText,m.isXMLDoc=s.isXML,m.contains=s.contains;var t=m.expr.match.needsContext,u=/^<(\w+)\s*\/?>(?:<\/\1>|)$/,v=/^.[^:#\[\.,]*$/;function w(a,b,c){if(m.isFunction(b))return m.grep(a,function(a,d){return!!b.call(a,d,a)!==c});if(b.nodeType)return m.grep(a,function(a){return a===b!==c});if("string"==typeof b){if(v.test(b))return m.filter(b,a,c);b=m.filter(b,a)}return m.grep(a,function(a){return m.inArray(a,b)>=0!==c})}m.filter=function(a,b,c){var d=b[0];return c&&(a=":not("+a+")"),1===b.length&&1===d.nodeType?m.find.matchesSelector(d,a)?[d]:[]:m.find.matches(a,m.grep(b,function(a){return 1===a.nodeType}))},m.fn.extend({find:function(a){var b,c=[],d=this,e=d.length;if("string"!=typeof a)return this.pushStack(m(a).filter(function(){for(b=0;e>b;b++)if(m.contains(d[b],this))return!0}));for(b=0;e>b;b++)m.find(a,d[b],c);return c=this.pushStack(e>1?m.unique(c):c),c.selector=this.selector?this.selector+" "+a:a,c},filter:function(a){return this.pushStack(w(this,a||[],!1))},not:function(a){return this.pushStack(w(this,a||[],!0))},is:function(a){return!!w(this,"string"==typeof a&&t.test(a)?m(a):a||[],!1).length}});var x,y=a.document,z=/^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]*))$/,A=m.fn.init=function(a,b){var c,d;if(!a)return this;if("string"==typeof a){if(c="<"===a.charAt(0)&&">"===a.charAt(a.length-1)&&a.length>=3?[null,a,null]:z.exec(a),!c||!c[1]&&b)return!b||b.jquery?(b||x).find(a):this.constructor(b).find(a);if(c[1]){if(b=b instanceof m?b[0]:b,m.merge(this,m.parseHTML(c[1],b&&b.nodeType?b.ownerDocument||b:y,!0)),u.test(c[1])&&m.isPlainObject(b))for(c in b)m.isFunction(this[c])?this[c](b[c]):this.attr(c,b[c]);return this}if(d=y.getElementById(c[2]),d&&d.parentNode){if(d.id!==c[2])return x.find(a);this.length=1,this[0]=d}return this.context=y,this.selector=a,this}return a.nodeType?(this.context=this[0]=a,this.length=1,this):m.isFunction(a)?"undefined"!=typeof x.ready?x.ready(a):a(m):(void 0!==a.selector&&(this.selector=a.selector,this.context=a.context),m.makeArray(a,this))};A.prototype=m.fn,x=m(y);var B=/^(?:parents|prev(?:Until|All))/,C={children:!0,contents:!0,next:!0,prev:!0};m.extend({dir:function(a,b,c){var d=[],e=a[b];while(e&&9!==e.nodeType&&(void 0===c||1!==e.nodeType||!m(e).is(c)))1===e.nodeType&&d.push(e),e=e[b];return d},sibling:function(a,b){for(var c=[];a;a=a.nextSibling)1===a.nodeType&&a!==b&&c.push(a);return c}}),m.fn.extend({has:function(a){var b,c=m(a,this),d=c.length;return this.filter(function(){for(b=0;d>b;b++)if(m.contains(this,c[b]))return!0})},closest:function(a,b){for(var c,d=0,e=this.length,f=[],g=t.test(a)||"string"!=typeof a?m(a,b||this.context):0;e>d;d++)for(c=this[d];c&&c!==b;c=c.parentNode)if(c.nodeType<11&&(g?g.index(c)>-1:1===c.nodeType&&m.find.matchesSelector(c,a))){f.push(c);break}return this.pushStack(f.length>1?m.unique(f):f)},index:function(a){return a?"string"==typeof a?m.inArray(this[0],m(a)):m.inArray(a.jquery?a[0]:a,this):this[0]&&this[0].parentNode?this.first().prevAll().length:-1},add:function(a,b){return this.pushStack(m.unique(m.merge(this.get(),m(a,b))))},addBack:function(a){return this.add(null==a?this.prevObject:this.prevObject.filter(a))}});function D(a,b){do a=a[b];while(a&&1!==a.nodeType);return a}m.each({parent:function(a){var b=a.parentNode;return b&&11!==b.nodeType?b:null},parents:function(a){return m.dir(a,"parentNode")},parentsUntil:function(a,b,c){return m.dir(a,"parentNode",c)},next:function(a){return D(a,"nextSibling")},prev:function(a){return D(a,"previousSibling")},nextAll:function(a){return m.dir(a,"nextSibling")},prevAll:function(a){return m.dir(a,"previousSibling")},nextUntil:function(a,b,c){return m.dir(a,"nextSibling",c)},prevUntil:function(a,b,c){return m.dir(a,"previousSibling",c)},siblings:function(a){return m.sibling((a.parentNode||{}).firstChild,a)},children:function(a){return m.sibling(a.firstChild)},contents:function(a){return m.nodeName(a,"iframe")?a.contentDocument||a.contentWindow.document:m.merge([],a.childNodes)}},function(a,b){m.fn[a]=function(c,d){var e=m.map(this,b,c);return"Until"!==a.slice(-5)&&(d=c),d&&"string"==typeof d&&(e=m.filter(d,e)),this.length>1&&(C[a]||(e=m.unique(e)),B.test(a)&&(e=e.reverse())),this.pushStack(e)}});var E=/\S+/g,F={};function G(a){var b=F[a]={};return m.each(a.match(E)||[],function(a,c){b[c]=!0}),b}m.Callbacks=function(a){a="string"==typeof a?F[a]||G(a):m.extend({},a);var b,c,d,e,f,g,h=[],i=!a.once&&[],j=function(l){for(c=a.memory&&l,d=!0,f=g||0,g=0,e=h.length,b=!0;h&&e>f;f++)if(h[f].apply(l[0],l[1])===!1&&a.stopOnFalse){c=!1;break}b=!1,h&&(i?i.length&&j(i.shift()):c?h=[]:k.disable())},k={add:function(){if(h){var d=h.length;!function f(b){m.each(b,function(b,c){var d=m.type(c);"function"===d?a.unique&&k.has(c)||h.push(c):c&&c.length&&"string"!==d&&f(c)})}(arguments),b?e=h.length:c&&(g=d,j(c))}return this},remove:function(){return h&&m.each(arguments,function(a,c){var d;while((d=m.inArray(c,h,d))>-1)h.splice(d,1),b&&(e>=d&&e--,f>=d&&f--)}),this},has:function(a){return a?m.inArray(a,h)>-1:!(!h||!h.length)},empty:function(){return h=[],e=0,this},disable:function(){return h=i=c=void 0,this},disabled:function(){return!h},lock:function(){return i=void 0,c||k.disable(),this},locked:function(){return!i},fireWith:function(a,c){return!h||d&&!i||(c=c||[],c=[a,c.slice?c.slice():c],b?i.push(c):j(c)),this},fire:function(){return k.fireWith(this,arguments),this},fired:function(){return!!d}};return k},m.extend({Deferred:function(a){var b=[["resolve","done",m.Callbacks("once memory"),"resolved"],["reject","fail",m.Callbacks("once memory"),"rejected"],["notify","progress",m.Callbacks("memory")]],c="pending",d={state:function(){return c},always:function(){return e.done(arguments).fail(arguments),this},then:function(){var a=arguments;return m.Deferred(function(c){m.each(b,function(b,f){var g=m.isFunction(a[b])&&a[b];e[f[1]](function(){var a=g&&g.apply(this,arguments);a&&m.isFunction(a.promise)?a.promise().done(c.resolve).fail(c.reject).progress(c.notify):c[f[0]+"With"](this===d?c.promise():this,g?[a]:arguments)})}),a=null}).promise()},promise:function(a){return null!=a?m.extend(a,d):d}},e={};return d.pipe=d.then,m.each(b,function(a,f){var g=f[2],h=f[3];d[f[1]]=g.add,h&&g.add(function(){c=h},b[1^a][2].disable,b[2][2].lock),e[f[0]]=function(){return e[f[0]+"With"](this===e?d:this,arguments),this},e[f[0]+"With"]=g.fireWith}),d.promise(e),a&&a.call(e,e),e},when:function(a){var b=0,c=d.call(arguments),e=c.length,f=1!==e||a&&m.isFunction(a.promise)?e:0,g=1===f?a:m.Deferred(),h=function(a,b,c){return function(e){b[a]=this,c[a]=arguments.length>1?d.call(arguments):e,c===i?g.notifyWith(b,c):--f||g.resolveWith(b,c)}},i,j,k;if(e>1)for(i=new Array(e),j=new Array(e),k=new Array(e);e>b;b++)c[b]&&m.isFunction(c[b].promise)?c[b].promise().done(h(b,k,c)).fail(g.reject).progress(h(b,j,i)):--f;return f||g.resolveWith(k,c),g.promise()}});var H;m.fn.ready=function(a){return m.ready.promise().done(a),this},m.extend({isReady:!1,readyWait:1,holdReady:function(a){a?m.readyWait++:m.ready(!0)},ready:function(a){if(a===!0?!--m.readyWait:!m.isReady){if(!y.body)return setTimeout(m.ready);m.isReady=!0,a!==!0&&--m.readyWait>0||(H.resolveWith(y,[m]),m.fn.triggerHandler&&(m(y).triggerHandler("ready"),m(y).off("ready")))}}});function I(){y.addEventListener?(y.removeEventListener("DOMContentLoaded",J,!1),a.removeEventListener("load",J,!1)):(y.detachEvent("onreadystatechange",J),a.detachEvent("onload",J))}function J(){(y.addEventListener||"load"===event.type||"complete"===y.readyState)&&(I(),m.ready())}m.ready.promise=function(b){if(!H)if(H=m.Deferred(),"complete"===y.readyState)setTimeout(m.ready);else if(y.addEventListener)y.addEventListener("DOMContentLoaded",J,!1),a.addEventListener("load",J,!1);else{y.attachEvent("onreadystatechange",J),a.attachEvent("onload",J);var c=!1;try{c=null==a.frameElement&&y.documentElement}catch(d){}c&&c.doScroll&&!function e(){if(!m.isReady){try{c.doScroll("left")}catch(a){return setTimeout(e,50)}I(),m.ready()}}()}return H.promise(b)};var K="undefined",L;for(L in m(k))break;k.ownLast="0"!==L,k.inlineBlockNeedsLayout=!1,m(function(){var a,b,c,d;c=y.getElementsByTagName("body")[0],c&&c.style&&(b=y.createElement("div"),d=y.createElement("div"),d.style.cssText="position:absolute;border:0;width:0;height:0;top:0;left:-9999px",c.appendChild(d).appendChild(b),typeof b.style.zoom!==K&&(b.style.cssText="display:inline;margin:0;border:0;padding:1px;width:1px;zoom:1",k.inlineBlockNeedsLayout=a=3===b.offsetWidth,a&&(c.style.zoom=1)),c.removeChild(d))}),function(){var a=y.createElement("div");if(null==k.deleteExpando){k.deleteExpando=!0;try{delete a.test}catch(b){k.deleteExpando=!1}}a=null}(),m.acceptData=function(a){var b=m.noData[(a.nodeName+" ").toLowerCase()],c=+a.nodeType||1;return 1!==c&&9!==c?!1:!b||b!==!0&&a.getAttribute("classid")===b};var M=/^(?:\{[\w\W]*\}|\[[\w\W]*\])$/,N=/([A-Z])/g;function O(a,b,c){if(void 0===c&&1===a.nodeType){var d="data-"+b.replace(N,"-$1").toLowerCase();if(c=a.getAttribute(d),"string"==typeof c){try{c="true"===c?!0:"false"===c?!1:"null"===c?null:+c+""===c?+c:M.test(c)?m.parseJSON(c):c}catch(e){}m.data(a,b,c)}else c=void 0}return c}function P(a){var b;for(b in a)if(("data"!==b||!m.isEmptyObject(a[b]))&&"toJSON"!==b)return!1;return!0}function Q(a,b,d,e){if(m.acceptData(a)){var f,g,h=m.expando,i=a.nodeType,j=i?m.cache:a,k=i?a[h]:a[h]&&h;
	if(k&&j[k]&&(e||j[k].data)||void 0!==d||"string"!=typeof b)return k||(k=i?a[h]=c.pop()||m.guid++:h),j[k]||(j[k]=i?{}:{toJSON:m.noop}),("object"==typeof b||"function"==typeof b)&&(e?j[k]=m.extend(j[k],b):j[k].data=m.extend(j[k].data,b)),g=j[k],e||(g.data||(g.data={}),g=g.data),void 0!==d&&(g[m.camelCase(b)]=d),"string"==typeof b?(f=g[b],null==f&&(f=g[m.camelCase(b)])):f=g,f}}function R(a,b,c){if(m.acceptData(a)){var d,e,f=a.nodeType,g=f?m.cache:a,h=f?a[m.expando]:m.expando;if(g[h]){if(b&&(d=c?g[h]:g[h].data)){m.isArray(b)?b=b.concat(m.map(b,m.camelCase)):b in d?b=[b]:(b=m.camelCase(b),b=b in d?[b]:b.split(" ")),e=b.length;while(e--)delete d[b[e]];if(c?!P(d):!m.isEmptyObject(d))return}(c||(delete g[h].data,P(g[h])))&&(f?m.cleanData([a],!0):k.deleteExpando||g!=g.window?delete g[h]:g[h]=null)}}}m.extend({cache:{},noData:{"applet ":!0,"embed ":!0,"object ":"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"},hasData:function(a){return a=a.nodeType?m.cache[a[m.expando]]:a[m.expando],!!a&&!P(a)},data:function(a,b,c){return Q(a,b,c)},removeData:function(a,b){return R(a,b)},_data:function(a,b,c){return Q(a,b,c,!0)},_removeData:function(a,b){return R(a,b,!0)}}),m.fn.extend({data:function(a,b){var c,d,e,f=this[0],g=f&&f.attributes;if(void 0===a){if(this.length&&(e=m.data(f),1===f.nodeType&&!m._data(f,"parsedAttrs"))){c=g.length;while(c--)g[c]&&(d=g[c].name,0===d.indexOf("data-")&&(d=m.camelCase(d.slice(5)),O(f,d,e[d])));m._data(f,"parsedAttrs",!0)}return e}return"object"==typeof a?this.each(function(){m.data(this,a)}):arguments.length>1?this.each(function(){m.data(this,a,b)}):f?O(f,a,m.data(f,a)):void 0},removeData:function(a){return this.each(function(){m.removeData(this,a)})}}),m.extend({queue:function(a,b,c){var d;return a?(b=(b||"fx")+"queue",d=m._data(a,b),c&&(!d||m.isArray(c)?d=m._data(a,b,m.makeArray(c)):d.push(c)),d||[]):void 0},dequeue:function(a,b){b=b||"fx";var c=m.queue(a,b),d=c.length,e=c.shift(),f=m._queueHooks(a,b),g=function(){m.dequeue(a,b)};"inprogress"===e&&(e=c.shift(),d--),e&&("fx"===b&&c.unshift("inprogress"),delete f.stop,e.call(a,g,f)),!d&&f&&f.empty.fire()},_queueHooks:function(a,b){var c=b+"queueHooks";return m._data(a,c)||m._data(a,c,{empty:m.Callbacks("once memory").add(function(){m._removeData(a,b+"queue"),m._removeData(a,c)})})}}),m.fn.extend({queue:function(a,b){var c=2;return"string"!=typeof a&&(b=a,a="fx",c--),arguments.length<c?m.queue(this[0],a):void 0===b?this:this.each(function(){var c=m.queue(this,a,b);m._queueHooks(this,a),"fx"===a&&"inprogress"!==c[0]&&m.dequeue(this,a)})},dequeue:function(a){return this.each(function(){m.dequeue(this,a)})},clearQueue:function(a){return this.queue(a||"fx",[])},promise:function(a,b){var c,d=1,e=m.Deferred(),f=this,g=this.length,h=function(){--d||e.resolveWith(f,[f])};"string"!=typeof a&&(b=a,a=void 0),a=a||"fx";while(g--)c=m._data(f[g],a+"queueHooks"),c&&c.empty&&(d++,c.empty.add(h));return h(),e.promise(b)}});var S=/[+-]?(?:\d*\.|)\d+(?:[eE][+-]?\d+|)/.source,T=["Top","Right","Bottom","Left"],U=function(a,b){return a=b||a,"none"===m.css(a,"display")||!m.contains(a.ownerDocument,a)},V=m.access=function(a,b,c,d,e,f,g){var h=0,i=a.length,j=null==c;if("object"===m.type(c)){e=!0;for(h in c)m.access(a,b,h,c[h],!0,f,g)}else if(void 0!==d&&(e=!0,m.isFunction(d)||(g=!0),j&&(g?(b.call(a,d),b=null):(j=b,b=function(a,b,c){return j.call(m(a),c)})),b))for(;i>h;h++)b(a[h],c,g?d:d.call(a[h],h,b(a[h],c)));return e?a:j?b.call(a):i?b(a[0],c):f},W=/^(?:checkbox|radio)$/i;!function(){var a=y.createElement("input"),b=y.createElement("div"),c=y.createDocumentFragment();if(b.innerHTML="  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>",k.leadingWhitespace=3===b.firstChild.nodeType,k.tbody=!b.getElementsByTagName("tbody").length,k.htmlSerialize=!!b.getElementsByTagName("link").length,k.html5Clone="<:nav></:nav>"!==y.createElement("nav").cloneNode(!0).outerHTML,a.type="checkbox",a.checked=!0,c.appendChild(a),k.appendChecked=a.checked,b.innerHTML="<textarea>x</textarea>",k.noCloneChecked=!!b.cloneNode(!0).lastChild.defaultValue,c.appendChild(b),b.innerHTML="<input type='radio' checked='checked' name='t'/>",k.checkClone=b.cloneNode(!0).cloneNode(!0).lastChild.checked,k.noCloneEvent=!0,b.attachEvent&&(b.attachEvent("onclick",function(){k.noCloneEvent=!1}),b.cloneNode(!0).click()),null==k.deleteExpando){k.deleteExpando=!0;try{delete b.test}catch(d){k.deleteExpando=!1}}}(),function(){var b,c,d=y.createElement("div");for(b in{submit:!0,change:!0,focusin:!0})c="on"+b,(k[b+"Bubbles"]=c in a)||(d.setAttribute(c,"t"),k[b+"Bubbles"]=d.attributes[c].expando===!1);d=null}();var X=/^(?:input|select|textarea)$/i,Y=/^key/,Z=/^(?:mouse|pointer|contextmenu)|click/,$=/^(?:focusinfocus|focusoutblur)$/,_=/^([^.]*)(?:\.(.+)|)$/;function ab(){return!0}function bb(){return!1}function cb(){try{return y.activeElement}catch(a){}}m.event={global:{},add:function(a,b,c,d,e){var f,g,h,i,j,k,l,n,o,p,q,r=m._data(a);if(r){c.handler&&(i=c,c=i.handler,e=i.selector),c.guid||(c.guid=m.guid++),(g=r.events)||(g=r.events={}),(k=r.handle)||(k=r.handle=function(a){return typeof m===K||a&&m.event.triggered===a.type?void 0:m.event.dispatch.apply(k.elem,arguments)},k.elem=a),b=(b||"").match(E)||[""],h=b.length;while(h--)f=_.exec(b[h])||[],o=q=f[1],p=(f[2]||"").split(".").sort(),o&&(j=m.event.special[o]||{},o=(e?j.delegateType:j.bindType)||o,j=m.event.special[o]||{},l=m.extend({type:o,origType:q,data:d,handler:c,guid:c.guid,selector:e,needsContext:e&&m.expr.match.needsContext.test(e),namespace:p.join(".")},i),(n=g[o])||(n=g[o]=[],n.delegateCount=0,j.setup&&j.setup.call(a,d,p,k)!==!1||(a.addEventListener?a.addEventListener(o,k,!1):a.attachEvent&&a.attachEvent("on"+o,k))),j.add&&(j.add.call(a,l),l.handler.guid||(l.handler.guid=c.guid)),e?n.splice(n.delegateCount++,0,l):n.push(l),m.event.global[o]=!0);a=null}},remove:function(a,b,c,d,e){var f,g,h,i,j,k,l,n,o,p,q,r=m.hasData(a)&&m._data(a);if(r&&(k=r.events)){b=(b||"").match(E)||[""],j=b.length;while(j--)if(h=_.exec(b[j])||[],o=q=h[1],p=(h[2]||"").split(".").sort(),o){l=m.event.special[o]||{},o=(d?l.delegateType:l.bindType)||o,n=k[o]||[],h=h[2]&&new RegExp("(^|\\.)"+p.join("\\.(?:.*\\.|)")+"(\\.|$)"),i=f=n.length;while(f--)g=n[f],!e&&q!==g.origType||c&&c.guid!==g.guid||h&&!h.test(g.namespace)||d&&d!==g.selector&&("**"!==d||!g.selector)||(n.splice(f,1),g.selector&&n.delegateCount--,l.remove&&l.remove.call(a,g));i&&!n.length&&(l.teardown&&l.teardown.call(a,p,r.handle)!==!1||m.removeEvent(a,o,r.handle),delete k[o])}else for(o in k)m.event.remove(a,o+b[j],c,d,!0);m.isEmptyObject(k)&&(delete r.handle,m._removeData(a,"events"))}},trigger:function(b,c,d,e){var f,g,h,i,k,l,n,o=[d||y],p=j.call(b,"type")?b.type:b,q=j.call(b,"namespace")?b.namespace.split("."):[];if(h=l=d=d||y,3!==d.nodeType&&8!==d.nodeType&&!$.test(p+m.event.triggered)&&(p.indexOf(".")>=0&&(q=p.split("."),p=q.shift(),q.sort()),g=p.indexOf(":")<0&&"on"+p,b=b[m.expando]?b:new m.Event(p,"object"==typeof b&&b),b.isTrigger=e?2:3,b.namespace=q.join("."),b.namespace_re=b.namespace?new RegExp("(^|\\.)"+q.join("\\.(?:.*\\.|)")+"(\\.|$)"):null,b.result=void 0,b.target||(b.target=d),c=null==c?[b]:m.makeArray(c,[b]),k=m.event.special[p]||{},e||!k.trigger||k.trigger.apply(d,c)!==!1)){if(!e&&!k.noBubble&&!m.isWindow(d)){for(i=k.delegateType||p,$.test(i+p)||(h=h.parentNode);h;h=h.parentNode)o.push(h),l=h;l===(d.ownerDocument||y)&&o.push(l.defaultView||l.parentWindow||a)}n=0;while((h=o[n++])&&!b.isPropagationStopped())b.type=n>1?i:k.bindType||p,f=(m._data(h,"events")||{})[b.type]&&m._data(h,"handle"),f&&f.apply(h,c),f=g&&h[g],f&&f.apply&&m.acceptData(h)&&(b.result=f.apply(h,c),b.result===!1&&b.preventDefault());if(b.type=p,!e&&!b.isDefaultPrevented()&&(!k._default||k._default.apply(o.pop(),c)===!1)&&m.acceptData(d)&&g&&d[p]&&!m.isWindow(d)){l=d[g],l&&(d[g]=null),m.event.triggered=p;try{d[p]()}catch(r){}m.event.triggered=void 0,l&&(d[g]=l)}return b.result}},dispatch:function(a){a=m.event.fix(a);var b,c,e,f,g,h=[],i=d.call(arguments),j=(m._data(this,"events")||{})[a.type]||[],k=m.event.special[a.type]||{};if(i[0]=a,a.delegateTarget=this,!k.preDispatch||k.preDispatch.call(this,a)!==!1){h=m.event.handlers.call(this,a,j),b=0;while((f=h[b++])&&!a.isPropagationStopped()){a.currentTarget=f.elem,g=0;while((e=f.handlers[g++])&&!a.isImmediatePropagationStopped())(!a.namespace_re||a.namespace_re.test(e.namespace))&&(a.handleObj=e,a.data=e.data,c=((m.event.special[e.origType]||{}).handle||e.handler).apply(f.elem,i),void 0!==c&&(a.result=c)===!1&&(a.preventDefault(),a.stopPropagation()))}return k.postDispatch&&k.postDispatch.call(this,a),a.result}},handlers:function(a,b){var c,d,e,f,g=[],h=b.delegateCount,i=a.target;if(h&&i.nodeType&&(!a.button||"click"!==a.type))for(;i!=this;i=i.parentNode||this)if(1===i.nodeType&&(i.disabled!==!0||"click"!==a.type)){for(e=[],f=0;h>f;f++)d=b[f],c=d.selector+" ",void 0===e[c]&&(e[c]=d.needsContext?m(c,this).index(i)>=0:m.find(c,this,null,[i]).length),e[c]&&e.push(d);e.length&&g.push({elem:i,handlers:e})}return h<b.length&&g.push({elem:this,handlers:b.slice(h)}),g},fix:function(a){if(a[m.expando])return a;var b,c,d,e=a.type,f=a,g=this.fixHooks[e];g||(this.fixHooks[e]=g=Z.test(e)?this.mouseHooks:Y.test(e)?this.keyHooks:{}),d=g.props?this.props.concat(g.props):this.props,a=new m.Event(f),b=d.length;while(b--)c=d[b],a[c]=f[c];return a.target||(a.target=f.srcElement||y),3===a.target.nodeType&&(a.target=a.target.parentNode),a.metaKey=!!a.metaKey,g.filter?g.filter(a,f):a},props:"altKey bubbles cancelable ctrlKey currentTarget eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" "),fixHooks:{},keyHooks:{props:"char charCode key keyCode".split(" "),filter:function(a,b){return null==a.which&&(a.which=null!=b.charCode?b.charCode:b.keyCode),a}},mouseHooks:{props:"button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" "),filter:function(a,b){var c,d,e,f=b.button,g=b.fromElement;return null==a.pageX&&null!=b.clientX&&(d=a.target.ownerDocument||y,e=d.documentElement,c=d.body,a.pageX=b.clientX+(e&&e.scrollLeft||c&&c.scrollLeft||0)-(e&&e.clientLeft||c&&c.clientLeft||0),a.pageY=b.clientY+(e&&e.scrollTop||c&&c.scrollTop||0)-(e&&e.clientTop||c&&c.clientTop||0)),!a.relatedTarget&&g&&(a.relatedTarget=g===a.target?b.toElement:g),a.which||void 0===f||(a.which=1&f?1:2&f?3:4&f?2:0),a}},special:{load:{noBubble:!0},focus:{trigger:function(){if(this!==cb()&&this.focus)try{return this.focus(),!1}catch(a){}},delegateType:"focusin"},blur:{trigger:function(){return this===cb()&&this.blur?(this.blur(),!1):void 0},delegateType:"focusout"},click:{trigger:function(){return m.nodeName(this,"input")&&"checkbox"===this.type&&this.click?(this.click(),!1):void 0},_default:function(a){return m.nodeName(a.target,"a")}},beforeunload:{postDispatch:function(a){void 0!==a.result&&a.originalEvent&&(a.originalEvent.returnValue=a.result)}}},simulate:function(a,b,c,d){var e=m.extend(new m.Event,c,{type:a,isSimulated:!0,originalEvent:{}});d?m.event.trigger(e,null,b):m.event.dispatch.call(b,e),e.isDefaultPrevented()&&c.preventDefault()}},m.removeEvent=y.removeEventListener?function(a,b,c){a.removeEventListener&&a.removeEventListener(b,c,!1)}:function(a,b,c){var d="on"+b;a.detachEvent&&(typeof a[d]===K&&(a[d]=null),a.detachEvent(d,c))},m.Event=function(a,b){return this instanceof m.Event?(a&&a.type?(this.originalEvent=a,this.type=a.type,this.isDefaultPrevented=a.defaultPrevented||void 0===a.defaultPrevented&&a.returnValue===!1?ab:bb):this.type=a,b&&m.extend(this,b),this.timeStamp=a&&a.timeStamp||m.now(),void(this[m.expando]=!0)):new m.Event(a,b)},m.Event.prototype={isDefaultPrevented:bb,isPropagationStopped:bb,isImmediatePropagationStopped:bb,preventDefault:function(){var a=this.originalEvent;this.isDefaultPrevented=ab,a&&(a.preventDefault?a.preventDefault():a.returnValue=!1)},stopPropagation:function(){var a=this.originalEvent;this.isPropagationStopped=ab,a&&(a.stopPropagation&&a.stopPropagation(),a.cancelBubble=!0)},stopImmediatePropagation:function(){var a=this.originalEvent;this.isImmediatePropagationStopped=ab,a&&a.stopImmediatePropagation&&a.stopImmediatePropagation(),this.stopPropagation()}},m.each({mouseenter:"mouseover",mouseleave:"mouseout",pointerenter:"pointerover",pointerleave:"pointerout"},function(a,b){m.event.special[a]={delegateType:b,bindType:b,handle:function(a){var c,d=this,e=a.relatedTarget,f=a.handleObj;return(!e||e!==d&&!m.contains(d,e))&&(a.type=f.origType,c=f.handler.apply(this,arguments),a.type=b),c}}}),k.submitBubbles||(m.event.special.submit={setup:function(){return m.nodeName(this,"form")?!1:void m.event.add(this,"click._submit keypress._submit",function(a){var b=a.target,c=m.nodeName(b,"input")||m.nodeName(b,"button")?b.form:void 0;c&&!m._data(c,"submitBubbles")&&(m.event.add(c,"submit._submit",function(a){a._submit_bubble=!0}),m._data(c,"submitBubbles",!0))})},postDispatch:function(a){a._submit_bubble&&(delete a._submit_bubble,this.parentNode&&!a.isTrigger&&m.event.simulate("submit",this.parentNode,a,!0))},teardown:function(){return m.nodeName(this,"form")?!1:void m.event.remove(this,"._submit")}}),k.changeBubbles||(m.event.special.change={setup:function(){return X.test(this.nodeName)?(("checkbox"===this.type||"radio"===this.type)&&(m.event.add(this,"propertychange._change",function(a){"checked"===a.originalEvent.propertyName&&(this._just_changed=!0)}),m.event.add(this,"click._change",function(a){this._just_changed&&!a.isTrigger&&(this._just_changed=!1),m.event.simulate("change",this,a,!0)})),!1):void m.event.add(this,"beforeactivate._change",function(a){var b=a.target;X.test(b.nodeName)&&!m._data(b,"changeBubbles")&&(m.event.add(b,"change._change",function(a){!this.parentNode||a.isSimulated||a.isTrigger||m.event.simulate("change",this.parentNode,a,!0)}),m._data(b,"changeBubbles",!0))})},handle:function(a){var b=a.target;return this!==b||a.isSimulated||a.isTrigger||"radio"!==b.type&&"checkbox"!==b.type?a.handleObj.handler.apply(this,arguments):void 0},teardown:function(){return m.event.remove(this,"._change"),!X.test(this.nodeName)}}),k.focusinBubbles||m.each({focus:"focusin",blur:"focusout"},function(a,b){var c=function(a){m.event.simulate(b,a.target,m.event.fix(a),!0)};m.event.special[b]={setup:function(){var d=this.ownerDocument||this,e=m._data(d,b);e||d.addEventListener(a,c,!0),m._data(d,b,(e||0)+1)},teardown:function(){var d=this.ownerDocument||this,e=m._data(d,b)-1;e?m._data(d,b,e):(d.removeEventListener(a,c,!0),m._removeData(d,b))}}}),m.fn.extend({on:function(a,b,c,d,e){var f,g;if("object"==typeof a){"string"!=typeof b&&(c=c||b,b=void 0);for(f in a)this.on(f,b,c,a[f],e);return this}if(null==c&&null==d?(d=b,c=b=void 0):null==d&&("string"==typeof b?(d=c,c=void 0):(d=c,c=b,b=void 0)),d===!1)d=bb;else if(!d)return this;return 1===e&&(g=d,d=function(a){return m().off(a),g.apply(this,arguments)},d.guid=g.guid||(g.guid=m.guid++)),this.each(function(){m.event.add(this,a,d,c,b)})},one:function(a,b,c,d){return this.on(a,b,c,d,1)},off:function(a,b,c){var d,e;if(a&&a.preventDefault&&a.handleObj)return d=a.handleObj,m(a.delegateTarget).off(d.namespace?d.origType+"."+d.namespace:d.origType,d.selector,d.handler),this;if("object"==typeof a){for(e in a)this.off(e,b,a[e]);return this}return(b===!1||"function"==typeof b)&&(c=b,b=void 0),c===!1&&(c=bb),this.each(function(){m.event.remove(this,a,c,b)})},trigger:function(a,b){return this.each(function(){m.event.trigger(a,b,this)})},triggerHandler:function(a,b){var c=this[0];return c?m.event.trigger(a,b,c,!0):void 0}});function db(a){var b=eb.split("|"),c=a.createDocumentFragment();if(c.createElement)while(b.length)c.createElement(b.pop());return c}var eb="abbr|article|aside|audio|bdi|canvas|data|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|summary|time|video",fb=/ jQuery\d+="(?:null|\d+)"/g,gb=new RegExp("<(?:"+eb+")[\\s/>]","i"),hb=/^\s+/,ib=/<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/gi,jb=/<([\w:]+)/,kb=/<tbody/i,lb=/<|&#?\w+;/,mb=/<(?:script|style|link)/i,nb=/checked\s*(?:[^=]|=\s*.checked.)/i,ob=/^$|\/(?:java|ecma)script/i,pb=/^true\/(.*)/,qb=/^\s*<!(?:\[CDATA\[|--)|(?:\]\]|--)>\s*$/g,rb={option:[1,"<select multiple='multiple'>","</select>"],legend:[1,"<fieldset>","</fieldset>"],area:[1,"<map>","</map>"],param:[1,"<object>","</object>"],thead:[1,"<table>","</table>"],tr:[2,"<table><tbody>","</tbody></table>"],col:[2,"<table><tbody></tbody><colgroup>","</colgroup></table>"],td:[3,"<table><tbody><tr>","</tr></tbody></table>"],_default:k.htmlSerialize?[0,"",""]:[1,"X<div>","</div>"]},sb=db(y),tb=sb.appendChild(y.createElement("div"));rb.optgroup=rb.option,rb.tbody=rb.tfoot=rb.colgroup=rb.caption=rb.thead,rb.th=rb.td;function ub(a,b){var c,d,e=0,f=typeof a.getElementsByTagName!==K?a.getElementsByTagName(b||"*"):typeof a.querySelectorAll!==K?a.querySelectorAll(b||"*"):void 0;if(!f)for(f=[],c=a.childNodes||a;null!=(d=c[e]);e++)!b||m.nodeName(d,b)?f.push(d):m.merge(f,ub(d,b));return void 0===b||b&&m.nodeName(a,b)?m.merge([a],f):f}function vb(a){W.test(a.type)&&(a.defaultChecked=a.checked)}function wb(a,b){return m.nodeName(a,"table")&&m.nodeName(11!==b.nodeType?b:b.firstChild,"tr")?a.getElementsByTagName("tbody")[0]||a.appendChild(a.ownerDocument.createElement("tbody")):a}function xb(a){return a.type=(null!==m.find.attr(a,"type"))+"/"+a.type,a}function yb(a){var b=pb.exec(a.type);return b?a.type=b[1]:a.removeAttribute("type"),a}function zb(a,b){for(var c,d=0;null!=(c=a[d]);d++)m._data(c,"globalEval",!b||m._data(b[d],"globalEval"))}function Ab(a,b){if(1===b.nodeType&&m.hasData(a)){var c,d,e,f=m._data(a),g=m._data(b,f),h=f.events;if(h){delete g.handle,g.events={};for(c in h)for(d=0,e=h[c].length;e>d;d++)m.event.add(b,c,h[c][d])}g.data&&(g.data=m.extend({},g.data))}}function Bb(a,b){var c,d,e;if(1===b.nodeType){if(c=b.nodeName.toLowerCase(),!k.noCloneEvent&&b[m.expando]){e=m._data(b);for(d in e.events)m.removeEvent(b,d,e.handle);b.removeAttribute(m.expando)}"script"===c&&b.text!==a.text?(xb(b).text=a.text,yb(b)):"object"===c?(b.parentNode&&(b.outerHTML=a.outerHTML),k.html5Clone&&a.innerHTML&&!m.trim(b.innerHTML)&&(b.innerHTML=a.innerHTML)):"input"===c&&W.test(a.type)?(b.defaultChecked=b.checked=a.checked,b.value!==a.value&&(b.value=a.value)):"option"===c?b.defaultSelected=b.selected=a.defaultSelected:("input"===c||"textarea"===c)&&(b.defaultValue=a.defaultValue)}}m.extend({clone:function(a,b,c){var d,e,f,g,h,i=m.contains(a.ownerDocument,a);if(k.html5Clone||m.isXMLDoc(a)||!gb.test("<"+a.nodeName+">")?f=a.cloneNode(!0):(tb.innerHTML=a.outerHTML,tb.removeChild(f=tb.firstChild)),!(k.noCloneEvent&&k.noCloneChecked||1!==a.nodeType&&11!==a.nodeType||m.isXMLDoc(a)))for(d=ub(f),h=ub(a),g=0;null!=(e=h[g]);++g)d[g]&&Bb(e,d[g]);if(b)if(c)for(h=h||ub(a),d=d||ub(f),g=0;null!=(e=h[g]);g++)Ab(e,d[g]);else Ab(a,f);return d=ub(f,"script"),d.length>0&&zb(d,!i&&ub(a,"script")),d=h=e=null,f},buildFragment:function(a,b,c,d){for(var e,f,g,h,i,j,l,n=a.length,o=db(b),p=[],q=0;n>q;q++)if(f=a[q],f||0===f)if("object"===m.type(f))m.merge(p,f.nodeType?[f]:f);else if(lb.test(f)){h=h||o.appendChild(b.createElement("div")),i=(jb.exec(f)||["",""])[1].toLowerCase(),l=rb[i]||rb._default,h.innerHTML=l[1]+f.replace(ib,"<$1></$2>")+l[2],e=l[0];while(e--)h=h.lastChild;if(!k.leadingWhitespace&&hb.test(f)&&p.push(b.createTextNode(hb.exec(f)[0])),!k.tbody){f="table"!==i||kb.test(f)?"<table>"!==l[1]||kb.test(f)?0:h:h.firstChild,e=f&&f.childNodes.length;while(e--)m.nodeName(j=f.childNodes[e],"tbody")&&!j.childNodes.length&&f.removeChild(j)}m.merge(p,h.childNodes),h.textContent="";while(h.firstChild)h.removeChild(h.firstChild);h=o.lastChild}else p.push(b.createTextNode(f));h&&o.removeChild(h),k.appendChecked||m.grep(ub(p,"input"),vb),q=0;while(f=p[q++])if((!d||-1===m.inArray(f,d))&&(g=m.contains(f.ownerDocument,f),h=ub(o.appendChild(f),"script"),g&&zb(h),c)){e=0;while(f=h[e++])ob.test(f.type||"")&&c.push(f)}return h=null,o},cleanData:function(a,b){for(var d,e,f,g,h=0,i=m.expando,j=m.cache,l=k.deleteExpando,n=m.event.special;null!=(d=a[h]);h++)if((b||m.acceptData(d))&&(f=d[i],g=f&&j[f])){if(g.events)for(e in g.events)n[e]?m.event.remove(d,e):m.removeEvent(d,e,g.handle);j[f]&&(delete j[f],l?delete d[i]:typeof d.removeAttribute!==K?d.removeAttribute(i):d[i]=null,c.push(f))}}}),m.fn.extend({text:function(a){return V(this,function(a){return void 0===a?m.text(this):this.empty().append((this[0]&&this[0].ownerDocument||y).createTextNode(a))},null,a,arguments.length)},append:function(){return this.domManip(arguments,function(a){if(1===this.nodeType||11===this.nodeType||9===this.nodeType){var b=wb(this,a);b.appendChild(a)}})},prepend:function(){return this.domManip(arguments,function(a){if(1===this.nodeType||11===this.nodeType||9===this.nodeType){var b=wb(this,a);b.insertBefore(a,b.firstChild)}})},before:function(){return this.domManip(arguments,function(a){this.parentNode&&this.parentNode.insertBefore(a,this)})},after:function(){return this.domManip(arguments,function(a){this.parentNode&&this.parentNode.insertBefore(a,this.nextSibling)})},remove:function(a,b){for(var c,d=a?m.filter(a,this):this,e=0;null!=(c=d[e]);e++)b||1!==c.nodeType||m.cleanData(ub(c)),c.parentNode&&(b&&m.contains(c.ownerDocument,c)&&zb(ub(c,"script")),c.parentNode.removeChild(c));return this},empty:function(){for(var a,b=0;null!=(a=this[b]);b++){1===a.nodeType&&m.cleanData(ub(a,!1));while(a.firstChild)a.removeChild(a.firstChild);a.options&&m.nodeName(a,"select")&&(a.options.length=0)}return this},clone:function(a,b){return a=null==a?!1:a,b=null==b?a:b,this.map(function(){return m.clone(this,a,b)})},html:function(a){return V(this,function(a){var b=this[0]||{},c=0,d=this.length;if(void 0===a)return 1===b.nodeType?b.innerHTML.replace(fb,""):void 0;if(!("string"!=typeof a||mb.test(a)||!k.htmlSerialize&&gb.test(a)||!k.leadingWhitespace&&hb.test(a)||rb[(jb.exec(a)||["",""])[1].toLowerCase()])){a=a.replace(ib,"<$1></$2>");try{for(;d>c;c++)b=this[c]||{},1===b.nodeType&&(m.cleanData(ub(b,!1)),b.innerHTML=a);b=0}catch(e){}}b&&this.empty().append(a)},null,a,arguments.length)},replaceWith:function(){var a=arguments[0];return this.domManip(arguments,function(b){a=this.parentNode,m.cleanData(ub(this)),a&&a.replaceChild(b,this)}),a&&(a.length||a.nodeType)?this:this.remove()},detach:function(a){return this.remove(a,!0)},domManip:function(a,b){a=e.apply([],a);var c,d,f,g,h,i,j=0,l=this.length,n=this,o=l-1,p=a[0],q=m.isFunction(p);if(q||l>1&&"string"==typeof p&&!k.checkClone&&nb.test(p))return this.each(function(c){var d=n.eq(c);q&&(a[0]=p.call(this,c,d.html())),d.domManip(a,b)});if(l&&(i=m.buildFragment(a,this[0].ownerDocument,!1,this),c=i.firstChild,1===i.childNodes.length&&(i=c),c)){for(g=m.map(ub(i,"script"),xb),f=g.length;l>j;j++)d=i,j!==o&&(d=m.clone(d,!0,!0),f&&m.merge(g,ub(d,"script"))),b.call(this[j],d,j);if(f)for(h=g[g.length-1].ownerDocument,m.map(g,yb),j=0;f>j;j++)d=g[j],ob.test(d.type||"")&&!m._data(d,"globalEval")&&m.contains(h,d)&&(d.src?m._evalUrl&&m._evalUrl(d.src):m.globalEval((d.text||d.textContent||d.innerHTML||"").replace(qb,"")));i=c=null}return this}}),m.each({appendTo:"append",prependTo:"prepend",insertBefore:"before",insertAfter:"after",replaceAll:"replaceWith"},function(a,b){m.fn[a]=function(a){for(var c,d=0,e=[],g=m(a),h=g.length-1;h>=d;d++)c=d===h?this:this.clone(!0),m(g[d])[b](c),f.apply(e,c.get());return this.pushStack(e)}});var Cb,Db={};function Eb(b,c){var d,e=m(c.createElement(b)).appendTo(c.body),f=a.getDefaultComputedStyle&&(d=a.getDefaultComputedStyle(e[0]))?d.display:m.css(e[0],"display");return e.detach(),f}function Fb(a){var b=y,c=Db[a];return c||(c=Eb(a,b),"none"!==c&&c||(Cb=(Cb||m("<iframe frameborder='0' width='0' height='0'/>")).appendTo(b.documentElement),b=(Cb[0].contentWindow||Cb[0].contentDocument).document,b.write(),b.close(),c=Eb(a,b),Cb.detach()),Db[a]=c),c}!function(){var a;k.shrinkWrapBlocks=function(){if(null!=a)return a;a=!1;var b,c,d;return c=y.getElementsByTagName("body")[0],c&&c.style?(b=y.createElement("div"),d=y.createElement("div"),d.style.cssText="position:absolute;border:0;width:0;height:0;top:0;left:-9999px",c.appendChild(d).appendChild(b),typeof b.style.zoom!==K&&(b.style.cssText="-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;display:block;margin:0;border:0;padding:1px;width:1px;zoom:1",b.appendChild(y.createElement("div")).style.width="5px",a=3!==b.offsetWidth),c.removeChild(d),a):void 0}}();var Gb=/^margin/,Hb=new RegExp("^("+S+")(?!px)[a-z%]+$","i"),Ib,Jb,Kb=/^(top|right|bottom|left)$/;a.getComputedStyle?(Ib=function(a){return a.ownerDocument.defaultView.getComputedStyle(a,null)},Jb=function(a,b,c){var d,e,f,g,h=a.style;return c=c||Ib(a),g=c?c.getPropertyValue(b)||c[b]:void 0,c&&(""!==g||m.contains(a.ownerDocument,a)||(g=m.style(a,b)),Hb.test(g)&&Gb.test(b)&&(d=h.width,e=h.minWidth,f=h.maxWidth,h.minWidth=h.maxWidth=h.width=g,g=c.width,h.width=d,h.minWidth=e,h.maxWidth=f)),void 0===g?g:g+""}):y.documentElement.currentStyle&&(Ib=function(a){return a.currentStyle},Jb=function(a,b,c){var d,e,f,g,h=a.style;return c=c||Ib(a),g=c?c[b]:void 0,null==g&&h&&h[b]&&(g=h[b]),Hb.test(g)&&!Kb.test(b)&&(d=h.left,e=a.runtimeStyle,f=e&&e.left,f&&(e.left=a.currentStyle.left),h.left="fontSize"===b?"1em":g,g=h.pixelLeft+"px",h.left=d,f&&(e.left=f)),void 0===g?g:g+""||"auto"});function Lb(a,b){return{get:function(){var c=a();if(null!=c)return c?void delete this.get:(this.get=b).apply(this,arguments)}}}!function(){var b,c,d,e,f,g,h;if(b=y.createElement("div"),b.innerHTML="  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>",d=b.getElementsByTagName("a")[0],c=d&&d.style){c.cssText="float:left;opacity:.5",k.opacity="0.5"===c.opacity,k.cssFloat=!!c.cssFloat,b.style.backgroundClip="content-box",b.cloneNode(!0).style.backgroundClip="",k.clearCloneStyle="content-box"===b.style.backgroundClip,k.boxSizing=""===c.boxSizing||""===c.MozBoxSizing||""===c.WebkitBoxSizing,m.extend(k,{reliableHiddenOffsets:function(){return null==g&&i(),g},boxSizingReliable:function(){return null==f&&i(),f},pixelPosition:function(){return null==e&&i(),e},reliableMarginRight:function(){return null==h&&i(),h}});function i(){var b,c,d,i;c=y.getElementsByTagName("body")[0],c&&c.style&&(b=y.createElement("div"),d=y.createElement("div"),d.style.cssText="position:absolute;border:0;width:0;height:0;top:0;left:-9999px",c.appendChild(d).appendChild(b),b.style.cssText="-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;display:block;margin-top:1%;top:1%;border:1px;padding:1px;width:4px;position:absolute",e=f=!1,h=!0,a.getComputedStyle&&(e="1%"!==(a.getComputedStyle(b,null)||{}).top,f="4px"===(a.getComputedStyle(b,null)||{width:"4px"}).width,i=b.appendChild(y.createElement("div")),i.style.cssText=b.style.cssText="-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;display:block;margin:0;border:0;padding:0",i.style.marginRight=i.style.width="0",b.style.width="1px",h=!parseFloat((a.getComputedStyle(i,null)||{}).marginRight)),b.innerHTML="<table><tr><td></td><td>t</td></tr></table>",i=b.getElementsByTagName("td"),i[0].style.cssText="margin:0;border:0;padding:0;display:none",g=0===i[0].offsetHeight,g&&(i[0].style.display="",i[1].style.display="none",g=0===i[0].offsetHeight),c.removeChild(d))}}}(),m.swap=function(a,b,c,d){var e,f,g={};for(f in b)g[f]=a.style[f],a.style[f]=b[f];e=c.apply(a,d||[]);for(f in b)a.style[f]=g[f];return e};var Mb=/alpha\([^)]*\)/i,Nb=/opacity\s*=\s*([^)]*)/,Ob=/^(none|table(?!-c[ea]).+)/,Pb=new RegExp("^("+S+")(.*)$","i"),Qb=new RegExp("^([+-])=("+S+")","i"),Rb={position:"absolute",visibility:"hidden",display:"block"},Sb={letterSpacing:"0",fontWeight:"400"},Tb=["Webkit","O","Moz","ms"];function Ub(a,b){if(b in a)return b;var c=b.charAt(0).toUpperCase()+b.slice(1),d=b,e=Tb.length;while(e--)if(b=Tb[e]+c,b in a)return b;return d}function Vb(a,b){for(var c,d,e,f=[],g=0,h=a.length;h>g;g++)d=a[g],d.style&&(f[g]=m._data(d,"olddisplay"),c=d.style.display,b?(f[g]||"none"!==c||(d.style.display=""),""===d.style.display&&U(d)&&(f[g]=m._data(d,"olddisplay",Fb(d.nodeName)))):(e=U(d),(c&&"none"!==c||!e)&&m._data(d,"olddisplay",e?c:m.css(d,"display"))));for(g=0;h>g;g++)d=a[g],d.style&&(b&&"none"!==d.style.display&&""!==d.style.display||(d.style.display=b?f[g]||"":"none"));return a}function Wb(a,b,c){var d=Pb.exec(b);return d?Math.max(0,d[1]-(c||0))+(d[2]||"px"):b}function Xb(a,b,c,d,e){for(var f=c===(d?"border":"content")?4:"width"===b?1:0,g=0;4>f;f+=2)"margin"===c&&(g+=m.css(a,c+T[f],!0,e)),d?("content"===c&&(g-=m.css(a,"padding"+T[f],!0,e)),"margin"!==c&&(g-=m.css(a,"border"+T[f]+"Width",!0,e))):(g+=m.css(a,"padding"+T[f],!0,e),"padding"!==c&&(g+=m.css(a,"border"+T[f]+"Width",!0,e)));return g}function Yb(a,b,c){var d=!0,e="width"===b?a.offsetWidth:a.offsetHeight,f=Ib(a),g=k.boxSizing&&"border-box"===m.css(a,"boxSizing",!1,f);if(0>=e||null==e){if(e=Jb(a,b,f),(0>e||null==e)&&(e=a.style[b]),Hb.test(e))return e;d=g&&(k.boxSizingReliable()||e===a.style[b]),e=parseFloat(e)||0}return e+Xb(a,b,c||(g?"border":"content"),d,f)+"px"}m.extend({cssHooks:{opacity:{get:function(a,b){if(b){var c=Jb(a,"opacity");return""===c?"1":c}}}},cssNumber:{columnCount:!0,fillOpacity:!0,flexGrow:!0,flexShrink:!0,fontWeight:!0,lineHeight:!0,opacity:!0,order:!0,orphans:!0,widows:!0,zIndex:!0,zoom:!0},cssProps:{"float":k.cssFloat?"cssFloat":"styleFloat"},style:function(a,b,c,d){if(a&&3!==a.nodeType&&8!==a.nodeType&&a.style){var e,f,g,h=m.camelCase(b),i=a.style;if(b=m.cssProps[h]||(m.cssProps[h]=Ub(i,h)),g=m.cssHooks[b]||m.cssHooks[h],void 0===c)return g&&"get"in g&&void 0!==(e=g.get(a,!1,d))?e:i[b];if(f=typeof c,"string"===f&&(e=Qb.exec(c))&&(c=(e[1]+1)*e[2]+parseFloat(m.css(a,b)),f="number"),null!=c&&c===c&&("number"!==f||m.cssNumber[h]||(c+="px"),k.clearCloneStyle||""!==c||0!==b.indexOf("background")||(i[b]="inherit"),!(g&&"set"in g&&void 0===(c=g.set(a,c,d)))))try{i[b]=c}catch(j){}}},css:function(a,b,c,d){var e,f,g,h=m.camelCase(b);return b=m.cssProps[h]||(m.cssProps[h]=Ub(a.style,h)),g=m.cssHooks[b]||m.cssHooks[h],g&&"get"in g&&(f=g.get(a,!0,c)),void 0===f&&(f=Jb(a,b,d)),"normal"===f&&b in Sb&&(f=Sb[b]),""===c||c?(e=parseFloat(f),c===!0||m.isNumeric(e)?e||0:f):f}}),m.each(["height","width"],function(a,b){m.cssHooks[b]={get:function(a,c,d){return c?Ob.test(m.css(a,"display"))&&0===a.offsetWidth?m.swap(a,Rb,function(){return Yb(a,b,d)}):Yb(a,b,d):void 0},set:function(a,c,d){var e=d&&Ib(a);return Wb(a,c,d?Xb(a,b,d,k.boxSizing&&"border-box"===m.css(a,"boxSizing",!1,e),e):0)}}}),k.opacity||(m.cssHooks.opacity={get:function(a,b){return Nb.test((b&&a.currentStyle?a.currentStyle.filter:a.style.filter)||"")?.01*parseFloat(RegExp.$1)+"":b?"1":""},set:function(a,b){var c=a.style,d=a.currentStyle,e=m.isNumeric(b)?"alpha(opacity="+100*b+")":"",f=d&&d.filter||c.filter||"";c.zoom=1,(b>=1||""===b)&&""===m.trim(f.replace(Mb,""))&&c.removeAttribute&&(c.removeAttribute("filter"),""===b||d&&!d.filter)||(c.filter=Mb.test(f)?f.replace(Mb,e):f+" "+e)}}),m.cssHooks.marginRight=Lb(k.reliableMarginRight,function(a,b){return b?m.swap(a,{display:"inline-block"},Jb,[a,"marginRight"]):void 0}),m.each({margin:"",padding:"",border:"Width"},function(a,b){m.cssHooks[a+b]={expand:function(c){for(var d=0,e={},f="string"==typeof c?c.split(" "):[c];4>d;d++)e[a+T[d]+b]=f[d]||f[d-2]||f[0];return e}},Gb.test(a)||(m.cssHooks[a+b].set=Wb)}),m.fn.extend({css:function(a,b){return V(this,function(a,b,c){var d,e,f={},g=0;if(m.isArray(b)){for(d=Ib(a),e=b.length;e>g;g++)f[b[g]]=m.css(a,b[g],!1,d);return f}return void 0!==c?m.style(a,b,c):m.css(a,b)},a,b,arguments.length>1)},show:function(){return Vb(this,!0)},hide:function(){return Vb(this)},toggle:function(a){return"boolean"==typeof a?a?this.show():this.hide():this.each(function(){U(this)?m(this).show():m(this).hide()})}});function Zb(a,b,c,d,e){return new Zb.prototype.init(a,b,c,d,e)}m.Tween=Zb,Zb.prototype={constructor:Zb,init:function(a,b,c,d,e,f){this.elem=a,this.prop=c,this.easing=e||"swing",this.options=b,this.start=this.now=this.cur(),this.end=d,this.unit=f||(m.cssNumber[c]?"":"px")
	},cur:function(){var a=Zb.propHooks[this.prop];return a&&a.get?a.get(this):Zb.propHooks._default.get(this)},run:function(a){var b,c=Zb.propHooks[this.prop];return this.pos=b=this.options.duration?m.easing[this.easing](a,this.options.duration*a,0,1,this.options.duration):a,this.now=(this.end-this.start)*b+this.start,this.options.step&&this.options.step.call(this.elem,this.now,this),c&&c.set?c.set(this):Zb.propHooks._default.set(this),this}},Zb.prototype.init.prototype=Zb.prototype,Zb.propHooks={_default:{get:function(a){var b;return null==a.elem[a.prop]||a.elem.style&&null!=a.elem.style[a.prop]?(b=m.css(a.elem,a.prop,""),b&&"auto"!==b?b:0):a.elem[a.prop]},set:function(a){m.fx.step[a.prop]?m.fx.step[a.prop](a):a.elem.style&&(null!=a.elem.style[m.cssProps[a.prop]]||m.cssHooks[a.prop])?m.style(a.elem,a.prop,a.now+a.unit):a.elem[a.prop]=a.now}}},Zb.propHooks.scrollTop=Zb.propHooks.scrollLeft={set:function(a){a.elem.nodeType&&a.elem.parentNode&&(a.elem[a.prop]=a.now)}},m.easing={linear:function(a){return a},swing:function(a){return.5-Math.cos(a*Math.PI)/2}},m.fx=Zb.prototype.init,m.fx.step={};var $b,_b,ac=/^(?:toggle|show|hide)$/,bc=new RegExp("^(?:([+-])=|)("+S+")([a-z%]*)$","i"),cc=/queueHooks$/,dc=[ic],ec={"*":[function(a,b){var c=this.createTween(a,b),d=c.cur(),e=bc.exec(b),f=e&&e[3]||(m.cssNumber[a]?"":"px"),g=(m.cssNumber[a]||"px"!==f&&+d)&&bc.exec(m.css(c.elem,a)),h=1,i=20;if(g&&g[3]!==f){f=f||g[3],e=e||[],g=+d||1;do h=h||".5",g/=h,m.style(c.elem,a,g+f);while(h!==(h=c.cur()/d)&&1!==h&&--i)}return e&&(g=c.start=+g||+d||0,c.unit=f,c.end=e[1]?g+(e[1]+1)*e[2]:+e[2]),c}]};function fc(){return setTimeout(function(){$b=void 0}),$b=m.now()}function gc(a,b){var c,d={height:a},e=0;for(b=b?1:0;4>e;e+=2-b)c=T[e],d["margin"+c]=d["padding"+c]=a;return b&&(d.opacity=d.width=a),d}function hc(a,b,c){for(var d,e=(ec[b]||[]).concat(ec["*"]),f=0,g=e.length;g>f;f++)if(d=e[f].call(c,b,a))return d}function ic(a,b,c){var d,e,f,g,h,i,j,l,n=this,o={},p=a.style,q=a.nodeType&&U(a),r=m._data(a,"fxshow");c.queue||(h=m._queueHooks(a,"fx"),null==h.unqueued&&(h.unqueued=0,i=h.empty.fire,h.empty.fire=function(){h.unqueued||i()}),h.unqueued++,n.always(function(){n.always(function(){h.unqueued--,m.queue(a,"fx").length||h.empty.fire()})})),1===a.nodeType&&("height"in b||"width"in b)&&(c.overflow=[p.overflow,p.overflowX,p.overflowY],j=m.css(a,"display"),l="none"===j?m._data(a,"olddisplay")||Fb(a.nodeName):j,"inline"===l&&"none"===m.css(a,"float")&&(k.inlineBlockNeedsLayout&&"inline"!==Fb(a.nodeName)?p.zoom=1:p.display="inline-block")),c.overflow&&(p.overflow="hidden",k.shrinkWrapBlocks()||n.always(function(){p.overflow=c.overflow[0],p.overflowX=c.overflow[1],p.overflowY=c.overflow[2]}));for(d in b)if(e=b[d],ac.exec(e)){if(delete b[d],f=f||"toggle"===e,e===(q?"hide":"show")){if("show"!==e||!r||void 0===r[d])continue;q=!0}o[d]=r&&r[d]||m.style(a,d)}else j=void 0;if(m.isEmptyObject(o))"inline"===("none"===j?Fb(a.nodeName):j)&&(p.display=j);else{r?"hidden"in r&&(q=r.hidden):r=m._data(a,"fxshow",{}),f&&(r.hidden=!q),q?m(a).show():n.done(function(){m(a).hide()}),n.done(function(){var b;m._removeData(a,"fxshow");for(b in o)m.style(a,b,o[b])});for(d in o)g=hc(q?r[d]:0,d,n),d in r||(r[d]=g.start,q&&(g.end=g.start,g.start="width"===d||"height"===d?1:0))}}function jc(a,b){var c,d,e,f,g;for(c in a)if(d=m.camelCase(c),e=b[d],f=a[c],m.isArray(f)&&(e=f[1],f=a[c]=f[0]),c!==d&&(a[d]=f,delete a[c]),g=m.cssHooks[d],g&&"expand"in g){f=g.expand(f),delete a[d];for(c in f)c in a||(a[c]=f[c],b[c]=e)}else b[d]=e}function kc(a,b,c){var d,e,f=0,g=dc.length,h=m.Deferred().always(function(){delete i.elem}),i=function(){if(e)return!1;for(var b=$b||fc(),c=Math.max(0,j.startTime+j.duration-b),d=c/j.duration||0,f=1-d,g=0,i=j.tweens.length;i>g;g++)j.tweens[g].run(f);return h.notifyWith(a,[j,f,c]),1>f&&i?c:(h.resolveWith(a,[j]),!1)},j=h.promise({elem:a,props:m.extend({},b),opts:m.extend(!0,{specialEasing:{}},c),originalProperties:b,originalOptions:c,startTime:$b||fc(),duration:c.duration,tweens:[],createTween:function(b,c){var d=m.Tween(a,j.opts,b,c,j.opts.specialEasing[b]||j.opts.easing);return j.tweens.push(d),d},stop:function(b){var c=0,d=b?j.tweens.length:0;if(e)return this;for(e=!0;d>c;c++)j.tweens[c].run(1);return b?h.resolveWith(a,[j,b]):h.rejectWith(a,[j,b]),this}}),k=j.props;for(jc(k,j.opts.specialEasing);g>f;f++)if(d=dc[f].call(j,a,k,j.opts))return d;return m.map(k,hc,j),m.isFunction(j.opts.start)&&j.opts.start.call(a,j),m.fx.timer(m.extend(i,{elem:a,anim:j,queue:j.opts.queue})),j.progress(j.opts.progress).done(j.opts.done,j.opts.complete).fail(j.opts.fail).always(j.opts.always)}m.Animation=m.extend(kc,{tweener:function(a,b){m.isFunction(a)?(b=a,a=["*"]):a=a.split(" ");for(var c,d=0,e=a.length;e>d;d++)c=a[d],ec[c]=ec[c]||[],ec[c].unshift(b)},prefilter:function(a,b){b?dc.unshift(a):dc.push(a)}}),m.speed=function(a,b,c){var d=a&&"object"==typeof a?m.extend({},a):{complete:c||!c&&b||m.isFunction(a)&&a,duration:a,easing:c&&b||b&&!m.isFunction(b)&&b};return d.duration=m.fx.off?0:"number"==typeof d.duration?d.duration:d.duration in m.fx.speeds?m.fx.speeds[d.duration]:m.fx.speeds._default,(null==d.queue||d.queue===!0)&&(d.queue="fx"),d.old=d.complete,d.complete=function(){m.isFunction(d.old)&&d.old.call(this),d.queue&&m.dequeue(this,d.queue)},d},m.fn.extend({fadeTo:function(a,b,c,d){return this.filter(U).css("opacity",0).show().end().animate({opacity:b},a,c,d)},animate:function(a,b,c,d){var e=m.isEmptyObject(a),f=m.speed(b,c,d),g=function(){var b=kc(this,m.extend({},a),f);(e||m._data(this,"finish"))&&b.stop(!0)};return g.finish=g,e||f.queue===!1?this.each(g):this.queue(f.queue,g)},stop:function(a,b,c){var d=function(a){var b=a.stop;delete a.stop,b(c)};return"string"!=typeof a&&(c=b,b=a,a=void 0),b&&a!==!1&&this.queue(a||"fx",[]),this.each(function(){var b=!0,e=null!=a&&a+"queueHooks",f=m.timers,g=m._data(this);if(e)g[e]&&g[e].stop&&d(g[e]);else for(e in g)g[e]&&g[e].stop&&cc.test(e)&&d(g[e]);for(e=f.length;e--;)f[e].elem!==this||null!=a&&f[e].queue!==a||(f[e].anim.stop(c),b=!1,f.splice(e,1));(b||!c)&&m.dequeue(this,a)})},finish:function(a){return a!==!1&&(a=a||"fx"),this.each(function(){var b,c=m._data(this),d=c[a+"queue"],e=c[a+"queueHooks"],f=m.timers,g=d?d.length:0;for(c.finish=!0,m.queue(this,a,[]),e&&e.stop&&e.stop.call(this,!0),b=f.length;b--;)f[b].elem===this&&f[b].queue===a&&(f[b].anim.stop(!0),f.splice(b,1));for(b=0;g>b;b++)d[b]&&d[b].finish&&d[b].finish.call(this);delete c.finish})}}),m.each(["toggle","show","hide"],function(a,b){var c=m.fn[b];m.fn[b]=function(a,d,e){return null==a||"boolean"==typeof a?c.apply(this,arguments):this.animate(gc(b,!0),a,d,e)}}),m.each({slideDown:gc("show"),slideUp:gc("hide"),slideToggle:gc("toggle"),fadeIn:{opacity:"show"},fadeOut:{opacity:"hide"},fadeToggle:{opacity:"toggle"}},function(a,b){m.fn[a]=function(a,c,d){return this.animate(b,a,c,d)}}),m.timers=[],m.fx.tick=function(){var a,b=m.timers,c=0;for($b=m.now();c<b.length;c++)a=b[c],a()||b[c]!==a||b.splice(c--,1);b.length||m.fx.stop(),$b=void 0},m.fx.timer=function(a){m.timers.push(a),a()?m.fx.start():m.timers.pop()},m.fx.interval=13,m.fx.start=function(){_b||(_b=setInterval(m.fx.tick,m.fx.interval))},m.fx.stop=function(){clearInterval(_b),_b=null},m.fx.speeds={slow:600,fast:200,_default:400},m.fn.delay=function(a,b){return a=m.fx?m.fx.speeds[a]||a:a,b=b||"fx",this.queue(b,function(b,c){var d=setTimeout(b,a);c.stop=function(){clearTimeout(d)}})},function(){var a,b,c,d,e;b=y.createElement("div"),b.setAttribute("className","t"),b.innerHTML="  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>",d=b.getElementsByTagName("a")[0],c=y.createElement("select"),e=c.appendChild(y.createElement("option")),a=b.getElementsByTagName("input")[0],d.style.cssText="top:1px",k.getSetAttribute="t"!==b.className,k.style=/top/.test(d.getAttribute("style")),k.hrefNormalized="/a"===d.getAttribute("href"),k.checkOn=!!a.value,k.optSelected=e.selected,k.enctype=!!y.createElement("form").enctype,c.disabled=!0,k.optDisabled=!e.disabled,a=y.createElement("input"),a.setAttribute("value",""),k.input=""===a.getAttribute("value"),a.value="t",a.setAttribute("type","radio"),k.radioValue="t"===a.value}();var lc=/\r/g;m.fn.extend({val:function(a){var b,c,d,e=this[0];{if(arguments.length)return d=m.isFunction(a),this.each(function(c){var e;1===this.nodeType&&(e=d?a.call(this,c,m(this).val()):a,null==e?e="":"number"==typeof e?e+="":m.isArray(e)&&(e=m.map(e,function(a){return null==a?"":a+""})),b=m.valHooks[this.type]||m.valHooks[this.nodeName.toLowerCase()],b&&"set"in b&&void 0!==b.set(this,e,"value")||(this.value=e))});if(e)return b=m.valHooks[e.type]||m.valHooks[e.nodeName.toLowerCase()],b&&"get"in b&&void 0!==(c=b.get(e,"value"))?c:(c=e.value,"string"==typeof c?c.replace(lc,""):null==c?"":c)}}}),m.extend({valHooks:{option:{get:function(a){var b=m.find.attr(a,"value");return null!=b?b:m.trim(m.text(a))}},select:{get:function(a){for(var b,c,d=a.options,e=a.selectedIndex,f="select-one"===a.type||0>e,g=f?null:[],h=f?e+1:d.length,i=0>e?h:f?e:0;h>i;i++)if(c=d[i],!(!c.selected&&i!==e||(k.optDisabled?c.disabled:null!==c.getAttribute("disabled"))||c.parentNode.disabled&&m.nodeName(c.parentNode,"optgroup"))){if(b=m(c).val(),f)return b;g.push(b)}return g},set:function(a,b){var c,d,e=a.options,f=m.makeArray(b),g=e.length;while(g--)if(d=e[g],m.inArray(m.valHooks.option.get(d),f)>=0)try{d.selected=c=!0}catch(h){d.scrollHeight}else d.selected=!1;return c||(a.selectedIndex=-1),e}}}}),m.each(["radio","checkbox"],function(){m.valHooks[this]={set:function(a,b){return m.isArray(b)?a.checked=m.inArray(m(a).val(),b)>=0:void 0}},k.checkOn||(m.valHooks[this].get=function(a){return null===a.getAttribute("value")?"on":a.value})});var mc,nc,oc=m.expr.attrHandle,pc=/^(?:checked|selected)$/i,qc=k.getSetAttribute,rc=k.input;m.fn.extend({attr:function(a,b){return V(this,m.attr,a,b,arguments.length>1)},removeAttr:function(a){return this.each(function(){m.removeAttr(this,a)})}}),m.extend({attr:function(a,b,c){var d,e,f=a.nodeType;if(a&&3!==f&&8!==f&&2!==f)return typeof a.getAttribute===K?m.prop(a,b,c):(1===f&&m.isXMLDoc(a)||(b=b.toLowerCase(),d=m.attrHooks[b]||(m.expr.match.bool.test(b)?nc:mc)),void 0===c?d&&"get"in d&&null!==(e=d.get(a,b))?e:(e=m.find.attr(a,b),null==e?void 0:e):null!==c?d&&"set"in d&&void 0!==(e=d.set(a,c,b))?e:(a.setAttribute(b,c+""),c):void m.removeAttr(a,b))},removeAttr:function(a,b){var c,d,e=0,f=b&&b.match(E);if(f&&1===a.nodeType)while(c=f[e++])d=m.propFix[c]||c,m.expr.match.bool.test(c)?rc&&qc||!pc.test(c)?a[d]=!1:a[m.camelCase("default-"+c)]=a[d]=!1:m.attr(a,c,""),a.removeAttribute(qc?c:d)},attrHooks:{type:{set:function(a,b){if(!k.radioValue&&"radio"===b&&m.nodeName(a,"input")){var c=a.value;return a.setAttribute("type",b),c&&(a.value=c),b}}}}}),nc={set:function(a,b,c){return b===!1?m.removeAttr(a,c):rc&&qc||!pc.test(c)?a.setAttribute(!qc&&m.propFix[c]||c,c):a[m.camelCase("default-"+c)]=a[c]=!0,c}},m.each(m.expr.match.bool.source.match(/\w+/g),function(a,b){var c=oc[b]||m.find.attr;oc[b]=rc&&qc||!pc.test(b)?function(a,b,d){var e,f;return d||(f=oc[b],oc[b]=e,e=null!=c(a,b,d)?b.toLowerCase():null,oc[b]=f),e}:function(a,b,c){return c?void 0:a[m.camelCase("default-"+b)]?b.toLowerCase():null}}),rc&&qc||(m.attrHooks.value={set:function(a,b,c){return m.nodeName(a,"input")?void(a.defaultValue=b):mc&&mc.set(a,b,c)}}),qc||(mc={set:function(a,b,c){var d=a.getAttributeNode(c);return d||a.setAttributeNode(d=a.ownerDocument.createAttribute(c)),d.value=b+="","value"===c||b===a.getAttribute(c)?b:void 0}},oc.id=oc.name=oc.coords=function(a,b,c){var d;return c?void 0:(d=a.getAttributeNode(b))&&""!==d.value?d.value:null},m.valHooks.button={get:function(a,b){var c=a.getAttributeNode(b);return c&&c.specified?c.value:void 0},set:mc.set},m.attrHooks.contenteditable={set:function(a,b,c){mc.set(a,""===b?!1:b,c)}},m.each(["width","height"],function(a,b){m.attrHooks[b]={set:function(a,c){return""===c?(a.setAttribute(b,"auto"),c):void 0}}})),k.style||(m.attrHooks.style={get:function(a){return a.style.cssText||void 0},set:function(a,b){return a.style.cssText=b+""}});var sc=/^(?:input|select|textarea|button|object)$/i,tc=/^(?:a|area)$/i;m.fn.extend({prop:function(a,b){return V(this,m.prop,a,b,arguments.length>1)},removeProp:function(a){return a=m.propFix[a]||a,this.each(function(){try{this[a]=void 0,delete this[a]}catch(b){}})}}),m.extend({propFix:{"for":"htmlFor","class":"className"},prop:function(a,b,c){var d,e,f,g=a.nodeType;if(a&&3!==g&&8!==g&&2!==g)return f=1!==g||!m.isXMLDoc(a),f&&(b=m.propFix[b]||b,e=m.propHooks[b]),void 0!==c?e&&"set"in e&&void 0!==(d=e.set(a,c,b))?d:a[b]=c:e&&"get"in e&&null!==(d=e.get(a,b))?d:a[b]},propHooks:{tabIndex:{get:function(a){var b=m.find.attr(a,"tabindex");return b?parseInt(b,10):sc.test(a.nodeName)||tc.test(a.nodeName)&&a.href?0:-1}}}}),k.hrefNormalized||m.each(["href","src"],function(a,b){m.propHooks[b]={get:function(a){return a.getAttribute(b,4)}}}),k.optSelected||(m.propHooks.selected={get:function(a){var b=a.parentNode;return b&&(b.selectedIndex,b.parentNode&&b.parentNode.selectedIndex),null}}),m.each(["tabIndex","readOnly","maxLength","cellSpacing","cellPadding","rowSpan","colSpan","useMap","frameBorder","contentEditable"],function(){m.propFix[this.toLowerCase()]=this}),k.enctype||(m.propFix.enctype="encoding");var uc=/[\t\r\n\f]/g;m.fn.extend({addClass:function(a){var b,c,d,e,f,g,h=0,i=this.length,j="string"==typeof a&&a;if(m.isFunction(a))return this.each(function(b){m(this).addClass(a.call(this,b,this.className))});if(j)for(b=(a||"").match(E)||[];i>h;h++)if(c=this[h],d=1===c.nodeType&&(c.className?(" "+c.className+" ").replace(uc," "):" ")){f=0;while(e=b[f++])d.indexOf(" "+e+" ")<0&&(d+=e+" ");g=m.trim(d),c.className!==g&&(c.className=g)}return this},removeClass:function(a){var b,c,d,e,f,g,h=0,i=this.length,j=0===arguments.length||"string"==typeof a&&a;if(m.isFunction(a))return this.each(function(b){m(this).removeClass(a.call(this,b,this.className))});if(j)for(b=(a||"").match(E)||[];i>h;h++)if(c=this[h],d=1===c.nodeType&&(c.className?(" "+c.className+" ").replace(uc," "):"")){f=0;while(e=b[f++])while(d.indexOf(" "+e+" ")>=0)d=d.replace(" "+e+" "," ");g=a?m.trim(d):"",c.className!==g&&(c.className=g)}return this},toggleClass:function(a,b){var c=typeof a;return"boolean"==typeof b&&"string"===c?b?this.addClass(a):this.removeClass(a):this.each(m.isFunction(a)?function(c){m(this).toggleClass(a.call(this,c,this.className,b),b)}:function(){if("string"===c){var b,d=0,e=m(this),f=a.match(E)||[];while(b=f[d++])e.hasClass(b)?e.removeClass(b):e.addClass(b)}else(c===K||"boolean"===c)&&(this.className&&m._data(this,"__className__",this.className),this.className=this.className||a===!1?"":m._data(this,"__className__")||"")})},hasClass:function(a){for(var b=" "+a+" ",c=0,d=this.length;d>c;c++)if(1===this[c].nodeType&&(" "+this[c].className+" ").replace(uc," ").indexOf(b)>=0)return!0;return!1}}),m.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "),function(a,b){m.fn[b]=function(a,c){return arguments.length>0?this.on(b,null,a,c):this.trigger(b)}}),m.fn.extend({hover:function(a,b){return this.mouseenter(a).mouseleave(b||a)},bind:function(a,b,c){return this.on(a,null,b,c)},unbind:function(a,b){return this.off(a,null,b)},delegate:function(a,b,c,d){return this.on(b,a,c,d)},undelegate:function(a,b,c){return 1===arguments.length?this.off(a,"**"):this.off(b,a||"**",c)}});var vc=m.now(),wc=/\?/,xc=/(,)|(\[|{)|(}|])|"(?:[^"\\\r\n]|\\["\\\/bfnrt]|\\u[\da-fA-F]{4})*"\s*:?|true|false|null|-?(?!0\d)\d+(?:\.\d+|)(?:[eE][+-]?\d+|)/g;m.parseJSON=function(b){if(a.JSON&&a.JSON.parse)return a.JSON.parse(b+"");var c,d=null,e=m.trim(b+"");return e&&!m.trim(e.replace(xc,function(a,b,e,f){return c&&b&&(d=0),0===d?a:(c=e||b,d+=!f-!e,"")}))?Function("return "+e)():m.error("Invalid JSON: "+b)},m.parseXML=function(b){var c,d;if(!b||"string"!=typeof b)return null;try{a.DOMParser?(d=new DOMParser,c=d.parseFromString(b,"text/xml")):(c=new ActiveXObject("Microsoft.XMLDOM"),c.async="false",c.loadXML(b))}catch(e){c=void 0}return c&&c.documentElement&&!c.getElementsByTagName("parsererror").length||m.error("Invalid XML: "+b),c};var yc,zc,Ac=/#.*$/,Bc=/([?&])_=[^&]*/,Cc=/^(.*?):[ \t]*([^\r\n]*)\r?$/gm,Dc=/^(?:about|app|app-storage|.+-extension|file|res|widget):$/,Ec=/^(?:GET|HEAD)$/,Fc=/^\/\//,Gc=/^([\w.+-]+:)(?:\/\/(?:[^\/?#]*@|)([^\/?#:]*)(?::(\d+)|)|)/,Hc={},Ic={},Jc="*/".concat("*");try{zc=location.href}catch(Kc){zc=y.createElement("a"),zc.href="",zc=zc.href}yc=Gc.exec(zc.toLowerCase())||[];function Lc(a){return function(b,c){"string"!=typeof b&&(c=b,b="*");var d,e=0,f=b.toLowerCase().match(E)||[];if(m.isFunction(c))while(d=f[e++])"+"===d.charAt(0)?(d=d.slice(1)||"*",(a[d]=a[d]||[]).unshift(c)):(a[d]=a[d]||[]).push(c)}}function Mc(a,b,c,d){var e={},f=a===Ic;function g(h){var i;return e[h]=!0,m.each(a[h]||[],function(a,h){var j=h(b,c,d);return"string"!=typeof j||f||e[j]?f?!(i=j):void 0:(b.dataTypes.unshift(j),g(j),!1)}),i}return g(b.dataTypes[0])||!e["*"]&&g("*")}function Nc(a,b){var c,d,e=m.ajaxSettings.flatOptions||{};for(d in b)void 0!==b[d]&&((e[d]?a:c||(c={}))[d]=b[d]);return c&&m.extend(!0,a,c),a}function Oc(a,b,c){var d,e,f,g,h=a.contents,i=a.dataTypes;while("*"===i[0])i.shift(),void 0===e&&(e=a.mimeType||b.getResponseHeader("Content-Type"));if(e)for(g in h)if(h[g]&&h[g].test(e)){i.unshift(g);break}if(i[0]in c)f=i[0];else{for(g in c){if(!i[0]||a.converters[g+" "+i[0]]){f=g;break}d||(d=g)}f=f||d}return f?(f!==i[0]&&i.unshift(f),c[f]):void 0}function Pc(a,b,c,d){var e,f,g,h,i,j={},k=a.dataTypes.slice();if(k[1])for(g in a.converters)j[g.toLowerCase()]=a.converters[g];f=k.shift();while(f)if(a.responseFields[f]&&(c[a.responseFields[f]]=b),!i&&d&&a.dataFilter&&(b=a.dataFilter(b,a.dataType)),i=f,f=k.shift())if("*"===f)f=i;else if("*"!==i&&i!==f){if(g=j[i+" "+f]||j["* "+f],!g)for(e in j)if(h=e.split(" "),h[1]===f&&(g=j[i+" "+h[0]]||j["* "+h[0]])){g===!0?g=j[e]:j[e]!==!0&&(f=h[0],k.unshift(h[1]));break}if(g!==!0)if(g&&a["throws"])b=g(b);else try{b=g(b)}catch(l){return{state:"parsererror",error:g?l:"No conversion from "+i+" to "+f}}}return{state:"success",data:b}}m.extend({active:0,lastModified:{},etag:{},ajaxSettings:{url:zc,type:"GET",isLocal:Dc.test(yc[1]),global:!0,processData:!0,async:!0,contentType:"application/x-www-form-urlencoded; charset=UTF-8",accepts:{"*":Jc,text:"text/plain",html:"text/html",xml:"application/xml, text/xml",json:"application/json, text/javascript"},contents:{xml:/xml/,html:/html/,json:/json/},responseFields:{xml:"responseXML",text:"responseText",json:"responseJSON"},converters:{"* text":String,"text html":!0,"text json":m.parseJSON,"text xml":m.parseXML},flatOptions:{url:!0,context:!0}},ajaxSetup:function(a,b){return b?Nc(Nc(a,m.ajaxSettings),b):Nc(m.ajaxSettings,a)},ajaxPrefilter:Lc(Hc),ajaxTransport:Lc(Ic),ajax:function(a,b){"object"==typeof a&&(b=a,a=void 0),b=b||{};var c,d,e,f,g,h,i,j,k=m.ajaxSetup({},b),l=k.context||k,n=k.context&&(l.nodeType||l.jquery)?m(l):m.event,o=m.Deferred(),p=m.Callbacks("once memory"),q=k.statusCode||{},r={},s={},t=0,u="canceled",v={readyState:0,getResponseHeader:function(a){var b;if(2===t){if(!j){j={};while(b=Cc.exec(f))j[b[1].toLowerCase()]=b[2]}b=j[a.toLowerCase()]}return null==b?null:b},getAllResponseHeaders:function(){return 2===t?f:null},setRequestHeader:function(a,b){var c=a.toLowerCase();return t||(a=s[c]=s[c]||a,r[a]=b),this},overrideMimeType:function(a){return t||(k.mimeType=a),this},statusCode:function(a){var b;if(a)if(2>t)for(b in a)q[b]=[q[b],a[b]];else v.always(a[v.status]);return this},abort:function(a){var b=a||u;return i&&i.abort(b),x(0,b),this}};if(o.promise(v).complete=p.add,v.success=v.done,v.error=v.fail,k.url=((a||k.url||zc)+"").replace(Ac,"").replace(Fc,yc[1]+"//"),k.type=b.method||b.type||k.method||k.type,k.dataTypes=m.trim(k.dataType||"*").toLowerCase().match(E)||[""],null==k.crossDomain&&(c=Gc.exec(k.url.toLowerCase()),k.crossDomain=!(!c||c[1]===yc[1]&&c[2]===yc[2]&&(c[3]||("http:"===c[1]?"80":"443"))===(yc[3]||("http:"===yc[1]?"80":"443")))),k.data&&k.processData&&"string"!=typeof k.data&&(k.data=m.param(k.data,k.traditional)),Mc(Hc,k,b,v),2===t)return v;h=k.global,h&&0===m.active++&&m.event.trigger("ajaxStart"),k.type=k.type.toUpperCase(),k.hasContent=!Ec.test(k.type),e=k.url,k.hasContent||(k.data&&(e=k.url+=(wc.test(e)?"&":"?")+k.data,delete k.data),k.cache===!1&&(k.url=Bc.test(e)?e.replace(Bc,"$1_="+vc++):e+(wc.test(e)?"&":"?")+"_="+vc++)),k.ifModified&&(m.lastModified[e]&&v.setRequestHeader("If-Modified-Since",m.lastModified[e]),m.etag[e]&&v.setRequestHeader("If-None-Match",m.etag[e])),(k.data&&k.hasContent&&k.contentType!==!1||b.contentType)&&v.setRequestHeader("Content-Type",k.contentType),v.setRequestHeader("Accept",k.dataTypes[0]&&k.accepts[k.dataTypes[0]]?k.accepts[k.dataTypes[0]]+("*"!==k.dataTypes[0]?", "+Jc+"; q=0.01":""):k.accepts["*"]);for(d in k.headers)v.setRequestHeader(d,k.headers[d]);if(k.beforeSend&&(k.beforeSend.call(l,v,k)===!1||2===t))return v.abort();u="abort";for(d in{success:1,error:1,complete:1})v[d](k[d]);if(i=Mc(Ic,k,b,v)){v.readyState=1,h&&n.trigger("ajaxSend",[v,k]),k.async&&k.timeout>0&&(g=setTimeout(function(){v.abort("timeout")},k.timeout));try{t=1,i.send(r,x)}catch(w){if(!(2>t))throw w;x(-1,w)}}else x(-1,"No Transport");function x(a,b,c,d){var j,r,s,u,w,x=b;2!==t&&(t=2,g&&clearTimeout(g),i=void 0,f=d||"",v.readyState=a>0?4:0,j=a>=200&&300>a||304===a,c&&(u=Oc(k,v,c)),u=Pc(k,u,v,j),j?(k.ifModified&&(w=v.getResponseHeader("Last-Modified"),w&&(m.lastModified[e]=w),w=v.getResponseHeader("etag"),w&&(m.etag[e]=w)),204===a||"HEAD"===k.type?x="nocontent":304===a?x="notmodified":(x=u.state,r=u.data,s=u.error,j=!s)):(s=x,(a||!x)&&(x="error",0>a&&(a=0))),v.status=a,v.statusText=(b||x)+"",j?o.resolveWith(l,[r,x,v]):o.rejectWith(l,[v,x,s]),v.statusCode(q),q=void 0,h&&n.trigger(j?"ajaxSuccess":"ajaxError",[v,k,j?r:s]),p.fireWith(l,[v,x]),h&&(n.trigger("ajaxComplete",[v,k]),--m.active||m.event.trigger("ajaxStop")))}return v},getJSON:function(a,b,c){return m.get(a,b,c,"json")},getScript:function(a,b){return m.get(a,void 0,b,"script")}}),m.each(["get","post"],function(a,b){m[b]=function(a,c,d,e){return m.isFunction(c)&&(e=e||d,d=c,c=void 0),m.ajax({url:a,type:b,dataType:e,data:c,success:d})}}),m.each(["ajaxStart","ajaxStop","ajaxComplete","ajaxError","ajaxSuccess","ajaxSend"],function(a,b){m.fn[b]=function(a){return this.on(b,a)}}),m._evalUrl=function(a){return m.ajax({url:a,type:"GET",dataType:"script",async:!1,global:!1,"throws":!0})},m.fn.extend({wrapAll:function(a){if(m.isFunction(a))return this.each(function(b){m(this).wrapAll(a.call(this,b))});if(this[0]){var b=m(a,this[0].ownerDocument).eq(0).clone(!0);this[0].parentNode&&b.insertBefore(this[0]),b.map(function(){var a=this;while(a.firstChild&&1===a.firstChild.nodeType)a=a.firstChild;return a}).append(this)}return this},wrapInner:function(a){return this.each(m.isFunction(a)?function(b){m(this).wrapInner(a.call(this,b))}:function(){var b=m(this),c=b.contents();c.length?c.wrapAll(a):b.append(a)})},wrap:function(a){var b=m.isFunction(a);return this.each(function(c){m(this).wrapAll(b?a.call(this,c):a)})},unwrap:function(){return this.parent().each(function(){m.nodeName(this,"body")||m(this).replaceWith(this.childNodes)}).end()}}),m.expr.filters.hidden=function(a){return a.offsetWidth<=0&&a.offsetHeight<=0||!k.reliableHiddenOffsets()&&"none"===(a.style&&a.style.display||m.css(a,"display"))},m.expr.filters.visible=function(a){return!m.expr.filters.hidden(a)};var Qc=/%20/g,Rc=/\[\]$/,Sc=/\r?\n/g,Tc=/^(?:submit|button|image|reset|file)$/i,Uc=/^(?:input|select|textarea|keygen)/i;function Vc(a,b,c,d){var e;if(m.isArray(b))m.each(b,function(b,e){c||Rc.test(a)?d(a,e):Vc(a+"["+("object"==typeof e?b:"")+"]",e,c,d)});else if(c||"object"!==m.type(b))d(a,b);else for(e in b)Vc(a+"["+e+"]",b[e],c,d)}m.param=function(a,b){var c,d=[],e=function(a,b){b=m.isFunction(b)?b():null==b?"":b,d[d.length]=encodeURIComponent(a)+"="+encodeURIComponent(b)};if(void 0===b&&(b=m.ajaxSettings&&m.ajaxSettings.traditional),m.isArray(a)||a.jquery&&!m.isPlainObject(a))m.each(a,function(){e(this.name,this.value)});else for(c in a)Vc(c,a[c],b,e);return d.join("&").replace(Qc,"+")},m.fn.extend({serialize:function(){return m.param(this.serializeArray())},serializeArray:function(){return this.map(function(){var a=m.prop(this,"elements");return a?m.makeArray(a):this}).filter(function(){var a=this.type;return this.name&&!m(this).is(":disabled")&&Uc.test(this.nodeName)&&!Tc.test(a)&&(this.checked||!W.test(a))}).map(function(a,b){var c=m(this).val();return null==c?null:m.isArray(c)?m.map(c,function(a){return{name:b.name,value:a.replace(Sc,"\r\n")}}):{name:b.name,value:c.replace(Sc,"\r\n")}}).get()}}),m.ajaxSettings.xhr=void 0!==a.ActiveXObject?function(){return!this.isLocal&&/^(get|post|head|put|delete|options)$/i.test(this.type)&&Zc()||$c()}:Zc;var Wc=0,Xc={},Yc=m.ajaxSettings.xhr();a.ActiveXObject&&m(a).on("unload",function(){for(var a in Xc)Xc[a](void 0,!0)}),k.cors=!!Yc&&"withCredentials"in Yc,Yc=k.ajax=!!Yc,Yc&&m.ajaxTransport(function(a){if(!a.crossDomain||k.cors){var b;return{send:function(c,d){var e,f=a.xhr(),g=++Wc;if(f.open(a.type,a.url,a.async,a.username,a.password),a.xhrFields)for(e in a.xhrFields)f[e]=a.xhrFields[e];a.mimeType&&f.overrideMimeType&&f.overrideMimeType(a.mimeType),a.crossDomain||c["X-Requested-With"]||(c["X-Requested-With"]="XMLHttpRequest");for(e in c)void 0!==c[e]&&f.setRequestHeader(e,c[e]+"");f.send(a.hasContent&&a.data||null),b=function(c,e){var h,i,j;if(b&&(e||4===f.readyState))if(delete Xc[g],b=void 0,f.onreadystatechange=m.noop,e)4!==f.readyState&&f.abort();else{j={},h=f.status,"string"==typeof f.responseText&&(j.text=f.responseText);try{i=f.statusText}catch(k){i=""}h||!a.isLocal||a.crossDomain?1223===h&&(h=204):h=j.text?200:404}j&&d(h,i,j,f.getAllResponseHeaders())},a.async?4===f.readyState?setTimeout(b):f.onreadystatechange=Xc[g]=b:b()},abort:function(){b&&b(void 0,!0)}}}});function Zc(){try{return new a.XMLHttpRequest}catch(b){}}function $c(){try{return new a.ActiveXObject("Microsoft.XMLHTTP")}catch(b){}}m.ajaxSetup({accepts:{script:"text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"},contents:{script:/(?:java|ecma)script/},converters:{"text script":function(a){return m.globalEval(a),a}}}),m.ajaxPrefilter("script",function(a){void 0===a.cache&&(a.cache=!1),a.crossDomain&&(a.type="GET",a.global=!1)}),m.ajaxTransport("script",function(a){if(a.crossDomain){var b,c=y.head||m("head")[0]||y.documentElement;return{send:function(d,e){b=y.createElement("script"),b.async=!0,a.scriptCharset&&(b.charset=a.scriptCharset),b.src=a.url,b.onload=b.onreadystatechange=function(a,c){(c||!b.readyState||/loaded|complete/.test(b.readyState))&&(b.onload=b.onreadystatechange=null,b.parentNode&&b.parentNode.removeChild(b),b=null,c||e(200,"success"))},c.insertBefore(b,c.firstChild)},abort:function(){b&&b.onload(void 0,!0)}}}});var _c=[],ad=/(=)\?(?=&|$)|\?\?/;m.ajaxSetup({jsonp:"callback",jsonpCallback:function(){var a=_c.pop()||m.expando+"_"+vc++;return this[a]=!0,a}}),m.ajaxPrefilter("json jsonp",function(b,c,d){var e,f,g,h=b.jsonp!==!1&&(ad.test(b.url)?"url":"string"==typeof b.data&&!(b.contentType||"").indexOf("application/x-www-form-urlencoded")&&ad.test(b.data)&&"data");return h||"jsonp"===b.dataTypes[0]?(e=b.jsonpCallback=m.isFunction(b.jsonpCallback)?b.jsonpCallback():b.jsonpCallback,h?b[h]=b[h].replace(ad,"$1"+e):b.jsonp!==!1&&(b.url+=(wc.test(b.url)?"&":"?")+b.jsonp+"="+e),b.converters["script json"]=function(){return g||m.error(e+" was not called"),g[0]},b.dataTypes[0]="json",f=a[e],a[e]=function(){g=arguments},d.always(function(){a[e]=f,b[e]&&(b.jsonpCallback=c.jsonpCallback,_c.push(e)),g&&m.isFunction(f)&&f(g[0]),g=f=void 0}),"script"):void 0}),m.parseHTML=function(a,b,c){if(!a||"string"!=typeof a)return null;"boolean"==typeof b&&(c=b,b=!1),b=b||y;var d=u.exec(a),e=!c&&[];return d?[b.createElement(d[1])]:(d=m.buildFragment([a],b,e),e&&e.length&&m(e).remove(),m.merge([],d.childNodes))};var bd=m.fn.load;m.fn.load=function(a,b,c){if("string"!=typeof a&&bd)return bd.apply(this,arguments);var d,e,f,g=this,h=a.indexOf(" ");return h>=0&&(d=m.trim(a.slice(h,a.length)),a=a.slice(0,h)),m.isFunction(b)?(c=b,b=void 0):b&&"object"==typeof b&&(f="POST"),g.length>0&&m.ajax({url:a,type:f,dataType:"html",data:b}).done(function(a){e=arguments,g.html(d?m("<div>").append(m.parseHTML(a)).find(d):a)}).complete(c&&function(a,b){g.each(c,e||[a.responseText,b,a])}),this},m.expr.filters.animated=function(a){return m.grep(m.timers,function(b){return a===b.elem}).length};var cd=a.document.documentElement;function dd(a){return m.isWindow(a)?a:9===a.nodeType?a.defaultView||a.parentWindow:!1}m.offset={setOffset:function(a,b,c){var d,e,f,g,h,i,j,k=m.css(a,"position"),l=m(a),n={};"static"===k&&(a.style.position="relative"),h=l.offset(),f=m.css(a,"top"),i=m.css(a,"left"),j=("absolute"===k||"fixed"===k)&&m.inArray("auto",[f,i])>-1,j?(d=l.position(),g=d.top,e=d.left):(g=parseFloat(f)||0,e=parseFloat(i)||0),m.isFunction(b)&&(b=b.call(a,c,h)),null!=b.top&&(n.top=b.top-h.top+g),null!=b.left&&(n.left=b.left-h.left+e),"using"in b?b.using.call(a,n):l.css(n)}},m.fn.extend({offset:function(a){if(arguments.length)return void 0===a?this:this.each(function(b){m.offset.setOffset(this,a,b)});var b,c,d={top:0,left:0},e=this[0],f=e&&e.ownerDocument;if(f)return b=f.documentElement,m.contains(b,e)?(typeof e.getBoundingClientRect!==K&&(d=e.getBoundingClientRect()),c=dd(f),{top:d.top+(c.pageYOffset||b.scrollTop)-(b.clientTop||0),left:d.left+(c.pageXOffset||b.scrollLeft)-(b.clientLeft||0)}):d},position:function(){if(this[0]){var a,b,c={top:0,left:0},d=this[0];return"fixed"===m.css(d,"position")?b=d.getBoundingClientRect():(a=this.offsetParent(),b=this.offset(),m.nodeName(a[0],"html")||(c=a.offset()),c.top+=m.css(a[0],"borderTopWidth",!0),c.left+=m.css(a[0],"borderLeftWidth",!0)),{top:b.top-c.top-m.css(d,"marginTop",!0),left:b.left-c.left-m.css(d,"marginLeft",!0)}}},offsetParent:function(){return this.map(function(){var a=this.offsetParent||cd;while(a&&!m.nodeName(a,"html")&&"static"===m.css(a,"position"))a=a.offsetParent;return a||cd})}}),m.each({scrollLeft:"pageXOffset",scrollTop:"pageYOffset"},function(a,b){var c=/Y/.test(b);m.fn[a]=function(d){return V(this,function(a,d,e){var f=dd(a);return void 0===e?f?b in f?f[b]:f.document.documentElement[d]:a[d]:void(f?f.scrollTo(c?m(f).scrollLeft():e,c?e:m(f).scrollTop()):a[d]=e)},a,d,arguments.length,null)}}),m.each(["top","left"],function(a,b){m.cssHooks[b]=Lb(k.pixelPosition,function(a,c){return c?(c=Jb(a,b),Hb.test(c)?m(a).position()[b]+"px":c):void 0})}),m.each({Height:"height",Width:"width"},function(a,b){m.each({padding:"inner"+a,content:b,"":"outer"+a},function(c,d){m.fn[d]=function(d,e){var f=arguments.length&&(c||"boolean"!=typeof d),g=c||(d===!0||e===!0?"margin":"border");return V(this,function(b,c,d){var e;return m.isWindow(b)?b.document.documentElement["client"+a]:9===b.nodeType?(e=b.documentElement,Math.max(b.body["scroll"+a],e["scroll"+a],b.body["offset"+a],e["offset"+a],e["client"+a])):void 0===d?m.css(b,c,g):m.style(b,c,d,g)},b,f?d:void 0,f,null)}})}),m.fn.size=function(){return this.length},m.fn.andSelf=m.fn.addBack,"function"=='function'&&require(16)&&!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function(){return m}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));var ed=a.jQuery,fd=a.$;return m.noConflict=function(b){return a.$===m&&(a.$=fd),b&&a.jQuery===m&&(a.jQuery=ed),m},typeof b===K&&(a.jQuery=a.$=m),m});
	


/***/ },
/* 7 */
/***/ function(module, exports, require) {

	var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;!function(e){true?!(__WEBPACK_AMD_DEFINE_ARRAY__ = [require(6)], __WEBPACK_AMD_DEFINE_RESULT__ = (e.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__)):e("object"==typeof exports?require("jquery"):jQuery)}(function(e){function n(e){return u.raw?e:encodeURIComponent(e)}function o(e){return u.raw?e:decodeURIComponent(e)}function i(e){return n(u.json?JSON.stringify(e):String(e))}function r(e){0===e.indexOf('"')&&(e=e.slice(1,-1).replace(/\\"/g,'"').replace(/\\\\/g,"\\"));try{return e=decodeURIComponent(e.replace(c," ")),u.json?JSON.parse(e):e}catch(n){}}function t(n,o){var i=u.raw?n:r(n);return e.isFunction(o)?o(i):i}var c=/\+/g,u=e.cookie=function(r,c,f){if(void 0!==c&&!e.isFunction(c)){if(f=e.extend({},u.defaults,f),"number"==typeof f.expires){var a=f.expires,d=f.expires=new Date;d.setTime(+d+864e5*a)}return document.cookie=[n(r),"=",i(c),f.expires?"; expires="+f.expires.toUTCString():"",f.path?"; path="+f.path:"",f.domain?"; domain="+f.domain:"",f.secure?"; secure":""].join("")}for(var p=r?void 0:{},s=document.cookie?document.cookie.split("; "):[],m=0,x=s.length;x>m;m++){var v=s[m].split("="),k=o(v.shift()),l=v.join("=");if(r&&r===k){p=t(l,c);break}r||void 0===(l=t(l))||(p[k]=l)}return p};u.defaults={},e.removeCookie=function(n,o){return void 0===e.cookie(n)?!1:(e.cookie(n,"",e.extend({},o,{expires:-1})),!e.cookie(n))}});

/***/ },
/* 8 */,
/* 9 */
/***/ function(module, exports, require) {

	/* WEBPACK VAR INJECTION */(function(require, jQuery) {!function(a,b,c,d){var e=a(b);a.fn.lazyload=function(f){function j(){var b=0;g.each(function(){var c=a(this);if(!i.skip_invisible||c.is(":visible"))if(a.abovethetop(this,i)||a.leftofbegin(this,i));else if(a.belowthefold(this,i)||a.rightoffold(this,i)){if(++b>i.failure_limit)return!1}else c.trigger("appear"),b=0})}var h,g=this,i={threshold:0,failure_limit:0,event:"scroll",effect:"show",container:b,data_attribute:"original",skip_invisible:!0,appear:null,load:null,placeholder:"data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxMTEgNzkuMTU4MzI1LCAyMDE1LzA5LzEwLTAxOjEwOjIwICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo0QjNENTFGOUIwNkExMUU1OUY1RkZBRDRDNjM2NTdFMSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo0QjNENTFGQUIwNkExMUU1OUY1RkZBRDRDNjM2NTdFMSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjRCM0Q1MUY3QjA2QTExRTU5RjVGRkFENEM2MzY1N0UxIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjRCM0Q1MUY4QjA2QTExRTU5RjVGRkFENEM2MzY1N0UxIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+Af/+/fz7+vn49/b19PPy8fDv7u3s6+rp6Ofm5eTj4uHg397d3Nva2djX1tXU09LR0M/OzczLysnIx8bFxMPCwcC/vr28u7q5uLe2tbSzsrGwr66trKuqqainpqWko6KhoJ+enZybmpmYl5aVlJOSkZCPjo2Mi4qJiIeGhYSDgoGAf359fHt6eXh3dnV0c3JxcG9ubWxramloZ2ZlZGNiYWBfXl1cW1pZWFdWVVRTUlFQT05NTEtKSUhHRkVEQ0JBQD8+PTw7Ojk4NzY1NDMyMTAvLi0sKyopKCcmJSQjIiEgHx4dHBsaGRgXFhUUExIREA8ODQwLCgkIBwYFBAMCAQAAIfkEAQAAAAAsAAAAAAEAAQAAAgJEAQA7"};return f&&(d!==f.failurelimit&&(f.failure_limit=f.failurelimit,delete f.failurelimit),d!==f.effectspeed&&(f.effect_speed=f.effectspeed,delete f.effectspeed),a.extend(i,f)),h=i.container===d||i.container===b?e:a(i.container),0===i.event.indexOf("scroll")&&h.bind(i.event,function(){return j()}),this.each(function(){var c=this,e=a(c);c.loaded=!1,(e.attr("src")===d||e.attr("src")===!1)&&e.is("img")&&e.attr("src",i.placeholder),e.one("appear",function(){if(!this.loaded){if(i.appear){var d=g.length;i.appear.call(c,d,i)}a("<img />").bind("load",function(){var d=e.attr("data-"+i.data_attribute),f=b.devicePixelRatio;2==f&&(d=d.replace("_190x190.jpg","_460x460.jpg").replace("_230x230.jpg","_460x460.jpg").replace("|220w_330h","|440w_660h")),e.hide(),e.is("img")?e.attr("src",d):e.css("background-image","url('"+d+"')"),e[i.effect](i.effect_speed),c.loaded=!0;var h=a.grep(g,function(a){return!a.loaded});if(g=a(h),e.removeAttr("data-"+i.data_attribute).removeClass("lazy"),i.load){var j=g.length;i.load.call(c,j,i)}}).attr("src",e.attr("data-"+i.data_attribute))}}),0!==i.event.indexOf("scroll")&&e.bind(i.event,function(){c.loaded||e.trigger("appear")})}),e.bind("resize",function(){j()}),/(?:iphone|ipod|ipad).*os 5/gi.test(navigator.appVersion)&&e.bind("pageshow",function(b){b.originalEvent&&b.originalEvent.persisted&&g.each(function(){a(this).trigger("appear")})}),a(c).ready(function(){j()}),this},a.belowthefold=function(c,f){var g;return g=f.container===d||f.container===b?(b.innerHeight?b.innerHeight:e.height())+e.scrollTop():a(f.container).offset().top+a(f.container).height(),g<=a(c).offset().top-f.threshold},a.rightoffold=function(c,f){var g;return g=f.container===d||f.container===b?e.width()+e.scrollLeft():a(f.container).offset().left+a(f.container).width(),g<=a(c).offset().left-f.threshold},a.abovethetop=function(c,f){var g;return g=f.container===d||f.container===b?e.scrollTop():a(f.container).offset().top,g>=a(c).offset().top+f.threshold+a(c).height()},a.leftofbegin=function(c,f){var g;return g=f.container===d||f.container===b?e.scrollLeft():a(f.container).offset().left,g>=a(c).offset().left+f.threshold+a(c).width()},a.inviewport=function(b,c){return!(a.rightoffold(b,c)||a.leftofbegin(b,c)||a.belowthefold(b,c)||a.abovethetop(b,c))},a.extend(a.expr[":"],{"below-the-fold":function(b){return a.belowthefold(b,{threshold:0})},"above-the-top":function(b){return!a.belowthefold(b,{threshold:0})},"right-of-screen":function(b){return a.rightoffold(b,{threshold:0})},"left-of-screen":function(b){return!a.rightoffold(b,{threshold:0})},"in-viewport":function(b){return a.inviewport(b,{threshold:0})},"above-the-fold":function(b){return!a.belowthefold(b,{threshold:0})},"right-of-fold":function(b){return a.rightoffold(b,{threshold:0})},"left-of-fold":function(b){return!a.rightoffold(b,{threshold:0})}})}(jQuery,window,document);
	
	/* WEBPACK VAR INJECTION */}.call(exports, require, require(6)))

/***/ },
/* 10 */
/***/ function(module, exports, require) {

	/* WEBPACK VAR INJECTION */(function(require, jQuery, $) {jQuery.fn.pagination=function(a,b){return b=jQuery.extend({items_per_page:10,num_display_entries:10,current_page:0,num_edge_entries:0,link_to:"#",prev_text:"Prev",next_text:"Next",ellipse_text:"...",prev_show_always:!0,next_show_always:!0,simple:!1,jump:!0,callback:function(){return!1}},b||{}),this.each(function(){function c(){return Math.ceil(a/b.items_per_page)}function d(){var a=Math.ceil(b.num_display_entries/2),d=c(),e=d-b.num_display_entries,f=g>a?Math.max(Math.min(g-a,e),0):0,h=g>a?Math.min(g+a,d):Math.min(b.num_display_entries,d);return[f,h]}function e(a,c){g=a,f();var d=b.callback(a,h);return d||(c.stopPropagation?c.stopPropagation():c.cancelBubble=!0),d}function f(){h.empty();var a=d(),f=c(),i=function(a){return function(b){return e(a,b)}},j=function(a,c){if(a=0>a?0:f>a?a:f-1,c=jQuery.extend({text:a+1,classes:""},c||{}),a==g)var d=jQuery("<span class='current'>"+c.text+"</span>");else var d=jQuery("<a>"+c.text+"</a>").attr("vda","link|flip").bind("click",i(a)).attr("href",b.link_to.replace(/__id__/,a));c.classes&&d.addClass(c.classes),h.append(d)};if(b.prev_text&&(g>0||b.prev_show_always)&&j(g-1,{text:b.prev_text,classes:"prev"}),a[0]>0&&b.num_edge_entries>0){for(var k=Math.min(b.num_edge_entries,a[0]),l=0;k>l;l++)j(l);b.num_edge_entries<a[0]&&b.ellipse_text&&jQuery("<span class='ellipse'>"+b.ellipse_text+"</span>").appendTo(h)}for(var l=a[0];l<a[1];l++)j(l);if(a[1]<f&&b.num_edge_entries>0){f-b.num_edge_entries>a[1]&&b.ellipse_text&&jQuery("<span class='ellipse'>"+b.ellipse_text+"</span>").appendTo(h);for(var m=Math.max(f-b.num_edge_entries,a[1]),l=m;f>l;l++)j(l)}b.simple&&h.append('<span class="vam pageinfo"><span class="text-error currentPage">'+(g+1)+"</span>/"+f+"</span>"),b.next_text&&(f-1>g||b.next_show_always)&&j(g+1,{text:b.next_text,classes:"next"}),b.jump&&!b.simple&&(h.append('<div class="pager-jump"><span class="pager-text">\u5171 '+f+' \u9875 \u8df3\u8f6c\u5230\u7b2c</span><div class="pager-textbox-wrapper"><input value="'+(g+1)+'" class="jump-textbox"></div><span class="pager-text">\u9875</span><button class="jump-button">\u786e\u5b9a</button></div>'),$(".jump-button").bind("click",function(a){a=a||window.event;var b=$(this).parent().find(".jump-textbox").val();""!=b&&(b>f&&(b=f),0>=b&&(b=1),e(b-1,a))}))}var g=b.current_page;a=!a||0>a?1:a,b.items_per_page=!b.items_per_page||b.items_per_page<0?1:b.items_per_page;var h=jQuery(this);this.selectPage=function(a){e(a)},this.prevPage=function(){return g>0?(e(g-1),!0):!1},this.nextPage=function(){return g<c()-1?(e(g+1),!0):!1},f()})};
	
	/* WEBPACK VAR INJECTION */}.call(exports, require, require(6), require(6)))

/***/ },
/* 11 */,
/* 12 */,
/* 13 */,
/* 14 */
/***/ function(module, exports, require) {

	/* WEBPACK VAR INJECTION */(function(require, $) {var api = require(3)
	var tpl = require(!(function webpackMissingModule() { throw new Error("Cannot find module \"html!../../quicklogin.html\""); }()))
	require(15)
	// require(_WEB_Cfg.staticPath + '/css/qlogin3.css')
	
	
	
		var SMSDELAY = 100; //短信重发间隔
		var _VERIFYCODEURL = "/apic/verifyCode/generate";
		var Main = function () {};
	
		var showError = function(text){
			$('.err-info').show();
			$('.err-info span').text(text);
		};
		var hideError = function(){
			$('.err-info').hide();
			$('.err-info span').text('');
		};
		$.extend(Main.prototype, {
			isShow:0,//是否显示验证码,默认0不显示
			goHref:'',
			smsDelay:true,//发送短信验证码
			smsDelayInterval:'',
			smsSendTag:false,//是否发送短信验证码
			autoVal:0,//记录自动登录值
			userNameExist:'',//存储已经存在的用户名
			doNotReload: false,
			init: function(href, doNotReload, cb){
				var self = this;
				if(href){
					self.goHref = href;
				}
				if(doNotReload){
					self.doNotReload = true;
				}
				if($.isFunction(cb)){
					self.cb = cb;
				}
				self.showLoginBox();
			},
			showLoginBox:function(){
				var self = this;
				self.closeLoginBox();
				$(document.body).append(tpl);
				self.setPositionLoginBox();
				$('.qlogin').show();
				cuvvic.sendShow("", $('#submitLogin'));
				self.setAuto();
				self.addEvent();
			},
			setPositionLoginBox:function(){
				var _height = $(window).height(),
					_boxHeight = 280;
				$('.qlogin').css({top:(_height - _boxHeight)/2 + 'px'});
			},
			setAuto:function(){
				var _auto = $.cookie('userLoginAuto');
				if(_auto && _auto == 1){
					$('.v-single-check').addClass('checked');
					$('#auto').val(1);
				}
			},
	
			closeLoginBox:function(){
				this.smsSendTag = false;
				this.isShow = 0;
				$('.w-loginbg,.qlogin').remove();
			},
			addEvent: function(){
				var self = this;
				var _errorIcon = '<i class="vvicon error-icon">&#xe616;</i>';
				var myValidate = $('#j-qlogin-form').validate({
						debug: true,
						onfocusout: false,
						focusInvalid:false,
						focusCleanup:true,
						rules:{
							username: "required",
							password: "required",
							secCode:{
								required:function(){
									return (self.isShow != 0)?true:false;
								}
							},
							//用户是否要发送手机验证码
							smsCode:{
								required:function(){
									$('#smsBox').removeClass('hide');
									return self.smsSendTag;
								}
							}
						},
						messages: {
							username: '请输入登录账户',
							password: '请输入登录密码',
							secCode: '请输入验证码',
							smsCode:'请输入短信验证码'
						},
						errorPlacement: function (error, element) {
						},
	
						showErrors:function(errorMap,errorList){
							var _errorArray = [];
							if(errorList.length <= 0){
								return false;
							}
	
							var errorName = $(errorList[0].element).attr('id'),
								$box = '';
	
							if(errorName == 'secCode'){
								$('#codeBox').removeClass('hide');
								$box = $('#secCode').parent();
							}else if(errorName == 'smsCode'){
								$('#smsBox').removeClass('hide');
								$box = $('.sms-input');
							}else{
								$box = $('#' + errorName).parents('dl');
							}
	
							for(var i in errorMap){
								_errorArray.push(errorMap[i]);
							}
							self.errorTip(_errorArray[0]);
							$box.addClass('error-focus');
						},
						submitHandler: function () {
							$('#names-error').remove();
							self.login();
						}
					});
	
				$('.v-single-check').on('click', function(){
					var $this = $(this);
					if($this.hasClass('checked')){
						$this.removeClass('checked');
						$('#auto').val(0);
					}else{
						$this.addClass('checked');
						$('#auto').val(1);
					}
				});
	
				$('.code-btn').on('click', function(){
					self.changeCode();
				});
	
				$("#username").blur(function(){
					var _name = $(this).val(),
						$this = this;
					if($.trim(_name).length > 0){
						self.sendShowCode(_name);
					}
				});
	
				$('input[type="text"],input[type="password"]').focus(function(){
					$('#names-error').remove();
					$('.error-focus').removeClass('error-focus');
					self.activeSendSmsBtn();
					if($(this).attr('name') == 'secCode' || $(this).attr('name') == 'smsCode'){
						$(this).parent('dd').removeClass('error-focus').addClass('focus');
						return;
					}
					$(this).parents('dl').removeClass('error-focus').addClass('focus');
				}).blur(function(){
					self.activeSendSmsBtn();
					if($(this).attr('name') == 'secCode' || $(this).attr('name') == 'smsCode'){
						$(this).parent('dd').removeClass('focus');
						return;
					}
					$(this).parents('dl').removeClass('focus');
				});
	
				$('.sms-btn').on('click',function(){
					if(self.smsSendTag && !$(this).hasClass('btn-disable')){
						self.sendSms();
					}
				});
	
				$('.qlogin-close').on('click',function(){
					self.closeLoginBox();
				});
	
				$(window).resize(function(){
					self.setPositionLoginBox();
				});
			},
	
			//错误提示的封装
			errorTip:function(txt){
				var _inner = '<label id="names-error" class="error" for="names"><i class="vvicon error-icon">&#xe616;</i>' + txt + '</label>';
				$('#names-error').remove();
				$('.error-focus').removeClass('error-focus');
				$('.login-other').prepend(_inner);
			},
			errorWarm:function(index){
				switch (index){
					case 1:
						$('#secCode').parent().addClass('error-focus');
						break;
					case 2:
						$('#password').parents('dl').addClass('error-focus');
						break;
					case 3:
						$('#userPhoneCode').parent().addClass('error-focus');
						break;
					default:
						$('#password').parents('dl').addClass('error-focus');
						break;
				}
			},
			login: function(){
				var self = this,
					_data =  {
						username: $("#username", $('.qlogin')).val(),
						password: $("#password").val(),
						auto: $("#auto").val(),
						user_key: $.cookie('user_key') || ''
					};
				// console.log(_data);
				self.autoVal = _data['auto'];
				///是否显示验证码
				if(self.isShow != 0){
					var addSecCode = $('#secCode').val();
					if(addSecCode != '' || addSecCode.length > 0){
						_data['secCode'] = addSecCode;
					}else{
						self.errorTip('请输入图形验证码');
						$('.code-input').addClass('error-focus');
						return false;
					}
	
				}
				//短信验证码
				if(self.smsSendTag){
					var addSmsCode = $('#userPhoneCode').val();
					if(addSmsCode != '' || addSmsCode.length > 0){
						_data['smsCode'] = addSmsCode;
					}else{
						self.errorTip('请输入短信验证码');
						$('.sms-input').addClass('error-focus');
						return false;
					}
	
				}
	
				api.service.account.login(_data, function(data){
					if(data.code != 200){
						self.isShow = 1;
						self.changeCode();
						self.errorTip(data.message);
						//显示验证码
						$('#codeBox').removeClass('hide').find('input').val('');
						// 防止用户多次登录。
						setTimeout(function(){self.isLogin = false}, 2000);
						self.isShow = 1;
						self.errorWarm(data.error_type);
						//用户手机号未激活的
						if(data.code == 509){
							self.smsSendTag = true;
							$('#smsBox').removeClass('hide');
						}
						return false;
					}
					self.isLogin=true;
					self.smsSendTag = false;
					self.closeLoginBox();
					self.isShow = 0;
	
					self.setCookies(data.data);
	
					if(self.goHref != '' || self.goHref.length > 0){
						/*var _tag = window.open('about:blank');
						_tag.location.href = self.goHref;*/
						/**阻止浏览器拦截**/
						var _a = document.createElement('a');
						_a.setAttribute('href',self.goHref);
						_a.setAttribute('target','_blank');
						_a.setAttribute('id','windonGoHref');
						// 防止反复添加
						if(!document.getElementById('windonGoHref')) {
							document.body.appendChild(_a);
						}
						_a.click();
					}
					if(!self.doNotReload){
						var dateTime = new Date(new Date() - 24 * 60 * 60 * 1000);
						$.cookie('user_key', '', {path: '/', expires: dateTime});
						window.location.reload();
					}else{
						if($.isFunction(self.cb)){
							self.cb();
						}
					}
					$("body").on('keyup',function(e){
						if(e.which==13){
							$("a.layui-layer-btn0").click();
						}
					});
					return;
				});
			},
			changeCode: function(){
				var time = new Date();
				$('#secCodeImg').attr('src', _VERIFYCODEURL + '?' + time.getTime());
			},
			setCookies: function(_user){
				var _expires = 1,
					self = this;
				if(self.autoVal==1){
					_expires = 30;
				}
	
				// 用户类型
				var _ut = _user.type; //用户类型
				$.cookie('ut', _ut , { path: '/', expires: _expires });
				// 用户id
				$.cookie('uid', _user.id , { path: '/' , domain: '.vvic.com', expires: _expires });
				// 用户username
				$.cookie('umc', _user.mobile_confirm, { path: '/' , expires: _expires});
				$.cookie('mobile', _user.mobile, { path: '/' , expires: _expires});
				// 拿货单数量
				$.cookie('pn', _user.pack_amount, { path: '/' , expires: _expires});
				$.cookie('defaultShopId', _user.default_shop_id, { path: '/' , expires: _expires});
				$.cookie('defaultShopName', _user.default_shop_name, { path: '/' , expires: _expires});
				$.cookie('uno', _user.orders_amount, { path: '/' , expires: _expires});
				$.cookie('userLoginAuto',self.autoVal,{ path: '/' , expires: _expires*3});
			},
			//短信验证码
			sendSms: function() {
				var $this = this,
					$btn = $('.sms-btn'),
					_data={
						username: $("#username", $('.qlogin')).val(),
						password: $("#password").val(),
						secCode: $("#secCode").val()
					};
				if($("#secCode").val() == '' || $("#secCode").val().length <= 0){
					$this.errorTip('请输入图形验证码');
					$('.code-input').addClass('error-focus');
					return false;
				}
				api.getData('/apic/getSmsCode','get',_data,function(data){
					var _obj=data,
						status=_obj.code;
					switch(!0){
						case (status==200):{
							$btn.addClass('btn-disable');
							layer.msg('已发送手机短信验证码');
							//loginVm.smsDelay = SMSDELAY
							$btn.text('重新发送(' + SMSDELAY + '秒)');
							$this.smsDelayInterval = setInterval(function() {
								if (SMSDELAY < 2) {
									$this.smsDelay = false;
									$btn.text('获取短信验证码').removeClass('btn-disable');
									clearInterval($this.smsDelayInterval);
									return;
								}
								SMSDELAY--;
								$btn.text('重新发送(' + SMSDELAY + '秒)');
							}, 1000);
							return;
							break;
						}
					}
					layer.msg(_obj.message);
					$this.smsDelay=true;
					$btn.text('获取短信验证码').removeClass('btn-disable');
	
				});
				return false;
			},
			//获取短信验证按钮激活
			activeSendSmsBtn:function(){
				var username = $("#username").val(),
					password = $("#password").val(),
					secCode = $('#secCode').val(),
					sendSms = this.smsSendTag;
				if(sendSms && username && password && secCode){
					$('.sms-btn').removeClass('btn-disabled');
				}else{
					$('.sms-btn').addClass('btn-disabled');
				}
	
			},
			//发送图形验证码
			sendShowCode:function(name){
				var	self = this,
					_data = {username:$('#username').val()},
					_name = name;
				if(self.userNameExist == _name){
					return false;
				}else{
					self.userNameExist = _name;
					self.isShow = 0;
					self.smsSendTag = false;
					$('#smsBox,#codeBox').addClass('hide');
				}
				api.service.user.loginShowCode(_data, function(r){
					$('#codeBox').find('input').val('');
					if(r && r.code == 200){
						var _is_show = r.data.is_show;
						if(_is_show != 0){
							self.isShow = _is_show;
							$('#codeBox').removeClass('hide');
						}else{
							self.isShow = 0;
							$('#codeBox').addClass('hide');
						}
					}
				});
			}
		});
	
		var main = new Main();
		module.exports = main;
	
	/* WEBPACK VAR INJECTION */}.call(exports, require, require(6)))

/***/ },
/* 15 */
/***/ function(module, exports, require) {

	var __WEBPACK_AMD_DEFINE_RESULT__;/* WEBPACK VAR INJECTION */(function(require, jQuery) {!function(a,b){"use strict";var d,e,c=a._WEB_Cfg.jsLibPath+"jquery.layer/",f={getPath:function(){var a=document.scripts,b=a[a.length-1],d=b.src;if(!b.getAttribute("merge"))return c?c:d.substring(0,d.lastIndexOf("/")+1)}(),enter:function(a){13===a.keyCode&&a.preventDefault()},config:{},end:{},btn:["&#x786E;&#x5B9A;","&#x53D6;&#x6D88;"],type:["dialog","page","iframe","loading","tips"]},g={v:"2.1",ie6:!!a.ActiveXObject&&!a.XMLHttpRequest,index:0,path:f.getPath,config:function(a,b){var c=0;return a=a||{},g.cache=f.config=d.extend(f.config,a),g.path=f.config.path||g.path,"string"==typeof a.extend&&(a.extend=[a.extend]),g.use("skin/layer.css",a.extend&&a.extend.length>0?function e(){var d=a.extend;g.use(d[d[c]?c:c-1],c<d.length?function(){return++c,e}():b)}():b),this},use:function(a,b,c){var f=d("head")[0],a=a.replace(/\s/g,""),h=/\.css$/.test(a),i=document.createElement(h?"link":"script"),j="layui_layer_"+a.replace(/\.|\//g,"");return g.path?(h&&(i.rel="stylesheet"),i[h?"href":"src"]=/^http:\/\//.test(a)?a:g.path+a,i.id=j,d("#"+j)[0]||f.appendChild(i),function k(){(h?1989===parseInt(d("#"+j).css("width")):g[c||j])?function(){b&&b();try{h||f.removeChild(i)}catch(a){}}():setTimeout(k,100)}(),this):void 0},ready:function(a,b){var c="function"==typeof a;return c&&(b=a),g.config(d.extend(f.config,function(){return c?{}:{path:a}}()),b),this},alert:function(a,b,c){var e="function"==typeof b;return e&&(c=b),g.open(d.extend({content:a,yes:c},e?{}:b))},confirm:function(a,b,c,e){var h="function"==typeof b;return h&&(e=c,c=b),g.open(d.extend({content:a,btn:f.btn,yes:c,cancel:e},h?{}:b))},msg:function(a,c,e){var h="function"==typeof c,j=f.config.skin,k=(j?j+" "+j+"-msg":"")||"layui-layer-msg",l=i.anim.length-1;return h&&(e=c),g.open(d.extend({content:a,time:3e3,shade:!1,skin:k,title:!1,closeBtn:!1,btn:!1,end:e},h&&!f.config.skin?{skin:k+" layui-layer-hui",shift:l}:function(){return c=c||{},(-1===c.icon||c.icon===b&&!f.config.skin)&&(c.skin=k+" "+(c.skin||"layui-layer-hui")),c}()))},load:function(a,b){return g.open(d.extend({type:3,icon:a||0,shade:.01},b))},tips:function(a,b,c){return g.open(d.extend({type:4,content:[a,b],closeBtn:!1,time:3e3,maxWidth:210},c))},stock:function(a,b,c){var d=g.tips(a,b,{tips:[2,"#FEFAEC"],skin:"stock-less",time:1e3});b.bind("mouseleave",function(){g.close(d)})},vtips:function(a,b){g.tips(a,b,{tips:[3,"#FEFAEC"],skin:"vtips",time:1e5});b.bind("mouseleave",function(){})}},h=function(a){var b=this;b.index=++g.index,b.config=d.extend({},b.config,f.config,a),b.creat()};h.pt=h.prototype;var i=["layui-layer",".layui-layer-title",".layui-layer-main",".layui-layer-dialog","layui-layer-iframe","layui-layer-content","layui-layer-btn","layui-layer-close"];i.anim=["layui-anim","layui-anim-01","layui-anim-02","layui-anim-03","layui-anim-04","layui-anim-05","layui-anim-06"],h.pt.config={type:0,shade:.3,fix:!0,move:i[1],title:"&#x4FE1;&#x606F;",offset:"auto",area:"auto",closeBtn:1,time:0,zIndex:19891014,maxWidth:360,shift:0,icon:-1,scrollbar:!0,tips:2},h.pt.vessel=function(a,b){var c=this,d=c.index,e=c.config,g=e.zIndex+d,h="object"==typeof e.title,j=e.maxmin&&(1===e.type||2===e.type),k=e.title?'<div class="layui-layer-title" style="'+(h?e.title[1]:"")+'">'+(h?e.title[0]:e.title)+"</div>":"";return e.zIndex=g,b([e.shade?'<div class="layui-layer-shade" id="layui-layer-shade'+d+'" times="'+d+'" style="'+("z-index:"+(g-1)+"; background-color:"+(e.shade[1]||"#000")+"; opacity:"+(e.shade[0]||e.shade)+"; filter:alpha(opacity="+(100*e.shade[0]||100*e.shade)+");")+'"></div>':"",'<div class="'+i[0]+" "+(i.anim[e.shift]||"")+(" layui-layer-"+f.type[e.type])+(0!=e.type&&2!=e.type||e.shade?"":" layui-layer-border")+" "+(e.skin||"")+'" id="'+i[0]+d+'" type="'+f.type[e.type]+'" times="'+d+'" showtime="'+e.time+'" conType="'+(a?"object":"string")+'" style="z-index: '+g+"; width:"+e.area[0]+";height:"+e.area[1]+(e.fix?"":";position:absolute;")+'">'+(a&&2!=e.type?"":k)+'<div class="layui-layer-content'+(0==e.type&&-1!==e.icon?" layui-layer-padding":"")+(3==e.type?" layui-layer-loading"+e.icon:"")+'">'+(0==e.type&&-1!==e.icon?'<i class="layui-layer-ico layui-layer-ico'+e.icon+'"></i>':"")+(1==e.type&&a?"":e.content||"")+'</div><span class="layui-layer-setwin">'+function(){var a=j?'<a class="layui-layer-min" href="javascript:;"><cite></cite></a><a class="layui-layer-ico layui-layer-max" href="javascript:;"></a>':"";return e.closeBtn&&(a+='<a class="layui-layer-ico '+i[7]+" "+i[7]+(e.title?e.closeBtn:4==e.type?"1":"2")+'" href="javascript:;"></a>'),a}()+"</span>"+(e.btn?function(){var a="";"string"==typeof e.btn&&(e.btn=[e.btn]);for(var b=0,c=e.btn.length;c>b;b++){var d=e.target?e.target[b]:"";a+="_blank"==d?'<a class="'+i[6]+b+'" target="_blank" class="link" href="'+e.src[b]+'">'+e.btn[b]+"</a>":'<a class="'+i[6]+b+'">'+e.btn[b]+"</a>"}return'<div class="'+i[6]+'">'+a+"</div>"}():"")+"</div>"],k),c},h.pt.creat=function(){var a=this,b=a.config,c=a.index,j=b.content,k="object"==typeof j;switch("string"==typeof b.area&&(b.area="auto"===b.area?["",""]:[b.area,""]),b.type){case 0:b.btn="btn"in b?b.btn:f.btn[0],g.closeAll("dialog");break;case 2:var j=b.content=k?b.content:[b.content||"http://layer.layui.com","auto"];b.content='<iframe scrolling="'+(b.content[1]||"auto")+'" allowtransparency="true" id="'+i[4]+c+'" name="'+i[4]+c+'" onload="this.className=\'\';" class="layui-layer-load" frameborder="0" src="'+b.content[0]+'"></iframe>';break;case 3:b.title=!1,b.closeBtn=!1,-1===b.icon&&0===b.icon,g.closeAll("loading");break;case 4:k||(b.content=[b.content,"body"]),b.follow=b.content[1],b.content=b.content[0]+'<i class="layui-layer-TipsG"></i><i class="layui-layer-TipsS"></i>',b.title=!1,b.shade=!1,b.fix=!1,b.tips="object"==typeof b.tips?b.tips:[b.tips,!0],b.tipsMore||g.closeAll("tips")}a.vessel(k,function(e,f){d("body").append(e[0]),k?function(){2==b.type||4==b.type?function(){d("body").append(e[1])}():function(){j.parents("."+i[0])[0]||(j.show().addClass("layui-layer-wrap").wrap(e[1]),d("#"+i[0]+c).find("."+i[5]).before(f))}()}():d("body").append(e[1]),a.layero=d("#"+i[0]+c),b.scrollbar||i.html.css("overflow","hidden").attr("layer-full",c)}).auto(c),2==b.type&&g.ie6&&a.layero.find("iframe").attr("src",j[0]),d(document).off("keydown",f.enter).on("keydown",f.enter),a.layero.on("keydown",function(a){d(document).off("keydown",f.enter)}),4==b.type?a.tips():a.offset(),b.fix&&e.on("resize",function(){a.offset(),(/^\d+%$/.test(b.area[0])||/^\d+%$/.test(b.area[1]))&&a.auto(c),4==b.type&&a.tips()}),b.time<=0||setTimeout(function(){g.close(a.index)},b.time),a.move().callback()},h.pt.auto=function(a){function k(a){a=f.find(a),a.height(g[1]-h-j-2*(0|parseFloat(a.css("padding"))))}var b=this,c=b.config,f=d("#"+i[0]+a);""===c.area[0]&&c.maxWidth>0&&(/MSIE 7/.test(navigator.userAgent)&&c.btn&&f.width(f.innerWidth()),f.outerWidth()>c.maxWidth&&f.width(c.maxWidth));var g=[f.innerWidth(),f.innerHeight()],h=f.find(i[1]).outerHeight()||0,j=f.find("."+i[6]).outerHeight()||0;switch(c.type){case 2:k("iframe");break;default:""===c.area[1]?c.fix&&g[1]>=e.height()&&(g[1]=e.height(),k("."+i[5])):k("."+i[5])}return b},h.pt.offset=function(){var a=this,b=a.config,c=a.layero,d=[c.outerWidth(),c.outerHeight()],f="object"==typeof b.offset;a.offsetTop=(e.height()-d[1])/2,a.offsetLeft=(e.width()-d[0])/2,f?(a.offsetTop=b.offset[0],a.offsetLeft=b.offset[1]||a.offsetLeft):"auto"!==b.offset&&(a.offsetTop=b.offset,"rb"===b.offset&&(a.offsetTop=e.height()-d[1],a.offsetLeft=e.width()-d[0])),b.fix||(a.offsetTop=/%$/.test(a.offsetTop)?e.height()*parseFloat(a.offsetTop)/100:parseFloat(a.offsetTop),a.offsetLeft=/%$/.test(a.offsetLeft)?e.width()*parseFloat(a.offsetLeft)/100:parseFloat(a.offsetLeft),a.offsetTop+=e.scrollTop(),a.offsetLeft+=e.scrollLeft()),c.css({top:a.offsetTop,left:a.offsetLeft})},h.pt.tips=function(){var a=this,b=a.config,c=a.layero,f=[c.outerWidth(),c.outerHeight()],g=d(b.follow);g[0]||(g=d("body"));var h={width:g.outerWidth(),height:g.outerHeight(),top:g.offset().top,left:g.offset().left},j=c.find(".layui-layer-TipsG"),k=b.tips[0];b.tips[1]||j.remove(),h.autoLeft=function(){h.left+f[0]-e.width()>0?(h.tipLeft=h.left+h.width-f[0],j.css({right:12,left:"auto"})):h.tipLeft=h.left},h.where=[function(){h.autoLeft(),h.tipTop=h.top-f[1]-10,j.removeClass("layui-layer-TipsB").addClass("layui-layer-TipsT").css("border-right-color",b.tips[1])},function(){h.tipLeft=h.left+h.width+10,h.tipTop=h.top,j.removeClass("layui-layer-TipsL").addClass("layui-layer-TipsR").css("border-bottom-color",b.tips[1])},function(){h.autoLeft(),h.tipTop=h.top+h.height+10,j.removeClass("layui-layer-TipsT").addClass("layui-layer-TipsB").css("border-right-color",b.tips[1])},function(){h.tipLeft=h.left-f[0]-10,h.tipTop=h.top,j.removeClass("layui-layer-TipsR").addClass("layui-layer-TipsL").css("border-bottom-color",b.tips[1])}],h.where[k-1](),1===k?h.top-(e.scrollTop()+f[1]+16)<0&&h.where[2]():2===k?e.width()-(h.left+h.width+f[0]+16)>0||h.where[3]():3===k?h.top-e.scrollTop()+h.height+f[1]+16-e.height()>0&&h.where[0]():4===k&&f[0]+16-h.left>0&&h.where[1](),c.find("."+i[5]).css({"background-color":b.tips[1],"padding-right":b.closeBtn?"30px":""}),c.css({left:h.tipLeft,top:h.tipTop})},h.pt.move=function(){var a=this,b=a.config,c={setY:0,moveLayer:function(){var a=c.layero,b=parseInt(a.css("margin-left")),d=parseInt(c.move.css("left"));0===b||(d-=b),"fixed"!==a.css("position")&&(d-=a.parent().offset().left,c.setY=0),a.css({left:d,top:parseInt(c.move.css("top"))-c.setY})}},f=a.layero.find(b.move);return b.move&&f.attr("move","ok"),f.css({cursor:b.move?"move":"auto"}),d(b.move).on("mousedown",function(a){if(a.preventDefault(),"ok"===d(this).attr("move")){c.ismove=!0,c.layero=d(this).parents("."+i[0]);var f=c.layero.offset().left,g=c.layero.offset().top,h=c.layero.outerWidth()-6,j=c.layero.outerHeight()-6;d("#layui-layer-moves")[0]||d("body").append('<div id="layui-layer-moves" class="layui-layer-moves" style="left:'+f+"px; top:"+g+"px; width:"+h+"px; height:"+j+'px; z-index:2147483584"></div>'),c.move=d("#layui-layer-moves"),b.moveType&&c.move.css({visibility:"hidden"}),c.moveX=a.pageX-c.move.position().left,c.moveY=a.pageY-c.move.position().top,"fixed"!==c.layero.css("position")||(c.setY=e.scrollTop())}}),d(document).mousemove(function(a){if(c.ismove){var d=a.pageX-c.moveX,f=a.pageY-c.moveY;if(a.preventDefault(),!b.moveOut){c.setY=e.scrollTop();var g=e.width()-c.move.outerWidth(),h=c.setY;0>d&&(d=0),d>g&&(d=g),h>f&&(f=h),f>e.height()-c.move.outerHeight()+c.setY&&(f=e.height()-c.move.outerHeight()+c.setY)}c.move.css({left:d,top:f}),b.moveType&&c.moveLayer(),d=f=g=h=null}}).mouseup(function(){try{c.ismove&&(c.moveLayer(),c.move.remove(),b.moveEnd&&b.moveEnd()),c.ismove=!1}catch(a){c.ismove=!1}}),a},h.pt.callback=function(){function e(){var b=c.cancel&&c.cancel(a.index);b===!1||g.close(a.index)}var a=this,b=a.layero,c=a.config;a.openLayer(),c.success&&(2==c.type?b.find("iframe").on("load",function(){c.success(b,a.index)}):c.success(b,a.index)),g.ie6&&a.IE6(b),b.find("."+i[6]).children("a:not(.link)").on("click",function(){var f=d(this).index();c["btn"+(f+1)]&&c["btn"+(f+1)](a.index,b),0===f?c.yes?c.yes(a.index,b):g.close(a.index):1===f?e():c["btn"+(f+1)]||g.close(a.index)}),b.find("."+i[7]).on("click",e),c.shadeClose&&d("#layui-layer-shade"+a.index).on("click",function(){g.close(a.index)}),b.find(".layui-layer-min").on("click",function(){g.min(a.index,c),c.min&&c.min(b)}),b.find(".layui-layer-max").on("click",function(){d(this).hasClass("layui-layer-maxmin")?(g.restore(a.index),c.restore&&c.restore(b)):(g.full(a.index,c),c.full&&c.full(b))}),c.end&&(f.end[a.index]=c.end)},f.reselect=function(){d.each(d("select"),function(a,b){var c=d(this);c.parents("."+i[0])[0]||1==c.attr("layer")&&d("."+i[0]).length<1&&c.removeAttr("layer").show(),c=null})},h.pt.IE6=function(a){function f(){a.css({top:c+(b.config.fix?e.scrollTop():0)})}var b=this,c=a.offset().top;f(),e.scroll(f),d("select").each(function(a,b){var c=d(this);c.parents("."+i[0])[0]||"none"===c.css("display")||c.attr({layer:"1"}).hide(),c=null})},h.pt.openLayer=function(){var a=this;g.zIndex=a.config.zIndex,g.setTop=function(a){var b=function(){g.zIndex++,a.css("z-index",g.zIndex+1)};return g.zIndex=parseInt(a[0].style.zIndex),a.on("mousedown",b),g.zIndex}},f.record=function(a){var b=[a.outerWidth(),a.outerHeight(),a.position().top,a.position().left+parseFloat(a.css("margin-left"))];a.find(".layui-layer-max").addClass("layui-layer-maxmin"),a.attr({area:b})},f.rescollbar=function(a){i.html.attr("layer-full")==a&&(i.html[0].style.removeProperty?i.html[0].style.removeProperty("overflow"):i.html[0].style.removeAttribute("overflow"),i.html.removeAttr("layer-full"))},a.layer=g,g.getChildFrame=function(a,b){return b=b||d("."+i[4]).attr("times"),d("#"+i[0]+b).find("iframe").contents().find(a)},g.getFrameIndex=function(a){return d("#"+a).parents("."+i[4]).attr("times")},g.iframeAuto=function(a){if(a){var b=g.getChildFrame("html",a).outerHeight(),c=d("#"+i[0]+a),e=c.find(i[1]).outerHeight()||0,f=c.find("."+i[6]).outerHeight()||0;c.css({height:b+e+f}),c.find("iframe").css({height:b})}},g.iframeSrc=function(a,b){d("#"+i[0]+a).find("iframe").attr("src",b)},g.style=function(a,b){var c=d("#"+i[0]+a),e=c.attr("type"),g=c.find(i[1]).outerHeight()||0,h=c.find("."+i[6]).outerHeight()||0;(e===f.type[1]||e===f.type[2])&&(c.css(b),e===f.type[2]&&c.find("iframe").css({height:parseFloat(b.height)-g-h}))},g.min=function(a,b){var c=d("#"+i[0]+a),e=c.find(i[1]).outerHeight()||0;f.record(c),g.style(a,{width:180,height:e,overflow:"hidden"}),c.find(".layui-layer-min").hide(),"page"===c.attr("type")&&c.find(i[4]).hide(),f.rescollbar(a)},g.restore=function(a){var b=d("#"+i[0]+a),c=b.attr("area").split(",");b.attr("type");g.style(a,{width:parseFloat(c[0]),height:parseFloat(c[1]),top:parseFloat(c[2]),left:parseFloat(c[3]),overflow:"visible"}),b.find(".layui-layer-max").removeClass("layui-layer-maxmin"),b.find(".layui-layer-min").show(),"page"===b.attr("type")&&b.find(i[4]).show(),f.rescollbar(a)},g.full=function(a){var c,b=d("#"+i[0]+a);f.record(b),i.html.attr("layer-full")||i.html.css("overflow","hidden").attr("layer-full",a),clearTimeout(c),c=setTimeout(function(){var c="fixed"===b.css("position");g.style(a,{top:c?0:e.scrollTop(),left:c?0:e.scrollLeft(),width:e.width(),height:e.height()}),b.find(".layui-layer-min").hide()},100)},g.title=function(a,b){var c=d("#"+i[0]+(b||g.index)).find(i[1]);c.html(a)},g.close=function(a){var b=d("#"+i[0]+a),c=b.attr("type");if(b[0]){if(c===f.type[1]&&"object"===b.attr("conType")){b.children(":not(."+i[5]+")").remove();for(var e=0;2>e;e++)b.find(".layui-layer-wrap").unwrap().hide()}else{if(c===f.type[2])try{var h=d("#"+i[4]+a)[0];h.contentWindow.document.write(""),h.contentWindow.close(),b.find("."+i[5])[0].removeChild(h)}catch(j){}b[0].innerHTML="",b.remove()}d("#layui-layer-moves, #layui-layer-shade"+a).remove(),g.ie6&&f.reselect(),f.rescollbar(a),d(document).off("keydown",f.enter),"function"==typeof f.end[a]&&f.end[a](),delete f.end[a]}},g.closeAll=function(a){d.each(d("."+i[0]),function(){var b=d(this),c=a?b.attr("type")===a:1;c&&g.close(b.attr("times")),c=null})},f.run=function(){d=jQuery,e=d(a),i.html=d("html"),g.open=function(a){var b=new h(a);return b.index}},true?!(__WEBPACK_AMD_DEFINE_RESULT__ = (function(){return f.run(),g.use("skin/layer.css"),g}.call(exports, require, exports, module)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__)):function(){f.run(),g.use("skin/layer.css")}()}(window);
	
	/* WEBPACK VAR INJECTION */}.call(exports, require, require(6)))

/***/ },
/* 16 */
/***/ function(module, exports, require) {

	/* WEBPACK VAR INJECTION */(function(require, __webpack_amd_options__) {module.exports = __webpack_amd_options__;
	
	/* WEBPACK VAR INJECTION */}.call(exports, require, {}))

/***/ }
/******/ ])
/*
//@ sourceMappingURL=common.js.map
*/