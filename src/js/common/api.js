var $ = require('jquery');
var cookie = require('cookie');

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
