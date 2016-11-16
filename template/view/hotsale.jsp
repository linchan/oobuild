<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="ladies3"/>
    <jsp:param name="cssHash" value="${cssHash.ladies3}"/>
    <jsp:param name="title" value="当季热卖 -"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="currentNav" value="5"/>
</jsp:include>

<div class="w">
    <div class="catContainer lady clearfix j-cat-content">
        <!---->
        <div class="loading3" style="height: 80px;"></div>
    </div>
    <script type="text/x-handlebars-template" id="tpl_cats">
        {{ var count = 0}}
        {{ _.each(data, function(item,odx){ }}
        <div class="catBoxes fl clearfix {{if(odx==0){}}catBoxWide{{} }}">
            {{ _.each(item.cats, function(cat,idx){ }}

            <div class="catList fl
                 {{if(odx==1&&idx==0){}}catList3{{} }}
                 {{if(odx==1&&idx==1){}}catList4{{} }}
                 {{if(odx==0&&idx==0){}}catList1{{} }}
                 {{if(odx==0&&idx==1){}}catList2{{} }}">
                <h6 class="catSubtitle">{{=cat.catSubTitle}}</h6>
                <div class="clearfix">
                    <img src="http://src.vvic.com{{=cat.catImg}}" class="catImg"/>

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
        <div class="floor newfloor" style="margin-bottom: -10px;">
            <div class="floor-title clearfix">
                <div class="fr more">
                    <a href="${weekhot.more_link}" target="_blank" vda=
                "link|hotcard">查看更多<i class="vvicon">&#xe630;</i><i class="vvicon more-hover">&#xe62f;</i></a>
                </div>
                <span>${weekhot.title}</span>
            </div>
            <div class="goods-list ">
                <ul class="big clearfix">
                    <c:forEach items="${weekhot.recordList}" var="item" varStatus="stats">
                        <li>
                            <i class="isRecommd isRecommd_0"></i>
                            <div class="item">
                                <div class="pic">
                                    <a target="_blank" href="${item.href_url}" class="showed j-vda"
                                       vda="tp|hotcard|${item.item_id}|0|0|${stats.count}">
                                        <img class="lazy" data-original="${item.img_url}">
                                    </a>
                                    <div class="ctrl clearfix">
                                        <span data-tid="${item.tid}" data-price="${item.price}"
                                              data-id="${item.item_id}" class="upload j-upload" vda="yjsc|hotcard|${item.id}|0|0|${status.count}">一键上传
                                        </span>
                                        <span data-id="${item.item_id}" class="collect addFav j-add-fav" vda="sc|hotcard|${item.id}|0|0|${status.count}">收藏</span>
                                        <a href="/samestyle/${item.item_id}" target="_blank" title="找${item.title}" vda="ztk|hotcard|${item.id}|0|0|${status.count}">
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
                                        <i class="fl ico_item_active_0 ico_item_active"></i>
                                    </div>
                                    <div class="title">
                                        <a target="_blank" href="${item.href_url}" vda="spbt|itemcard|0|${item.shop_id}|0|${status.count}">${item.title}</a>
                                    </div>
                                    <div class="clearfix shop-name-box">
                                        <div class="fr num j_clip_button art_no_${item.art_no}"> ${item.art_no}#</div>
                                        <a class=" shop-name" target="_blank" href="/shop/${item.shop_id}"
                                           title="${item.marketName} ${item.position}" vda="dkmc|hotcard|0|${item.shop_id}|0|${status.count}">
                                            <span class="inner">${item.marketName} ${item.position}</span>
                                        </a>
                                    </div>
                                    <div class="foot clearfix">
                                        <div class="fl pos tb">
                                            <a target="_blank" href="/shop/${item.shop_id}" class="vam"
                                               title="${item.shop_name}" vda="dkmc|hotcard|0|${item.shop_id}|0|${status.count}">
                                                ${item.shop_name}
                                            </a>
                                            <a target="_blank"
                                               href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid=${item.ww_nickname}" vda="ww|hotcard|0|${item.shop_id}|0|${status.count}">
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
                    </c:forEach>

                </ul>
            </div>
        </div>
        <div class="floor shopfloor">
            <div class="floor-title clearfix">
                <div class="fr more">
                    <a href="${goodshops.link}" target="_blank" title="${goodshops.title}" vda="link|jxdpcard">查看更多<i class="vvicon">&#xe630;</i><i class="vvicon more-hover">&#xe62f;</i>
                    </a>
                </div>
                <span>${goodshops.title}</span>
            </div>
            <div class="shop-slide">
                <div class="silder-btn next"><i></i></div>
                <div class="silder-btn prev"><i></i></div>
                <div class="bd">
                    <ul class="shopList clearfix">
                        <c:forEach items="${goodshops.recordList}" var="item" varStatus="status">
                            <li class="item">
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

                        <c:forEach items="${items.banner}" var="z" begin="0" end="0" varStatus="bannerState">
                            <li class="frist">
                                <a href="${z.href_url}" target="_blank" title="${z.title}" vda="tp|mixcard|${z.item_id}|${z.shop_id}|${floorState.count}|0">
                                    <img data-original="${z.img_url}" class="lazy"/>
                                </a>
                            </li>
                        </c:forEach>


                        <c:forEach items="${items.itemsList}" var="item" varStatus="itemState">

                            <li><i class="isRecommd isRecommd_0"></i>
                                <div class="item">
                                    <div class="pic">
                                        <a target="_blank" href="${item.href_url}" class="showed j-vda">
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
                                               title="${item.marketName} ${item.position}" vda="dkh|mixcard|${item.item_id}|${item.shop_id}|${floorState.count}|${itemState.count}">
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

                        </c:forEach>
                        <c:forEach items="${items.banner}" var="z" begin="1" end="1">
                            <li class="frist">
                                <a href="${z.href_url}" target="_blank" title="${z.title}" vda="tp|mixcard|${z.item_id}|${z.shop_id}|${floorState.count}|-1">
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
    require(['web3/ladies3'], function (lady) {
        /*-------------定义顶部cat------------*/
        var SHOE_CAT = [{
            cats: [{
                catSubTitle: '时尚元素',
                catImg: '/statics/assets/css/img/lady/catimg1.jpg',
                arr: [{
                    text: '蝴蝶结',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E8%9D%B4%E8%9D%B6%E7%BB%93&pid=1#jump'
                }, {
                    text: '条纹',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%9D%A1%E7%BA%B9&pid=1#jump'
                }, {
                    text: '格子',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%A0%BC%E5%AD%90&pid=1#jump'
                }, {
                    text: '卡通',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%8D%A1%E9%80%9A&pid=1#jump'
                }, {
                    text: '流苏',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%B5%81%E8%8B%8F&pid=1#jump'
                }, {
                    text: '荷叶边',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E8%8D%B7%E5%8F%B6%E8%BE%B9&pid=1#jump'
                }, {
                    text: '字母',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%AD%97%E6%AF%8D&pid=1#jump'
                }, {
                    text: '镂空',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E9%95%82%E7%A9%BA&pid=1#jump'
                }, {
                    text: '钉珠',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E9%92%89%E7%8F%A0&pid=1#jump'
                }, {
                    text: '立体',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E7%AB%8B%E4%BD%93&pid=1#jump'
                }, {
                    text: '娃娃领',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%A8%83%E5%A8%83%E9%A2%86&pid=1#jump'
                }, {
                    text: '刺绣',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%88%BA%E7%BB%A3&pid=1#jump'
                }, {
                    text: '贴布',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E8%B4%B4%E5%B8%83&pid=1#jump'
                }, {
                    text: '拼接',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%8B%BC%E6%8E%A5&pid=1#jump'
                }, {
                    text: '波点',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%B3%A2%E7%82%B9&pid=1#jump'
                }]
            }, {
                catSubTitle: '流行风格',
                catImg: '/statics/assets/css/img/lady/catimg2.jpg',
                arr: [{
                    text: '小香风',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%B0%8F%E9%A6%99%E9%A3%8E&pid=1#jump'
                }, {
                    text: '欧美',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%AC%A7%E7%BE%8E&pid=1#jump'
                }, {
                    text: '森女',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%A3%AE%E5%A5%B3&pid=1#jump'
                }, {
                    text: 'OL',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=OL&pid=1#jump'
                }, {
                    text: '学院',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%AD%A6%E9%99%A2&pid=1#jump'
                }, {
                    text: '民族风',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%B0%91%E6%97%8F%E9%A3%8E&pid=1#jump'
                }, {
                    text: '甜美',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E7%94%9C%E7%BE%8E&pid=1#jump'
                }, {
                    text: '复古',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%A4%8D%E5%8F%A4&pid=1#jump'
                }, {
                    text: '运动',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E8%BF%90%E5%8A%A8&pid=1#jump'
                }, {
                    text: '街头',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E8%A1%97%E5%A4%B4&pid=1#jump'
                }, {
                    text: '夜店风',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%A4%9C%E5%BA%97&pid=1#jump'
                }, {
                    text: '显瘦',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%98%BE%E7%98%A6&pid=1#jump'
                }, {
                    text: '气质',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%B0%94%E8%B4%A8&pid=1#jump'
                }, {
                    text: '韩系',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E9%9F%A9%E7%B3%BB&pid=1#jump'
                }, {
                    text: '日系',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%97%A5%E7%B3%BB&pid=1#jump'
                }]
            }]
        }, {
            cats: [{
                catSubTitle: '版型',
                catImg: '/statics/assets/css/img/lady/catimg3.jpg',
                arr: [{
                    text: '不规则',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E4%B8%8D%E8%A7%84%E5%88%99&pid=1#jump'
                }, {
                    text: '高腰',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E9%AB%98%E8%85%B0&pid=1#jump'
                }, {
                    text: '收腰',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%94%B6%E8%85%B0&pid=1#jump'
                }, {
                    text: '宽松',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%AE%BD%E6%9D%BE&pid=1#jump'
                }, {
                    text: '直筒',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E7%9B%B4%E7%AD%92&pid=1#jump'
                }, {
                    text: '大摆',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%A4%A7%E6%91%86&pid=1#jump'
                }, {
                    text: '开叉',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%BC%80%E5%8F%89&pid=1#jump'
                }, {
                    text: '紧身',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E7%B4%A7%E8%BA%AB&pid=1#jump'
                }, {
                    text: '鱼尾',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E9%B1%BC%E5%B0%BE&pid=1#jump'
                }, {
                    text: '茧型',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E9%AB%98%E8%85%B0&pid=1#jump'
                }, {
                    text: '廓形',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%BB%93%E5%BD%A2&pid=1#jump'
                }, {
                    text: '阔口',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E9%98%94%E5%8F%A3&pid=1#jump'
                }]
            }, {
                catSubTitle: '面料质地',
                catImg: '/statics/assets/css/img/lady/catimg4.jpg',
                arr: [{
                    text: '太空棉',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E5%A4%AA%E7%A9%BA%E6%A3%89&pid=1#jump'
                }, {
                    text: '纯棉',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E7%BA%AF%E6%A3%89&pid=1#jump'
                }, {
                    text: '雪纺',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E9%9B%AA%E7%BA%BA&pid=1#jump'
                }, {
                    text: '毛呢',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E6%AF%9B%E5%91%A2&pid=1#jump'
                }, {
                    text: '针织',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E9%92%88%E7%BB%87&pid=1#jump'
                }, {
                    text: '网纱',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E7%BD%91%E7%BA%B1&pid=1#jump'
                }, {
                    text: '牛仔',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E7%89%9B%E4%BB%94&pid=1#jump'
                }, {
                    text: '蕾丝',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E8%95%BE%E4%B8%9D&pid=1#jump'
                }, {
                    text: '麂皮',
                    href: 'http://www.vvic.com/search.html?pageSize=50&q=%E9%BA%82%E7%9A%AE&pid=1#jump'
                }]
            }]
        }]

        lady.renderCat({data: SHOE_CAT})
    });
</script>
<jsp:include page="common/third.jsp"/></body></html>
