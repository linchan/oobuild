<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="search3"/>
    <jsp:param name="cssHash" value="${cssHash.search3}"/>
    <jsp:param name="title" value="找同款"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="currentNav" value="99"/>
    <jsp:param name="fixdHeaderClassName" value="header_fixed_able"/>

</jsp:include>


<style>
    .search-main {
        width: 1190px
    }
    .goods-list {
        width: 1190px
    }
</style>


<div class="w">
	<div class="item-goods mt10 clearfix" id="itemContent">
		<div class="loading3" style="height:110px;"></div>
		<script type="text/x-handlebars-template" id="itemTemplate">
			<div class="pic fl">
				<a href="/item/{{=id}}" title="{{=title}}" vda="tp|iteminfo|{{=id}}|0|0|0"><img data-original="{{=index_img_url}}_130x130.jpg" alt="{{=title}}" class="lazy"/></a>
			</div>
			<div class="desc fl">
				<div class="title">
					<a href="/item/{{=id}}" title="{{=title}}" vda="spbt|iteminfo|{{=id}}|0|0|0">{{=title}}</a>
				</div>
				<div class="price"><span class="yuan">¥</span>{{=discount_price}}</div>
				<div class="info">
					<a href="/shop/{{=shop_id}}" class="info-shop vam" title="{{=shop_name}}" target="_blank" vda="dkh|iteminfo|0|{{=shop_id}}|0|0">
					{{=shop_name}}</a>
					<a target="_blank" href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid={{=ww_nickname}}" vda="ww|iteminfo|0|{{=shop_id}}|0|4"> <img class="info-ww vam" src="http://www.vvic.com/api/online?nickname={{=ww_nickname}}"> </a>
                    {{ if(years>1 || is_shop_auth == 1 || cloud_update==1 || top>0){ }}
					<div class="shop-icon fl">
						<div class="shop-year-icon year{{=years}} fl j-v-tip" data-tip="year" data-date="{{=start_business_date}}" style="margin-right: 3px;"></div>
						<i class="cert cert_{{=is_shop_auth}} j-v-tip" data-tip="cert"></i>
						<i class="miao miao_{{=cloud_update}} j-v-tip" data-tip="miao"></i>
						<i class="top{{=top}} j-v-tip" data-tip="top" data-top="{{=top}}"></i>
						<div class="clear"></div>
					</div>
                    {{ } }}
				</div>
				<div class="clear"></div>
				<a class="upload mt20" data-id="{{=id}}" data-tid="{{=tid}}" data-price="{{=discount_price}}" vda="yjsc|iteminfo|{{=id}}|0|0|0">一键上传</a>
			</div>

		</script>
	</div>


    <div class="fl search-main">
        <div class="goods-sort">
            <div class="pro-sort">
                <div class="s-b-right">
                    <div class="fr search-info ">
                        <span class="overMax" style="display: none;">超过</span>
                        <span class="totalTxt" style="display: none;">共</span>
                        <span class="recordCount" style="color:#333"></span>
                        件相关商品
                    </div>
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

                        <a class="h-item clk up_time" data-asc="sort-up_time-asc" data-sort="up_time" vda="link|fliter|0|1">
                            <span>上新时间</span>
                            <i class="sort-up vvicon">&#xe60d;</i>
                            <i class="sort-down vvicon">&#xe609;</i>
                        </a>

                        <a class="h-item clk hot" data-asc="hot-asc" data-sort="hot" vda="link|fliter|0|1">
                            <span>热度</span>
                            <i class="sort-up vvicon">&#xe60d;</i>
                            <i class="sort-down vvicon">&#xe609;</i>
                        </a>

                        <li class="item price">
                            <input type="text" name="price_start" class="fl price-box ml price_start vam"
                                   placeholder="¥ 最低价">
                            <div class="fl line"></div>
                            <input type="text" name="price_end" class="fl price-box price_end vam" placeholder="¥ 最高价">

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

        <div class="pagination"></div>
    </div>

    <div class="empty-tip" style="display:none;">
        <span class="vvicon">&#xe614;</span>
        <div class="text">没有找到相关商品
        </div>
    </div>

    <div class="clear"></div>

</div>

<script type="text/x-handlebars-template" id="cardTemplate">
    {{ _.each(list, function(item, index){ }}
        {{var blockName = item.hot ? 'topcard' : 'itemcard'}}
        <li>
            <i class="isRecommd isRecommd_{{=item.hot}}"></i>
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


<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>
<script>
	var ID = '${id}'
    require(['web3/samestyle3'], function () {
    });
</script>
<jsp:include page="common/third.jsp"/>

</body>
</html>
