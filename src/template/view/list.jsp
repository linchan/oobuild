<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="search3.css"/>
    <jsp:param name="title" value=""/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="pid" value="6"/>
    <jsp:param name="fixdHeaderClassName" value="header_fixed_able"/>

</jsp:include>


<div class="w">
    <div class="breadcrumb">
        <a href="/list.html" title="所有类目" vda="link|fliter|0|1">
            所有类目
        </a>
        <span class="keyword-box" style="display: none;">
            &nbsp;&gt;&nbsp;
            <span class="keyword">
                <span class="text"></span>
                <a href="/list.html" class="vvicon" vda="link|fliter|0|1">&#xe60a;</a>
            </span>
        </span>
        <div class="fr search-info ">
            <span class="overMax" style="display: none;">超过</span>
            <span class="totalTxt" style="display: none;">共</span>
            <span class="recordCount"></span>
            件相关商品
        </div>
    </div>

    <div class="screen">

        <div class="nav-category clearfix nav-adv" style="display: none;">
            <div class="nc-key">品牌</div>
            <div class="nc-value" id="brandList">
                <div class="adv-loading" style="height:60px; display:none;"></div>
                <div class="brand-list-inner"></div>
            </div>
        </div>

        <div class="nav-category clearfix nav-pid">
            <div class="nc-key">分类</div>
            <div class="nc-value">

                <div class="types">
                    <a href="#/pid/" class="h-item pid"  vda="link|fliter|0|1">全部</a>
                    <c:forEach items="${categorys}" var="item">
                        <a href="#/pid/${item.pid}" class="h-item pid pid_${item.pid}"
                           title="${item.pname}" vda="link|fliter|0|1">${item.pname}
                        </a>
                    </c:forEach>
                </div>
                <div style="display:none" class="more open">
                    <span>更多</span>
                    <i></i>
                </div>
            </div>
        </div>

        <c:forEach items="${categorys}" var="cat">

            <div class="catid_${cat.pid} catid">
                <c:forEach items="${cat.list}" var="list">

                    <div class="nav-category clearfix ">
                        <div class="nc-key">${list.tag_name}</div>
                        <div class="nc-value">

                            <div class="types show-more">
                                <c:forEach items="${list.catlist}" var="item">
                                    <a href="#/tcid/${item.tcid}" class="h-item tcid tcid_${item.tcid}"
                                       title="${item.tcname}" vda="link|fliter|0|1">${item.tcname}
                                    </a>
                                </c:forEach>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </div>

        </c:forEach>


        <div class="nav-category clearfix nav-market">
            <div class="nc-key">市场</div>
            <div class="nc-value">

                <div id="listMarket" class="types">
                    <a href="#/bid/" class="h-item bid" vda="link|fliter|0|1">全部</a>
                    <c:forEach items="${markets}" var="item" varStatus="midState">
                        <a href="#/bid/${item.bid}" class="h-item bid bid_${item.bid}"
                           title="${item.bname}" vda="link|fliter|0|1">${item.bname}
                        </a>
                    </c:forEach>
                </div>
                <div style="display:block" class="more open">
                    <span>更多</span>
                    <i></i>
                </div>
            </div>
        </div>
        <div class="nav-category clearfix last">
            <div class="nc-key">筛选</div>
            <div class="nc-value">
                <ul class="conditions">
                    <li class="c-item">
                        <div class="trigger"><i></i>
                            <span class="value">颜色</span>
                            <span class="colors-value value"></span>
                        </div>
                        <div class="line"></div>
                        <div class="overlay">
                            <div class="o-item">
                                <a class="o-item-all h-item" href="#/color/" title="全部" vda="link|fliter|0|1">全部</a>

                                <span class="colors"></span>
                            </div>
                        </div>
                    </li>
                    <li class="c-item">
                        <div class="trigger"><i></i>
                            <span class="value">尺码</span>
                            <span class="sizes-value value"></span>
                        </div>
                        <div class="line"></div>
                        <div class="overlay">
                            <div class="o-item">
                                <a class="o-item-all h-item" href="#/size/" title="全部" vda="link|fliter|0|1">全部</a>

                                <span class="sizes"></span>

                            </div>
                        </div>
                    </li>
                    <li class="c-item">
                        <div class="trigger"><i></i>
                            <span class="value">服务</span>
                            <span class="service-value value"></span>
                        </div>
                        <div class="line"></div>
                        <div class="overlay">
                            <div class="o-item o-item-btns service">
                                <ul class="checks">
                                    <li class="is_tx" data-value="is_tx">
                                        <i class=" vvicon">&#xe608;</i>
                                        <span>退现</span>
                                    </li>
                                    <li class="is_sp" data-value="is_sp">
                                        <i class=" vvicon">&#xe608;</i>
                                        <span>实拍</span>
                                    </li>
                                    <li class="cloud_update" data-value="cloud_update">
                                        <i class=" vvicon">&#xe608;</i>
                                        <span>秒更新</span>
                                    </li>
                                    <li class="is_df" data-value="is_df">
                                        <i class=" vvicon">&#xe608;</i>
                                        <span>一件代发</span>
                                    </li>

                                </ul>
                                <div class="btns">
                                    <div class="btn j-service-cancel">取消</div>
                                    <div class="btn btn-fill j-service-ok">确定</div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <c:if test="${fn:length(styles)>1}">
                        <li class="c-item c-item-style">
                            <div class="trigger"><i></i>
                                <span class="value">风格</span>
                                <span class="styles-value value"></span>
                            </div>
                            <div class="line"></div>
                            <div class="overlay">
                                <div class="o-item o-item-btns styles">
                                    <ul class="checks">
                                        <c:forEach items="${styles}" var="item" varStatus="midState">
                                            <li class="" data-value="${item}">
                                                <i class=" vvicon">&#xe608;</i>
                                                <span>${item}</span>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                    <div class="btns">
                                        <div class="btn j-style-cancel">取消</div>
                                        <div class="btn btn-fill j-style-ok">确定</div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </c:if>
                    <c:forEach items="${markets}" var="market" varStatus="midState">
                        <li class="c-item j-market j-market-${market.bid}" style="display: none;">
                            <div class="trigger"><i></i>
                                <span class="value">楼层</span>
                                <span class="floors-value value"></span>
                            </div>
                            <div class="line"></div>
                            <div class="overlay">
                                <div class="o-item">

                                    <a class="o-item-all h-item" href="#/floor/" title="全部" vda="link|fliter|0|1">全部</a>
                                    <span class="floors">
                                        <c:forEach items="${market.floors}" var="item" varStatus="midState">
                                            <a class="h-item floor-item j-floor-${market.bid}-${item.subBid}-${item.floor}"
                                               data-floor="${item.floor}" data-subBid="${item.subBid}"
                                               data-subarea="${item.subarea}" href="#/subBid/${item.subBid}/floor/${item.floor}/subarea/${item.subarea}" vda="link|fliter|0|1">
                                                <c:choose>
                                                    <c:when test="${item.subName!=item.bname}">
                                                        ${item.subName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${item.floor}楼 ${item.subarea}
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                        </c:forEach>
                                    </span>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>


    </div>


    <div class="search_noresult_ads clearfix" style="display: none;">
<!--“<span class="keyword"></span>”-->
        <div class="top_tip">
            没有找到相关的商品，为您推荐以下结果：
        </div>
        <ul class="side-list clearfix">
            <!--搜索无结果-->
        </ul>
    </div>

    <div class="fl search-main">
        <div class="goods-sort">
            <div class="pro-sort">
                <div class="s-b-right mini-page">
                    <!--<span class="vam pageinfo"><span class="text-error  currentPage">1</span>/100</span>-->
                </div>
                <div class="s-b-left clearfix">
                    <ul>
                        <a href="#/sort/default" class="h-item  sort-default" vda="link|fliter|0|1">
                            <span>综合</span>
                        </a>

                        <a  class="h-item clk price" data-asc="sort-price-asc" data-desc="sort-price-desc" data-sort="price" vda="link|fliter|0|1">
                            <span>价格</span>
                            <i class="sort-up vvicon">&#xe60d;</i>
                            <i class="sort-down vvicon">&#xe609;</i>
                        </a>

                        <a class="h-item clk up_time" data-asc="sort-up_time-asc" data-sort="up_time" vda="link|fliter">
                            <span>上新时间</span>
                            <i class="sort-up vvicon">&#xe60d;</i>
                            <i class="sort-down vvicon">&#xe609;</i>
                        </a>

                        <a class="h-item clk hot" data-asc="hot-asc" data-sort="hot" vda="link|fliter|0|1">
                            <span>销量</span>
                            <i class="sort-up vvicon">&#xe60d;</i>
                            <i class="sort-down vvicon">&#xe609;</i>
                        </a>

                        <li class="item price">

                                <!--<em class="vam">¥</em>-->
                                <input type="text" name="price_start" class="price_start vam fl price-box ml" placeholder="¥ 最低价">

                            <div class="fl line"></div>

                                <!--<em class="vam">¥</em>-->
                                <input type="text" name="price_end" class="price_end vam fl price-box" placeholder="¥ 最高价">


                            <div class="btn price_start_end" style="display: none;">确定</div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="goods-list clearfix">
            <ul class="clearfix search-content">
                <!--搜索结果-->
            </ul>

            <div class="loading3" style="height: 380px;"></div>
        </div>


        <div class="pagination">

        </div>
    </div>
    <div class="fr side-list-box ">
        <h2> 推荐商品 </h2>
        <ul class="side-list clearfix">
            <!-- js 异步数据 -->
        </ul>
    </div>
    <div class="clear"></div>

    <div class="con-detail">
        <h2 class="title" style="font-size:22px;">
            <div class="mini-page fr page-box"></div>
            人气商品
        </h2>
        <div class="con-list" style="margin-top:0;" id="bottomContent">

        </div>
        <div class="clear"></div>
    </div>
</div>
<script type="text/x-handlebars-template" id="bottomTemplate">
        <ul class="side-list clearfix">
        {{ _.each(list, function(item, index){ }}
            <li class="fl">
                {{if(item.hot==1){}}
                <i class="isRecommd isRecommd_{{=item.hot}}"></i>
                {{}}}
                <a target="_blank" href="{{=item.url}}" class="pic showed j-vda" vda="tp|hotitem|{{=item.item_id}}|{{=item.shop_id}}|0|{{=item.id}}">
                    <img src="{{=item.index_img_url}}|260w_390h" />
                </a>
                <div class="price">
                    <span class="yuan">¥</span>{{=item.discount_price}}
                </div>
                <div class="pos">
                    <a target="_blank" href="/shop/{{=item.shop_id}}" title="{{=item.shop_name}}" vda="tp|hotitem|{{=item.item_id}}|{{=item.shop_id}}|0|{{=item.id}}">
                        {{ if(item.is_gold_shop == 1){ }}
                            <img src="${staticDomain}/statics/v2/css/img/common/gold.png" aglin="absmiddle" width="19">
                        {{ } }}
                        {{=item.shop_name}}
                    </a>
                    <div class="more-info">
                        <div class="shop-pos fl">{{=item.sub_name}} {{=item.position}}</div>
                        <div class="shop-ww fr">
                            <a target="_blank" href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid={{=item.ww_nickname}}" vda="ww|hotitem|{{=item.item_id}}|{{=item.shop_id}}|0|{{=item.id}}">
                                <img src="http://www.vvic.com/api/online?nickname={{=item.ww_nickname}}" class="" alt="">
                            </a>
                        </div>
                        <div class="clear"></div>
                        <div class="shop-icon fl shop-icon_{{=item.is_shop_auth}}{{=item.cloud_update}}{{=item.top}}">
                            <i class="cert cert_{{=item.is_shop_auth}} j-v-tip" data-tip="cert"></i> <i class="miao miao_{{=item.cloud_update}} j-v-tip" data-tip="miao"></i> <i class="top{{=item.top}} j-v-tip" data-tip="top" data-top="{{=item.top}}"></i>
                            <div class="clear"></div>
                        </div>
                        <div class="shop-year-icon year{{=item.years}} fr j-v-tip" data-tip="year" data-date="{{=item.start_business_date}}"></div>
                        <div class="clear"></div>
                    </div>
                    <div class="triangle triangle-up1"></div>
                    <div class="triangle triangle-up2"></div>
                </div>
            </li>
        {{ }) }}
        </ul>
</script>

<script type="text/x-handlebars-template" id="cardTemplate">
    {{ _.each(list, function(item, index){ }}
        {{var blockName = item.hot ? 'topcard' : 'itemcard'}}
        <li>
            {{if(item.hot==1){}}
            <i class="isRecommd isRecommd_{{=item.hot}}"></i>
            {{}}}
            <div class="item">
                <div class="pic">
                    <a target="_blank" href="/item/{{=item.item_id}}" class="j-vda" vda="tp|{{=blockName}}|{{=item.item_id}}|0|0|{{=item.count}}">
                        <img  class="lazy" data-original="{{=item.index_img_url}}_230x230.jpg">
                    </a>
                    <div class="ctrl clearfix">
                        <span class="upload" data-id="{{=item.item_id}}" data-tid="{{=item.tid}}" data-price="{{=item.discount_price}}" vda="yjsc|{{=blockName}}|{{=item.item_id}}|0|0|{{=item.count}}">一键上传</span>
                        <span class="addFav" data-id="{{=item.item_id}}" vda="sc|{{=blockName}}|{{=item.item_id}}|0|0|{{=item.count}}">收藏</span>
                        <a target="_blank" href="/samestyle/{{=item.item_id}}" title="" vda="ztk|{{=blockName}}|{{=item.item_id}}|0|0|{{=item.count}}"><span>找同款</span></a>
                    </div>
                </div>
                <div class="desc">
                    <div class="info clearfix">
                        <span class="fr up_time">{{=item.up_time}}</span>
                        <div class="fl price">
                            <span class="yuan">¥</span>{{=item.discount_price}}
                        </div>
                        <i class="fl ico_item_active_{{=item.is_active}} ico_item_active"></i>
                        <div class="fr sales"><span class="num">{{=item.sales || 0}}</span>件代发</div>

                    </div>
                    <div class="title">
                        <a target="_blank" href="/item/{{=item.item_id}}" vda="spbt|{{=blockName}}|{{=item.item_id}}|0|0|{{=item.count}}">{{=item.title}}</a>
                    </div>
                    <div class="clearfix shop-name-box">
                        <div class="fr num j_clip_button art_no_{{=item.art_no}}"> {{=item.art_no}}# </div>
                        <a class=" shop-name" target="_blank" href="/shop/{{=item.shop_id}}" title="{{=item.bname}} {{=item.position}}" vda="dkh|{{=blockName}}|{{=item.item_id}}|{{=item.shop_id}}|0|{{=item.count}}"><span class="inner">{{=item.sub_name}} {{=item.floor}}楼{{=item.subarea}} {{=item.position}}</span></a>
                    </div>
                    <div class="foot clearfix">
                        <div class="fl pos tb">
                            <a target="_blank" href="/shop/{{=item.shop_id}}" class="vam" title="{{=item.shop_name}}" vda="dkmc|{{=blockName}}|{{=item.item_id}}|{{=item.shop_id}}|0|{{=item.count}}">{{=item.shop_name}}</a>
                            <a target="_blank" href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid={{=item.ww_nickname}}" vda="ww|{{=blockName}}|{{=item.item_id}}|{{=item.shop_id}}|0|{{=item.count}}">
                                <img class="vam lazy" data-original="http://www.vvic.com/api/online?nickname={{=item.ww_nickname}}">
                            </a>
                            <div class="more-info">
                                <div class="shop-pos"> {{=item.sub_name}} {{=item.floor}}楼{{=item.subarea}} {{=item.position}} </div>
                                {{ if(item.is_shop_auth==1 || item.cloud_update==1 || item.top > 0 || item.year >1 || item.is_gold_shop==1){ }}
                                <div class="shop-icon fl clearfix">
                                    {{ if(item.is_shop_auth==1){ }}
                                    <i class="cert j-v-tip" data-tip="cert"></i>
                                    {{ } }}
                                    {{ if(item.cloud_update==1){ }}
                                    <i class="miao j-v-tip" data-tip="miao"></i>
                                    {{ } }}
                                    {{ if(item.top>0){ }}
                                    <i class="top{{=item.top}} j-v-tip" data-tip="top" data-top="{{=item.top}}"></i>
                                    {{ } }}
                                    {{ if(item.years>1){ }}
                                    <i class="shop-year-icon j-v-tip year{{=item.years}} fr" data-tip="year" data-date="{{=item.start_business_date}}"></i>
                                    {{ } }}
                                </div>
                                {{ if(item.is_gold_shop == 1){ }}
                                <div class="shop-gold fr">
                                    <img src="${staticDomain}/statics/v2/css/img/common/gold.png" width="19">
                                </div>
                                {{ } }}
                                {{ } }}
                                <div class="clear"></div>
                            </div>
                            <div class="triangle triangle-up1"></div>
                            <div class="triangle triangle-up2"></div>
                        </div>
                        <div class="service-icon service-icon-tg fr">
                            {{ if(item.is_sp){ }}
                            <div class="s-item sp j-v-tip" data-tip="sp"><i></i></div>
                            {{ } }}
                            {{ if(item.is_tx){ }}
                            <div class="s-item tx j-v-tip" data-tip="tx"><i></i></div>
                            {{ } }}
                            {{ if(item.is_df){ }}
                            <div class="s-item df j-v-tip" data-tip="df"><i></i></div>
                            {{ } }}
                        </div>
                    </div>
                </div>
            </div>
        </li>
    {{ }) }}
</script>

<script type="text/x-handlebars-template" id="sideTemplate">
    {{ _.each(list, function(item, index){ }}
    <li class="fl">
        {{if(item.hot==1){}}
        <i class="isRecommd isRecommd_{{=item.hot}}"></i>
        {{}}}
        <a target="_blank" href="item/{{=item.item_id}}"  class="pic j-vda" vda="tp|ad_itemcard|{{=item.item_id}}|0|0|{{=item.count}}">
            <img class="lazy" data-original="{{=item.index_img_url}}|220w_330h"/>
        </a>
        <div class="price">
            <span class="yuan">¥</span>{{=item.discount_price}}
        </div>
        <div class="pos">
            <a target="_blank" href="/shop/{{=item.shop_id}}" title="{{=item.shop_name}}" vda="tp|ad_itemcard|{{=item.item_id}}|{{=item.shop_id}}|0|{{=item.count}}">
                {{ if(item.is_gold_shop == 1){ }}
                <img src="${staticDomain}/statics/v2/css/img/common/gold.png" aglin="absmiddle" width="19">
                {{ } }}
                {{=item.shop_name}}
            </a>
            <div class="more-info">
                <div class="shop-pos fl">{{=item.sub_name}} {{=item.position}}</div>
                <div class="shop-ww fr">
                    <a target="_blank" href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid={{=item.ww_nickname}}" vda="ww|ad_itemcard|{{=item.item_id}}|{{=item.shop_id}}|0|{{=item.count}}">
                        <img src="http://www.vvic.com/api/online?nickname={{=item.ww_nickname}}" class="" alt="" src="">
                    </a>
                </div>
                <div class="clear"></div>
                {{ if(item.is_shop_auth==1 || item.cloud_update==1 || item.top > 0 || item.years >1){ }}
                <div class="shop-icon fl clearfix">
                    {{ if(item.is_shop_auth==1){ }}
                    <i class="cert j-v-tip" data-tip="cert"></i>
                    {{ } }}
                    {{ if(item.cloud_update==1){ }}
                    <i class="miao j-v-tip" data-tip="miao"></i>
                    {{ } }}
                    {{ if(item.top > 0){ }}
                    <i class="top{{=item.top}} j-v-tip" data-tip="top" data-top="{{=item.top}}"></i>
                    {{ } }}
                </div>
                {{ if(item.years > 1){ }}
                <i class="shop-year-icon year{{=item.years}} fr j-v-tip" data-tip="year" data-date="{{=item.start_business_date}}"></i>
                {{ } }}
                <div class="clear"></div>
                {{ } }}
            </div>
            <div class="triangle triangle-up1"></div>
            <div class="triangle triangle-up2"></div>
        </div>
    </li>
    {{ }) }}
</script>

<script type="text/x-handlebars-template" id="brandTemplate">
    <ul class="advs-list">
        {{ _.each(list, function(item, index){ }}
        <li class="advs-cell">
            <a href="/shop/{{=item.shop_id}}" target="_blank" vda="cp|brandlist|0|{{=item.shop_id}}|0|{{=index+1}}">
                <span class="adv-shop-icon">
                    <img class="lazy" data-original="{{=item.img_url}}" />
                </span>
                <span class="adv-shop-desc">
                    {{=item.marketName}} {{=item.position}}
                </span>
            </a>
        </li>
        {{ }) }}
    </ul>
</script>

<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>
<script>
    require(['web3/search3'], function (main) {
        main.initListPage()
    });
    window.PAGENAME = 'list'
    window.STYLES = '${styles}'
</script>
<jsp:include page="common/third.jsp"/>
</body></html>
