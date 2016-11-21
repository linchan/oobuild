
var api = require('common/api');
var common = require('common/web');
var cookie = require('cookie');
require('common/search');
var main = {
    init: function () {

        bindChangeSearcher();

        bindLogout();

        scrollFixed();

        topBanner();

        if(window.page!='item' && window.page!='shop'){
            setTimeout(getNewamount, 200);
        }

        bindEvents();
        catSlide();


        //os x 导航等字体加粗
        var agent = window.navigator.userAgent.toLowerCase();
        if (agent.indexOf('mac os x') > -1) {
            $('.nav_item_list').css({'font-weight': 'bold'});
            $('.floor_list .floor_item .item_shop .info .name').css({'font-weight': 'bold'});
            $('.hot_shops .hot_shops_list .item.item_shop .info .desc').css({'font-weight': 'bold'});
        }
    },
    logout: bindLogout,
    clearNewamout: clearNewamout,
    loginUinfo: loginUinfo(),
    refreshLoginUinfo: loginUinfo
};

main.init();

module.exports = main;

function loginUinfo() {
    var _userKey = $.cookie('user_key') || '';
    return api.service.loginUinfo({user_key: _userKey}, function (dt) {
        if (dt.code == 200) {
            var _data = dt.data,
                _userId = _data.id,
                _username = _data.username,
                _verify = _data.is_verify_user,
                _carts_amount = _data.carts_amount,
                _news_amount = _data.amount,
                _order_amount = _data.orders_count,
                $topbar = $(".top_bar");
            // 是否登录
            if(_userId){
                $('#username', $topbar).text(_username);
                $(".islog", $topbar).show();
                $(".unlog", $topbar).remove();

                if(_news_amount > 0){
                    $('.messageUnRead').text(_news_amount).show();
                }
                _order_amount = _order_amount > 99 ? 99 : _order_amount;
                if(_order_amount > 0){
                    $('.orderUnRead').text(_order_amount).show();
                }

                if(window.page=='refund'){
                    $('.o-address input#mobile').val(_data.mobile);
                }
            }else{
                $(".islog", $topbar).remove();
                $(".unlog", $topbar).show();
                $(".j-btn-addrent").remove();
            }

            _carts_amount = _carts_amount > 0 ? _carts_amount : '';
            _carts_amount = _carts_amount <= 99 ? _carts_amount : '99+';
            $('.j-cart-amount').text(_carts_amount);
            $(".header3 .btn_cart .num").text(_carts_amount);
            if(_carts_amount){
                $('.j-cart-amount').show();
            }
            if(!_carts_amount){
                $('.j-cart-amount').hide();
            }
            // if(!_data.new_amount){
            //     getNewamount(_data.new_amount);
            // }
        }
    });
}

function catSlide() {

    var nav_drop = $('.nav_drop');
    var $nav_drop_menu = $('.nav_drop_menu', nav_drop);
    var $menu_item = $('.menu_item', nav_drop);
    var $nav_expend = $('.nav_expend', nav_drop);
    var $nav_item = $('.nav_item', nav_drop);
    var $nav_expend_txt = $('.nav_expend_txt', nav_drop);
    var $nav_expend_ad = $('.nav_expend_ad', nav_drop);

    var can_animate = true;
    var timer;

    $menu_item.hover(function () {
        var _this = $(this);

        $nav_expend.show();
        $nav_item.hide().css('width', 0);

        $($nav_expend_txt, $($nav_item.get(_this.index()))).css('width', 580).show();
        $($nav_expend_ad, $($nav_item.get(_this.index()))).css('width', 220).show();

        $($nav_item.get(_this.index())).show().css('width', 800).addClass('selected');

        $menu_item.removeClass('selected');
        _this.addClass('selected');

        if (can_animate) {
            can_animate = !can_animate;

            $(".nav_expend_txt", $nav_item.get(_this.index())).css('width', 0).animate({
                width: 580
            }, 500);

            $(".nav_expend_ad", $nav_item.get(_this.index())).css('width', 0);

            timer = setTimeout(function () {
                $(".nav_expend_ad", $nav_item.get(_this.index())).animate({
                    width: 220
                }, 400);
            }, 350);
        }
        var $a = $nav_item.find('.nav_expend_ad a');
        if ($a.hasClass('ishide')) {
            cuvvic.sendShow("", $a);
        }
    });

    $nav_drop_menu.mouseleave(function (event) {
        var _this = $(this);

        var to_element = event.toElement || event.relatedTarget; //firefox 没有toElement
        var $to_element = $(to_element);

        if (!$to_element.hasClass('inner')) {

            $nav_expend.hide();
            $nav_item.hide().css('width', 0).removeClass('selected');
            $nav_expend_txt.css('width', 0).hide();
            $nav_expend_ad.css('width', 0).hide();

            $menu_item.removeClass('selected');

            can_animate = true;

        }
    });

    $nav_expend.mouseleave(function (event) {
        $nav_expend.hide();
        $nav_item.hide().css('width', 0).removeClass('selected');
        $nav_expend_txt.css('width', 0).hide();
        $nav_expend_ad.css('width', 0).hide();

        $menu_item.removeClass('selected');

    });

}

function bindEvents() {

    $('.j_clear_newamount').on('click', function () {
        clearNewamout();
    });

    /*搜全站*/
    $('.btn-search-global').on('click', function () {
        var q = $('input#q').val();
        location.href = '/search.html?q=' + q;
    });

    /*
    * 搜索框焦点变色
    * */
    var query_box =  $('.search_query_wrap');

    if(query_box.length > 0){
        $('.search_query_wrap input.search_query').on('focus', function () {
            query_box.css('border-color','#fb658a');
        }).on('blur', function () {
            query_box.css('border-color','#e5e5e5');
        });
    }

}

function scrollFixed() {

    var header = $('.header_fixed_able');
    var initFixed = function () {

        if (!header.length) {
            return;
        }
        var height = header.height();
        var offsetTop = header.offset().top;
        var scrollTop = $(window).scrollTop();

        if (scrollTop > offsetTop + 1 * height) {
            header.addClass('header_fixed');
        } else {
            header.removeClass('header_fixed');
        }
    };

    initFixed();

    $(window).on('scroll', initFixed);
}

function clearNewamout() {

    $('.newamount-box').hide();
    var newamount =  $('.newamount').attr('newamount');
    var timestamp = Date.parse(new Date());

    if(newamount-0){
        $.cookie('newamount', newamount + '|' + timestamp, {
            path: '/',
            expires: 1
        });
    }

    main.isClearNewamout = true;

}

function isToday(str) {
    var cookieDate = new Date(str-0).toDateString();
    if (cookieDate === new Date().toDateString()) {
        //今天
        return true;
    } else if (new Date(str) < new Date()){
        //之前
        return false;
    }
}

function getNewamount(new_amount) {
    if(main.isClearNewamout) {
        return;
    }
    var $newamount =  $('.newamount');

    if(!$newamount.size()){
        return;
    }

    api.service.newamount(function (res) {
        if (res.code == 200 && res.data.amount > 0) {
            var newAmountObj = $.cookie('newamount') || '',
                newAmount = 0,
                timestamp;
            if(newAmountObj){
                newAmountObj = newAmountObj.split('|');
                timestamp = newAmountObj[1];
                var _result = isToday(timestamp);
                if(_result){
                    newAmount = newAmountObj[0];
                }
            }
            newAmount = res.data.amount - newAmount;
            $newamount.attr('newamount', res.data.amount);

            if (newAmount > 0) {
                $newamount.html(newAmount);
                $('.newamount-box').show();
            }
        } else {
            $('.newamount-box').hide();
        }
    });

    // var newamount = $.cookie('newamount') || 0;
    // newamount = new_amount - newamount;

    // $newamount.attr('newamount', new_amount);

    // if (newamount > 0) {
    //     $newamount.html(newamount);
    //     $('.newamount-box').show();
    // }
}




function bindChangeSearcher() {
    var header_tab = common.tabs({
        container: '.header_inner',
        top: '.search_tab_top'
    });
    $('.tab-wraper .trigger').on('click', function () {
        var $this = $(this);
        var action = $this.attr('data-action');

        if($this.closest('.header_shop').length){
            $('.header_shop .search_tab_content').hide();
            $(action).show();
        }else{
            header_tab.trigger(action);
        }
    });
}

function bindLogout() {
    $('body').on('click', '.doLogout', function () {
        api.service.logout(function (res) {
            if (res.code == 200) {

                location.href = '/login.html';
            }
        });
    });
}
function topBanner() {
    var $ad = $('.top_ban_60'),
        item = $('a', $ad),
        $close = $('.close', $ad);

    var isShow = $.cookie('_TOPBANNER') == 1 ? false : true;

    if (isShow) {
        if (item.size() > 0) {
            // 随机数 显示广告
            var randomIndex = Math.floor(Math.random()*item.length+1) - 1;
            item.eq(randomIndex).show();
            $ad.show().css('height', 0).animate({
                height: 60
            }, 400);
            setTimeout(function(){
                cuvvic.sendShow('',item.eq(randomIndex),1);
            }, 500);
        }
    }

    // 广告点击关闭后一天后开启
    $close.bind('click', function(){
        $ad.animate({
            height: 0
        }, 400, function () {
            $ad.hide();
        });
        $.cookie('_TOPBANNER', '1', {expires: 1, path: '/'});
    });
}
