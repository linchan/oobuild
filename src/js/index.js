var $ = require('jquery');
// var header = require('common/header');
// var web = require('common/web');
// var api = require('common/api');
var slide = require('slide');
var cookie = require('cookie');
var lazyload = require('lazyload');
var pagination = require('pagination');
var common = require('common/web');
var _ = require('underscore');

_.templateSettings = {
    evaluate: /\{\{(.+?)\}\}/g,
    interpolate: /\{\{=(.+?)\}\}/g,
    escape: /\{\{-(.+?)\}\}/g
}

var SHOPLIST = [],ITEMLIST=[]
var maps = {
    // 今日热卖 110001
    110001: {
        selector: '.index_hot_sale .page-box',
        content: '.index_hot_sale',
        item: '.index_hot_sale_list .item',
        pageSize: 3,
        timer: null,
        direction: 1,
        render: function(currentPage) {
            var self = this,
                $content = $(self.content)
            var userAgent = window.navigator.userAgent.toLowerCase(),
                msie8 = $.browser.msie && /msie 8\.0/i.test(userAgent);
            if(msie8){
                $content.find('.data-split.showed').removeClass('showed').hide()
                $content.find('.data-split').eq(currentPage).addClass('showed').show()
            }else{
                $content.find('.data-split.showed').removeClass('showed').fadeOut(500)
                $content.find('.data-split').eq(currentPage).addClass('showed').fadeIn(500)
            }
            $content.find('.data-split').eq(currentPage).find('.ishide').removeClass('ishide')
            cuvvic.sendShow($content);
        }
    },
    // 实力档口 110002
    110002: {
        effect: 'page',
        selector: '.hot_shops .page-box',
        content: '.hot_shops', //tab
        pageSize: 5,
        timeout: 5000,
        timer: null,
        direction: 1,
        list: '.hot_shops_list', //每个tab content
        item: '.hot_shops_tabs .item_box', //取id，shop_id
        render: function (currentPage) {
            var self = this,
                $content = $(self.content)
            $content.find('.data-split.showed').removeClass('showed').fadeOut(500)
            var $currContent = $content.find('.data-split').eq(currentPage)
            $currContent.addClass('showed').fadeIn(500)
            $currContent.find('.item_box a.item').removeClass('selected').eq(0).addClass('selected')
            $currContent.find('.hot_shops_list').hide().eq(0).show()

            // 判断滚动是否在可视范围内
            var inWindows = checkPosition($content)
            if(inWindows){
                $currContent.find('.ishide').removeClass('ishide')
                cuvvic.sendShow($content)
            }
        }
    },
    // 热门商品 110003
    110003: {
        selector: '.hot_goods .page-box',
        content: '.hot_goods',
        item: '.hot_goods_list .item',
        pageSize: 10,
        timeout: 6000,
        timer: null,
        direction: 1,
        render: function(currentPage) {
            var self = this,
                $content = $(self.content)
            $content.find('.data-split.showed').removeClass('showed').fadeOut(500)
            $content.find('.data-split').eq(currentPage).addClass('showed').fadeIn(500)

            // 判断滚动是否在可视范围内
            var inWindows = checkPosition($content)
            //console.log(inWindows);
            if(inWindows){
                $content.find('.data-split.showed').find('.ishide').removeClass('ishide')
                cuvvic.sendShow($content)
            }
        }
    },
    // 精选店铺 110004
    110004: {
        selector: '.index_shops .page-box',
        content: '.index_shops_list',
        item: '.index_shops_list .item',
        pageSize: 12,
        timeout: 6000,
        timer: null,
        direction: 1,
        ul: '.index_shops_list .item .bd', //图片列表容器 img_box
        tpl: '<div  class="item" id="${id}" shop-id="${shop_id}"> <div class="img_box">' +
        '' +
        '<ul class="bd"> </ul>' +
        '' +
        '</div> </div>',
        tpl_li: ' <a href="${href_url}" class=" noslide j-vda li" target="_blank" vda="tp|jxdpcard|0|${shop_id}|0|${count}"> <img src="${img_url}" alt=""> </a>',
        render: function (currentPage) {
            var self = this
            var list = SHOPLIST[currentPage]
            var vda = 'image|jxdpcard|0|${shop_id}|0|${count}'
            $.each(list, function (index, item) {
                var div = $($(self.item)[index])
                div.attr('id', item.id).attr('shop-id', item.shop_id)
                item.count = index + 1
                var vda_value = sub(vda, item)
                $('a', div).attr('href', item.href_url).attr('vda', vda_value)
            })
            var $ul = $(self.ul)
            var ul_html = []
            $.each($ul, function (index, ul) {
                if(index<list.length){
                    var arr = list[index].img_url.split(',')
                    var href_url = list[index].href_url
                    var data = []

                    $.each(arr, function(index, url) {
                        data.push({
                            img_url: url,
                            href_url: href_url
                        })
                    })

                    ul_html.push(render(self.tpl_li, data))
                }
            })
            var r = 0, n = 0
            $(self.item).each(function (e, n) {
                var s = Math.floor(e % 6);
                var o = Math.floor(e / 6);
                var l = ul_html[e];
                r = s + o;
                setTimeout(function () {
                    $(".img_box", n).animate({
                       width: 0
                    }, 150, "linear", function () {
                        $('.bd', n).html(l)
                        $(".img_box", n).css({
                           width: 0
                        }).animate({
                            width: 190
                        }, 100, "linear")
                    })
                }, 30 + r * 100)
            })
            cuvvic.sendShow(self.content);
        }
    }
}

var sub = (function () {

    return function (str, data) {
        return str.replace(/\${(.*?)}/igm, function ($, $1) {
            if (typeof data[$1] == 'undefined') {
                return ''
            }
            return data[$1]
        });
    }

})();

var render = function (tpl, list) {
    var _html = ''
    $.each(list, function (index, item) {

        if (index == 0) {
            item.classname = 'selected'
        }
        item.index = index
        item.count = index + 1

        _html = _html + sub(tpl, item)
    })
    return _html
}

var checkPosition = function(selector) {
    var _offsetTop = parseInt($(selector).offset().top),
        _scrollTop = parseInt($(window).scrollTop());
    return _offsetTop >= _scrollTop && _offsetTop < WINDOWHEIGHT + _scrollTop
}

var Main = (function () {

    function Main() {
        this.init()

        common.fixLazyload()
    }

    Main.prototype = {
        init: function () {
            var that = this;
            that.bindSlide()

            // that.catsSlide()
            that.initTabs()
            that.img_box_slide()
            that.initData() // 精选店铺, 热门商品数据初始化
            that.initPage() //分页初始化
            that.more_markets() //更多市场
            that.renderHelp()
            that.renderUserInfo() //登陆框用户信息
            setTimeout(function () {
                that.getNotice();
            }, 2000);

            that.renderShopData() //用户信息

            that.addEvent()
            //fixme
            that.service.login()
        },
        addEvent: function(){
            var self = this

            $.each(maps, function(position, item){
                if(item.timeout){
                    $(item.content).hover(function(){
                        clearInterval(item.timer)
                        item.timer=null
                    },function(){
                        self.selectorSlide(item)
                    })
                }
            })

            // 屏幕滚动 检测各广告区域是否在可视范围。是则启动制动轮播，否则清除自动参数
            $(window).scroll(function(event) {
                self.scrollEvent()
            });
        },
        scrollEvent: function(){
            var self = this
            $.each(maps, function(position, item){
                if(item.timeout){
                    if(self.checkPositionToSlide(item)){
                        self.selectorSlide(item)
                    }else{
                        clearInterval(item.timer);
                        item.timer=null
                    }
                }
            })
        },
        checkPositionToSlide: function(item){
            var _offsetTop = parseInt($(item.content).offset().top),
                _scrollTop = parseInt($(window).scrollTop());
            return _offsetTop >= _scrollTop && _offsetTop < WINDOWHEIGHT + _scrollTop
        },
        initData: function(){
            // 获取json数据
            var shopPageSize = maps[110004].pageSize,
                shopPageCount = Math.ceil(SHOPVIPS.length / shopPageSize),
                itemPageSize = maps[110003].pageSize,
                itemPageCount = Math.ceil(HOTITEMS.length / itemPageSize)

            for(var i=0;i<shopPageCount;i++){
                var start = i ? i*shopPageSize : 0,
                    end = i*shopPageSize+shopPageSize
                end = end > SHOPVIPS.length ? SHOPVIPS.length : end
                SHOPLIST[i] = SHOPVIPS.slice(start, end)
            }
            // console.log(SHOPVIPS.length,shopPageCount,SHOPLIST);
            for(var i=0;i<itemPageCount;i++){
                var start = i ? i*itemPageSize : 0,
                    end = i*itemPageSize+itemPageSize
                end = end > HOTITEMS.length ? HOTITEMS.length : end
                // console.log(start, end);
                ITEMLIST[i] = HOTITEMS.slice(start, end)
            }
            // console.log(HOTITEMS.length,itemPageSize,ITEMLIST);
        },
        initTabs: function () {
            common.tabs({
                container: '.index_notice',
                top: '.notice_top',
                events: 'hover'
            })

            //实力档口
            common.tabs({
                container: '.hot_shops .data-split',
                top: '.hot_shops_tabs',
                topElem: 'a.tab_item',
                events: 'hover',
                callback: function (href) {
                    $('.hot_shops .page-box').attr('currentPosition', href)
                }
            })
        },
        //轮播
        bindSlide: function () {
            if ($('.index_slider li').size() > 1) {
                $('.index_slider').slide({
                    mainCell: "ul.bd",
                    effect: "leftLoop",
                    interTime: 3000,
                    delayTime: 600,
                    autoPlay: true,
                    vda: true
                })
            }

            if ($('.index_slider_ad li').size() > 1) {
                setTimeout(function () {
                    $('.index_slider_ad').slide({
                        mainCell: "ul.bd",
                        effect: "fold",
                        interTime: 4000,
                        delayTime: 1500,
                        autoPlay: true,
                        vda: true,
                        easing: "swing"
                    })
                }, 1500)
            }

            //新增广告
            if ($('.index_hot_adv_list .index_hot_cell').size() > 0){
                setTimeout(function () {
                    $('.index_shops_ad').slide({
                        mainCell: ".index_hot_adv_list",
                        effect: "fold",
                        interTime: 4000,
                        delayTime: 1500,
                        autoPlay: true,
                        vda: true,
                        easing: "swing"
                    })
                }, 1500)
            }

        },
        /*
         * 热门商品
         * */
        img_box_slide: function () {
            var timer
            $('body').on('mouseenter', '.img_box', function () {

                var $this = $(this)
                var $li = $('.li', $this)
                var len = $li.size()

                var index = 1

                var interTime = 2000,
                    delayTime = 500,
                    easing = 'swing'


                $li.hide()
                $($li[index]).show()

                if ($this.hasClass('noslide')) {
                    return
                }

                timer = setInterval(function () {

                    index++
                    while (index == len) {
                        index = 0
                    }

                    var curr = $($li[index])

                    // curr.animate({opacity: "show"}, delayTime, easing)
                    //     .siblings()
                    //     .animate({opacity: "hide"}, delayTime, easing)
                    curr.animate({opacity: "show"}, 1, easing)
                        .siblings()
                        .animate({opacity: "hide"}, delayTime, easing)

                }, interTime)
            })


            $('body').on('mouseleave', '.img_box', function () {
                clearInterval(timer)
                var $this = $(this)
                var $li = $('.li', $this)
                $li.hide()
                $($li[0]).show()
            })
        },
        /*
         * 分类菜单*/
        catsSlide: function () {
            var nav_drop = $('.nav_drop')
            var $nav_drop_menu = $('.nav_drop_menu', nav_drop)
            var $menu_item = $('.menu_item', nav_drop)
            var $nav_expend = $('.nav_expend', nav_drop)
            var $nav_item = $('.nav_item', nav_drop)
            var $nav_expend_txt = $('.nav_expend_txt', nav_drop)
            var $nav_expend_ad = $('.nav_expend_ad', nav_drop)

            var can_animate = true
            var timer

            $menu_item.hover(function () {
                var _this = $(this)

                $nav_expend.show()
                $nav_item.hide().css('width', 0)

                $($nav_expend_txt, $($nav_item.get(_this.index()))).css('width', 580).show()
                $($nav_expend_ad, $($nav_item.get(_this.index()))).css('width', 220).show()

                $($nav_item.get(_this.index())).show().css('width', 800).addClass('selected')

                $menu_item.removeClass('selected')
                _this.addClass('selected')

                if (can_animate) {
                    can_animate = !can_animate

                    $(".nav_expend_txt", $nav_item.get(_this.index())).css('width', 0).animate({
                        width: 580
                    }, 500);

                    $(".nav_expend_ad", $nav_item.get(_this.index())).css('width', 0)

                    timer = setTimeout(function () {
                        $(".nav_expend_ad", $nav_item.get(_this.index())).animate({
                            width: 220
                        }, 400);
                    }, 350)
                }
                var $a = $nav_item.find('.nav_expend_ad a');
                if ($a.hasClass('ishide')) {
                    cuvvic.sendShow("", $a)
                }
            })

            $nav_drop_menu.mouseleave(function (event) {
                var _this = $(this)

                var to_element = event.toElement || event.relatedTarget //firefox 没有toElement
                var $to_element = $(to_element)

                if (!$to_element.hasClass('inner')) {

                    $nav_expend.hide()
                    $nav_item.hide().css('width', 0).removeClass('selected')
                    $nav_expend_txt.css('width', 0).hide()
                    $nav_expend_ad.css('width', 0).hide()

                    $menu_item.removeClass('selected')

                    can_animate = true

                }
            })

            $nav_expend.mouseleave(function (event) {
                $nav_expend.hide()
                $nav_item.hide().css('width', 0).removeClass('selected')
                $nav_expend_txt.css('width', 0).hide()
                $nav_expend_ad.css('width', 0).hide()

                $menu_item.removeClass('selected')

            })
        },
        initPage: function () {
            var self = this
            $.each(maps, function (position, item) {
                var itemLength = $(item.item).length
                if(position=='110004'){
                    itemLength = SHOPVIPS.length
                }
                if(position=='110003'){
                    itemLength = HOTITEMS.length
                }
                $(item.selector).pagination(itemLength, {
                    current_page: 0,
                    num_edge_entries: 0,
                    items_per_page: item.pageSize,
                    num_display_entries: 0,
                    simple: true,
                    prev_text: '<span class="mp-prev vvicon">&#xe611;</span>',
                    next_text: '<span class="mp-next vvicon">&#xe60f;</span>',
                    callback: function (currentPage) {
                        item.render(currentPage);
                        return false;
                    }
                })
            })
            setTimeout(function(){
                self.scrollEvent();
            }, 1000);
        },
        selectorSlide: function(item) {
            if(item.timer==undefined || item.timer==null){
                item.timer = setInterval(function(){
                    var $next = $(item.selector).find('a.next'),
                        $prev = $(item.selector).find('a.prev')
                    if(item.direction==0){
                        if($prev.length){
                            $prev.click()
                        }else{
                            $next.click()
                            item.direction = 1
                        }
                    }else{
                        if($next.length){
                            $next.click()
                        }else{
                            $prev.click()
                            item.direction = 0
                        }
                    }
                }, item.times || 4000);
            }
        },
        more_markets: function () {
            var $btn = $('.more_items')
            var $list = $('.index_markets')

            /*  $list.bind('mouseenter', function () {
             $list.addClass('selected')
             })*/

            $btn.bind('click', function () {
                $list.toggleClass('selected')
            })
        },
        // 帮助中心链接
        renderHelp: function () {
            $.ajax({
                url: _WEB_Cfg.actUrl + "/data/helplist.jsonp",
                type: "get",
                dataType: "jsonp",
                jsonpCallback: "helplist",
                success: function (data) {
                    if (data.code == "200") {
                        var HTML = ""
                        for (var i = 0; i < data.tags.length; i++) {
                            var tag = data.tags[i]
                            HTML += '<div class="item">'
                            HTML += '<h2 class="title">' + tag.text + '</h2><div class="lists">'
                            for (var j = 0; j < tag.list.length; j++) {
                                var item = tag.list[j]
                                HTML += '<a href="' + item.link + '" vda="link|bottom" target="_blank" title="' + item.text + '">' + item.text + '</a>'
                            }
                            HTML += '</div></div>'
                        }
                        $("#helpList").html(HTML);
                    }
                    // console.log(data);
                }
            })
        },
        renderShopData: function () {

            if (!$.cookie('defaultShopId')) {
                return
            }
            var _data = {
                shopId: $.cookie('defaultShopId') || 0,
                pageSize: 1,
                currentPage: 100000,
                t: 't'
            }
            api.service.renderShopData(_data, function (returnData) {
                if (returnData.code == 200) {
                    var data = returnData.data,
                        pack_amount = data.pack_amount || 0,
                        _totalFavItemNum = data.totalFavItemNum || 0,
                        _totalUploadNum = data.totalUploadNum || 0,
                        _totalFavShopNum = data.totalFavShopNum || 0;
                    $("#shopFav").text(_totalFavItemNum);
                    $("#shopUpNum").text(_totalUploadNum);
                    $("#shopFollow").text(_totalFavShopNum);
                    $("#packAmount").text(pack_amount);
                }
            })
        },
        renderUserInfo: function () {
            api.service.loginUMoreInfo({}, function (dt) {
                if (dt.code == 200) {

                    var login = $('#tpl-index-login')

                    if(login.length > 0){
                        var tpl = _.template(login.html())

                        $('.j-index_login').html( tpl(dt) )
                    }
                }
            })
        },

        getNotice: function () {
            $.ajax({
                url: _WEB_Cfg.actUrl + "/data/notice.jsonp",
                type: "get",
                dataType: "jsonp",
                jsonpCallback: "notice",
                success: function (data) {
                    var _show = data.show,
                        _expires = data.expires || 0,
                        _title = data.title,
                        _remark = data.remark,
                        _times = data.times || 15,
                        _url = data.url,
                        _start = data.start,
                        _end = data.end,
                        _cookieName = data.cookieName || '';
                    _cookieName = '_NOTICE_' + _cookieName;
                    if (_show == "true") {
                        // 判断是否在有效期内
                        if (_start != '' && _end != '') {
                            var sTime = new Date(_start).getTime(),
                                eTime = new Date(_end).getTime(),
                                cTime = new Date().getTime();
                            if (cTime < sTime || cTime > eTime) {
                                return false;
                            }
                        }
                        if (_expires != 0 && $.cookie(_cookieName) == 1) {
                            return false;
                        }
                        layer.open({
                            type: 1,
                            title: false,
                            shade: false,
                            skin: 'layer-skin-notice',
                            area: ['232px', '156px'],
                            offset: 'rb', //右下角弹出
                            time: _times * 1000, //15秒后自动关闭
                            shift: 2,
                            content: '<div class="notice-news"><h2>' + _title + '</h2><div class="desc">' + _remark + '</div><div class="tr"><a href="' + _url + '" target="_blank">点击查看详情</a></div></div>',
                            end: function () {
                                if (_expires != 0)
                                    $.cookie(_cookieName, 1, {expires: parseInt(_expires)});
                            }
                        });
                    }
                }
            })
        },

        service: (function () {
            function ajax_error(res) {
                throw Error('ajax请求报错', res)
            }

            return {
                login: function () {
                    // //for test
                    // return $.ajax({
                    //     url: '/api/login',
                    //     type: 'POST',
                    //     data: {
                    //         username:'18664622513',
                    //         password:'111111',
                    //         secCode:'7509'
                    //     },
                    //     error: ajax_error
                    // })
                },
                next: function (data, cb) {
                    return $.ajax({
                        url: '/next/' + data.positon,
                        type: 'POST',
                        data: data,
                        success: cb,
                        error: ajax_error
                    })
                }
            }
        })()
    }

    return Main
}())

var main = new Main()
