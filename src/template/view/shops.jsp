<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="markets3"/>
    <jsp:param name="cssHash" value="${cssHash.markets3}"/>
    <jsp:param name="title" value="${market_name} -"/>
    <jsp:param name="keywords" value="${market_name},VVIC 搜款网"/>
    <jsp:param name="desc" value="${market_name}，是 VVIC 搜款网收录的批发市场，共找到 ${recordCount} 个档口。VVIC 搜款网是广州最大的网批平台，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="currentNav" value="2"/>
</jsp:include>
<style type="text/css">
    body {
        background-color:#fff;
    }
    .body_markets3  .fixed_bar_bg,.body_markets3 .fixed_bar .item {
        background-color:#f5f5f5;
    }

</style>
<div class="w clearfix">
    <div class="mk-left mt10 fl">
        <div class="mk-intro fl">
            <div class="mk-logo">
                <img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(${bid}).jpg" width="140" alt="">
            </div>
            <div class="mk-info">
                <div class="mk-num fr">
                    ${recordCount} 个档口
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <div id="floorNav">
            <c:if test='${floor_amount > 1}'>
                <div class="mk-floor mt10 fl">
                    <ul class='clearfix <c:if test='${floor_amount > 8}'>two</c:if>'>
                    <c:forEach items="${topFloorList}" var="floor" varStatus="stats">
                        <li data-id="${stats.index}"
                            class="col${stats.count % 2}<c:if test='${floor_amount == stats.count || floor_amount > 8 && stats.count % 2 == 1 && floor_amount-stats.count == 1}'> last</c:if>" vda="action|quicknav|floornav">
                            <span>
                                <c:choose>
                                    <c:when test="${floor.is_market == 1}">
                                        ${floor.subName}
                                    </c:when>
                                    <c:otherwise>
                                        ${floor.floor}楼${floor.subarea}
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </li>
                    </c:forEach>
                    </ul>

                </div>
            </c:if>
            <div class="clear"></div>
            <div class="mk-recommend mt10">
                <c:forEach items="${side_ads}" var="side" varStatus="status">
                    <a href="${side.href_url}" vda="link|marketcard|${side.id}" class="j-vda ishide" style="display:none" target="_blank">
                        <img src="${side.img_url}" width="168" height="252" alt="">
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>

    <c:if test="${fn:length(coverList) > 0}">
        <div class="mk-cover mt10 fr">
            <div class="mk-slide">
                <c:if test="${fn:length(coverList) > 1}">
                    <div class="silder-btn next"><i></i></div>
                    <div class="silder-btn prev"><i></i></div>
                </c:if>
                <div class="bd" style="visibility: hidden;">
                    <ul>
                        <c:forEach items="${coverList}" var="cover" varStatus="stats">
                            <li>
                                <c:choose>
                                    <c:when test="${cover.href_url =='' || cover.href_url=='#'}">
                                        <a class="j-vda<c:if test="${stats.index != 0}"> ishide</c:if>" vda="tp|shopsbanner|0|0|0|${stats.count}">
                                        <img src="${cover.img_url}" alt="${cover.tips_title}"/>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="j-vda<c:if test="${stats.index != 0}"> ishide</c:if>" href="${cover.href_url}" target="_blank" title="${cover.tips_title}" vda="tp|shopsbanner|0|0|0|${stats.count}">
                                            <img src="${cover.img_url}" alt="${cover.tips_title}"/>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </c:forEach>

                    </ul>
                </div>

            </div>

        </div>
    </c:if>


    <div class="mk-shops mt10 fr">
        <c:forEach items="${floorList}" var="floor" varStatus="stats">
            <dl class="stall-table" data-id="${stats.index}" data-index="${stats.index}">
                <dt>
                <h2>
                    <c:choose>
                        <c:when test="${floor.is_market == 1}">
                            ${floor.subName}
                        </c:when>
                        <c:otherwise>
                            ${floor.floor}楼${floor.subarea}
                        </c:otherwise>
                    </c:choose>
                </h2>
                </dt>
                <dd>
                    <ul class="floor-item-${stats.index} clearfix">
                        <c:forEach items="${floor.recordList}" var="stall" varStatus="stallStats">
                            <li
                            <c:if test='${stall.count % 6 eq 0}'>class="last"</c:if>
                            >
                            <a class="items <c:if test='${stall.is_gold_shop==1}'>items-gold</c:if>" href="/shop/${stall.id}"  target="_blank" data-title="${stall.name}" data-auth="${stall.authenticated}" data-id="${stall.id}" data-ww="${stall.ww_nickname}" data-wwen="${stall.ww_nickname_code}" data-pos="${stall.marketName} ${stall.floor}楼 ${stall.position}" data-tel="${stall.telephone}" data-qq="${stall.qq}" data-wachat="${stall.wchat}" data-years="${stall.years}" data-cu="${stall.cloud_update}" data-sbd="${stall.start_business_date}" vda="link|content" data-source="${stall.province_name} ${stall.city_name}" data-gold="${stall.is_gold_shop}">
                                <span class="stall-no">${stall.position}</span>
                                <span class="stall-name">
                                    ${stall.name}
                                    <c:if test="${stall.is_gold_shop == 1}">
                                    <i class="vvicon">&#xe62f;</i>
                                    </c:if>
                                </span>
                                <div class="more-tip">
                                    <div class="p-article-table"></div>
                                    <div class="jt"></div>
                                </div>
                            </a>
                            </li>
                        </c:forEach>
                    </ul>
                    <div class="clear"></div>
                </dd>
            </dl>
        </c:forEach>
    </div>
</div>

<script type="text/x-handlebars-template" id="tpl">
    <div class="shop-info">
        <div class="shop-content">
            <h2 class="shop-name">
                {{=shop.title}}
                {{ if(shop.gold == 1){ }}
                <img src="${staticDomain}/statics/v2/css/img/common/gold.png" aglin="absmiddle" width="19" style="vertical-align: middle;">
                {{ } }}
            </h2>
            {{ if(shop.auth==1 || shop.years > 1 || shop.cloud_update==1){ }}
            <div class="shop-icon">
                {{ if(shop.auth==1){ }}
                <i class="cert j-v-tip" data-tip="cert"></i>
                {{ } }}
                {{ if(shop.cloud_update==1){ }}
                <i class="miao j-v-tip" data-tip="miao"></i>
                {{ } }}
                {{ if(shop.years>1){ }}
                <i class="shop-year-icon year{{=shop.years}} j-v-tip" data-date="{{=shop.start_business_date}}" data-tip="year"></i>
                {{ } }}
            </div>
            {{ } }}
            <ul>
                <li>
                    <div class="attr">旺旺：</div>
                    <div class="text">
                        <a vda="action|shopcard|ww" href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid={{=shop.wwen}}" target="_blank" title="CherryAka" class="kf" vda="action|shopinfo|ww">{{=shop.ww}}<img class="" src="/api/online?nickname={{=shop.wwEncode}}"></a>
                    </div>
                </li>
                <li>
                    <div class="attr" style="line-height: 28px;">地址：</div>
                    <div class="text">
                        {{=shop.pos}}
                        <a href="http://www1.vvic.com/map.html" target="_blank"><em class="guide vvicon">&#xe62c;</em></a>
                    </div>
                </li>
                <li>
                    <div class="attr">产地：</div>
                    <div class="text">{{=shop.source}}</div>
                </li>
                <li class="tel-list">
                    <div class="attr">电话：</div>
                    <div class="text">
                        {{ _.each(shop.tel, function(el){ }}
                        <p>{{=el}}</p>
                        {{ }) }}
                    </div>
                </li>
                {{ if(shop.wchat!=''){ }}
                <li>
                    <div class="attr">微信：</div>
                    <div class="text">{{=shop.wchat}}</div>
                </li>
                {{ } }}
                {{ if(shop.qq!=''){ }}
                <li>
                    <div class="attr">QQ：</div>
                    <div class="text">{{=shop.qq}}</div>
                </li>
                {{ } }}
            </ul>
            <div class="clear"></div>
            <div class="btns clearfix">
                <a href="/shop/{{=shop.shopid}}" target="_blank" class="btn-default fl enter" vda="action|shopcard|dkmc">进入档口
                </a>
                <a href="javascript:;" class="btn-default fr btn_care_shop" data-id="{{=shop.shopid}}" vda="action|shopcard|gz">关注档口
                </a>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</script>

<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>
<script>
    var FIXEDAMOUNT = parseInt('${fixed_amount}');

    require(['markets3/shops3'], {});
</script>
<%@ include file="common/third.jsp"%>
</body>
</html>
