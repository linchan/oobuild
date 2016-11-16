<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit">
    <title>一键上传 - 搜款网 - 广州最大的网批平台</title>
    <meta name="keywords" content="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网">
    <meta name="description" content="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网">
    <link rel="stylesheet" href="${staticDomain}/statics/v2/css/index3.css?20160919">
    <link rel="stylesheet" href="${staticDomain}/statics/v2/css/tool3.css?20160919">
    <link href="${staticDomain}/favicon.ico" type="image/x-icon" rel="shortcut icon">
</head>
<body>
	<jsp:include page="common/topbar.jsp">
	    <jsp:param name="homeBtn" value="true" />
		<jsp:param name="hideNav" value="1" />
	</jsp:include>

	<div class="search-warp">
		<div class="warp">
			<div class="title">
				<img src="${staticDomain}/statics/v2/css/img/tool/title3.png" width="112" height="28">
			</div>
			<div class="search">
				<div class="clear"></div>
				<div class="search-box">
					<i></i>
					<input id="q" type="text"  placeholder="商品详情页URL">
					<input type="submit" value="提交" id="submit">
				</div>
				<div class="tips">
					支持淘宝、1688、美丽说、蘑菇街、搜款网的商品链接
				</div>
			</div>
		</div>
	</div>
	<div class="warp main">
		<ul class="desc">
			<li class="dpt">
				<span class="vvicon">&#xe645;</span>
				<h3>多平台</h3>
				<p>支持淘宝、阿里巴巴等多平台</p>
			</li>
			<li class="znpp">
				<span class="vvicon">&#xe646;</span>
				<h3>智能匹配</h3>
				<p>自动匹配商品类目、属性，无需手工输入</p>
			</li>
			<li class="plsc">
				<span class="vvicon">&#xe644;</span>
				<h3>支持模板</h3>
				<p>根据模板批量上传，节省时间</p>
			</li>
		</ul>
		<div class="clear"></div>
		<div class="hot-adv-list">
			<h2>
				<div class="mini-page fr page-box"></div>
				为您推荐
			</h2>
			<div class="item-list">
				<div class="bd" id="list">
					<div class="loading3" style="height:370px;"></div>
				</div>
				<div class="clear"></div>
			</div>
		</div>

	</div>
	<jsp:include page="common/footer.jsp">
		<jsp:param name="hideFixBar" value="1" />
	</jsp:include>
	<jsp:include page="common/footjs.jsp">
		<jsp:param name="hideFixBar" value="1" />
	</jsp:include>

	<script type="text/x-handlebars-template" id="tpl">
		{{ _.each(list, function(array, index){ }}
			<ul class="side-list adv-list clearfix {{ if( index == 0){ }}showed{{ } }}" {{ if( index != 0 ){ }}style="display:none;"{{ } }} >
				{{ _.each(array, function(item, index0){ }}
				<li class="fl">
					{{if(item.hot==1){}}
					<i class="isRecommd isRecommd_{{=item.hot}}"></i>
					{{}}}
					<a target="_blank" href="{{=item.href_url}}" class="pic showed j-vda" vda="tp|hotitem|{{=item.item_id}}|{{=item.shop_id}}|0|{{=item.id}}">
						<img src="{{=item.img_url}}|260w_390h" />
					</a>
					<div class="price">
						<span class="yuan">¥</span>{{=item.discount_price}}
					</div>
					<div class="pos">
						<a target="_blank" href="/shop/{{=item.shop_id}}" title="{{=item.shop_name}}" vda="tp|hotitem|{{=item.item_id}}|{{=item.shop_id}}|0|{{=item.id}}">
						{{ if(item.is_gold_shop == 1){ }}
						<img src="http://src.vvic.com/statics/v2/css/img/common/gold.png" aglin="absmiddle" width="19">
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
							<div class="shop-icon fl shop-icon_{{=item.authenticated}}{{=item.cloud_update}}{{=item.top}}">
								{{ if(item.authenticated != 0){ }}
								<i class="cert cert_{{=item.authenticated}} j-v-tip" data-tip="cert"></i>
								{{ } }}
								{{ if(item.cloud_update != 0){ }}
								<i class="miao miao_{{=item.cloud_update}} j-v-tip" data-tip="miao"></i>
								{{ } }}
								<i class="top{{=item.top}} j-v-tip" data-tip="top" data-top="{{=item.top}}"></i>
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
		{{ }) }}
	</script>
	<script>
		require(['tools3/tool3'], {});
	</script>
	<%@ include file="common/third.jsp"%>
</body>
</html>
