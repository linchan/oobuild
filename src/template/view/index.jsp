<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="index3.css"/>
    <jsp:param name="title" value=""/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="1"/>
    <jsp:param name="currentNav" value="1"/>
    <jsp:param name="fixdHeaderClassName" value="header_fixed_able"/>
</jsp:include>

<div class="index_ban">

    <div class="index_slider loading3">
        <div class="silder-btn prev"><i class="ico"></i></div>
        <div class="silder-btn next"><i class="ico"></i></div>
        <ul class="bd">
            <c:forEach items="${focusAdList}" var="item" varStatus="stats">
                <li>
                    <a href="${item.href_url}" vda="tp|focustp|0|0|0|${stats.count}"
                       class="j-vda<c:if test="${stats.index != 0}"> ishide</c:if>" target="_blank">
                        <img src="${item.img_url}" alt="">
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <div class="index_slider_ad">
        <div class="silder-btn prev"><i class="ico"></i></div>
        <div class="silder-btn next"><i class="ico"></i></div>

        <ul class="bd">
            <c:forEach items="${shop_vips}" var="item" varStatus="stats">
                <li>
                    <a href="${item.href_url}" vda="tp|selectedshop|0|0|0|${stats.count}"
                       class="j-vda<c:if test="${stats.index != 0}"> ishide</c:if>" target="_blank">
                        <img src="${item.img_url}" alt="">
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
    <script type="text/x-handlebars-template" id="tpl-index-login">

        {{ if(data.username){ }}
        {{ if(data.type==0){ }}
        <div class="index_islogin">

            <div class="title">Hi，{{=data.username}} </div>
            <div class="login_infos">
                <a href="/user/follow.html" vda="link|account" class="item">
                    <span class="red">
                       {{=data.favoriteShops}}
                    </span>
                    <span class="txt">关注</span>
                </a>
                <a href="/user/favorite.html" vda="link|account" class="item">
                    <span class="red">{{=data.favoriteItems}}</span>
                    <span class="txt">收藏</span>
                </a>
                <a href="/user/packet.html" vda="link|account" class="item">
                    <span class="red">{{=data.pack_amount}}</span>
                    <span class="txt">数据包</span>
                </a>
            </div>
            <a href="/user/home.html" vda="link|account" class="btn btn-default btn-big">个人中心</a>
        </div>
        {{ } else { }}
        <div class="index_islogin">

            <div class="title">Hi，{{=data.username}} </div>
            <div class="login_infos">
                <a href="/shop/data.html?sid={{=data.default_shop_id}}" class="item" vda="link|account">
                    <span class="red" id="shopFollow">{{=data.shop_favShop_num}}</span>
                    <span class="txt">关注</span>
                </a>
                <a href="/shop/data.html?sid={{=data.default_shop_id}}" class="item" vda="link|account">
                    <span class="red" id="shopFav">{{=data.shop_favItem_num}}</span>
                    <span class="txt">收藏</span>
                </a>
                <a href="/shop/data.html?sid={{=data.default_shop_id}}" class="item" vda="link|account">
                    <span class="red" id="shopUpNum">{{=data.shop_upload_num}}</span>
                    <span class="txt">上传</span>
                </a>
            </div>
            <a href="/shop/data.html?sid={{=data.default_shop_id}}" class="btn btn-default btn-big" vda="link|account">我是档口</a>
        </div>

        {{ } }}
        {{ } else { }}
        <div class="index_notlogin">
            <div class="title">欢迎来到搜款网！</div>

            <div class="index_nologin">

                <a href="/login.html" vda="link|account" target="_blank" class="btn btn-primary btn-big" title="立即登录">立即登录</a>

                <div class="no_acc_tip">还没有账号</div>
                <a href="/reg.html" vda="link|account" target="_blank" class="btn btn-default btn-big" title="免费注册">免费注册</a>

            </div>
        </div>
        {{ } }}


    </script>
    <div class="index_login j-index_login">

        <div class="loading3" style="height: 175px;"></div>

    </div>

    <div class="index_notice">
        <c:choose>
            <c:when test="${user.type==0}">
                <c:set var="classname0" value="selected" />
                <c:set var="classname1" value="" />
            </c:when>
            <c:when test="${user.type==1}">
                <c:set var="classname0" value="" />
                <c:set var="classname1" value="selected" />
            </c:when>
            <c:otherwise>
                <c:set var="classname0" value="selected" />
                <c:set var="classname1" value="" />
            </c:otherwise>
        </c:choose>
        <div class="notice_top">
            <a href="#index_notice_content_0" class="item ${classname0}">网站公告</a>
            <a href="#index_notice_content_1" class="item ${classname1}">档口通知</a>
        </div>
        <div id="index_notice_content_0" class="notice_list ${classname0}">
            <c:forEach items="${bulletinList0}" var="item">

                <a href="${item.href_url}" target="_blank" class="item red_${item.red}" title="${item.title}" vda="link|notice">${item.title}
                </a>
            </c:forEach>
        </div>
        <div id="index_notice_content_1" class="notice_list ${classname1}">
            <c:forEach items="${bulletinList1}" var="item">
                <a href="${item.href_url}" target="_blank" class="item red_${item.red}" title="${item.title}" vda="link|notice">${item.title}
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<div class="index_ban_below clearfix">
    <div class="index_left">
        <div class="index_markets">
            <div class="title">市场</div>
            <div class="index_markets_list">
                <c:forEach items="${marketNaviList}" var="item">
                    <a href="/shops/${item.bid}" class="item" vda="link|shops">${item.name}</a>
                </c:forEach>
            </div>

            <span class="more_items">
                <span class="text text_more">更多市场 <i class="more_grey"></i></span>
                <span class="text text_fold">收起市场 <i class="more_grey"></i></span>
            </span>
        </div>
        <div class="index_shops_ad">
            <c:set var="hotAdvsLength" value="${fn:length(recommend_shops)}"></c:set>
            <c:if test="${hotAdvsLength > 1}">
            <div class="silder-btn prev"><i class="ico"></i></div>
            <div class="silder-btn next"><i class="ico"></i></div>
            </c:if>
            <div class="bd">
                <div class="index_hot_adv_list">
                <c:forEach items="${recommend_shops}" var="itemShop">
                    <div class="index_hot_cell">
                    <c:forEach items="${itemShop.items}" var="item" varStatus="stats">
                        <a href="${item.href_url}" class="<c:if test='${stats.index % 5 != 3 && stats.index % 5 != 4}'>index_hot_split_s</c:if><c:if test='${stats.index % 5 == 3 || stats.index % 5 == 4}'> index_hot_split_b</c:if><c:if test='${stats.index % 5==0}'> index_hot_split_first</c:if>" vda="tp|hottoday|${item.item_id}|0|0|${stats.count}" id="${item.id}" shop-id="${item.shop_id}" target="_blank">
                        <img src="${item.img_url}"/>
                        </a>
                    </c:forEach>
                    </div>
                </c:forEach>
                </div>
                <c:if test='1!=0'>
                <div class="ulWrap">
                    <c:forEach items="${shop_hots}" var="item" varStatus="stats">
                        <c:if test="${stats.index%2 eq 0}">
                            <ul>
                        </c:if>
                        <li class="item">
                            <a href="${item.href_url}" vda="tp|recommendshop|0|${item.shop_id}|0|${stats.count}"
                               class="j-vda<c:if test='${stats.index > 5}'> ishide</c:if>"  target="_blank">
                                <img src="${item.img_url}"/>
                            </a>
                        </li>
                        <c:if test="${stats.index%2 eq 1}">
                            </ul>
                        </c:if>
                    </c:forEach>
                </div>
                </c:if>
            </div>
        </div>
    </div>
    <c:if test='1!=0'>
    <div class="index_hot_sale">
        <div class="title">
            <div class="mini-page fr page-box"></div>
            今日热卖
        </div>
        <c:set var="hotLength" value="${fn:length(hot_todays)}"></c:set>
        <div class="index_hot_sale_list">
            <c:forEach items="${hot_todays}" var="item" varStatus="stats">
                <c:if test='${stats.index % 3==0}'>
                <div class='data-split <c:if test="${stats.index==0}">showed</c:if>'<c:if test="${stats.index!=0}"> style="display:none"</c:if>>
                </c:if>
                    <a href="${item.href_url}" class="item j-vda <c:if test='${stats.index >= 3}'>ishide</c:if>" vda="tp|hottoday|${item.item_id}|0|0|${stats.count}"
                        id="${item.id}" shop-id="${item.shop_id}" target="_blank">
                        <img src="${item.img_url}"/>
                    </a>
                <c:if test='${stats.index % 3==2 || stats.count == hotLength}'>
                </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
    </c:if>
</div>

<!--通栏 banner-->
<div class="index_ad_60">

    <a href="${gBanner.href_url}" class="item j-vda" vda="tp|middlebanner|0|0|0|0" title="${gBanner.tips_title}"
       target="_blank">
        <img src="${gBanner.img_url}"/>
    </a>
</div>


<div class="hot_shops">
    <div class="title">
        <div class="mini-page fr page-box"></div>
        实力档口
    </div>
    <c:set var="goodShopLength" value="${fn:length(good_shops)}"></c:set>
    <c:forEach items="${good_shops}" var="shop" varStatus="stats">
    <c:if test='${stats.index % 5==0}'>
        <div class='data-split <c:if test="${stats.index==0}">showed</c:if>'<c:if test="${stats.index!=0}"> style="display:none"</c:if>>
        <div class="hot_shops_tabs">
    </c:if>
            <c:choose>
                <c:when test="${stats.index==0 || stats.index % 5 == 0}">
                    <c:set var="classname" value="selected"/>
                </c:when>
                <c:otherwise>
                    <c:set var="classname" value=""/>
                </c:otherwise>
            </c:choose>
            <div class="item_box">
                <a href="#hot_shops_list_${stats.index}" class="item ${classname} tab_item">
                    ${shop.shop_name}
                    <span class="tab_item_bg"></span>
                </a>
            </div>
            <div id="hot_shops_list_${stats.index}" class="hot_shops_list ${classname} ">
                <c:forEach items="${shop.items}" var="item" varStatus="itemStats">
                    <c:choose>
                        <c:when test="${item.type==1}">
                            <a target="_blank" href="/shop/${item.shop_id}"
                               vda="tp|sldkcard|0|${item.shop_id}|0|${itemStats.count}" class="item item_shop j-vda <c:if test='${stats.index>4}'>ishide</c:if>" id="${item.id}" shop-id="${item.shop_id}">
                                <img src="${item.img_url}<c:if test="${fn:contains(item.img_url, '.jpg@')}">|260w_390h</c:if>" alt="">
                                <div class="info">
                                    <div class="info_bg"></div>
                                    <div class="desc">${fn:substring(item.shop_remark, 0, 12)}</div>
                                    <div class="position">${item.marketName} ${item.position}</div>
                                    <div class="link" title="${item.tips_title}">
                                        <div class="link_bg"></div>
                                        进入档口
                                    </div>
                                </div>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${item.href_url}" class="item j-vda <c:if test='${stats.index>4}'>ishide</c:if>"
                               vda="tp|sldkcard|${item.item_id}|${item.shop_id}|0|${itemStats.count}"
                                id="${item.id}" shop-id="${item.shop_id}" target="_blank">
                                <img src="${item.img_url}<c:if test="${fn:contains(item.img_url, '.jpg@')}">|260w_390h</c:if>" alt="">
                                <span class="info">
                                    <span class="info_bg"></span>
                                    <c:choose>
                                        <c:when test="${item.price_type eq 1}">
                                            <span class="price"><span class="yuan">¥</span>${item.discount_price}</span>
                                        </c:when>
                                        <c:when test="${item.price_type eq 2}">
                                            <span class="price"><span class="yuan">¥</span>${item.discount_price}</span>
                                        </c:when>
                                        <c:otherwise>
                                          <span class="price_error">价格错误</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                </c:forEach>
            </div>
    <c:if test='${stats.index % 5==4 || stats.count == goodShopLength}'>
        </div></div>
    </c:if>
    </c:forEach>
</div>

<div class="hot_goods imgs_slide ">
    <div class="title">
        <div class="mini-page fr page-box"></div>
        热门商品
    </div>
    <div class="hot_goods_list">
        <c:set var="hotItemsLength" value="${fn:length(hot_items)}"></c:set>
        <c:forEach items="${hot_items}" var="item" varStatus="state">
            <c:if test='${state.index % 10==0}'>
            <div class='data-split <c:if test="${state.index==0}">showed</c:if>'<c:if test="${state.index!=0}"> style="display:none"</c:if>>
            </c:if>

            <div class="item" id="${item.id}" shop-id="${item.shop_id}">
                <div href="${item.href_url}" class="img_box">
                    <span class="bd">
                        <c:forEach items="${item.img_url}" var="img_url" varStatus="states">
                            <c:if test="${states.index==0}">
                                <c:set var="firsrclass" value="first j-vda"/>
                            </c:if>
                            <c:if test="${states.index!=0}">
                                <c:set var="firsrclass" value=""/>
                            </c:if>
                            <a href="${item.href_url}" class="li ${firsrclass} <c:if test='${state.index>9}'>ishide</c:if>" vda="tp|hotcard|${item.item_id}|${item.shop_id}|0|${state.count}" target="_blank">
                                <img src="${img_url}<c:if test="${fn:contains(img_url, '.jpg@')}">|260w_390h</c:if>" class="img" alt="" />
                            </a>
                        </c:forEach>
                    </span>
                </div>
                <p class="info">
                    <c:choose>
                        <c:when test="${item.price_type eq 1}">
                            <span class="price"><span class="yuan">¥</span> ${item.discount_price}</span>
                        </c:when>
                        <c:when test="${item.price_type eq 2}">
                            <span class="price"><span class="yuan">¥</span> ${item.discount_price}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="price_error">价格错误</span>
                        </c:otherwise>
                    </c:choose>

                    <a href="/shop/${item.shop_id}" vda="dkmc|hotcard|0|${item.shop_id}|0|${state.count}" target="_blank" class="name" title="${item.shop_name}">
                       <c:if test="${item.is_gold_shop == 1}">
                       <img src="${staticDomain}/dist/css/img/common/gold.png" aglin="absmiddle" width="19">
                       </c:if>
                        ${item.shop_name}
                    </a>
                </p>
            </div>

             <c:if test='${state.index % 10==9 || state.count == hotItemsLength}'>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>
<div class="index_shops imgs_slide ">
    <div class="title">
        <div class="mini-page fr page-box"></div>
        精选店铺
    </div>

    <div class="index_shops_list ">
        <c:forEach items="${shop_vvips}" var="item"  begin="0" end="11" varStatus="state1">
            <div class="item" id="${item.id}" shop-id="${item.shop_id}">
                <div class="img_box">
                    <div class="bd">
                        <c:forEach items="${item.img_url}" var="img_url" varStatus="state">
                            <c:if test="${state.index==0 && state1.index % 12==0}">
                                <c:set var="firsrclass" value="first j-vda"/>
                            </c:if>
                            <c:if test="${state.index!=0}">
                                <c:set var="firsrclass" value=""/>
                            </c:if>
                            <a href="${item.href_url}" class=" noslide li ${firsrclass} <c:if test='${state1.index>11}'>ishide</c:if>" target="_blank" vda="tp|jxdpcard|0|${item.shop_id}|0|${state1.count}">
                                <img src="${img_url}" alt="">
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<div class="floor_list">
    <c:forEach items="${homeFloorAdList}" var="floor" varStatus="state">
        <div class="floor_item">
            <div class="title clearfix">
                <img class="title-number" src="${staticDomain}/dist/css/img/common/floor${state.count}.png" alt="">

                <span>${floor.floorTitle}</span>
            </div>

            <div class="floor_goods ">

                <c:forEach items="${floor.itemsList}" var="item" varStatus="itemState">

                    <c:choose>

                        <c:when test="${item.type==1}">
                            <!--档口-->
                            <a href="${item.href_url}" class="item item_shop j-vda"
                               vda="tp|mixcard|0|${item.shop_id}|${floor.floor}|${itemState.count}"
                                target="_blank">
                                <img data-original="${item.img_url}" src="" alt="" class="lazy">
                                <div class="info">
                                    <div class="info_bg"></div>
                                    <div class="name_shop">${item.shop_name}</div>
                                    <div class="desc">${item.shop_remark}</div>
                                    <div class="pos">
                                        <div class="pos_bg"></div>
                                        ${item.marketName} ${item.position}
                                    </div>
                                </div>
                            </a>
                        </c:when>

                        <c:otherwise>
                            <!--商品-->
                            <div class="item">
                                <a href="${item.href_url}"
                                   vda="tp|mixcard|${item.item_id}|0|${floor.floor}|${itemState.count}"
                                   class="j-vda"  target="_blank">
                                    <img data-original="${item.img_url}<c:if test="${fn:contains(item.img_url, '.jpg@')}">|260w_390h</c:if>" src="" alt="" class="lazy">
                                </a>
                                <p class="info">
                                    <c:choose>
                                        <c:when test="${item.price_type eq 1}">
                                            <span class="price"><span class="yuan">¥</span> ${item.discount_price}</span>
                                        </c:when>
                                        <c:when test="${item.price_type eq 2}">
                                            <span class="price"><span class="yuan">¥</span> ${item.discount_price}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="price_error">价格错误</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <a href="/shop/${item.shop_id}" target="_blank" vda="dkmc|mixcard|0|${item.shop_id}|${floor.floor}|${itemState.count}" class="name j-vda">
                                        <c:if test="${item.is_gold_shop == 1}">
                                        <img src="${staticDomain}/dist/css/img/common/gold.png" aglin="absmiddle" width="19">
                                        </c:if>
                                        ${item.shop_name}
                                    </a>
                                </p>

                            </div>

                        </c:otherwise>
                    </c:choose>

                </c:forEach>

            </div>

        </div>
        <div class="floor_apart">
            <c:forEach items="${floor.middleList}" var="item" varStatus="midState" begin="0" end="2">
                <a href="${item.href_url}" class="item j-vda" target="_blank"
                   vda="tp|mixcard|0|${item.item_id}|${floor.floor}|${midState.count + 10}"
                   >
                    <img data-original="${item.img_url}" src="" alt="" class="lazy">
                </a>
            </c:forEach>
        </div>

    </c:forEach>

</div>

<div class="banner_120">
    <a href="/tools.html" class="j-vda" vda="tp|brands|0|0|0|0" target="_blank">
        <img data-original="${staticDomain}/dist/css/img/common/banner_1920_120.jpg" class="lazy" src="" alt="">
    </a>
</div>

<div class="help2_wrap">
    <div class="help2" >
        <div class="help_row" id="helpList"></div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>
<script>
    var HOTITEMS = ${hot_items_var};
    var SHOPVIPS = ${shop_vvips_var};
</script>
<jsp:
</body></html>
