<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="common/header.jsp">
<jsp:param name="headerName" value="shop"/>
<jsp:param name="cssName" value="shop3"/>
<jsp:param name="cssHash" value="${cssHash.shop3} -"/>
<jsp:param name="title" value="${shop.name} - ${shop.marketName} - 档口首页 -"/>
<jsp:param name="desc"
           value="${shop.name}，是 VVIC 搜款网收录的档口，属于 ${shop.marketName} 批发市场，主营 ${shop.pname} 。VVIC 搜款网是广州最大的网批平台，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
<jsp:param name="keywords" value="${shop.name},${shop.marketName}, ${shop.pname},VVIC 搜款网"/>
<jsp:param name="hideNav" value="1"/>
<jsp:param name="fixdHeaderClassName" value="header_fixed_able"/>
</jsp:include>

<div class="w clearfix shop-wrap">

    <div class="fl shop-info <c:if test='${shop.is_gold_shop == 1}'>shop-gold</c:if>">
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
                <span>${shop.name}</span>
            </h2>
            <c:if test="${shop.authenticated==1 || shop.cloud_update==1 || shop.top>0}">
            <div class="shop-icon">
                <c:if test="${shop.authenticated==1}">
                    <i class="cert j-v-tip" data-tip="cert"></i>
                </c:if>
                <c:if test="${shop.cloud_update==1}">
                    <i class="miao j-v-tip" data-tip="miao"></i>
                </c:if>
                <c:if test="${shop.top>0}">
                    <i class="top${shop.top} j-v-tip" data-tip="top" data-top="${shop.top}"></i>
                </c:if>
            </div>
            </c:if>
            <div class="clear"></div>
            <a href="javascript:;" class="icon-btn care btn-shop-care" data-sid="${shop.id}" vda="action|shopinfo|gz">
                <i class="vvicon">&#xe613;</i>
                <span>关注</span>
            </a>

            <ul class="mt10">
                <li>
                    <div class="attr" style="line-height: 28px;">地址：</div>
                    <div class="text">
                        <span>${shop.marketName}&nbsp;</span>
                        <span>${shop.floor}楼&nbsp;</span>
                        <span>${shop.position}</span>
                        <a href="http://www1.vvic.com/map.html" target="_blank"><em class="guide vvicon">&#xe62c;</em></a>
                    </div>
                </li>
                <li style="display: none;">
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
                        <c:forEach items="${shop.telephone}" var="el">
                            <p>${el}</p>
                        </c:forEach>
                    </div>
                </li>
                <c:if test="${shop.wechat != ''}">
                    <li>
                        <div class="attr">微信：</div>
                        <div class="text">${shop.wechat}</div>
                    </li>
                </c:if>
                <c:if test="${shop.qq != ''}">
                <li>
                    <div class="attr">QQ：</div>
                    <div class="text">${shop.qq}</div>
                </li>
                </c:if>
            </ul>
            <div class="clear"></div>
            <div class="btns clearfix">
                <c:if test="${shop.sid != ''}">
                    <a href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid=${shop.ww_nickname_code}"
                       target="_blank" title="${shop.name}" class="fl btn-default kf" vda="action|shopInfo|ww">
                        <c:choose>
                            <c:when test="${shop.ww_nickname_code==''}">
                                <img src="${staticDomain}/statics/assets/css/img/shop/ww0.png" alt="${shop.name}"/>
                            </c:when>
                            <c:otherwise>
                                <img src="/api/online?nickname=${shop.ww_nickname_code}"
                                     onerror="this.src='${staticDomain}/statics/assets/css/img/shop/ww0.png'"
                                     alt="${shop.name}"/>
                            </c:otherwise>
                        </c:choose>
                        <span>旺旺</span>
                    </a>
                </c:if>
                <a href="https://shop${shop.sid}.taobao.com/" target="_blank" class="fl tb btn-default" vda="action|shopInfo|tblink">进入淘宝</a>
            </div>
        </div>
    </div>
    <div class="fr stall-goods">
        <c:if test="${shop.notice != '' && shop.notice_status != 2}">
            <div class="vvic-msg">
                <span class="t">档口通知：</span>
                ${shop.notice}
            </div>
        </c:if>

        <div class="shop_tab">
            <div class="tab_top clearfix">

                <c:if test="${shop.cloud_update eq 0}">
                    <a href="http://tb.vvic.com/AccessTokenRegister.aspx" target="_blank" class="fr cloud_update" vda="link|shopInfo">开通秒更新服务</a>
                </c:if>

                <a href="#content_all" class="item selected" vda="action|status|allgoods">全部商品</a>
                <a href="#content_off" class="item" vda="action|status|xjgoods">下架商品</a>
                <a href="#content_record" class="item" vda="action|status|sxjjl">上下架记录</a>
            </div>
            <div class="tab_content" id="content_all" style="display: block;">
                <div class="screen">
                    <h5 class="clearfix">
                        <small class="fr">
                            <c:choose>
                                <c:when test="${param.amount>0}">
                                    <c:set var="total_items" value="${param.amount}" />
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${shop_home_page.recordCount < shop.total_items}">
                                            <c:set var="total_items" value="${shop_home_page.recordCount}" />
                                        </c:when>
                                        <c:otherwise>

                                            <c:set var="total_items" value="${shop.total_items}" />
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>

                            共 <span class="num">${total_items}</span> 件相关商品
                        </small>
                        商品分类
                    </h5>

                    <c:forEach items="${item_cat_list}" var="el">
                        <div id="cateNav${el.parentId}" class="nav-category clearfix show-more">

                            <div class="nc-key">${el.parentName}：</div>
                            <div class="nc-value">
                                <div class="types" style="width: auto;">
                                    <c:forEach items="${el.categoryList}" var="type">

                                        <c:set var="classname" value=""/>
                                        <c:if test="${type.tcid == param.tcid}">
                                            <c:set var="classname" value="selected"/>
                                        </c:if>

                                        <a href="?tcid=${type.tcid}&sort=${param.sort}&price_start=${param.price_start}&price_end=${param.price_end}&q=${param.q}&amount=${type.amount}" class="${classname}" vda="link|fliter">
                                            ${type.name}(${type.amount})
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>

                        </div>
                    </c:forEach>

                </div>
                <div class="goods-sort">
                    <div class="pro-sort">
                        <div class="s-b-left clearfix">
                            <ul>
                                <c:choose>
                                    <c:when test="${param.sort=='default'}">
                                        <c:set var="default_class_name" value="curr" />
                                    </c:when>

                                    <c:otherwise>
                                        <c:set var="default_class_name" value="" />
                                    </c:otherwise>
                                </c:choose>

                                <a href="?sort=default&tcid=${param.tcid}&price_start=${param.price_start}&price_end=${param.price_end}&q=${param.q}" class="h-item ${default_class_name}" vda="link|fliter">
                                    <span>综合</span>
                                </a>

                                <c:choose>
                                    <c:when test="${param.sort=='price-desc'}">
                                        <c:set var="price_class_name" value="curr desc" />
                                        <c:set var="price_sort" value="?sort=price-asc" />
                                    </c:when>
                                    <c:when test="${param.sort=='price-asc'}">
                                        <c:set var="price_class_name" value="curr asc" />
                                        <c:set var="price_sort" value="?sort=price-desc" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="price_class_name" value="" />
                                        <c:set var="price_sort" value="?sort=price-asc" />
                                    </c:otherwise>
                                </c:choose>
                                <a href="${price_sort}&tcid=${param.tcid}&price_start=${param.price_start}&price_end=${param.price_end}&q=${param.q}" class="clk h-item ${price_class_name}" vda="link|fliter">
                                    <span>价格</span>
                                    <i class="sort-up vvicon">&#xe60d;</i>
                                    <i class="sort-down vvicon">&#xe609;</i>
                                </a>

                                <c:choose>
                                    <c:when test="${param.sort=='up_time-desc'}">
                                        <c:set var="time_class_name" value="curr desc" />
                                        <c:set var="time_sort" value="?sort=up_time-asc" />
                                    </c:when>
                                    <c:when test="${param.sort=='up_time-asc'}">
                                        <c:set var="time_class_name" value="curr asc" />
                                        <c:set var="time_sort" value="?sort=up_time-desc" />
                                    </c:when>
                                    <c:when test="${fn:length(param.sort)==0}">
                                        <c:set var="time_class_name" value="curr desc" />
                                        <c:set var="time_sort" value="?sort=up_time-asc" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="time_class_name" value="" />
                                        <c:set var="time_sort" value="?sort=up_time-desc" />
                                    </c:otherwise>
                                </c:choose>
                                <a href="${time_sort}&tcid=${param.tcid}&price_start=${param.price_start}&price_end=${param.price_end}&q=${param.q}" class=" clk h-item ${time_class_name}" vda="link|fliter" >
                                    <span>上新时间</span>
                                    <i class="sort-up vvicon">&#xe60d;</i>
                                    <i class="sort-down vvicon">&#xe609;</i>
                                </a>
                                <c:choose>
                                    <c:when test="${param.sort=='hot-desc'}">
                                        <c:set var="hot_class_name" value="curr desc" />
                                        <c:set var="hot_sort" value="?sort=hot-asc" />
                                    </c:when>
                                    <c:when test="${param.sort=='hot-asc'}">
                                        <c:set var="hot_class_name" value="curr asc" />
                                        <c:set var="hot_sort" value="?sort=hot-desc" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="hot_class_name" value="" />
                                        <c:set var="hot_sort" value="?sort=hot-desc" />
                                    </c:otherwise>
                                </c:choose>
                                <a href="${hot_sort}&tcid=${param.tcid}&price_start=${param.price_start}&price_end=${param.price_end}&q=${param.q}" class="clk h-item ${hot_class_name}" vda="link|fliter">
                                    <span>销量</span>
                                    <i class="sort-up vvicon">&#xe60d;</i>
                                    <i class="sort-down vvicon">&#xe609;</i>
                                </a>

                                <li class="item price">

                                    <input type="text" placeholder="¥ 最低价" class="fl price-box ml price_start"
                                           value="${param.price_start}"/>
                                    <div class="fl line"></div>

                                    <input type="text" placeholder="¥ 最高价" class="fl price-box price_end" value="${param.price_end}"/>
                                    <div class="btn j-price_start_end" style="display: none;">确定</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="goods-list shop-list clearfix">
                    <ul class="clearfix">
                        <c:forEach items="${shop_home_page.recordList}" var="el" varStatus="status">
                            <li>
                                <div class="item">
                                    <div class="pic">
                                        <a href="/item/${el.id}" target="_blank" class="j-vda" vda="tp|itemcard|${el.id}|0|0|${status.count}">
                                            <img data-original="${el.index_img_url}_230x230.jpg" alt="${el.title}"
                                                 src="${staticDomain}/statics/assets/css/img/blank.gif"
                                                 class="pImg lazy"/>
                                        </a>
                                        <i></i>
                                        <div class="ctrl shops clearfix">
                                            <span class="upload" data-id="${el.id}" data-price="${el.discount_price}" data-tid="${el.tid}" vda="yjsc|itemcard|${el.id}|0|0|${status.count}">一键上传</span>
                                            <span data-id="${el.id}" class="addFav" vda="sc|itemcard|${el.id}|0|0|${status.count}">收藏</span>
                                            <a href="/samestyle/${el.id}" target="_blank" title="${el.title}" vda="ztk|itemcard|${el.id}|0|0|${status.count}">
                                                <span>找同款</span>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="desc">
                                        <div class="info clearfix">
                                            <div class="fl price">

                                                <c:choose>
                                                    <c:when test="${el.price_type eq 1}">
                                                        <span class="yuan ">¥</span>${el.discount_price}
                                                    </c:when>
                                                    <c:when test="${el.price_type eq 2}">
                                                        <span class="yuan ">¥</span>${el.discount_price}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <strong class="sale"
                                                                style="color: #9c9c9c;font-size: 14px;">价格错误
                                                        </strong>
                                                    </c:otherwise>
                                                </c:choose>

                                            </div>
                                            <i class="fl ico_item_active_${el.is_active} ico_item_active"></i>
                                            <!--
                                            <c:choose>
                                                <c:when test="${el.status==0}">
                                                    <div class="fr tr shop-name">
                                                        <!--${el.expired_time}-->
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:if test="${fn:containsIgnoreCase(pageContext.request.queryString,'up_time')}">
                                                        <div class="fr tr shop-name">
                                                            ${el.up_time}
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${fn:length(param.sort)==0}">
                                                        <div class="fr tr shop-name">
                                                            ${el.up_time}
                                                        </div>
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                            -->

                                            <c:choose>
                                                <c:when test="${fn:containsIgnoreCase(pageContext.request.queryString,'up_time')}">
                                                    <div class="fr tr shop-name">
                                                    ${el.up_time}
                                                    </div>
                                                </c:when>
                                                <c:when test="${fn:length(param.sort)==0}">
                                                    <div class="fr tr shop-name">
                                                    ${el.up_time}
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="fr sales"><span class="num">${el.sales}</span>件代发</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="title">
                                            <a href="/item/${el.id}" title="${el.title}" target="_blank" vda="spbt|itemcard|${el.id}|0|0|${status.count}">
                                                ${el.title}
                                            </a>
                                        </div>

                                        <div class="foot clearfix">
                                            <div class="fl ">
                                                <div class="service-icon service-icon-tg shown_sp_1 shown_tx_1 shown_df_1">
                                                    <c:if test="${shop.is_sp==1}">
                                                        <div class="s-item sp j-v-tip" data-tip="sp">
                                                            <i></i>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${shop.is_tx==1}">
                                                        <div class="s-item tx j-v-tip" data-tip="tx">
                                                            <i></i>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${shop.is_df==1}">
                                                        <div class="s-item df j-v-tip" data-tip="df">
                                                            <i></i>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <c:if test="${el.art_no!=''}">
                                                <div class="fr j_clip_button">${el.art_no}#</div>
                                            </c:if>

                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>

                    </ul>

                    <c:if test="${shop_home_page.recordCount==0}">
                        <div class="empty-tip">
                            <span class="vvicon">&#xe614;</span>
                            <div class="text">
                                <div>没有找到相关商品</div>
                            </div>
                        </div>
                    </c:if>

                </div>


                <div class="pagination pagination_all"></div>
            </div>
            <div class="tab_content" id="content_off">

                <div class="screen">
                    <h5>
                        <small class="fr">
                            共 <b class="j_down_total_items"></b> 件相关商品
                        </small>
                        商品分类
                    </h5>

                    <div class="j-screen-box"></div>

                </div>

                <div class="goods-sort">
                    <div class="pro-sort">
                        <div class="s-b-right"></div>

                        <div class="s-b-left clearfix">
                            <ul>
                                <a href="#/sort/default" class="h-item sort-default " vda="link|fliter">
                                    <span>综合</span>
                                </a>

                                <a  class="h-item clk price" data-asc="sort-price-asc" data-desc="sort-price-desc" data-sort="price" vda="link|fliter">
                                    <span>价格</span>
                                    <i class="sort-up vvicon">&#xe60d;</i>
                                    <i class="sort-down vvicon">&#xe609;</i>
                                </a>

                                <a href="#/sort/last_update_time-desc" class="h-item clk up_time curr desc" data-asc="sort-last_update_time-asc" data-sort="last_update_time" vda="link|fliter">
                                    <span>下架时间</span>
                                    <i class="sort-up vvicon">&#xe60d;</i>
                                    <i class="sort-down vvicon">&#xe609;</i>
                                </a>

                                <a href="#/sort/hot-desc" class="h-item clk hot" data-asc="hot-asc" data-sort="hot" vda="link|fliter">
                                    <span>销量</span>
                                    <i class="sort-up vvicon">&#xe60d;</i>
                                    <i class="sort-down vvicon">&#xe609;</i>
                                </a>

                                <li class="item price">

                                    <input type="text" name="price_start" class="fl price-box ml price_start vam"
                                           placeholder="¥ 最低价">

                                    <div class="fl line"></div>

                                    <input type="text" name="price_end" class="fl price-box price_end vam"
                                           placeholder="¥ 最高价">


                                    <div class="btn j_price_start_end" style="display: none;">确定</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="goods-list shop-list ">
                    <ul class="clearfix"></ul>

                    <div class="pagination"></div>
                </div>

                <div class="empty-tip" style="display: none;">
                    <span class="vvicon"></span>
                    <div class="text">
                        <div>没有找到相关商品</div>
                    </div>
                </div>

            </div>
            <div class="tab_content" id="content_record">

                <table class="table up_down_record_list">
                    <tr>
                        <th>日期</th>
                        <c:forEach items="${up_down_record_list}" var="item" varStatus="loop">

                            <th class="last_${loop.last}">${item.date}</th>
                        </c:forEach>
                    </tr>
                    <tr>
                        <td class="first">上架数量</td>
                        <c:forEach items="${up_down_record_list}" var="item" varStatus="stats">
                            <td><span data-date="${item.date}" data-status="1" class="up_record_list_${stats.index}" vda="link|fliter">${item.up_num}</span></td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <td class="first">下架数量</td>
                        <c:forEach items="${up_down_record_list}" var="item" varStatus="stats">
                            <td><span data-date="${item.date}" data-status="0" class="down_record_list_${stats.index}" vda="link|fliter">${item.down_num}</span></td>
                        </c:forEach>
                    </tr>
                </table>

                <div class="up_down_record_content goods-list shop-list ">
                    <ul class="clearfix"></ul>

                    <div class="pagination"></div>
                </div>

            </div>
        </div>

    </div>
    <div class="fl con-side cl_l side-list-box" <c:if test="${sidebar_good_shops_record_count <= 0}"> style="display:none;" </c:if>>

        <h2>
            <div class="mini-page fr page-box" <c:if test="${sidebar_good_shops_record_count <= 1}"> style="display:none;" </c:if>></div>
            推荐商品
        </h2>

        <div id="shopAdvsList">
            <c:forEach items="${sidebar_good_shops}" var="shop" begin="0" end="${sidebar_good_shops_record_count}" varStatus="stats">
                <ul class='side-list adv-list clearfix <c:if test="${stats.index==0}">showed</c:if>' <c:if test="${stats.index!=0}"> style="display:none"</c:if>>
                <c:forEach items="${shop.items}" var="el" varStatus="status">
                    <li class="clearfix">
                        <a href="${el.href_url}" title="${el.title}" target="_blank" class="j-vda ishide" vda="tp|ad_itemcard|${el.item_id}|${el.shop_id}|0|${status.count}">
                            <div class="pic">
                                <img data-original="${el.img_url}|220w_330h" class="lazy" src1="${staticDomain}/statics/assets/css/img/blank.gif"/>
                            </div>
                        </a>
                        <c:if test="${el.hot == 1}">
                            <i class="isRecommd"></i>qie
                        </c:if>
                        <div class="price">
                            <c:choose>
                                <c:when test="${el.price_type eq 1}">
                                    <span class="yuan">¥</span>${el.discount_price}
                                </c:when>
                                <c:when test="${el.price_type eq 2}">
                                    <span class="yuan">¥</span>${el.discount_price}
                                </c:when>
                                <c:otherwise>
                                    <strong class="yuan" style="display: none;">¥</strong>
                                    <strong class="sale"
                                            style="color: #9c9c9c;">价格错误
                                    </strong>
                                </c:otherwise>
                            </c:choose>

                        </div>
                        <i class="fl ico_item_active_${el.is_active} ico_item_active"></i>
                        <div class="pos">
                            <a target="_blank" href="/shop/${el.shop_id}" title="${el.shop_name}">
                                <c:if test="${el.is_gold_shop == 1}">
                                    <img src="${staticDomain}/statics/v2/css/img/common/gold.png" aglin="absmiddle" width="19">
                                </c:if>
                                ${el.shop_name}
                            </a>
                            <div class="more-info">
                                <div class="shop-pos fl">${el.sub_name} ${el.position}</div>
                                <div class="shop-ww fr">

                                    <a href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid=${el.ww_nickname_code}"
                                       target="_blank" title="${shop.name}" class="kf" vda="ww|ad_itemcard|${el.id}|0|0|${status.count}">
                                        <c:if test="${shop.ww_nickname_code!=''}">
                                            <img class="" src="http://www.vvic.com//api/online?nickname=${el.ww_nickname_code}"/>
                                        </c:if>
                                    </a>

                                </div>
                                <div class="clear"></div>

                                <c:if test="${el.authenticated == 1 || el.cloud_update == 1 || el.years > 1 || el.top > 0}">
                                    <div class="shop-icon fl clearfix">
                                        <c:if test="${el.authenticated == '1'}">
                                            <i class="cert j-v-tip" data-tip="cert"></i>
                                        </c:if>
                                        <c:if test="${el.cloud_update == '1'}">
                                            <i class="miao j-v-tip" data-tip="miao"></i>
                                        </c:if>
                                        <c:if test="${el.top > 0}">
                                            <i class="top${el.top} j-v-tip" data-tip="top" data-top="${el.top}"></i>
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
            </c:forEach>
        </div>



    </div>
    <div class="clear"></div>
    <div class="hot_shops" style="height: 380px;padding-bottom:0">
        <div class="title">
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
                                <span class="info" style="text-align: center">
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

<script type="text/x-handlebars-template" id="tpl">
    {{ _.each(list, function(item, index1){ }}
    <ul class="side-list adv-list clearfix {{ if(index1 == 0){ }} showed {{ } }}" {{ if(index1 != 0){ }} style="display:none;" {{ } }} >
        {{ _.each(item.items, function(el, index2){ }}
            <li class="clearfix ishide">
        <a href="{{=el.href_url}}" title="{{=el.title}}" target="_blank" class="j-vda ishide" vda="tp|ad_itemcard|{{=el.item_id}}|{{=el.shop_id}}|0|{{=el.shop_status}}">
            <div class="pic">
                <img src1="${staticDomain}/statics/assets/css/img/blank.gif" data-original="{{=el.img_url}}|220w_330h" class="lazy" />
            </div>
        </a>
        <div class="price">
            {{ if(el.price_type == 1){ }}
            <span class="yuan">¥</span>{{=el.discount_price}}
            {{ } }}
            {{if(el.price_type == 2){ }}
            <span class="yuan">¥</span>{{=el.discount_price}}
            {{ } }}
            {{if(el.price_type != 1 && el.price_type != 2){ }}
            <strong class="yuan" style="display: none;">¥</strong>
            <strong class="sale"
                    style="color: #9c9c9c;">价格错误
            </strong>
            {{ } }}
        </div>
        <i class="fl ico_item_active_{{=el.is_active}} ico_item_active"></i>
        <div class="pos">
            <a target="_blank" href="/shop/{{=el.shop_id}}" title="{{=el.shop_name}}">
                {{ if(el.is_gold_shop == 1){ }}
                <img src="${staticDomain}/statics/v2/css/img/common/gold.png" aglin="absmiddle" width="19">
                {{ } }}
                {{=el.shop_name}}
            </a>
            <div class="more-info">
                <div class="shop-pos fl">{{=el.sub_name}} {{=el.position}}</div>
                <div class="shop-ww fr">
                    <a href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid={{=el.ww_nickname_code}"
                       target="_blank" title="${shop.name}" class="kf" vda="ww|ad_itemcard|{{=el.id}}|0|0|{{=index2}}">
                        {{ if(el.ww_nickname_code!='') { }}
                            <img class="" src="http://www.vvic.com//api/online?nickname={{=el.ww_nickname_code}}"/>
                        {{ } }}
                    </a>
                </div>
                <div class="clear"></div>

                {{ if(el.authenticated == 1 || el.cloud_update == 1 || el.years > 1 || el.top > 0) { }}
                <div class="shop-icon fl clearfix">
                    {{ if(el.authenticated == '1'){ }}
                    <i class="cert j-v-tip" data-tip="cert"></i>
                    {{ } }}
                    {{ if(el.cloud_update == '1'){ }}
                    <i class="miao j-v-tip" data-tip="miao"></i>
                    {{ } }}
                    {{ if(el.top > 0){ }}
                    <i class="top{{=el.top}} j-v-tip" data-tip="top" data-top="{{=el.top}}"></i>
                    {{ } }}
                </div>
                {{ if(el.years > 1){ }}
                <div class="shop-year-icon year{{=el.years}} fr j-v-tip" data-tip="year" data-date="{{=el.start_business_date}}"></div>
                {{ } }}
                <div class="clear"></div>
                {{ } }}
            </div>
            <div class="triangle triangle-up1"></div>
            <div class="triangle triangle-up2"></div>
        </div>
    </li>
        {{ }) }}
    </ul>
    {{ }) }}
</script>

<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>

<script>
window.SHOP_ID = '${shop.id}'
window.RECORDCOUNT = '${shop_home_page.recordCount}'
window.CURRENTPAGE = '${shop_home_page.currentPage}'
window.PAGECOUNT = '${shop_home_page.pageCount}'
window.PAGESIZE = '${shop_home_page.pageSize}'
window.TCID = '${first_tcid}'
window.page = 'shop'
require(['web3/shop3'], function () {
});
</script>

<jsp:include page="common/third.jsp"/></body></html>
