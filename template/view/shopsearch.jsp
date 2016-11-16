<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="common/header.jsp">
	<jsp:param name="cssName" value="shops3" />
	<jsp:param name="cssHash" value="${cssHash.shops3}" />
 	<jsp:param name="title" value="${param.searchKey} - 档口搜索 -" />
 	<jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网" />
 	<jsp:param name="description" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。" />
 	<jsp:param name="currentNav" value="2" />
</jsp:include>

<div class="w clearfix">
    <div class="breadcrumb clearfix">
        <span class="fr extra-info">
            <span>
                <c:if test="${page.recordCount eq 5000}">超过</c:if>
                <c:if test="${page.recordCount != 5000}">共</c:if>
            </span>
            <i class="totalAmount">${page.recordCount}</i>个相关档口
        </span>

        <span>
            <c:choose>
                <c:when test="${param.bid>0}">
                    ${market_name}
                </c:when>
                <c:otherwise>
                    所有市场
                </c:otherwise>
            </c:choose>
        </span>

    </div>
    <div class="screen">
        <div class="nav-category clearfix<c:if test="${topFloorListSize eq 0}"> last</c:if> nav-market">
            <div class="nc-key">市场：</div>
            <div class="nc-value">
                <div id="listMarket" class='types <c:if test="${bid>0}">show-more</c:if>'>
                    <a href="/shopsearch.html<c:if test="${searchKey != ''}">?searchKey=${searchKey}</c:if>" class="h-item bid" vda="link|fliter">全部</a>
                    <c:forEach items="${marketList}" var="market" varStatus="stats">
                        <a href="/shopsearch.html?bid=${market.bid}<c:if test="${searchKey != ''}">&searchKey=${searchKey}</c:if>" class='h-item bid bid_${market.bid} <c:if test="${market.bid == bid}">selected</c:if>' data-b="${market.bid}" title="${market.name}" vda="link|fliter">${market.name}</a>
                    </c:forEach>
                </div>
                <div class='more <c:if test="${bid==0}">open</c:if><c:if test="${bid!=0}">close</c:if>' style="display:block">
                    <span><c:if test="${bid==0}">更多</c:if><c:if test="${bid>0}">收起</c:if></span>
                    <i></i>
                </div>
            </div>
        </div>
        <c:if test="${topFloorListSize > 0}">
        <div class="nav-category last clearfix nav-floor">
            <div class="nc-key">楼层：</div>
            <div class="nc-value">
                <div id="listFloor" class="types <c:if test="${floor>0}">show-more</c:if>">
                     <a href="/shopsearch.html?bid=${bid}<c:if test="${searchKey != ''}">&searchKey=${searchKey}</c:if>" class="h-item floor" vda="link|fliter">全部</a>
                     <c:forEach items="${topFloorList}" var="floors" varStatus="stats">
                         <a vda="link|fliter" href="/shopsearch.html?bid=${bid}&floor=${floors.floor}<c:if test="${floors.subarea != ''}">&subarea=${floors.subarea}</c:if><c:if test="${floors.is_market eq 1}">&subBid=${floors.subBid}</c:if><c:if test="${searchKey != ''}">&searchKey=${searchKey}</c:if>" data-f="${floors.floor}" class='h-item floor floor_${floors.floor} <c:if test="${floor eq floors.floor && subarea eq floors.subarea && subBid eq floors.subBid}">selected</c:if>'>
                             <c:choose>
                                 <c:when test="${floors.is_market == 1}">
                                     ${floors.subName}
                                 </c:when>
                                 <c:otherwise>
                                     ${floors.floor}楼${floors.subarea}
                                 </c:otherwise>
                             </c:choose>
                         </a>
                     </c:forEach>
                </div>
                <div class='more <c:if test="${floor==0}">open</c:if><c:if test="${floor!=0}">close1</c:if>' <c:if test="${floor!=0}">style="display:block"</c:if>>
                    <span><c:if test="${floor==0}">更多</c:if><c:if test="${floor>0}">收起</c:if></span>
                    <i></i>
                </div>
            </div>
        </div>
        </c:if>
    </div>
</div>
<div id="stallContent" class="w clearfix">
    <dl class="stall-dl mt10">
        <dt class="tline clearfix"><span class="cell name-cell">名称</span><span class="cell addr-cell">地址</span><span class="cell type-cell">主营</span><span class="cell contact-cell">旺旺号</span><span class="cell ctrl-cell">操作</span>
        </dt>
        <c:forEach items="${page.recordList}" var="stall">
            <dd class="dline clearfix">
                <span class="cell name-cell">
                    <a vda="link|content" class="items" href="/shop/${stall.id}"  target="_blank" data-title="${stall.name}" data-auth="${stall.authenticated}" data-id="${stall.id}" data-ww="${stall.ww_nickname}" data-wwen="${stall.ww_nickname_code}" data-pos="${stall.marketName} ${stall.floor}楼 ${stall.position}" data-tel="${stall.telephone}" data-qq="${stall.qq}" data-wachat="${stall.wchat}" data-years="${stall.years}" data-cu="${stall.cloud_update}" data-sbd="${stall.start_business_date}" data-source="${stall.province_name} ${stall.city_name}" data-gold="${stall.is_gold_shop}">
                        ${stall.name}
                        <div class="more-tip">
                            <div class="p-article-table"></div>
                            <div class="jt"></div>
                        </div>
                    </a>
                </span>
                <span class="cell addr-cell">
                    ${stall.marketName} ${stall.floor}楼 ${stall.position} </span>
                <span class="cell type-cell">${stall.shop_category}</span>
                <span class="cell contact-cell">${stall.ww_nickname}</span>
                <span class="cell ctrl-cell">
                    <a href="/shop/${stall.id}" vda="link|content" title="${stall.name}" class="link" target="_blank">进入档口</a>
                </span>
            </dd>
        </c:forEach>
    </dl>
    <c:if test="${page.recordCount != 0}">
    <div id="Pagination" class="pagination"><!-- 这里显示分页 --></div>
    </c:if>
    <c:if test="${page.recordCount eq 0}">
        <div class="empty-tip">
            <span class="vvicon">&#xe614;</span>
            <div class="text">没有找到相关档口。</div>
        </div>
    </c:if>
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
                        <a vda="action|shopcard|ww" href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid={{=shop.wwen}}" target="_blank" title="CherryAka" class="kf" vda="action|shopinfo|ww">{{=shop.ww}}<img class="" src="/api/online?nickname={{=shop.wwen}}"></a>
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
<script src="http://src.vvic.com/statics/lib/avalon/avalon.shim.js" type="text/javascript" charset="utf-8" async defer></script>
<script>
    var SEARCHKEY = '${searchKey}';
    var RECORDCOUNT = '${page.recordCount}';
    var CURRENTPAGE = '${page.currentPage}';
    var PAGECOUNT = '${page.pageCount}';
    var BID = '${bid}';
    var FLOOR = '${floor}';

    require(['markets3/shopsearch3'], {});
</script>
<%@ include file="common/third.jsp"%>
</body>
</html>
