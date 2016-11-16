<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="foreign3"/>
    <jsp:param name="cssHash" value="${cssHash.foreign3}"/>
    <jsp:param name="title" value="外贸爆款"/>
    <jsp:param name="currentNav" value="4"/>
</jsp:include>

<div class="w">
    <div class="catContainer clearfix">
        <div class="tagList" id="tagContent">
            <div class="loading3" style="height:280px;"></div>
            <script type="text/x-handlebars-template" id="tpl">
                <div class="plats catBoxes">
                    <div class="platsTitle catTitle">国际平台</div>
                    {{ _.each(plats,function(el, index){ }}
                    <div class="platItem">
                        <a href="{{=el.link}}" target="blank" vda="link|hotcategory|1{{=index+1}}">
                            <img src="{{=el.img}}" alt="{{=el.text}}"/>
                        </a>
                    </div>
                    {{ }) }}
                </div>
                {{ _.each(tags,function(el, index){ }}
                <div class="catBoxes {{index?'':'catBoxWide'}} clearfix">
                    <h5 class="catTitle">{{=el.text}}</h5>
                    {{ _.each(el.list,function(cats, subindex){ }}
                    <div class="catList fl">
                        <a href="{{=cats.link}}"  target="blank" class="catSubtitle" title="{{=cats.text}}" vda="link|hotcategory|{{=index+2}}{{=subindex+1}}">{{=cats.text}}</a>
                    </div>
                    {{ }) }}
                </div>
                {{ }) }}
            </script>
        </div>

        <div class="catFocus">

            <div class="mk-slide j-mk-slide">

                <c:if test="${fn:length(focusAd)>1}">
                    <div class="silder-btn next"><i></i></div>
                    <div class="silder-btn prev"><i></i></div>
                </c:if>
                <div class="bd mk-mask">
                    <ul>
                        <c:forEach items="${focusAd}" var="cover">
                            <li>
                                <c:choose>
                                    <c:when test="${cover.href_url =='' || cover.href_url=='#'}">
                                        <img src="${cover.img_url}" alt="${cover.tips_title}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${cover.href_url}" target="_blank" title="${cover.tips_title}">
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

    </div>
    <div class="w  ">

        <c:forEach items="${floorAdList}" var="el" varStatus="floorState">
            <div class="floor pmfloor ">
                <div class="floor-title clearfix">
                    <div class="fr more">
                        <a href="${el.moreLink}" target="_blank" title="${el.floorTitle}" vda="link|mixcard">查看更多<i class="vvicon">&#xe630;</i><i class="vvicon more-hover">&#xe62f;</i>
                        </a>
                    </div>
                    <span>${el.floorTitle}</span>
                </div>
                <div class="goods-list">
                    <ul class="big clearfix">

                        <c:forEach items="${el.itemsList}" var="item" varStatus="itemState">

                            <c:if test="${item.is_pic == 1}">
                                <li class="">
                                    <img data-original="${item.img_url}" class="lazy"/>
                                </li>
                            </c:if>

                            <c:if test="${item.is_pic == 0}">
                                <li>
                                    <div class="item">
                                        <div class="pic">
                                            <a target="_blank" href="${item.href_url}" class="showed j-vda" vda="tp|mixcard|${item.item_id}|0|${floorState.count}|${itemState.count}">
                                                <img class="lazy" data-original="${item.img_url}">
                                            </a>
                                            <div class="ctrl clearfix">
                                                <span data-tid="${item.tid}" data-price="${item.price}"
                                                      data-id="${item.item_id}" class="upload j-upload " vda="yjsc|mixcard|${item.item_id}|0|${floorState.count}|${itemState.count}">一键上传
                                                </span>
                                                <span data-id="${item.item_id}" class="collect addFav j-add-fav" vda="sc|mixcard|${item.item_id}|0|${floorState.count}|${itemState.count}">收藏</span>
                                                <a href="/samestyle/${item.item_id}" target="_blank"
                                                   title="找${item.title}" vda="ztk|mixcard|${item.item_id}|0|${floorState.count}|${itemState.count}">
                                                    <span>找同款</span>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="desc">
                                            <div class="info clearfix">

                                                <div class="fl price">
                                                    <c:choose>
                                                        <c:when test="${item.price_type eq 1}">
                                                            <span class="yuan">¥</span><b class="sale">${item.price}</b>
                                                        </c:when>
                                                        <c:when test="${item.price_type eq 2}">
                                                            <span class="yuan">¥</span><b class="sale">${item.price}</b>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <strong class="sale" style="color: #9c9c9c;">价格错误</strong>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </div>

                                            </div>
                                            <div class="title">
                                                <a target="_blank" href="${item.href_url}" vda="spbt|mixcard|${item.item_id}|0|${floorState.count}|${itemState.count}">${item.title}</a>
                                            </div>
                                            <div class="clearfix shop-name-box" >
                                                <div class="fr num j_clip_button art_no_8155"> ${item.art_no}#</div>
                                                <a class=" shop-name" target="_blank" href="/shop/${item.shop_id}" vda="dkh|mixcard|${item.item_id}|${item.shop_id}|${floorState.count}|${itemState.count}" title="${item.marketName} ${item.position}" >
                                                    <span class="inner">${item.marketName} ${item.position}</span>
                                                </a>
                                            </div>
                                            <div class="foot clearfix">
                                                <div class="fl pos tb">
                                                    <a target="_blank" href="/shop/${item.shop_id}" class="vam" title="${item.shop_name}" vda="dkmc|mixcard|${item.item_id}|${item.shop_id}|${floorState.count}|${itemState.count}">
                                                        ${item.shop_name}
                                                    </a>
                                                    <a target="_blank"
                                                       href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid=${item.ww_nickname}" vda="ww|mixcard|${item.item_id}|${item.shop_id}|${floorState.count}|${itemState.count}">
                                                        <img class="vam lazy"
                                                             data-original="http://www.vvic.com/api/online?nickname=${item.ww_nickname}">
                                                    </a>
                                                    <div class="more-info">
                                                        <div class="shop-pos">${item.marketName} ${item.position}</div>
                                                        <c:if test="${item.authenticated == 1 || item.cloud_update == 1 || item.top > 0 || item.years > 1 || item.is_gold_shop == 1}">
                                                        <div class="shop-icon fl clearfix">
                                                            <c:if test="${item.authenticated == 1}">
                                                            <i class="cert j-v-tip" data-tip="cert"></i>
                                                            </c:if>
                                                            <c:if test="${item.cloud_update == 1}">
                                                            <i class="miao j-v-tip" data-tip="miao"></i>
                                                            </c:if>
                                                            <c:if test="${item.top > 0}">
                                                            <i class="top${item.top} j-v-tip" data-tip="top"
                                                                data-top="${item.top}"></i>
                                                            </c:if>
                                                            <c:if test="${item.years>1}">
                                                            <i class="shop-year-icon j-v-tip year${item.years} fr" data-tip="year"
                                                             data-date="${item.start_business_date}"></i>
                                                             </c:if>
                                                        </div>
                                                        <c:if test="${item.is_gold_shop == 1}">
                                                        <div class="shop-gold fr">
                                                            <img src="${staticDomain}/statics/v2/css/img/common/gold.png" width="19">
                                                        </div>
                                                        </c:if>
                                                        </c:if>
                                                        <div class="clear"></div>
                                                    </div>
                                                    <div class="triangle triangle-up1"></div>
                                                    <div class="triangle triangle-up2"></div>
                                                </div>
                                                <div class="service-icon service-icon-tg shown_sp_${item.is_sp} shown_tx_${item.is_tx} shown_df_${item.is_df} fr">
                                                    <div class="s-item sp j-v-tip" data-tip="sp"><i></i></div>
                                                    <div class="s-item tx j-v-tip" data-tip="tx"><i></i></div>
                                                    <div class="s-item df j-v-tip" data-tip="df"><i></i></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:if>


                        </c:forEach>
                    </ul>
                </div>

            </div>
        </c:forEach>

    </div>
</div>

<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>

<script>
    var FIXEDAMOUNT = parseInt('${fixed_amount}');

    require(['web3/foreign3'], function () {
    });</script><%@ include file="common/third.jsp"%></body></html>
