webpackJsonp([1],[
/* 0 */
/***/ function(module, exports, require) {

	/* WEBPACK VAR INJECTION */(function(require, _, $) {var header = require(1);
	var web = require(2);
	var api = require(3);
	var slide = require(4);
	var cookie = require(5);
	var lazyload = require(6);
	var pagination = require(7);
	var common = require(2);
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
	            //cuvvic.sendShow($content);
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
	                //cuvvic.sendShow($content)
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
	                //cuvvic.sendShow($content)
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
	            //cuvvic.sendShow(self.content);
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
	                    //cuvvic.sendShow("", $a)
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
	
	/* WEBPACK VAR INJECTION */}.call(exports, require, require(8), require(9)))

/***/ },
/* 1 */,
/* 2 */,
/* 3 */,
/* 4 */
/***/ function(module, exports, require) {

	/* WEBPACK VAR INJECTION */(function(require, jQuery) {!function(a){a.fn.slide=function(b){return a.fn.slide.defaults={type:"slide",effect:"fade",autoPlay:!1,delayTime:500,interTime:2500,triggerTime:150,defaultIndex:0,titCell:".hd li",mainCell:".bd",targetCell:null,trigger:"mouseover",scroll:1,vis:1,titOnClassName:"on",autoPage:!1,prevCell:".prev",nextCell:".next",pageStateCell:".pageState",opp:!1,pnLoop:!0,easing:"swing",startFun:null,endFun:null,vda:!1,switchLoad:null,playStateCell:".playState",mouseOverStop:!0,defaultPlay:!0,returnDefault:!1},this.each(function(){var R,c=a.extend({},a.fn.slide.defaults,b),d=a(this),e=c.effect,f=a(c.prevCell,d),g=a(c.nextCell,d),h=a(c.pageStateCell,d),i=a(c.playStateCell,d),j=a(c.titCell,d),k=j.size(),l=a(c.mainCell,d),m=l.children().size(),n=c.switchLoad,o=a(c.targetCell,d),p=parseInt(c.defaultIndex),q=parseInt(c.delayTime),r=parseInt(c.interTime),t=(parseInt(c.triggerTime),parseInt(c.scroll)),u=parseInt(c.vis),v="false"==c.autoPlay||0==c.autoPlay?!1:!0,w="false"==c.opp||0==c.opp?!1:!0,x="false"==c.autoPage||0==c.autoPage?!1:!0,y="false"==c.pnLoop||0==c.pnLoop?!1:!0,z="false"==c.mouseOverStop||0==c.mouseOverStop?!1:!0,A="false"==c.defaultPlay||0==c.defaultPlay?!1:!0,B="false"==c.returnDefault||0==c.returnDefault?!1:!0,C="false"==c.vda||0==c.vda?!1:!0,D=0,E=0,F=0,G=0,H=c.easing,I=null,J=null,K=null,L=c.titOnClassName,M=j.index(d.find("."+L)),N=p=-1==M?p:M,O=p,P=p,Q=m>=u?m%t!=0?m%t:t:0,S="leftMarquee"==e||"topMarquee"==e?!0:!1,T=function(){a.isFunction(c.startFun)&&c.startFun(p,k,d,a(c.titCell,d),l,o,f,g)},U=function(){if(a.isFunction(c.endFun)&&c.endFun(p,k,d,a(c.titCell,d),l,o,f,g),C){var b=l.children().not(".clone").eq(p).find("a.j-vda");b.hasClass("ishide")&&cuvvic.sendShow("",b)}},V=function(){j.removeClass(L),A&&j.eq(O).addClass(L)};if("menu"==c.type)return A&&j.removeClass(L).eq(p).addClass(L),j.hover(function(){R=a(this).find(c.targetCell);var b=j.index(a(this));J=setTimeout(function(){switch(p=b,j.removeClass(L).eq(p).addClass(L),T(),e){case"fade":R.stop(!0,!0).animate({opacity:"show"},q,H,U);break;case"slideDown":R.stop(!0,!0).animate({height:"show"},q,H,U)}},c.triggerTime)},function(){switch(clearTimeout(J),e){case"fade":R.animate({opacity:"hide"},q,H);break;case"slideDown":R.animate({height:"hide"},q,H)}}),void(B&&d.hover(function(){clearTimeout(K)},function(){K=setTimeout(V,q)}));if(0==k&&(k=m),S&&(k=2),x){if(m>=u)if("leftLoop"==e||"topLoop"==e)k=m%t!=0?(m/t^0)+1:m/t;else{var W=m-u;k=1+parseInt(W%t!=0?W/t+1:W/t),0>=k&&(k=1)}else k=1;j.html("");var X="";if(1==c.autoPage||"true"==c.autoPage)for(var Y=0;k>Y;Y++)X+="<li>"+(Y+1)+"</li>";else for(var Y=0;k>Y;Y++)X+=c.autoPage.replace("$",Y+1);j.html(X);var j=j.children()}if(m>=u){l.children().each(function(){a(this).width()>F&&(F=a(this).width(),E=a(this).outerWidth(!0)),a(this).height()>G&&(G=a(this).height(),D=a(this).outerHeight(!0))});var Z=l.children(),$=function(){for(var a=0;u>a;a++)Z.eq(a).clone().addClass("clone").appendTo(l);for(var a=0;Q>a;a++)Z.eq(m-a-1).clone().addClass("clone").prependTo(l)};switch(e){case"fold":l.css({position:"relative",width:E,height:D}).children().css({position:"absolute",width:F,left:0,top:0,display:"none"});break;case"top":l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; height:'+u*D+'px"></div>').css({top:-(p*t)*D,position:"relative",padding:"0",margin:"0"}).children().css({height:G});break;case"left":l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; width:'+u*E+'px"></div>').css({width:m*E,left:-(p*t)*E,position:"relative",overflow:"hidden",padding:"0",margin:"0"}).children().css({"float":"left",width:F});break;case"leftLoop":case"leftMarquee":$(),l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; width:'+u*E+'px"></div>').css({width:(m+u+Q)*E,position:"relative",overflow:"hidden",padding:"0",margin:"0",left:-(Q+p*t)*E}).children().css({"float":"left",width:F});break;case"topLoop":case"topMarquee":$(),l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; height:'+u*D+'px"></div>').css({height:(m+u+Q)*D,position:"relative",padding:"0",margin:"0",top:-(Q+p*t)*D}).children().css({height:G})}}var _=function(a){var b=a*t;return a==k?b=m:-1==a&&m%t!=0&&(b=-m%t),b},aa=function(b){var c=function(c){for(var d=c;u+c>d;d++)b.eq(d).find("img["+n+"]").each(function(){var b=a(this);if(b.attr("src",b.attr(n)).removeAttr(n),l.find(".clone")[0])for(var c=l.children(),d=0;d<c.size();d++)c.eq(d).find("img["+n+"]").each(function(){a(this).attr(n)==b.attr("src")&&a(this).attr("src",a(this).attr(n)).removeAttr(n)})})};switch(e){case"fade":case"fold":case"top":case"left":case"slideDown":c(p*t);break;case"leftLoop":case"topLoop":c(Q+_(P));break;case"leftMarquee":case"topMarquee":var d="leftMarquee"==e?l.css("left").replace("px",""):l.css("top").replace("px",""),f="leftMarquee"==e?E:D,g=Q;if(d%f!=0){var h=Math.abs(d/f^0);g=1==p?Q+h:Q+h-1}c(g)}},ba=function(a){if(!A||N!=p||a||S){if(S?p>=1?p=1:0>=p&&(p=0):(P=p,p>=k?p=0:0>p&&(p=k-1)),T(),null!=n&&aa(l.children()),o[0]&&(R=o.eq(p),null!=n&&aa(o),"slideDown"==e?(o.not(R).stop(!0,!0).slideUp(q),R.slideDown(q,H,function(){l[0]||U()})):(o.not(R).stop(!0,!0).hide(),R.animate({opacity:"show"},q,function(){l[0]||U()}))),m>=u)switch(e){case"fade":l.children().stop(!0,!0).eq(p).animate({opacity:"show"},q,H,function(){U()}).siblings().hide();break;case"fold":l.children().stop(!0,!0).eq(p).animate({opacity:"show"},q,H,function(){U()}).siblings().animate({opacity:"hide"},q,H);break;case"top":l.stop(!0,!1).animate({top:-p*t*D},q,H,function(){U()});break;case"left":l.stop(!0,!1).animate({left:-p*t*E},q,H,function(){U()});break;case"leftLoop":var b=P;l.stop(!0,!0).animate({left:-(_(P)+Q)*E},q,H,function(){-1>=b?l.css("left",-(Q+(k-1)*t)*E):b>=k&&l.css("left",-Q*E),U()});break;case"topLoop":var b=P;l.stop(!0,!0).animate({top:-(_(P)+Q)*D},q,H,function(){-1>=b?l.css("top",-(Q+(k-1)*t)*D):b>=k&&l.css("top",-Q*D),U()});break;case"leftMarquee":var c=l.css("left").replace("px","");0==p?l.animate({left:++c},0,function(){l.css("left").replace("px","")>=0&&l.css("left",-m*E)}):l.animate({left:--c},0,function(){l.css("left").replace("px","")<=-(m+Q)*E&&l.css("left",-Q*E)});break;case"topMarquee":var d=l.css("top").replace("px","");0==p?l.animate({top:++d},0,function(){l.css("top").replace("px","")>=0&&l.css("top",-m*D)}):l.animate({top:--d},0,function(){l.css("top").replace("px","")<=-(m+Q)*D&&l.css("top",-Q*D)})}j.removeClass(L).eq(p).addClass(L),N=p,y||(g.removeClass("nextStop"),f.removeClass("prevStop"),0==p&&f.addClass("prevStop"),p==k-1&&g.addClass("nextStop")),h.html("<span>"+(p+1)+"</span>/"+k)}};A&&ba(!0),B&&d.hover(function(){clearTimeout(K)},function(){K=setTimeout(function(){p=O,A?ba():"slideDown"==e?R.slideUp(q,V):R.animate({opacity:"hide"},q,V),N=p},300)});var ca=function(a){I=setInterval(function(){w?p--:p++,ba()},a?a:r)},da=function(a){I=setInterval(ba,a?a:r)},ea=function(){z||(clearInterval(I),ca())},fa=function(){(y||p!=k-1)&&(p++,ba(),S||ea())},ga=function(){(y||0!=p)&&(p--,ba(),S||ea())},ha=function(){clearInterval(I),S?da():ca(),i.removeClass("pauseState")},ia=function(){clearInterval(I),i.addClass("pauseState")};if(v?S?(w?p--:p++,da(),z&&l.hover(ia,ha)):(ca(),z&&d.hover(ia,ha)):(S&&(w?p--:p++),i.addClass("pauseState")),i.click(function(){i.hasClass("pauseState")?ha():ia()}),"mouseover"==c.trigger?j.hover(function(){var a=j.index(this);J=setTimeout(function(){p=a,ba(),ea()},c.triggerTime)},function(){clearTimeout(J)}):j.click(function(){p=j.index(this),ba(),ea()}),S){if(g.mousedown(fa),f.mousedown(ga),y){var ja,ka=function(){ja=setTimeout(function(){clearInterval(I),da(r/10^0)},150)},la=function(){clearTimeout(ja),clearInterval(I),da()};g.mousedown(ka),g.mouseup(la),f.mousedown(ka),f.mouseup(la)}"mouseover"==c.trigger&&(g.hover(fa,function(){}),f.hover(ga,function(){}))}else g.click(fa),f.click(ga)})}}(jQuery),jQuery.easing.jswing=jQuery.easing.swing,jQuery.extend(jQuery.easing,{def:"easeOutQuad",swing:function(a,b,c,d,e){return jQuery.easing[jQuery.easing.def](a,b,c,d,e)},easeInQuad:function(a,b,c,d,e){return d*(b/=e)*b+c},easeOutQuad:function(a,b,c,d,e){return-d*(b/=e)*(b-2)+c},easeInOutQuad:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b+c:-d/2*(--b*(b-2)-1)+c},easeInCubic:function(a,b,c,d,e){return d*(b/=e)*b*b+c},easeOutCubic:function(a,b,c,d,e){return d*((b=b/e-1)*b*b+1)+c},easeInOutCubic:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b*b+c:d/2*((b-=2)*b*b+2)+c},easeInQuart:function(a,b,c,d,e){return d*(b/=e)*b*b*b+c},easeOutQuart:function(a,b,c,d,e){return-d*((b=b/e-1)*b*b*b-1)+c},easeInOutQuart:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b*b*b+c:-d/2*((b-=2)*b*b*b-2)+c},easeInQuint:function(a,b,c,d,e){return d*(b/=e)*b*b*b*b+c},easeOutQuint:function(a,b,c,d,e){return d*((b=b/e-1)*b*b*b*b+1)+c},easeInOutQuint:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b*b*b*b+c:d/2*((b-=2)*b*b*b*b+2)+c},easeInSine:function(a,b,c,d,e){return-d*Math.cos(b/e*(Math.PI/2))+d+c},easeOutSine:function(a,b,c,d,e){return d*Math.sin(b/e*(Math.PI/2))+c},easeInOutSine:function(a,b,c,d,e){return-d/2*(Math.cos(Math.PI*b/e)-1)+c},easeInExpo:function(a,b,c,d,e){return 0==b?c:d*Math.pow(2,10*(b/e-1))+c},easeOutExpo:function(a,b,c,d,e){return b==e?c+d:d*(-Math.pow(2,-10*b/e)+1)+c},easeInOutExpo:function(a,b,c,d,e){return 0==b?c:b==e?c+d:(b/=e/2)<1?d/2*Math.pow(2,10*(b-1))+c:d/2*(-Math.pow(2,-10*--b)+2)+c},easeInCirc:function(a,b,c,d,e){return-d*(Math.sqrt(1-(b/=e)*b)-1)+c},easeOutCirc:function(a,b,c,d,e){return d*Math.sqrt(1-(b=b/e-1)*b)+c},easeInOutCirc:function(a,b,c,d,e){return(b/=e/2)<1?-d/2*(Math.sqrt(1-b*b)-1)+c:d/2*(Math.sqrt(1-(b-=2)*b)+1)+c},easeInElastic:function(a,b,c,d,e){var f=1.70158,g=0,h=d;if(0==b)return c;if(1==(b/=e))return c+d;if(g||(g=.3*e),h<Math.abs(d)){h=d;var f=g/4}else var f=g/(2*Math.PI)*Math.asin(d/h);return-(h*Math.pow(2,10*(b-=1))*Math.sin((b*e-f)*(2*Math.PI)/g))+c},easeOutElastic:function(a,b,c,d,e){var f=1.70158,g=0,h=d;if(0==b)return c;if(1==(b/=e))return c+d;if(g||(g=.3*e),h<Math.abs(d)){h=d;var f=g/4}else var f=g/(2*Math.PI)*Math.asin(d/h);return h*Math.pow(2,-10*b)*Math.sin((b*e-f)*(2*Math.PI)/g)+d+c},easeInOutElastic:function(a,b,c,d,e){var f=1.70158,g=0,h=d;if(0==b)return c;if(2==(b/=e/2))return c+d;if(g||(g=e*(.3*1.5)),h<Math.abs(d)){h=d;var f=g/4}else var f=g/(2*Math.PI)*Math.asin(d/h);return 1>b?-.5*(h*Math.pow(2,10*(b-=1))*Math.sin((b*e-f)*(2*Math.PI)/g))+c:h*Math.pow(2,-10*(b-=1))*Math.sin((b*e-f)*(2*Math.PI)/g)*.5+d+c},easeInBack:function(a,b,c,d,e,f){return void 0==f&&(f=1.70158),d*(b/=e)*b*((f+1)*b-f)+c},easeOutBack:function(a,b,c,d,e,f){return void 0==f&&(f=1.70158),d*((b=b/e-1)*b*((f+1)*b+f)+1)+c},easeInOutBack:function(a,b,c,d,e,f){return void 0==f&&(f=1.70158),(b/=e/2)<1?d/2*(b*b*(((f*=1.525)+1)*b-f))+c:d/2*((b-=2)*b*(((f*=1.525)+1)*b+f)+2)+c},easeInBounce:function(a,b,c,d,e){return d-jQuery.easing.easeOutBounce(a,e-b,0,d,e)+c},easeOutBounce:function(a,b,c,d,e){return(b/=e)<1/2.75?d*(7.5625*b*b)+c:2/2.75>b?d*(7.5625*(b-=1.5/2.75)*b+.75)+c:2.5/2.75>b?d*(7.5625*(b-=2.25/2.75)*b+.9375)+c:d*(7.5625*(b-=2.625/2.75)*b+.984375)+c},easeInOutBounce:function(a,b,c,d,e){return e/2>b?.5*jQuery.easing.easeInBounce(a,2*b,0,d,e)+c:.5*jQuery.easing.easeOutBounce(a,2*b-e,0,d,e)+.5*d+c}});
	
	/* WEBPACK VAR INJECTION */}.call(exports, require, require(9)))

/***/ }
])
/*
//@ sourceMappingURL=index.bundle.js.map
*/