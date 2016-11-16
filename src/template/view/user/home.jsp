<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="user3"/>
    <jsp:param name="cssHash" value="${cssHash.user3}"/>
    <jsp:param name="title" value="个人中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>

<div class="w user-w">
    <div class="user-left">
        <jsp:include page="usernav.jsp">
            <jsp:param name="bigClass" value="1" />
            <jsp:param name="smallClass" value="0" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="home-main">
                <div class="h-userinfo clearfix">
                    <div class="h-userbar clearfix">
                        <div class="h-baseinfo fl">
                            <em class="h-name"><a href="/user/account/profile.html" id="userName"></a></em>
                            <a href="/user/account/profile.html" class="h-edit vvicon">&#xe64e;</a>
                        </div>
                        <div class="h-my-stuffs fr">
                            <ul>
                                <li>
                                    <a href="/user/message.html" class="i-trigger">消息中心</a>
                                </li>
                                <li class="interval"></li>
                                <li>
                                    <a href="/user/account/setting.html" class="i-trigger">账户设置</a>
                                </li>
                            </ul>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <div class="h-box h-account fl">
                        <div class="h-box-title">
                            账户余额
                        </div>
                        <div class="h-box-content clearfix">
                            <div class="h-account-info mt10 fl">
                                <span class="yuan">¥</span>
                                <em id="userMoney">0.00</em>
                            </div>
                            <a href="/user/withdraw.html" class="btn btn-red btn-small fr mt10">提现</a>
                        </div>
                    </div>
                    <div class="h-box h-my-counts fr">
                        <ul>
                            <li>
                                <a target="_blank" href="/user/orders.html?t=0"><span>待付款</span></a>
                            </li>
                            <li class="brn">
                                <a target="_blank" href="/user/orders.html?t=3"><span>拿货中<em></em></span></a>
                            </li>
                            <li class="bbn">
                                <a target="_blank" href="/user/orders.html?t=5"><span>配送中</span></a>
                            </li>
                            <li class="brn bbn">
                                <a target="_blank" href="/user/return.html"><span>退货记录<em></em></span></a>
                            </li>
                        </ul>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="h-box h-order clearfix">
                    <div class="h-box-title">
                        <a href="/user/orders.html" class="h-box-more">查看全部订单 <i class="vvicon">&#xe60f;</i></a>
                        我的订单
                    </div>
                    <div class="h-box-content">
                        <div class="h-order">
                            <div id="order-content"><div class="loading3"></div></div>
                        </div>
                    </div>
                </div>

                <div class="h-header mt10 clearfix">
                    <h2 class="h-header-title">我的收藏</h2>
                    <a href="/user/favorite.html" class="h-header-more">查看更多 <i class="vvicon">&#xe60f;</i></a>
                </div>
                <div class="h-favlist fav-main">
                    <div id="fav-content">
                        <div class="loading3"></div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>


<script type="text/x-handlebars-template" id="orderTemplate">
    {{ var orderStatusText = ['待付款','待审核','交易关闭','拿货中','打包中','配送中','交易成功','退款中','交易关闭']}}
    {{ _.each(list, function(el, index){ }}
    <!-- <a href="/user/orders_detail.html?order_id={{=el.orderId}}" target="_blank"> -->
        <dl class="h-order-list {{if(index==0){}}first{{}}}">
            <dt class="h-order-info">
                <div class="h-info-status">
                    {{ if(el.orderStatus == 0){ }}
                        <a href="/user/pay.html?orderId={{=el.orderId}}" target="_blank" class="btn btn-primary pay-btn j-pay">立即支付</a>
                    {{ }else{ }}
                        {{=orderStatusText[el.orderStatus]}}
                    {{ } }}
                </div>
                <span class="h-info-no">订单号：<em>{{=el.orderNo}}</em></span>
                <span class="h-info-date">下单时间：<em>{{=el.createTime}}</em></span>
            </dt>
            <dd class="h-order-detail">
                <ul>
                    {{ _.each(el.orderDetails, function(item, index){ }}
                    {{ if(index<10){ }}
                    <li skuColor="{{=item.skuColor}}" skuPrice="{{=item.skuPrice}}" skuSize="{{=item.skuSize}}" deliveryStatus="{{=item.deliveryStatus}}" refundStatus="{{=item.refundStatus}}">
                        <a href="/item/{{=item.itemId}}" title="{{=item.itemName}}" target="_blank">
                            <img src="{{=item.itemImg.replace('230x230.jpg','80x80.jpg')}}" >
                        </a>
                    </li>
                    {{ } }}
                    {{ }) }}
                </ul>
            </dd>
        </dl>
    <!-- </a> -->
    {{ }) }}

    {{ if(!list.length){ }}
        <div class="empty-tip" style="height:170px;">
            <i class="vvicon" style="margin:auto;">&#xe614;</i>
            <div class="text">没有购买任何商品</div>
            <p><a href="/" class="red">立即去下单</a>，快来体验搜款代发服务</p>
        </div>
    {{ } }}
</script>

<script type="text/x-handlebars-template" id="favTemplate">
    <div class="goods-list small-list clearfix" style="width:990px;">
        <ul class="clearfix goods-content">
            {{ _.each(list, function(item, index){ }}
            <li>
                <div class="item">
                    <div class="pic">
                        <a target="_blank" class="j-vda" vda="tp|itemcard|${item.id}|0|0|{{=index+1}}" href="/item/{{=item.id}}">
                            <img class="lazy" data-original="{{=item.index_img_url}}_190x190.jpg"/>
                        </a>

                        {{ if(item.status==1){ }}
                            {{ if(item.is_pre_sell==1 || item.art_no=='' || item.support_cart !=1){ }}
                                <div class="ctrl one clearfix">
                                    <a href="javascript:;" class="j-upload" data-id="{{=item.tid}}" data-vid="{{=item.id}}"
                                          data-price="{{=item.discount_price}}" vda="yjsc|itemcard|{{=item.id}}|0|0|{{=index+1}}"><span>一键上传</span>
                                    </a>
                                </div>
                            {{ }else{ }}
                                <div class="ctrl clearfix">
                                    <div class="line"></div>
                                    <span class="j-addcart" vda="gwc|itemcard|{{=item.id}}|0|0|{{=index+1}}" data-id="{{=item.id}}">加入购物车</span>

                                    <span class="j-upload upload" data-id="{{=item.tid}}" data-vid="{{=item.id}}"
                                          data-price="{{=item.discount_price}}" vda="yjsc|itemcard|{{=item.id}}|0|0|{{=index+1}}">一键上传
                                    </span>
                                </div>
                            {{ } }}
                        {{ }else{ }}
                            <div class="ctrl clearfix">
                                <a target="_blank" href="/samestyle/{{=item.id}}" vda="ztk|itemcard|${item.id}|0|0{{=index+1}}">
                                    <span>找同款</span>
                                </a>
                            </div>
                        {{ } }}
                    </div>
                    <div class="desc">
                        <div class="info clearfix">
                            <span class="fr up_time">{{- (new Date(item.ctime)).format('M月d日')}}收藏</span>
                            {{ if(item.status==1){ }}
                                <div class="price">
                                    <span class="yuan">¥</span>{{=item.discount_price}}
                                </div>
                            {{ }else{ }}
                                <div class="status0">已下架</div>
                            {{ } }}
                            <!--<i class="fl ico_item_active_0 ico_item_active"></i></div>-->
                            <div class="title">
                                <a target="_blank" href="/item/{{=item.id}}" vda="spbt|itemcard|{{=item.id}}|0|0|{{=index+1}}">
                                    {{=item.title}}
                                </a>
                            </div>
                            <div class="clearfix shop-name-box">
                                <div class="fr num j_clip_button">
                                    {{=item.art_no!=''?item.art_no+'#':'无货号'}}
                                </div>
                                <a target="_blank" class="shop-name" href="/shop/{{=item.shop_id}}"
                                   title="{{=item.marketName}} {{=item.position}}" vda="dkmc|itemcard|0|{{=item.shop_id}}|0|{{=index+1}}">
                                    <span class="inner">{{=item.marketName}} {{=item.position}}</span>
                                </a>
                            </div>

                            <div class="foot clearfix">
                                <div class="fl pos tb">
                                    <a target="_blank" class="vam" href="/shop/{{=item.shop_id}}"
                                       title="{{=item.shop_name}}" vda="dkmc|itemcard|0|{{=item.shop_id}}|0|{{=index+1}}">{{=item.shop_name}}
                                    </a>
                                    <a target="_blank" title="{{=item.shop_name}}"
                                       href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid={{=item.ww_nickname}}" vda="ww|itemcard|0|0|0|{{=index+1}}">
                                        <img class="lazy" style="display: inline;"
                                             data-original="http://www.vvic.com/api/online?nickname={{=item.ww_nickname}}">
                                    </a>

                                    <div class="triangle triangle-up1"></div>
                                    <div class="triangle triangle-up2"></div>
                                </div>
                                <div class="service-icon fr">
                                    {{ if(item.is_pre_sell==1){ }}
                                        <div class="s-item ys"><i></i></div>
                                    {{ } }}
                                    {{ if(item.is_sp==1){ }}
                                        <div class="s-item sp j-v-tip" data-tip="sp"><i></i></div>
                                    {{ } }}
                                    {{ if(item.is_tx==1){ }}
                                        <div class="s-item tx j-v-tip" data-tip="tx"><i></i></div>
                                    {{ } }}
                                    {{ if(item.is_df==1){ }}
                                        <div class="s-item df j-v-tip" data-tip="df"><i></i></div>
                                    {{ } }}
                                </div>
                            </div>

                        </div>
                    </div>
            </li>
            {{ }) }}
        </ul>
    </div>
    {{ if(!list.length){ }}
         <div style="background-color: #FAFAFA;height: 330px;line-height: 330px;border:1px solid #E5E5E5;" class="j-fav-empty-info empty-info">没有收藏任何商品</div>
    {{ } }}
</script>

<script type="text/x-handlebars-template" id="msgTemplate">
    <ul>
        {{ _.each(recordList, function(el){ }}
        {{ var _url = ['', "http://www1.vvic.com/help1.html", "/user/setting", "/shop/" + el.shop_id, "/item/" + el.item_id, "/item/" + el.item_id, "/shop/list.html", "/shop/list.html"] }}
        <li><a href="{{=_url[el.type]}}" target="_blank" title="{{=el.content}}">{{=el.content}}</a></li>
        {{ }) }}
    </ul>
</script>
<jsp:include page="../common/addcart.jsp"/>
<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    var _SKUMAP,_ITEMID,_TID,_DISCOUNTPRICE,_SOLDOUT,_SIZEID,_COLOR,_SIZE,_SUPPORT;
    require(['user3/home3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>
