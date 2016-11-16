<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="headerName" value="shop"/>
    <jsp:param name="hideNav" value="1"/>
    <jsp:param name="cssName" value="item3.css"/>
    <jsp:param name="title" value="${item.title} - 商品详情 -"/>
    <jsp:param name="keywords" value="${item.title},${shop.tcname},${shop.pname},${shop.marketName},${shop.name},VVIC 搜款网"/>
    <jsp:param name="desc" value="${item.title}，由 ${shop.marketName} ${shop.name} 档口发布在 VVIC 搜款网，属于 ${shop.pname} ${shop.tcname}类目。VVIC 搜款网是广州最大的网批平台，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。
"/>
    <jsp:param name="fixdHeaderClassName" value=""/>

</jsp:include>
<div class="w clearfix">
    <div class="fl item-left mt10">

        <div class="product-intro <c:if test="${item.status eq 0}">sold-out</c:if>">
            <div class="name">
                <a href="https://item.taobao.com/item.htm?id=${item.tid}" vda="link|itemdetail|tblink" target="_blank" class="tb">淘宝链接</a>
                <h1>${item.title}</h1>
            </div>
            <!--banner 活动商品 is_active == 1-->
    <!--临时banner-->
                <c:choose>
                    <c:when test="${item.status != 0 && item.is_active eq 1}">
                    <div class="price-banner">
                        <a href="http://www1.vvic.com/11df.html" target="_blank"><img src="${staticDomain}/statics/v2/css/img/detail-active-banner-1.png" style="display:block;"></a>
                    </div>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${item.status != 0 && item.support_cart==1 && price_type < 3}">
                            <c:if test="${item.art_no!='' && item.is_pre_sell !=1}">
                            <div class="price-banner">
                                <a href="http://www1.vvic.com/pgjieshao1.html" target="_blank"><img src="${staticDomain}/statics/v2/css/img/detail-ative-banner-2.png" style="display:block;"></a>
                            </div>
                            </c:if>
                        </c:if>
                    </c:otherwise>
                </c:choose>

            <div class="price-time-buyer">
            <!--
                <c:choose>
                    <c:when test="${item.is_active eq 1}">
                        <c:set var="active_class_name" value="d-price"/>
                        <c:set var="discount_class_name" value=""/>

                        <div class="v-price ${active_class_name}">
                            <div class="p-name" style="color:#333">活动价</div>
                            <div class="p-value">
                                <span class="yuan" style="vertical-align: bottom;">¥</span>
                                <span class="sale vam">${item.active_price}</span>

                                <i class="ico_item_active vam"></i>
                            </div>
                            <div class="clear"></div>
                        </div>

                    </c:when>
                    <c:otherwise>
                        <c:set var="discount_class_name" value="d-price"/>
                    </c:otherwise>
                </c:choose>
                -->
                <c:set var="discount_class_name" value="d-price"/>
                <div class="v-price ${discount_class_name}">
                    <div class="p-name">批发价</div>
                    <div class="p-value">
                        <c:choose>
                            <c:when test="${price_type eq 1}">
                                <span class="fl">
                                    <strong class="yuan">¥</strong>
                                    <strong class="sale">${item.discount_price}</strong>
                                </span>
                                <c:if test="${item.is_active == 1}">
                                <span class="active-money-tip"><i></i>搜款网下单立减<b><fmt:formatNumber type="number" value="${item.discount_price - item.active_price}" pattern="0" maxFractionDigits="0"/></b>元</span>
                                </c:if>
                            </c:when>
                            <c:when test="${price_type eq 2}">
                                <strong class="yuan">¥</strong>
                                <strong class="sale">${rang_price}</strong>
                            </c:when>
                            <c:otherwise>
                                <strong class="yuan" style="display: none;">¥</strong><strong class="sale" style="color: #9c9c9c;">档口设置错误</strong>

                                <a class="error_link" target="_blank" href="http://www1.vvic.com/jgcw.html" style="font-size: 12px;color: #999;margin-left: 5px;" vda="link|itemdetail">查看原因</a>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${item.is_pre_sell==1}">
                                <i class="type-tip">预售商品无法下单</i>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${item.is_special_offer==1}">
                                    <i class="type-tip">特价商品不退不换</i>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                        <!--销售量sales-->
                        <div class="v-sale-num">
                            <p class="v-sale-total">${item.sales}</p>
                            <p class="v-sale-title">
                                代发销量
                                <span class="v-sale-tip"><i></i>累计通过搜款网代发的商品件数，<br/>不包含其他渠道的数据</span>
                            </p>

                        </div>
                    </div>
                    <div class="clear"></div>
                </div>


                <div class="v-price">
                    <div class="p-name">淘宝价</div>
                    <div class="p-value">
                        <span class="yuan">¥</span>
                        <span class="sale">${item.price}</span>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>

            <dl class="summary clearfix">
                <dd>
                    <div class="name">货号</div>
                    <div class="value ff-arial">
                        <c:choose>
                            <c:when test="${item.art_no!=''}">
                                ${item.art_no}#
                            </c:when>
                            <c:otherwise>
                                档口未提供
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="clear"></div>
                </dd>
                <dd>
                    <div class="name">上新时间</div>
                    <div class="value  ff-arial">
                        ${item.up_time}
                    </div>
                </dd>
            </dl>
            <dl class="summary v-sku clearfix" id="j-buy">
                <div class="close j-buy vvicon" id="j-buy-close">&#xe60a;</div>
                <c:if test="${fn:length(item.size)>0}">
                    <dd class="fl choice">
                        <div class="name">尺码</div>
                        <div class="value goods-choice">
                            <ul>
                            <c:set var="sizeArray" value="${fn:split(item.size, ',')}"></c:set>
                            <c:set var="sizeLength" value="${fn:length(sizeArray)}"></c:set>
                            <c:forEach items="${item.size}" var="el">
                                <li class='selectSize' data-size="${el}">
                                <a href="javascript:;">${el}</a>
                                </li>
                            </c:forEach>
                            </ul>
                            <div class="clear"></div>
                        </div>
                    </dd>
                </c:if>
                <dd class="fl choice">
                    <c:set var="colorArray" value="${fn:split(item.color, ',')}"></c:set>
                    <c:set var="colorLength" value="${fn:length(colorArray)}"></c:set>
                    <c:choose>
                        <c:when test="${fn:length(item.color_pics)>0}">
                            <div class="name color" style="margin-top:15px;">颜色</div>
                            <div class="value color-choice">
                                <ul class="clearfix">
                                <c:forEach items="${item.color_pics}" var="el" varStatus="status">
                                    <li class='selectColorPic selectColor' data-index="${status.index}">
                                    <a>
                                        <c:if test="${fn:length(el)>0}">
                                            <img src="${el}_40x40.jpg"/>
                                        </c:if>
                                    </a>
                                    </li>
                                </c:forEach>
                                </ul>
                                <div class="clear"></div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${fn:length(item.color)>0}">
                            <div class="name">颜色</div>
                            <div class="value goods-choice">
                                <ul>
                                <c:forEach items="${item.color}" var="el">
                                    <li class='selectColor' data-color="${el}">
                                        <a href="javascript:;">${el}</a>
                                    </li>
                                </c:forEach>
                                </ul>
                            </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </dd>
                <c:if test="${item.support_cart == 1 && item.status == 1}">
                <dd class="fl amount j-parts">
                    <div class="name">数量</div>
                    <div class="value amount-stock">
                        <span class="stock" id="J_Stock">
                            <a href="javascript:void(0);" title="减1" hidefocus="" class="v-reduce vvicon v-disable-reduce">&#xe61e;</a>
                            <input id="j_iptAmount" type="text" value="1" maxlength="3" title="请输入购买量">
                            <a href="javascript:void(0);" hidefocus="" class="v-increase vvicon" title="加1">&#xe61b;</a>
                            <a href="http://www1.vvic.com/invertory_status.html" target="_blank" class="stock-tips j-stock-less" style="display:none;" data-tip="">库存紧张</a>
                        </span>
                    </div>
                </dd>
                <dd class="fl parts j-parts">
                    <div class="name">配件</div>
                    <div class="value parts-ck">
                        <i>
                            <span class="vvicon j-ckb-0">&#xe628;</span>
                            <span class="vvicon j-ckb-1">&#xe627;</span>
                        </i>
                        <div class="parts-text">有</div>
                    </div>
                </dd>
                </c:if>
                <dd class="fl j-buy" style="margin-top:20px">
                    <div class="name">&nbsp;</div>
                    <div class="value">
                        <div class='btn-buy j-btn-confirm <c:if test="${item.color!='' || item.size!=''}">btn-disable-buy</c:if>' vda="action|itemdetail|addconfirm">确认</div>
                    </div>
                </dd>
            </dl>
            <c:choose>
                <c:when test="${item.status eq 0}">
                    <div class="sold-info">此商品已于 ${item.expired_time} 下架</div>
                </c:when>
                <c:otherwise>
                    <div class="buy-tips j-unbuy j-buy-tips">
                        <c:if test="${item.support_cart==1 && price_type < 3}">
                        <span>
                            <c:choose>
                                <c:when test="${item.is_pre_sell==1}">
                                    档口预售的商品，无法下单购买
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${item.art_no==''}">
                                            档口未提供货号的商品无法下单
                                        </c:when>

                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </span>
                        </c:if>
                    </div>
                    <div class="btns j-unbuy clearfix">
                        <div class="buy-guild" style="display:none;"></div>
                        <c:if test="${item.support_cart==1 && price_type < 3}">
                            <c:choose>
                                <c:when test="${item.art_no=='' || item.is_pre_sell ==1}">
                                     <div class="btn btn-primary btn_add_cart btn_red j-vda ishide btn-disabled" vda="action|itemdetail|addcart">加入购物车</div>
                                </c:when>
                                <c:otherwise>
                                     <div class="btn btn-primary btn_add_cart btn_red j-vda ishide" vda="action|itemdetail|addcart">加入购物车</div>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <div class='btn btn_upload <c:if test="${item.support_cart!=1}">btn_red</c:if>' vda="action|itemdetail|yjsc">一键上传</div>
                    </div>
                </c:otherwise>
            </c:choose>
            <dl class="summary summary-service j-unbuy clearfix">
                <dd>
                    <div class="name">服务</div>
                    <div class="value">
                        <c:if test="${item.is_tx != 1 && item.is_sp != 1 && item.is_df != 1}">
                            无
                        </c:if>
                        <div class="service-icon">
                            <c:if test="${item.is_sp eq 1}">
                                <div data-title="实拍" class="s-item sp j-v-tip j-v-tip-item" data-tip="sp"><i></i>
                                    <span>实拍</span>
                                </div>
                            </c:if>
                            <c:if test="${item.is_tx eq 1}">
                                <div data-title="退现" class="s-item tx j-v-tip j-v-tip-item" data-tip="tx"><i></i>
                                    <span>退现</span>
                                </div>
                            </c:if>
                            <c:if test="${item.is_df eq 1}">
                                <div data-title="代发" class="s-item df j-v-tip j-v-tip-item" data-tip="df"><i></i>
                                    <span>代发</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </dd>
            </dl>
            <div class="preview">
                <div class="thumbnail">
                    <div class="tb-booth tb-pic tb-s400">
                        <c:forEach items="${item.imgs}" var="el" varStatus="status" begin="0" end="0">
                            <a href="${el}">
                                <img src="${el}_500x500.jpg" alt="" rel="${el}" class="jqzoom"/>
                            </a>
                        </c:forEach>

                        <ul id="thumblist" class="tb-thumb">
                            <c:forEach items="${item.imgs}" var="el" varStatus="status" begin="0" end="4">
                                <li class="<c:if test="${status.first == true}
                                ">tb-selected</c:if><c:if test="${status.last}"> last</c:if>
                                ">
                                    <div class="tb-pic tb-s60">
                                        <a href="javascript:;">
                                            <img src="${el}_60x60.jpg" mid="${el}_500x500.jpg" big="${el}"/>
                                        </a>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="links">
                    <c:if test="${item.status eq 1}">
                    <a id="dataBtn" class="cart btn_create_data" vda="link|itemdetail|sjb"><i class="vvicon">&#xe60c;</i>数据包</a>
                    <a id="dataBtn" class="cart btn_add_purchase" vda="link|itemdetail|nhd"><i class="vvicon">&#xe60b;</i>加入拿货单</a>
                    <a id="dataBtn" class="cart btn_collect_product" vda="action|itemdetail|sc"><i class="vvicon">&#xe61c;</i>收藏</a>
                    </c:if>
                   <a href="/samestyle/${item.id}" target="_blank" class="same" vda="link|itemdetail|ztk"><i class="vvicon">&#xe610;</i>找同款</a>
                </div>
            </div>
        </div>
        <div id="main-con" class="content-more mt20 clearfix">
            <c:if test="${fn:length(middle_ads)>0}">
            <div class="con-detail hot-recommend mt20">
                <h2 class="title">
                    <div class="mini-page fr page-box"></div>
                    人气商品
                </h2>
                <div class="con-list mid-list">
                    <c:set var="rqLength" value="${fn:length(middle_ads)}"></c:set>
                    <c:forEach items="${middle_ads}" var="shop" varStatus="status">
                        <div class='data-split <c:if test="${status.index==0}">showed</c:if>' <c:if test="${status.index!=0}"> style="display:none"</c:if>>
                            <span class="mid-list-name">
                                <a href="/shop/${shop.shop_id}" target="_blank">${shop.shop_name}</a>
                            </span>
                            <ul class="side-list clearfix">
                            <c:forEach items="${shop.items}" var="el">
                            <li class="small fl">
                                <div class="pic">
                                    <a href="${el.href_url}" title="${el.title}" target="_blank" class="ad_side_item j-vda <c:if test='${status.index>0}'>ishide</c:if>" vda="tp|hotitem|${el.item_id}|${el.shop_id}|0|${el.id}">
                                        <img src="${el.img_url}|220w_330h" width="166" />
                                    </a>
                                </div>
                                <div class="price">
                                    <span class="yuan">¥</span>${el.discount_price}
                                </div>
                            </li>
                            </c:forEach>
                            </ul>
                        </div>
                    </c:forEach>
                    <div class="clear"></div>
                </div>
            </div>
            </c:if>

            <div class="con-detail mt20">
                <div class="con-info">
                    <h2 class="title">商品详情</h2>
                    <div class="desc-attr clearfix">
                        <ul>
                            <c:forEach items="${item.attrs}" var="el">
                                <li title="${el}">
                                    ${el}
                                </li>
                            </c:forEach>

                        </ul>
                        <div class="clear"></div>
                    </div>
                    <c:choose>
                        <c:when test="${param.desc==1}">
                            <script>
                                _DESC = '${item.desc}';
                            </script>
                            <div class="desc-content j-desc">
                            </div>
                        </c:when>
                        <c:otherwise>
                            <script>
                                _DESC = '';
                            </script>
                            <div class="desc-content">
                                ${item.desc}
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    <div class="fr item-right mt10">
        <div class="shop-info <c:if test='${shop.is_gold_shop == 1}'>shop-gold</c:if>">
            <c:if test='${shop.is_gold_shop == 1}'>
            <img class="shop-gold-title" src="${staticDomain}/statics/v2/css/img/common/gold_shop.png" width="218">
            </c:if>
            <c:set var="classname" value=""/>
            <c:if test="${(shop.years <= 1 && shop.is_gold_shop == 0) || (shop.years > 1 && shop.is_gold_shop == 0)}">
               <c:set var="classname1" value="shop-content-top"/>
            </c:if>
            <c:if test="${shop.years > 1 && shop.is_gold_shop == 0}">
               <c:set var="classname2" value="mt15"/>
            </c:if>
            <div class="shop-content ${classname1}">
                <c:if test="${shop.years > 1}">
                <div class="shop-year j-v-tip ${classname2}" data-tip="year" data-date='${shop.start_business_date}'>
                    <i></i>
                    <span><em>${shop.years}</em> 年老店</span>
                </div>
                </c:if>
                <h2 class="shop-name">
                    ${shop.name}
                </h2>
                <c:if test="${shop.authenticated==1 || shop.cloud_update==1 || shop.top>0}">
                <div class="shop-icon">
                    <c:if test="${shop.authenticated==1}">
                        <i class="cert j-v-tip" data-tip="cert"></i>
                    </c:if>
                    <c:if test="${shop.cloud_update==1}"><i class="miao j-v-tip" data-tip="miao"></i></c:if>
                    <c:if test="${shop.top>0}">
                    <i class="top${shop.top} j-v-tip" data-top="${shop.top}" data-tip="top"></i>
                    </c:if>
                </div>
                </c:if>
                <ul class="mt10">
                    <c:if test="${shop.sid!=''}">
                        <li>
                            <div class="attr">旺旺：</div>
                            <div class="text">
                                <a href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid=${shop.ww_nickname_code}"
                                   target="_blank" title="${shop.name}" class="kf" vda="action|shopinfo|ww">
                                    ${shop.ww_nickname}
                                    <c:if test="${shop.ww_nickname_code!=''}">
                                        <img class="" src="/api/online?nickname=${shop.ww_nickname_code}"/>
                                    </c:if>
                                </a>
                            </div>
                        </li>
                    </c:if>
                    <li>
                        <div class="attr" style="line-height: 28px;">地址：</div>
                        <div class="text">
                            <span>${shop.marketName}&nbsp;</span>
                            <span>${shop.floor}楼&nbsp;</span>
                            <span>${shop.position}</span>
                            <a href="http://www1.vvic.com/map.html" target="_blank"><em class="guide vvicon">&#xe62c;</em></a>
                        </div>
                    </li>
                    <li>
                        <div class="attr">商品：</div>
                        <div class="text">${shop.total_items}&nbsp;件</div>
                    </li>
                    <li>
                        <div class="attr">产地：</div>
                        <div class="text">${shop.province_name} ${shop.city_name}</div>
                    </li>
                    <li class="tel-list">
                        <div class="attr">电话：</div>
                        <div class="text">
                            <c:forEach items="${shop.telephone}" var="tel">
                                <p>${tel}</p>
                            </c:forEach>
                        </div>
                    </li>
                    <c:if test="${shop.wechat!=''}">
                        <li>
                            <div class="attr">微信：</div>
                            <div class="text">${shop.wechat}</div>
                        </li>
                    </c:if>
                    <li>
                        <div class="attr">QQ：</div>
                        <div class="text">${shop.qq}</div>
                    </li>
                </ul>
                <div class="clear"></div>
                <div class="btns clearfix">
                    <a href="/shop/${shop.id}" target="_blank" class="btn-default fl enter" vda="action|shopinfo|dkmc">进入档口
                    </a>
                    <a href="javascript:;" class="btn-default fr btn_care_shop" data-shop-id="${shop.id}" vda="action|shopinfo|gz">关注档口
                    </a>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        <div class="side-list-box mt20">
            <h2> 推荐商品 </h2>
            <ul class="side-list">
                <c:forEach items="${ads}" var="el" varStatus="status">
                    <li class="clearfix" <c:if test="${status.index > 0}">style="display:none"</c:if>>
                        <a href="<c:if test="${fn:indexOf(el.url, 'http')==-1}">/</c:if>${el.url}" title="${el.title}" target="_blank" class="ad_side_item j-vda ishide" vda="tp|ad_itemcard|${el.item_id}|${el.shop_id}|0|${status.count}">
                            <div class="pic">
                                <img data-original="${el.index_img_url}|220w_330h" class="lazy" />
                            </div>
                        </a>
                        <c:if test="${el.hot == 1}">
                        <i class="isRecommd"></i>
                        </c:if>
                        <div class="price">
                            <span class="yuan">¥</span>${el.discount_price}
                        </div>
                        <i class="fl ico_item_active_${el.is_active} ico_item_active"></i>

                        <div class="pos">
                            <a target="_blank" vda="tp|ad_itemcard|0|${el.shop_id}|0|${status.count}" href="/shop/${el.shop_id}" title="${el.shop_name}">
                                <c:if test="${el.is_gold_shop == 1}">
                                <img src="${staticDomain}/statics/v2/css/img/common/gold.png" aglin="absmiddle" width="19">
                                </c:if>
                                ${el.shop_name}
                            </a>
                            <div class="more-info">
                                <div class="shop-pos fl">${el.sub_name} ${el.position}</div>
                                <div class="shop-ww fr">
                                    <a href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid=${shop.ww_nickname_code}" target="_blank" title="${shop.name}" class="kf"  vda="ww|ad_itemcard|0|0|0|${el.id}">
                                        <c:if test="${shop.ww_nickname_code!=''}">
                                            <img alt="${shop.ww_nickname_code}" class="" src="/api/online?nickname=${shop.ww_nickname_code}"/>
                                        </c:if>
                                    </a>
                                </div>
                                <div class="clear"></div>
                                <c:if test="${el.is_shop_auth == 1 || el.cloud_update == 1 || el.top > 0 || el.years > 1}">
                                    <div class="shop-icon fl clearfix">
                                        <c:if test="${el.is_shop_auth == 1}">
                                        <i class="cert j-v-tip" data-tip="cert"></i>
                                        </c:if>
                                        <c:if test="${el.cloud_update == 1}">
                                        <i class="miao j-v-tip" data-tip="miao"></i>
                                        </c:if>
                                        <c:if test="${el.top > 0}">
                                        <i class="top${el.top} j-v-tip" data-top="${el.top}" data-tip="top"></i>
                                        </c:if>
                                    </div>
                                    <c:if test="${el.years > 1}">
                                    <div class="shop-year-icon year${el.years} fr j-v-tip" data-tip="year" data-date="${el.start_business_date}"></div>
                                    </c:if>
                                    <div class="clear"></div>
                                </c:if>
                            </div>
                            <div class="triangle triangle-up1"></div>
                            <div class="triangle triangle-up2"></div>
                        </div>
                    </li>
                </c:forEach>

            </ul>
        </div>
    </div>

    <div class="clear"></div>
    <div class="hot_shops" style="height: 380px;padding-bottom:0;">
        <div class="title clearfix">
            <div class="mini-page fr page-box"></div>
            推荐档口
        </div>
        <c:forEach items="${good_shops}" var="shop" begin="0" end="9" varStatus="stats">
        <div class='data-split <c:if test="${stats.index==0}">showed</c:if>'<c:if test="${stats.index!=0}"> style="display:none"</c:if>>
            <div id="hot_shops_list_${stats.index}" class="hot_shops_list" style="top:0;display:block">
                <c:forEach items="${shop.items}" var="item" varStatus="itemStats">
                    <c:choose>
                        <c:when test="${item.type==1}">
                            <a target="_blank" href="/shop/${item.shop_id}"
                               vda="tp|recommendshop|0|${item.shop_id}|0|${itemStats.count}" class="item item_shop j-vda <c:if test='${stats.index>0}'>ishide</c:if>" id="${item.id}" shop-id="${item.shop_id}">
                                <img src="${item.img_url}|260w_390h" alt="">
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
                            <a href="${item.href_url}" class="item j-vda <c:if test='${stats.index>0}'>ishide</c:if>"
                               vda="tp|recommendshop|${item.item_id}|${item.shop_id}|0|${itemStats.count}"
                                id="${item.id}" shop-id="${item.shop_id}" target="_blank">
                                <img src="${item.img_url}|260w_390h" alt="">
                                <span class="info" style="text-align:center;">
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
        </div>
        </c:forEach>
    </div>

</div>
<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>
<script>
    _ITEMID = '${item.id}';
    _SOLDOUT = ${item.status} == 0;
    _TID = '${item.tid}';
    _DISCOUNTPRICE = '${item.discount_price}';
    _SIZE = '${item.size}';
    _COLOR = '${item.color}';
    _COLORPICS = '${item.color_pics}';
    _SKUMAP = '${skumap}';
    _SIZEID = '${item.size_id}';
    _COLORID = '${item.color_id}';
    _ARTNO = '${item.art_no}';
    _INDEXIMGURL = '${item.index_img_url}_500x500.jpg';
    _SUPPORT = '${item.support_cart}';
    _SHOPID = '${item.shop_id}';
    window.page = 'item';
    window.good_shops = '${good_shops_page_count}';
    require(['web3/item3'], function (item) {
        item.init();
    });
</script>
<jsp:include page="common/third.jsp"/></body></html>
