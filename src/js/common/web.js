var api = require('common/api');
var layer = require('layer');
var cookie = require('cookie');
var qlogin = require('common/login');

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
