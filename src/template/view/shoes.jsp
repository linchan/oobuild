<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="shoes3"/>
    <jsp:param name="cssHash" value="${cssHash.shoes3}"/>
    <jsp:param name="title" value="潮流鞋靴 -"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="currentNav" value="7"/>
</jsp:include>

<div ms-controller="shoes" class="w">

    <div class="catContainer  clearfix j-cat-content">
        <!---->
        <div class="loading3" style="height: 80px;"></div>
    </div>
    <script type="text/x-handlebars-template" id="tpl_newitem">
        {{ _.each(data.recordList, function(item, index){ }}

        <li>
            <div class="item">
                <div class="pic">
                    <a target="_blank" class="j-vda" href="/item/{{=item.id}}" class="showed" vda="tp|hottoday|{{=item.id}}|0|-1|{{=index+1}}">
                        <img class="lazy" data-original="{{=item.index_img_url}}">
                    </a>
                    <div class="ctrl clearfix">
                        <span data-tid="{{=item.tid}}" data-price="{{=item.price}}"
                              data-id="{{=item.id}}" class="upload j-upload" vda="yjsc|hottoday|{{=item.id}}|0|-1|{{=index+1}}">一键上传
                        </span>
                        <span data-id="{{=item.id}}" class="collect addFav j-add-fav" vda="sc|hottoday|{{=item.id}}|0|-1|{{=index+1}}">收藏</span>
                        <a href="/samestyle/{{=item.id}}" target="_blank"
                           title="找{{=item.title}}" vda="ztk|hottoday|{{=item.id}}|0|-1|{{=index+1}}">
                            <span>找同款</span>
                        </a>
                    </div>
                </div>
                <div class="desc">
                    <div class="info clearfix">

                        <div class="fl price">
                            <span class="yuan">¥</span><b class="sale">{{=item.discount_price}}</b>
                        </div>

                    </div>
                    <div class="title">
                        <a target="_blank" href="/item/{{=item.id}}" vda="spbt|hottoday|{{=item.id}}|0|-1|{{=index+1}}">{{=item.title}}</a>
                    </div>
                    <div class="clearfix shop-name-box" >
                        <div class="fr num j_clip_button art_no_{{=item.art_no}}"> {{=item.art_no}}#</div>
                        <a class=" shop-name" target="_blank" href="/shop/{{=item.shop_id}}"
                           title="{{=item.marketName}} {{=item.position}}" vda="dkh|hottoday|{{=item.id}}|{{=item.item_id}}|-1|{{=index+1}}">
                            <span class="inner">{{=item.marketName}} {{=item.position}}</span>
                        </a>
                    </div>
                    <div class="foot clearfix">
                        <div class="fl pos tb">
                            <a target="_blank" href="/shop/{{=item.shop_id}}" class="vam" title="{{=item.shop_name}}" vda="dkmc|hottoday|{{=item.id}}|{{=item.item_id}}|-1|{{=index+1}}">
                                {{=item.shop_name}}
                            </a>
                            <a target="_blank"
                               href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid={{=item.ww_nickname}}" vda="ww|hottoday|{{=item.id}}|{{=item.item_id}}|-1|{{=index+1}}">
                                <img class="vam lazy"
                                     data-original="http://www.vvic.com/api/online?nickname={{=item.ww_nickname}}">
                            </a>
                            <div class="more-info">
                                <div class="shop-pos">{{=item.marketName}} {{=item.position}}</div>
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
                        <div class="service-icon service-icon-tg shown_sp_{{=item.is_sp}} shown_tx_{{=item.is_tx}} shown_df_{{=item.is_df}} fr">
                            <div class="s-item sp j-v-tip" data-tip="sp"><i></i></div>
                            <div class="s-item tx j-v-tip" data-tip="tx"><i></i></div>
                            <div class="s-item df j-v-tip" data-tip="df"><i></i></div>
                        </div>
                    </div>
                </div>
            </div>
        </li>
        {{ }) }}

    </script>

    <script type="text/x-handlebars-template" id="tpl_cats">
        {{ var count = 0}}
        {{ _.each(list, function(item,odx){ }}
        <div class="catBoxes fl clearfix {{if(odx==0){}}catBoxWide{{} }}">
            {{ _.each(item.cats, function(cat,idx){ }}
            {{ count++}}
            <div class="catList fl
                 {{if(odx==1&&idx==0){}}catList3{{} }}
                 {{if(odx==1&&idx==1){}}catList4{{} }}
                 {{if(odx==0&&idx==0){}}catList1{{} }}
                 {{if(odx==0&&idx==1){}}catList2{{} }}">
                <h6 class="catSubtitle">{{=cat.catSubTitle}}</h6>
                <div class="clearfix">
                    <img src="{{=cat.catImg}}" class="catImg"/>

                    {{ _.each(cat.arr, function(arr,idxx){ }}
                    <a href="{{=arr.href}}" target="_blank" title="{{=arr.text}}" class="catItem" vda="link|hotcategory|{{=count}}{{=idxx+1}}">
                        {{=arr.text}}
                    </a>
                    {{ }) }}

                </div>
            </div>
            {{ }) }}

        </div>

        {{ }) }}


    </script>

    <div class="w">

        <div class="floor shopfloor">
            <div class="floor-title clearfix">
                <div class="fr more">
                    <a href="/shops/24" target="_blank" title="${goodshops.title}" vda="link|jxdpcard">查看更多<i class="vvicon">&#xe630;</i><i class="vvicon more-hover">&#xe62f;</i>
                    </a>
                </div>
                <span>发现好店</span>
            </div>
            <div class="shop-slide" id="showSlideBox">
                <div class="loading3" style="height: 345px;"></div>
                <div style="display: none;" id="showSlideList">
                    <div class="silder-btn next"><i></i></div>
                    <div class="silder-btn prev"><i></i></div>
                    <div class="bd">
                        <ul class="shopList clearfix">
                            <c:forEach items="${goodshops.recordList}" var="item" varStatus=" status">
                                <li class="item" data-random="${item.is_random}">
                                    <div class="picWrap">
                                        <a href="${item.href_url}" target="_blank" vda="link|jxdpcard|${status.count}">
                                            <img src="${item.img_url}" class="listPic"/>
                                            <span class="maskWrap"><b class="mask">${item.shop_name}</b></span>
                                        </a>
                                    </div>
                                    <div class="desc">
                                        <h6 class="shopName">${item.marketName} ${item.position}</h6>
                                        <p class="shopIntro">${item.remark}</p>
                                    </div>
                                </li>
                            </c:forEach>

                        </ul>
                    </div>
                </div>

            </div>
        </div>

        <div class="floor pmfloor" style="margin-bottom: -10px;">
            <div class="floor-title clearfix">
                <div class="fr more">
                    <a href="/new.html?pid=3" target="_blank" title="每日新款" vda="link|hottoday">查看更多<i class="vvicon">&#xe630;</i><i class="vvicon more-hover">&#xe62f;</i></a>
                </div>
                <span>每日新款</span>
            </div>
            <div class="goods-list hot-list">
                <ul class="big clearfix j-news-content"></ul>
            </div>
        </div>

        <c:forEach items="${floors.recordList}" var="items" varStatus="floorState">

            <div class="floor pmfloor">
                <div class="floor-title clearfix">
                    <div class="fr more">
                        <a href="${items.moreLink}" target="_blank" title="${items.floorTitle}" vda="link|mixcard">查看更多<i class="vvicon">&#xe630;</i><i class="vvicon more-hover">&#xe62f;</i></a>
                    </div>
                    <span>${items.floorTitle}</span>
                </div>
                <div class="goods-list hot-list">
                    <ul class="big clearfix">

                        <c:forEach items="${items.banner}" var="z" begin="0" end="0"  varStatus="bannerState">
                            <li class="frist">
                                <a href="${z.href_url}" class="j-vda" target="_blank" title="${z.title}" vda="tp|mixcard|${z.item_id}|${z.shop_id}|${floorState.count}|0">
                                    <img data-original="${z.img_url}" class="lazy"/>
                                </a>
                            </li>
                        </c:forEach>


                        <c:forEach items="${items.itemsList}" var="item" varStatus="itemState">

                            <li><i class="isRecommd isRecommd_0"></i>
                                <div class="item">
                                    <div class="pic">
                                        <a target="_blank" href="${item.href_url}" class="showed j-vda" vda="tp|mixcard|${item.item_id}|0|${floorState.count}|${itemState.count}">
                                            <img class="lazy" data-original="${item.img_url}">
                                        </a>
                                        <div class="ctrl clearfix">
                                            <span data-tid="${item.tid}" data-price="${item.price}"
                                                  data-id="${item.item_id}" class="upload j-upload" vda="yjsc|mixcard|${item.item_id}|0|${floorState.count}|${itemState.count}">一键上传
                                            </span>
                                            <span data-id="${item.item_id}" class="collect addFav j-add-fav"vda="sc|mixcard|${item.item_id}|0|${floorState.count}|${itemState.count}">收藏</span>
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
                                            <div class="fr num j_clip_button art_no_${item.art_no}"> ${item.art_no}#</div>
                                            <a class=" shop-name" target="_blank" href="/shop/${item.shop_id}"
                                               title="${item.marketName} ${item.position}" >
                                                <span class="inner" vda="dkh|mixcard|${item.item_id}|${item.shop_id}|${floorState.count}|${itemState.count}">${item.marketName} ${item.position}</span>
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

                        </c:forEach>
                        <c:forEach items="${items.banner}" var="z" begin="1" end="1">
                            <li class="frist">
                                <a href="${z.href_url}" class="j-vda" target="_blank" title="${z.title}" vda="tp|mixcard|${z.item_id}|${z.shop_id}|${floorState.count}|-1">
                                    <img data-original="${z.img_url}" class="lazy"/>
                                </a>
                            </li>
                        </c:forEach>

                    </ul>
                </div>


                <div  class="floor-hot clearfix subSlide" class="shoes-hot">

                    <div class="bd">
                        <ul>
                            <c:forEach items="${items.middleList}" var="item">
                                <li >
                                    <a href="${item.href_url}" target="_blank" title="${item.title}">
                                        <img src="${item.img_url}" />
                                    </a>
                                </li>
                            </c:forEach>

                        </ul>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div>
</div>


<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>

<script>
    require(['web3/shoes3'], function (shoes3) {

    });
</script>
<jsp:include page="common/third.jsp"/></body></html>
