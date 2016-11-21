webpackJsonp([1],{

/***/ 0:
/***/ function(module, exports, require) {

	var $ = require(6);
	// var header = require('common/header');
	// var web = require('common/web');
	// var api = require('common/api');
	var slide = require(8);
	var cookie = require(7);
	var lazyload = require(9);
	var pagination = require(10);
	var common = require(1);
	var _ = require(11);
	
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


/***/ },

/***/ 8:
/***/ function(module, exports, require) {

	/* WEBPACK VAR INJECTION */(function(require, jQuery) {!function(a){a.fn.slide=function(b){return a.fn.slide.defaults={type:"slide",effect:"fade",autoPlay:!1,delayTime:500,interTime:2500,triggerTime:150,defaultIndex:0,titCell:".hd li",mainCell:".bd",targetCell:null,trigger:"mouseover",scroll:1,vis:1,titOnClassName:"on",autoPage:!1,prevCell:".prev",nextCell:".next",pageStateCell:".pageState",opp:!1,pnLoop:!0,easing:"swing",startFun:null,endFun:null,vda:!1,switchLoad:null,playStateCell:".playState",mouseOverStop:!0,defaultPlay:!0,returnDefault:!1},this.each(function(){var R,c=a.extend({},a.fn.slide.defaults,b),d=a(this),e=c.effect,f=a(c.prevCell,d),g=a(c.nextCell,d),h=a(c.pageStateCell,d),i=a(c.playStateCell,d),j=a(c.titCell,d),k=j.size(),l=a(c.mainCell,d),m=l.children().size(),n=c.switchLoad,o=a(c.targetCell,d),p=parseInt(c.defaultIndex),q=parseInt(c.delayTime),r=parseInt(c.interTime),t=(parseInt(c.triggerTime),parseInt(c.scroll)),u=parseInt(c.vis),v="false"==c.autoPlay||0==c.autoPlay?!1:!0,w="false"==c.opp||0==c.opp?!1:!0,x="false"==c.autoPage||0==c.autoPage?!1:!0,y="false"==c.pnLoop||0==c.pnLoop?!1:!0,z="false"==c.mouseOverStop||0==c.mouseOverStop?!1:!0,A="false"==c.defaultPlay||0==c.defaultPlay?!1:!0,B="false"==c.returnDefault||0==c.returnDefault?!1:!0,C="false"==c.vda||0==c.vda?!1:!0,D=0,E=0,F=0,G=0,H=c.easing,I=null,J=null,K=null,L=c.titOnClassName,M=j.index(d.find("."+L)),N=p=-1==M?p:M,O=p,P=p,Q=m>=u?m%t!=0?m%t:t:0,S="leftMarquee"==e||"topMarquee"==e?!0:!1,T=function(){a.isFunction(c.startFun)&&c.startFun(p,k,d,a(c.titCell,d),l,o,f,g)},U=function(){if(a.isFunction(c.endFun)&&c.endFun(p,k,d,a(c.titCell,d),l,o,f,g),C){var b=l.children().not(".clone").eq(p).find("a.j-vda");b.hasClass("ishide")&&cuvvic.sendShow("",b)}},V=function(){j.removeClass(L),A&&j.eq(O).addClass(L)};if("menu"==c.type)return A&&j.removeClass(L).eq(p).addClass(L),j.hover(function(){R=a(this).find(c.targetCell);var b=j.index(a(this));J=setTimeout(function(){switch(p=b,j.removeClass(L).eq(p).addClass(L),T(),e){case"fade":R.stop(!0,!0).animate({opacity:"show"},q,H,U);break;case"slideDown":R.stop(!0,!0).animate({height:"show"},q,H,U)}},c.triggerTime)},function(){switch(clearTimeout(J),e){case"fade":R.animate({opacity:"hide"},q,H);break;case"slideDown":R.animate({height:"hide"},q,H)}}),void(B&&d.hover(function(){clearTimeout(K)},function(){K=setTimeout(V,q)}));if(0==k&&(k=m),S&&(k=2),x){if(m>=u)if("leftLoop"==e||"topLoop"==e)k=m%t!=0?(m/t^0)+1:m/t;else{var W=m-u;k=1+parseInt(W%t!=0?W/t+1:W/t),0>=k&&(k=1)}else k=1;j.html("");var X="";if(1==c.autoPage||"true"==c.autoPage)for(var Y=0;k>Y;Y++)X+="<li>"+(Y+1)+"</li>";else for(var Y=0;k>Y;Y++)X+=c.autoPage.replace("$",Y+1);j.html(X);var j=j.children()}if(m>=u){l.children().each(function(){a(this).width()>F&&(F=a(this).width(),E=a(this).outerWidth(!0)),a(this).height()>G&&(G=a(this).height(),D=a(this).outerHeight(!0))});var Z=l.children(),$=function(){for(var a=0;u>a;a++)Z.eq(a).clone().addClass("clone").appendTo(l);for(var a=0;Q>a;a++)Z.eq(m-a-1).clone().addClass("clone").prependTo(l)};switch(e){case"fold":l.css({position:"relative",width:E,height:D}).children().css({position:"absolute",width:F,left:0,top:0,display:"none"});break;case"top":l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; height:'+u*D+'px"></div>').css({top:-(p*t)*D,position:"relative",padding:"0",margin:"0"}).children().css({height:G});break;case"left":l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; width:'+u*E+'px"></div>').css({width:m*E,left:-(p*t)*E,position:"relative",overflow:"hidden",padding:"0",margin:"0"}).children().css({"float":"left",width:F});break;case"leftLoop":case"leftMarquee":$(),l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; width:'+u*E+'px"></div>').css({width:(m+u+Q)*E,position:"relative",overflow:"hidden",padding:"0",margin:"0",left:-(Q+p*t)*E}).children().css({"float":"left",width:F});break;case"topLoop":case"topMarquee":$(),l.wrap('<div class="tempWrap" style="overflow:hidden; position:relative; height:'+u*D+'px"></div>').css({height:(m+u+Q)*D,position:"relative",padding:"0",margin:"0",top:-(Q+p*t)*D}).children().css({height:G})}}var _=function(a){var b=a*t;return a==k?b=m:-1==a&&m%t!=0&&(b=-m%t),b},aa=function(b){var c=function(c){for(var d=c;u+c>d;d++)b.eq(d).find("img["+n+"]").each(function(){var b=a(this);if(b.attr("src",b.attr(n)).removeAttr(n),l.find(".clone")[0])for(var c=l.children(),d=0;d<c.size();d++)c.eq(d).find("img["+n+"]").each(function(){a(this).attr(n)==b.attr("src")&&a(this).attr("src",a(this).attr(n)).removeAttr(n)})})};switch(e){case"fade":case"fold":case"top":case"left":case"slideDown":c(p*t);break;case"leftLoop":case"topLoop":c(Q+_(P));break;case"leftMarquee":case"topMarquee":var d="leftMarquee"==e?l.css("left").replace("px",""):l.css("top").replace("px",""),f="leftMarquee"==e?E:D,g=Q;if(d%f!=0){var h=Math.abs(d/f^0);g=1==p?Q+h:Q+h-1}c(g)}},ba=function(a){if(!A||N!=p||a||S){if(S?p>=1?p=1:0>=p&&(p=0):(P=p,p>=k?p=0:0>p&&(p=k-1)),T(),null!=n&&aa(l.children()),o[0]&&(R=o.eq(p),null!=n&&aa(o),"slideDown"==e?(o.not(R).stop(!0,!0).slideUp(q),R.slideDown(q,H,function(){l[0]||U()})):(o.not(R).stop(!0,!0).hide(),R.animate({opacity:"show"},q,function(){l[0]||U()}))),m>=u)switch(e){case"fade":l.children().stop(!0,!0).eq(p).animate({opacity:"show"},q,H,function(){U()}).siblings().hide();break;case"fold":l.children().stop(!0,!0).eq(p).animate({opacity:"show"},q,H,function(){U()}).siblings().animate({opacity:"hide"},q,H);break;case"top":l.stop(!0,!1).animate({top:-p*t*D},q,H,function(){U()});break;case"left":l.stop(!0,!1).animate({left:-p*t*E},q,H,function(){U()});break;case"leftLoop":var b=P;l.stop(!0,!0).animate({left:-(_(P)+Q)*E},q,H,function(){-1>=b?l.css("left",-(Q+(k-1)*t)*E):b>=k&&l.css("left",-Q*E),U()});break;case"topLoop":var b=P;l.stop(!0,!0).animate({top:-(_(P)+Q)*D},q,H,function(){-1>=b?l.css("top",-(Q+(k-1)*t)*D):b>=k&&l.css("top",-Q*D),U()});break;case"leftMarquee":var c=l.css("left").replace("px","");0==p?l.animate({left:++c},0,function(){l.css("left").replace("px","")>=0&&l.css("left",-m*E)}):l.animate({left:--c},0,function(){l.css("left").replace("px","")<=-(m+Q)*E&&l.css("left",-Q*E)});break;case"topMarquee":var d=l.css("top").replace("px","");0==p?l.animate({top:++d},0,function(){l.css("top").replace("px","")>=0&&l.css("top",-m*D)}):l.animate({top:--d},0,function(){l.css("top").replace("px","")<=-(m+Q)*D&&l.css("top",-Q*D)})}j.removeClass(L).eq(p).addClass(L),N=p,y||(g.removeClass("nextStop"),f.removeClass("prevStop"),0==p&&f.addClass("prevStop"),p==k-1&&g.addClass("nextStop")),h.html("<span>"+(p+1)+"</span>/"+k)}};A&&ba(!0),B&&d.hover(function(){clearTimeout(K)},function(){K=setTimeout(function(){p=O,A?ba():"slideDown"==e?R.slideUp(q,V):R.animate({opacity:"hide"},q,V),N=p},300)});var ca=function(a){I=setInterval(function(){w?p--:p++,ba()},a?a:r)},da=function(a){I=setInterval(ba,a?a:r)},ea=function(){z||(clearInterval(I),ca())},fa=function(){(y||p!=k-1)&&(p++,ba(),S||ea())},ga=function(){(y||0!=p)&&(p--,ba(),S||ea())},ha=function(){clearInterval(I),S?da():ca(),i.removeClass("pauseState")},ia=function(){clearInterval(I),i.addClass("pauseState")};if(v?S?(w?p--:p++,da(),z&&l.hover(ia,ha)):(ca(),z&&d.hover(ia,ha)):(S&&(w?p--:p++),i.addClass("pauseState")),i.click(function(){i.hasClass("pauseState")?ha():ia()}),"mouseover"==c.trigger?j.hover(function(){var a=j.index(this);J=setTimeout(function(){p=a,ba(),ea()},c.triggerTime)},function(){clearTimeout(J)}):j.click(function(){p=j.index(this),ba(),ea()}),S){if(g.mousedown(fa),f.mousedown(ga),y){var ja,ka=function(){ja=setTimeout(function(){clearInterval(I),da(r/10^0)},150)},la=function(){clearTimeout(ja),clearInterval(I),da()};g.mousedown(ka),g.mouseup(la),f.mousedown(ka),f.mouseup(la)}"mouseover"==c.trigger&&(g.hover(fa,function(){}),f.hover(ga,function(){}))}else g.click(fa),f.click(ga)})}}(jQuery),jQuery.easing.jswing=jQuery.easing.swing,jQuery.extend(jQuery.easing,{def:"easeOutQuad",swing:function(a,b,c,d,e){return jQuery.easing[jQuery.easing.def](a,b,c,d,e)},easeInQuad:function(a,b,c,d,e){return d*(b/=e)*b+c},easeOutQuad:function(a,b,c,d,e){return-d*(b/=e)*(b-2)+c},easeInOutQuad:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b+c:-d/2*(--b*(b-2)-1)+c},easeInCubic:function(a,b,c,d,e){return d*(b/=e)*b*b+c},easeOutCubic:function(a,b,c,d,e){return d*((b=b/e-1)*b*b+1)+c},easeInOutCubic:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b*b+c:d/2*((b-=2)*b*b+2)+c},easeInQuart:function(a,b,c,d,e){return d*(b/=e)*b*b*b+c},easeOutQuart:function(a,b,c,d,e){return-d*((b=b/e-1)*b*b*b-1)+c},easeInOutQuart:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b*b*b+c:-d/2*((b-=2)*b*b*b-2)+c},easeInQuint:function(a,b,c,d,e){return d*(b/=e)*b*b*b*b+c},easeOutQuint:function(a,b,c,d,e){return d*((b=b/e-1)*b*b*b*b+1)+c},easeInOutQuint:function(a,b,c,d,e){return(b/=e/2)<1?d/2*b*b*b*b*b+c:d/2*((b-=2)*b*b*b*b+2)+c},easeInSine:function(a,b,c,d,e){return-d*Math.cos(b/e*(Math.PI/2))+d+c},easeOutSine:function(a,b,c,d,e){return d*Math.sin(b/e*(Math.PI/2))+c},easeInOutSine:function(a,b,c,d,e){return-d/2*(Math.cos(Math.PI*b/e)-1)+c},easeInExpo:function(a,b,c,d,e){return 0==b?c:d*Math.pow(2,10*(b/e-1))+c},easeOutExpo:function(a,b,c,d,e){return b==e?c+d:d*(-Math.pow(2,-10*b/e)+1)+c},easeInOutExpo:function(a,b,c,d,e){return 0==b?c:b==e?c+d:(b/=e/2)<1?d/2*Math.pow(2,10*(b-1))+c:d/2*(-Math.pow(2,-10*--b)+2)+c},easeInCirc:function(a,b,c,d,e){return-d*(Math.sqrt(1-(b/=e)*b)-1)+c},easeOutCirc:function(a,b,c,d,e){return d*Math.sqrt(1-(b=b/e-1)*b)+c},easeInOutCirc:function(a,b,c,d,e){return(b/=e/2)<1?-d/2*(Math.sqrt(1-b*b)-1)+c:d/2*(Math.sqrt(1-(b-=2)*b)+1)+c},easeInElastic:function(a,b,c,d,e){var f=1.70158,g=0,h=d;if(0==b)return c;if(1==(b/=e))return c+d;if(g||(g=.3*e),h<Math.abs(d)){h=d;var f=g/4}else var f=g/(2*Math.PI)*Math.asin(d/h);return-(h*Math.pow(2,10*(b-=1))*Math.sin((b*e-f)*(2*Math.PI)/g))+c},easeOutElastic:function(a,b,c,d,e){var f=1.70158,g=0,h=d;if(0==b)return c;if(1==(b/=e))return c+d;if(g||(g=.3*e),h<Math.abs(d)){h=d;var f=g/4}else var f=g/(2*Math.PI)*Math.asin(d/h);return h*Math.pow(2,-10*b)*Math.sin((b*e-f)*(2*Math.PI)/g)+d+c},easeInOutElastic:function(a,b,c,d,e){var f=1.70158,g=0,h=d;if(0==b)return c;if(2==(b/=e/2))return c+d;if(g||(g=e*(.3*1.5)),h<Math.abs(d)){h=d;var f=g/4}else var f=g/(2*Math.PI)*Math.asin(d/h);return 1>b?-.5*(h*Math.pow(2,10*(b-=1))*Math.sin((b*e-f)*(2*Math.PI)/g))+c:h*Math.pow(2,-10*(b-=1))*Math.sin((b*e-f)*(2*Math.PI)/g)*.5+d+c},easeInBack:function(a,b,c,d,e,f){return void 0==f&&(f=1.70158),d*(b/=e)*b*((f+1)*b-f)+c},easeOutBack:function(a,b,c,d,e,f){return void 0==f&&(f=1.70158),d*((b=b/e-1)*b*((f+1)*b+f)+1)+c},easeInOutBack:function(a,b,c,d,e,f){return void 0==f&&(f=1.70158),(b/=e/2)<1?d/2*(b*b*(((f*=1.525)+1)*b-f))+c:d/2*((b-=2)*b*(((f*=1.525)+1)*b+f)+2)+c},easeInBounce:function(a,b,c,d,e){return d-jQuery.easing.easeOutBounce(a,e-b,0,d,e)+c},easeOutBounce:function(a,b,c,d,e){return(b/=e)<1/2.75?d*(7.5625*b*b)+c:2/2.75>b?d*(7.5625*(b-=1.5/2.75)*b+.75)+c:2.5/2.75>b?d*(7.5625*(b-=2.25/2.75)*b+.9375)+c:d*(7.5625*(b-=2.625/2.75)*b+.984375)+c},easeInOutBounce:function(a,b,c,d,e){return e/2>b?.5*jQuery.easing.easeInBounce(a,2*b,0,d,e)+c:.5*jQuery.easing.easeOutBounce(a,2*b-e,0,d,e)+.5*d+c}});
	
	/* WEBPACK VAR INJECTION */}.call(exports, require, require(6)))

/***/ },

/***/ 11:
/***/ function(module, exports, require) {

	var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;//     Underscore.js 1.8.3
	//     http://underscorejs.org
	//     (c) 2009-2015 Jeremy Ashkenas, DocumentCloud and Investigative Reporters & Editors
	//     Underscore may be freely distributed under the MIT license.
	(function(){function n(n){function t(t,r,e,u,i,o){for(;i>=0&&o>i;i+=n){var a=u?u[i]:i;e=r(e,t[a],a,t)}return e}return function(r,e,u,i){e=b(e,i,4);var o=!k(r)&&m.keys(r),a=(o||r).length,c=n>0?0:a-1;return arguments.length<3&&(u=r[o?o[c]:c],c+=n),t(r,e,u,o,c,a)}}function t(n){return function(t,r,e){r=x(r,e);for(var u=O(t),i=n>0?0:u-1;i>=0&&u>i;i+=n)if(r(t[i],i,t))return i;return-1}}function r(n,t,r){return function(e,u,i){var o=0,a=O(e);if("number"==typeof i)n>0?o=i>=0?i:Math.max(i+a,o):a=i>=0?Math.min(i+1,a):i+a+1;else if(r&&i&&a)return i=r(e,u),e[i]===u?i:-1;if(u!==u)return i=t(l.call(e,o,a),m.isNaN),i>=0?i+o:-1;for(i=n>0?o:a-1;i>=0&&a>i;i+=n)if(e[i]===u)return i;return-1}}function e(n,t){var r=I.length,e=n.constructor,u=m.isFunction(e)&&e.prototype||a,i="constructor";for(m.has(n,i)&&!m.contains(t,i)&&t.push(i);r--;)i=I[r],i in n&&n[i]!==u[i]&&!m.contains(t,i)&&t.push(i)}var u=this,i=u._,o=Array.prototype,a=Object.prototype,c=Function.prototype,f=o.push,l=o.slice,s=a.toString,p=a.hasOwnProperty,h=Array.isArray,v=Object.keys,g=c.bind,y=Object.create,d=function(){},m=function(n){return n instanceof m?n:this instanceof m?void(this._wrapped=n):new m(n)};true?("undefined"!=typeof module&&module.exports&&(exports=module.exports=m),exports._=m):u._=m,m.VERSION="1.8.3";var b=function(n,t,r){if(t===void 0)return n;switch(null==r?3:r){case 1:return function(r){return n.call(t,r)};case 2:return function(r,e){return n.call(t,r,e)};case 3:return function(r,e,u){return n.call(t,r,e,u)};case 4:return function(r,e,u,i){return n.call(t,r,e,u,i)}}return function(){return n.apply(t,arguments)}},x=function(n,t,r){return null==n?m.identity:m.isFunction(n)?b(n,t,r):m.isObject(n)?m.matcher(n):m.property(n)};m.iteratee=function(n,t){return x(n,t,1/0)};var _=function(n,t){return function(r){var e=arguments.length;if(2>e||null==r)return r;for(var u=1;e>u;u++)for(var i=arguments[u],o=n(i),a=o.length,c=0;a>c;c++){var f=o[c];t&&r[f]!==void 0||(r[f]=i[f])}return r}},j=function(n){if(!m.isObject(n))return{};if(y)return y(n);d.prototype=n;var t=new d;return d.prototype=null,t},w=function(n){return function(t){return null==t?void 0:t[n]}},A=Math.pow(2,53)-1,O=w("length"),k=function(n){var t=O(n);return"number"==typeof t&&t>=0&&A>=t};m.each=m.forEach=function(n,t,r){t=b(t,r);var e,u;if(k(n))for(e=0,u=n.length;u>e;e++)t(n[e],e,n);else{var i=m.keys(n);for(e=0,u=i.length;u>e;e++)t(n[i[e]],i[e],n)}return n},m.map=m.collect=function(n,t,r){t=x(t,r);for(var e=!k(n)&&m.keys(n),u=(e||n).length,i=Array(u),o=0;u>o;o++){var a=e?e[o]:o;i[o]=t(n[a],a,n)}return i},m.reduce=m.foldl=m.inject=n(1),m.reduceRight=m.foldr=n(-1),m.find=m.detect=function(n,t,r){var e;return e=k(n)?m.findIndex(n,t,r):m.findKey(n,t,r),e!==void 0&&e!==-1?n[e]:void 0},m.filter=m.select=function(n,t,r){var e=[];return t=x(t,r),m.each(n,function(n,r,u){t(n,r,u)&&e.push(n)}),e},m.reject=function(n,t,r){return m.filter(n,m.negate(x(t)),r)},m.every=m.all=function(n,t,r){t=x(t,r);for(var e=!k(n)&&m.keys(n),u=(e||n).length,i=0;u>i;i++){var o=e?e[i]:i;if(!t(n[o],o,n))return!1}return!0},m.some=m.any=function(n,t,r){t=x(t,r);for(var e=!k(n)&&m.keys(n),u=(e||n).length,i=0;u>i;i++){var o=e?e[i]:i;if(t(n[o],o,n))return!0}return!1},m.contains=m.includes=m.include=function(n,t,r,e){return k(n)||(n=m.values(n)),("number"!=typeof r||e)&&(r=0),m.indexOf(n,t,r)>=0},m.invoke=function(n,t){var r=l.call(arguments,2),e=m.isFunction(t);return m.map(n,function(n){var u=e?t:n[t];return null==u?u:u.apply(n,r)})},m.pluck=function(n,t){return m.map(n,m.property(t))},m.where=function(n,t){return m.filter(n,m.matcher(t))},m.findWhere=function(n,t){return m.find(n,m.matcher(t))},m.max=function(n,t,r){var e,u,i=-1/0,o=-1/0;if(null==t&&null!=n){n=k(n)?n:m.values(n);for(var a=0,c=n.length;c>a;a++)e=n[a],e>i&&(i=e)}else t=x(t,r),m.each(n,function(n,r,e){u=t(n,r,e),(u>o||u===-1/0&&i===-1/0)&&(i=n,o=u)});return i},m.min=function(n,t,r){var e,u,i=1/0,o=1/0;if(null==t&&null!=n){n=k(n)?n:m.values(n);for(var a=0,c=n.length;c>a;a++)e=n[a],i>e&&(i=e)}else t=x(t,r),m.each(n,function(n,r,e){u=t(n,r,e),(o>u||1/0===u&&1/0===i)&&(i=n,o=u)});return i},m.shuffle=function(n){for(var t,r=k(n)?n:m.values(n),e=r.length,u=Array(e),i=0;e>i;i++)t=m.random(0,i),t!==i&&(u[i]=u[t]),u[t]=r[i];return u},m.sample=function(n,t,r){return null==t||r?(k(n)||(n=m.values(n)),n[m.random(n.length-1)]):m.shuffle(n).slice(0,Math.max(0,t))},m.sortBy=function(n,t,r){return t=x(t,r),m.pluck(m.map(n,function(n,r,e){return{value:n,index:r,criteria:t(n,r,e)}}).sort(function(n,t){var r=n.criteria,e=t.criteria;if(r!==e){if(r>e||r===void 0)return 1;if(e>r||e===void 0)return-1}return n.index-t.index}),"value")};var F=function(n){return function(t,r,e){var u={};return r=x(r,e),m.each(t,function(e,i){var o=r(e,i,t);n(u,e,o)}),u}};m.groupBy=F(function(n,t,r){m.has(n,r)?n[r].push(t):n[r]=[t]}),m.indexBy=F(function(n,t,r){n[r]=t}),m.countBy=F(function(n,t,r){m.has(n,r)?n[r]++:n[r]=1}),m.toArray=function(n){return n?m.isArray(n)?l.call(n):k(n)?m.map(n,m.identity):m.values(n):[]},m.size=function(n){return null==n?0:k(n)?n.length:m.keys(n).length},m.partition=function(n,t,r){t=x(t,r);var e=[],u=[];return m.each(n,function(n,r,i){(t(n,r,i)?e:u).push(n)}),[e,u]},m.first=m.head=m.take=function(n,t,r){return null==n?void 0:null==t||r?n[0]:m.initial(n,n.length-t)},m.initial=function(n,t,r){return l.call(n,0,Math.max(0,n.length-(null==t||r?1:t)))},m.last=function(n,t,r){return null==n?void 0:null==t||r?n[n.length-1]:m.rest(n,Math.max(0,n.length-t))},m.rest=m.tail=m.drop=function(n,t,r){return l.call(n,null==t||r?1:t)},m.compact=function(n){return m.filter(n,m.identity)};var S=function(n,t,r,e){for(var u=[],i=0,o=e||0,a=O(n);a>o;o++){var c=n[o];if(k(c)&&(m.isArray(c)||m.isArguments(c))){t||(c=S(c,t,r));var f=0,l=c.length;for(u.length+=l;l>f;)u[i++]=c[f++]}else r||(u[i++]=c)}return u};m.flatten=function(n,t){return S(n,t,!1)},m.without=function(n){return m.difference(n,l.call(arguments,1))},m.uniq=m.unique=function(n,t,r,e){m.isBoolean(t)||(e=r,r=t,t=!1),null!=r&&(r=x(r,e));for(var u=[],i=[],o=0,a=O(n);a>o;o++){var c=n[o],f=r?r(c,o,n):c;t?(o&&i===f||u.push(c),i=f):r?m.contains(i,f)||(i.push(f),u.push(c)):m.contains(u,c)||u.push(c)}return u},m.union=function(){return m.uniq(S(arguments,!0,!0))},m.intersection=function(n){for(var t=[],r=arguments.length,e=0,u=O(n);u>e;e++){var i=n[e];if(!m.contains(t,i)){for(var o=1;r>o&&m.contains(arguments[o],i);o++);o===r&&t.push(i)}}return t},m.difference=function(n){var t=S(arguments,!0,!0,1);return m.filter(n,function(n){return!m.contains(t,n)})},m.zip=function(){return m.unzip(arguments)},m.unzip=function(n){for(var t=n&&m.max(n,O).length||0,r=Array(t),e=0;t>e;e++)r[e]=m.pluck(n,e);return r},m.object=function(n,t){for(var r={},e=0,u=O(n);u>e;e++)t?r[n[e]]=t[e]:r[n[e][0]]=n[e][1];return r},m.findIndex=t(1),m.findLastIndex=t(-1),m.sortedIndex=function(n,t,r,e){r=x(r,e,1);for(var u=r(t),i=0,o=O(n);o>i;){var a=Math.floor((i+o)/2);r(n[a])<u?i=a+1:o=a}return i},m.indexOf=r(1,m.findIndex,m.sortedIndex),m.lastIndexOf=r(-1,m.findLastIndex),m.range=function(n,t,r){null==t&&(t=n||0,n=0),r=r||1;for(var e=Math.max(Math.ceil((t-n)/r),0),u=Array(e),i=0;e>i;i++,n+=r)u[i]=n;return u};var E=function(n,t,r,e,u){if(!(e instanceof t))return n.apply(r,u);var i=j(n.prototype),o=n.apply(i,u);return m.isObject(o)?o:i};m.bind=function(n,t){if(g&&n.bind===g)return g.apply(n,l.call(arguments,1));if(!m.isFunction(n))throw new TypeError("Bind must be called on a function");var r=l.call(arguments,2),e=function(){return E(n,e,t,this,r.concat(l.call(arguments)))};return e},m.partial=function(n){var t=l.call(arguments,1),r=function(){for(var e=0,u=t.length,i=Array(u),o=0;u>o;o++)i[o]=t[o]===m?arguments[e++]:t[o];for(;e<arguments.length;)i.push(arguments[e++]);return E(n,r,this,this,i)};return r},m.bindAll=function(n){var t,r,e=arguments.length;if(1>=e)throw new Error("bindAll must be passed function names");for(t=1;e>t;t++)r=arguments[t],n[r]=m.bind(n[r],n);return n},m.memoize=function(n,t){var r=function(e){var u=r.cache,i=""+(t?t.apply(this,arguments):e);return m.has(u,i)||(u[i]=n.apply(this,arguments)),u[i]};return r.cache={},r},m.delay=function(n,t){var r=l.call(arguments,2);return setTimeout(function(){return n.apply(null,r)},t)},m.defer=m.partial(m.delay,m,1),m.throttle=function(n,t,r){var e,u,i,o=null,a=0;r||(r={});var c=function(){a=r.leading===!1?0:m.now(),o=null,i=n.apply(e,u),o||(e=u=null)};return function(){var f=m.now();a||r.leading!==!1||(a=f);var l=t-(f-a);return e=this,u=arguments,0>=l||l>t?(o&&(clearTimeout(o),o=null),a=f,i=n.apply(e,u),o||(e=u=null)):o||r.trailing===!1||(o=setTimeout(c,l)),i}},m.debounce=function(n,t,r){var e,u,i,o,a,c=function(){var f=m.now()-o;t>f&&f>=0?e=setTimeout(c,t-f):(e=null,r||(a=n.apply(i,u),e||(i=u=null)))};return function(){i=this,u=arguments,o=m.now();var f=r&&!e;return e||(e=setTimeout(c,t)),f&&(a=n.apply(i,u),i=u=null),a}},m.wrap=function(n,t){return m.partial(t,n)},m.negate=function(n){return function(){return!n.apply(this,arguments)}},m.compose=function(){var n=arguments,t=n.length-1;return function(){for(var r=t,e=n[t].apply(this,arguments);r--;)e=n[r].call(this,e);return e}},m.after=function(n,t){return function(){return--n<1?t.apply(this,arguments):void 0}},m.before=function(n,t){var r;return function(){return--n>0&&(r=t.apply(this,arguments)),1>=n&&(t=null),r}},m.once=m.partial(m.before,2);var M=!{toString:null}.propertyIsEnumerable("toString"),I=["valueOf","isPrototypeOf","toString","propertyIsEnumerable","hasOwnProperty","toLocaleString"];m.keys=function(n){if(!m.isObject(n))return[];if(v)return v(n);var t=[];for(var r in n)m.has(n,r)&&t.push(r);return M&&e(n,t),t},m.allKeys=function(n){if(!m.isObject(n))return[];var t=[];for(var r in n)t.push(r);return M&&e(n,t),t},m.values=function(n){for(var t=m.keys(n),r=t.length,e=Array(r),u=0;r>u;u++)e[u]=n[t[u]];return e},m.mapObject=function(n,t,r){t=x(t,r);for(var e,u=m.keys(n),i=u.length,o={},a=0;i>a;a++)e=u[a],o[e]=t(n[e],e,n);return o},m.pairs=function(n){for(var t=m.keys(n),r=t.length,e=Array(r),u=0;r>u;u++)e[u]=[t[u],n[t[u]]];return e},m.invert=function(n){for(var t={},r=m.keys(n),e=0,u=r.length;u>e;e++)t[n[r[e]]]=r[e];return t},m.functions=m.methods=function(n){var t=[];for(var r in n)m.isFunction(n[r])&&t.push(r);return t.sort()},m.extend=_(m.allKeys),m.extendOwn=m.assign=_(m.keys),m.findKey=function(n,t,r){t=x(t,r);for(var e,u=m.keys(n),i=0,o=u.length;o>i;i++)if(e=u[i],t(n[e],e,n))return e},m.pick=function(n,t,r){var e,u,i={},o=n;if(null==o)return i;m.isFunction(t)?(u=m.allKeys(o),e=b(t,r)):(u=S(arguments,!1,!1,1),e=function(n,t,r){return t in r},o=Object(o));for(var a=0,c=u.length;c>a;a++){var f=u[a],l=o[f];e(l,f,o)&&(i[f]=l)}return i},m.omit=function(n,t,r){if(m.isFunction(t))t=m.negate(t);else{var e=m.map(S(arguments,!1,!1,1),String);t=function(n,t){return!m.contains(e,t)}}return m.pick(n,t,r)},m.defaults=_(m.allKeys,!0),m.create=function(n,t){var r=j(n);return t&&m.extendOwn(r,t),r},m.clone=function(n){return m.isObject(n)?m.isArray(n)?n.slice():m.extend({},n):n},m.tap=function(n,t){return t(n),n},m.isMatch=function(n,t){var r=m.keys(t),e=r.length;if(null==n)return!e;for(var u=Object(n),i=0;e>i;i++){var o=r[i];if(t[o]!==u[o]||!(o in u))return!1}return!0};var N=function(n,t,r,e){if(n===t)return 0!==n||1/n===1/t;if(null==n||null==t)return n===t;n instanceof m&&(n=n._wrapped),t instanceof m&&(t=t._wrapped);var u=s.call(n);if(u!==s.call(t))return!1;switch(u){case"[object RegExp]":case"[object String]":return""+n==""+t;case"[object Number]":return+n!==+n?+t!==+t:0===+n?1/+n===1/t:+n===+t;case"[object Date]":case"[object Boolean]":return+n===+t}var i="[object Array]"===u;if(!i){if("object"!=typeof n||"object"!=typeof t)return!1;var o=n.constructor,a=t.constructor;if(o!==a&&!(m.isFunction(o)&&o instanceof o&&m.isFunction(a)&&a instanceof a)&&"constructor"in n&&"constructor"in t)return!1}r=r||[],e=e||[];for(var c=r.length;c--;)if(r[c]===n)return e[c]===t;if(r.push(n),e.push(t),i){if(c=n.length,c!==t.length)return!1;for(;c--;)if(!N(n[c],t[c],r,e))return!1}else{var f,l=m.keys(n);if(c=l.length,m.keys(t).length!==c)return!1;for(;c--;)if(f=l[c],!m.has(t,f)||!N(n[f],t[f],r,e))return!1}return r.pop(),e.pop(),!0};m.isEqual=function(n,t){return N(n,t)},m.isEmpty=function(n){return null==n?!0:k(n)&&(m.isArray(n)||m.isString(n)||m.isArguments(n))?0===n.length:0===m.keys(n).length},m.isElement=function(n){return!(!n||1!==n.nodeType)},m.isArray=h||function(n){return"[object Array]"===s.call(n)},m.isObject=function(n){var t=typeof n;return"function"===t||"object"===t&&!!n},m.each(["Arguments","Function","String","Number","Date","RegExp","Error"],function(n){m["is"+n]=function(t){return s.call(t)==="[object "+n+"]"}}),m.isArguments(arguments)||(m.isArguments=function(n){return m.has(n,"callee")}),"function"!=typeof/./&&"object"!=typeof Int8Array&&(m.isFunction=function(n){return"function"==typeof n||!1}),m.isFinite=function(n){return isFinite(n)&&!isNaN(parseFloat(n))},m.isNaN=function(n){return m.isNumber(n)&&n!==+n},m.isBoolean=function(n){return n===!0||n===!1||"[object Boolean]"===s.call(n)},m.isNull=function(n){return null===n},m.isUndefined=function(n){return n===void 0},m.has=function(n,t){return null!=n&&p.call(n,t)},m.noConflict=function(){return u._=i,this},m.identity=function(n){return n},m.constant=function(n){return function(){return n}},m.noop=function(){},m.property=w,m.propertyOf=function(n){return null==n?function(){}:function(t){return n[t]}},m.matcher=m.matches=function(n){return n=m.extendOwn({},n),function(t){return m.isMatch(t,n)}},m.times=function(n,t,r){var e=Array(Math.max(0,n));t=b(t,r,1);for(var u=0;n>u;u++)e[u]=t(u);return e},m.random=function(n,t){return null==t&&(t=n,n=0),n+Math.floor(Math.random()*(t-n+1))},m.now=Date.now||function(){return(new Date).getTime()};var B={"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#x27;","`":"&#x60;"},T=m.invert(B),R=function(n){var t=function(t){return n[t]},r="(?:"+m.keys(n).join("|")+")",e=RegExp(r),u=RegExp(r,"g");return function(n){return n=null==n?"":""+n,e.test(n)?n.replace(u,t):n}};m.escape=R(B),m.unescape=R(T),m.result=function(n,t,r){var e=null==n?void 0:n[t];return e===void 0&&(e=r),m.isFunction(e)?e.call(n):e};var q=0;m.uniqueId=function(n){var t=++q+"";return n?n+t:t},m.templateSettings={evaluate:/<%([\s\S]+?)%>/g,interpolate:/<%=([\s\S]+?)%>/g,escape:/<%-([\s\S]+?)%>/g};var K=/(.)^/,z={"'":"'","\\":"\\","\r":"r","\n":"n","\u2028":"u2028","\u2029":"u2029"},D=/\\|'|\r|\n|\u2028|\u2029/g,L=function(n){return"\\"+z[n]};m.template=function(n,t,r){!t&&r&&(t=r),t=m.defaults({},t,m.templateSettings);var e=RegExp([(t.escape||K).source,(t.interpolate||K).source,(t.evaluate||K).source].join("|")+"|$","g"),u=0,i="__p+='";n.replace(e,function(t,r,e,o,a){return i+=n.slice(u,a).replace(D,L),u=a+t.length,r?i+="'+\n((__t=("+r+"))==null?'':_.escape(__t))+\n'":e?i+="'+\n((__t=("+e+"))==null?'':__t)+\n'":o&&(i+="';\n"+o+"\n__p+='"),t}),i+="';\n",t.variable||(i="with(obj||{}){\n"+i+"}\n"),i="var __t,__p='',__j=Array.prototype.join,"+"print=function(){__p+=__j.call(arguments,'');};\n"+i+"return __p;\n";try{var o=new Function(t.variable||"obj","_",i)}catch(a){throw a.source=i,a}var c=function(n){return o.call(this,n,m)},f=t.variable||"obj";return c.source="function("+f+"){\n"+i+"}",c},m.chain=function(n){var t=m(n);return t._chain=!0,t};var P=function(n,t){return n._chain?m(t).chain():t};m.mixin=function(n){m.each(m.functions(n),function(t){var r=m[t]=n[t];m.prototype[t]=function(){var n=[this._wrapped];return f.apply(n,arguments),P(this,r.apply(m,n))}})},m.mixin(m),m.each(["pop","push","reverse","shift","sort","splice","unshift"],function(n){var t=o[n];m.prototype[n]=function(){var r=this._wrapped;return t.apply(r,arguments),"shift"!==n&&"splice"!==n||0!==r.length||delete r[0],P(this,r)}}),m.each(["concat","join","slice"],function(n){var t=o[n];m.prototype[n]=function(){return P(this,t.apply(this._wrapped,arguments))}}),m.prototype.value=function(){return this._wrapped},m.prototype.valueOf=m.prototype.toJSON=m.prototype.value,m.prototype.toString=function(){return""+this._wrapped},"function"=='function'&&require(16)&&!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function(){return m}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__))}).call(this);
	//# sourceMappingURL=underscore-min.map

/***/ }

})
/*
//@ sourceMappingURL=index.bundle.js.map
*/