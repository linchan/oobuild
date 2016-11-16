<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="pageTitle" value="订单详情" />
<c:if test="${param.m==1}">
	<c:set var="pageTitle" value="修改订单" />
</c:if>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="order3"/>
    <jsp:param name="cssHash" value="${cssHash.order3}"/>
    <jsp:param name="title" value="${pageTitle}"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="currentNav" value="99"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>
<!–[if lt IE 7]>
<script  type="text/javascript" src="${staticDomain}/statics/lib/json2.js"></script>
<![endif]–>

<div class="order">
	<form id="detailForm" method="get" action="">
	<c:if test="${param.m==1}">
	<!-- 修改订单地址表单 -->
	<div class="o-msg">取消已拿货商品会产生额外的手续费，手续费需买手自行承担！如有疑问请 <a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDAyNjY5M18zNjE3MDZfODAwMDI2NjkzXzJf" target="_blank">咨询客服 <i class="vvicon">&#xe62d;</i></a></div>
	<div class="o-box">
		<div class="o-box-t">
			收货地址
		</div>
		<div class="o-box-main">
			<fieldset class="o-address">
				<div class="item clearfix">
					<label><span class="required">*</span>所在地区：</label>
					<div id="regionBox"></div>
					<input type="text" id="region" name="region" style="padding:0;width:0;border:none;" />
				</div>
				<div class="item clearfix">
					<label><span class="required">*</span>详细地址：</label>
					<input type="text" id="address" name="address" class="input-address" />
				</div>
				<!-- <div class="item clearfix">
					<label>邮政编码：</label>
					<input type="zipcode" name="zipcode" id="zipcode" maxlength="6">
				</div> -->
				<div class="item clearfix">
					<label><span class="required">*</span>收货人：</label>
					<input type="text" name="consignee" id="consignee" />
				</div>
				<div class="item clearfix">
					<label><span class="required">*</span>手机号码：</label>
					<input type="mobile" name="mobile" id="mobile" maxlength="11" class="input-mobile" >
					<label class="label-tel">固定号码：</label>
					<input type="text" name="tel1" id="tel1" class="input-area_no j-tel-0" placeholder="区号" maxlength="4">
					<input type="text" name="tel2" id="tel2" class="input-tel j-tel-1" placeholder="电话号码" maxlength="8">
					<input type="text" class="j-tel" id="tel" style="padding:0;width:0;border:none;" name="tel">
				</div>
			</fieldset>
		</div>
	</div>
	<!-- 修改订单地址表单 -->
	</c:if>

	<c:if test="${param.m!=1}">
	<!-- 订单详情信息 -->
	<div class="o-box o-detail" id="orderInfo">

	</div>
	<!-- 订单详情信息 -->
	</c:if>

	<div class="o-box">
		<div class="o-box-t">
			商品信息
		</div>
		<div class="o-box-main">
			<div class="order-detail-list" id="orderDetail">
				<div class="loading3" style="height: 200px"></div>
			</div>
		</div>
	</div>


	<c:if test="${param.m==1}">
	<div class="o-box o-foot">
		<div class="o-foot-amount">
			<table width="100%">
				<!-- <tr>
					<td>运费总计：</td>
					<td nowrap="nowrap" class="o-foot-price"><span class="yuan">¥</span><em id="expressFee">0.00</em></td>
				</tr> -->
				<!-- <tr>
					<td>拿货费总计：</td>
					<td nowrap="nowrap" class="o-foot-price"><span class="yuan">¥</span><em id="purchaseFee">0.00</em></td>
				</tr> -->
				<c:if test="${param.m==1}">
				<tr>
					<td>手续费总计：</td>
					<td nowrap="nowrap" class="o-foot-price"><span class="yuan">¥</span><em id="handlingFee">0.00</em></td>
				</tr>
				</c:if>
				<!-- <tr>
					<td>商品总金额：</td>
					<td nowrap="nowrap" class="o-foot-price"><span class="yuan">¥</span><em id="goodsAmount">0.00</em></td>
				</tr> -->
				<c:if test="${param.m==1}">
				<tr>
					<td colspan="2" style="height: 10px;"></td>
				</tr>
				<!-- <tr>
					<td>应付总额：</td>
					<td nowrap="nowrap" class="o-foot-price"><span class="yuan">¥</span><em id="newOrderAmount">0.00</em></td>
				</tr> -->
				<tr>
					<td>- 已付总额：</td>
					<td nowrap="nowrap" class="o-foot-price"><span class="yuan">¥</span><em id="orderAmount">0.00</em></td>
				</tr>
				</c:if>
			</table>
		</div>
		<div class="o-foot-count">
			<span id="payText">应付总额</span>：<span class="yuan">¥</span><em id="payAmount">0.00</em>
		</div>
		<div class="o-foot-protocol checked j-protocol">
			<span class="check-txt">阅读并接受<a id="theP" href="http://www1.vvic.com/user_agreement.html" target="_blank">《搜款网代发服务协议》</a></span>
			<i class="vvicon check-item">&#xe627;</i><i class="vvicon uncheck-item">&#xe619;</i>
		</div>
		<div class="o-foot-btn">
			<a href="/user/orders.html" class="o-btn-back">返回订单列表</a>
			<input vda="action|edit_submit|tjdd|${param.order_id}" type="submit" value="提交订单" id="j_submit" class="disabled" />
		</div>
	</div>
	</c:if>
	<div class="clear"></div>
	</form>
</div>

<script type="text/x-handlebars-template" id="sameTemplate">
	<div class="find-same">
		<p style="line-height: 18px">找到合适的商品后，请将商品详情页的链接地址复制到下方输入框中，完成商品替换。<a href="/samestyle/{{=itemId}}" target="_blank">立即找同款 <font class="vvicon">&#xe62d;</font></a></p>
		<dl>
			<dt>
				<input type="text" placeholder="http://www.vvic.com/item/{{=itemId}}" value='' id="sameUrl">
			</dt>
			<dd class="j-add-same">
				提交
			</dd>
		</dl>
		<div class="err-info mt10">
			<i class="vvicon">&#xe616;</i>
			输入的链接地址有误或者商品不支持购买
		</div>
	</div>
	<div class="find-detail sku-edit-popup" data-color="{{=itemColor}}" data-size="{{=itemSize}}" data-price="{{=itemPrice}}" data-id="{{=orderDetailsId}}">

	</div>
</script>


<script type="text/x-handlebars-template" id="numberTemplate">
	<div class="modify-number">
		<ul class="number-info clearfix">
			<li>已拿货：<em class="{{if(hasPurchaseNum>0){ }}red{{}}}">{{=hasPurchaseNum}}</em></li>
			<li>待拿货：<em class="{{if(waitPurchaseNum>0){ }}red{{}}}">{{=waitPurchaseNum}}</em></li>
			<li>拿货中：<em class="{{if(ingPurchaseNum>0){ }}red{{}}}">{{=ingPurchaseNum}}</em></li>
			<li>缺货：<em class="{{if(notPurchaseNum>0){ }}red{{}}}">{{=notPurchaseNum}}</em></li>
		</ul>
		<div class="amount-stock clearfix">
            <span class="stock" id="J_Stock">
                <a href="javascript:void(0);" title="减1" hidefocus="" class="v-reduce vvicon {{if(count<=minNum){}}v-disable-reduce{{}}}"></a>
                <input id="j_iptAmount" type="text" data-count="{{=count}}" data-min="{{=minNum}}" value="{{=count}}" maxlength="3">
                <a href="javascript:void(0);" hidefocus="" class="v-increase vvicon v-disable-increase" title="加1"></a>
            </span>
        </div>
        <div class="clear"></div>
	</div>
</script>

<script type="text/x-handlebars-template" id="infoTemplate">
	{{ var orderStatusText = ['待付款','待审核','交易关闭','拿货中','打包中','配送中','交易成功','退款中','交易关闭']}}
	<div class="o-box-t">
		<a href="#" class="kf">客服咨询</a>
		<em class="o-date">{{=createTime}}</em>
		订单号：<em>{{=orderNo}}</em>
	</div>
	<div class="o-detail-info">
		<table height="100%" width="100%">
			<tr>
				<td class="o-status" width="275">
					<b>{{=orderStatusText[orderStatus]}}</b>
					{{ if(orderStatus==0){ }}
					<a href="#" class="btn-pay j-pay">立即付款</a>
					{{ } }}
				</td>
				<td>
					<ul>
						<li class="o-detail-t">订单信息</li>
						<li>
							<label>收件信息：</label>
							<span>{{=consignee}}</span>
							<em>{{=mobile}}</em>
							<span>{{=country}} {{=province}} {{=city}} {{=area}} {{=address}}</span>
						</li>
						<li><label>买家留言：</label></li>
						<li><label>物流公司：</label>{{=expressName}}</li>
						<li><label>运单号码：</label>{{=expressNo}}</li>
						<li><label>支付流水号：</label>{{=payNo}}</li>
						<li><label>支付方式：</label>{{=payName}}</li>
						<li><label>实付总金额（含运费）：</label><span class="o-detail-amount">¥<em>{{=orderAmount.toFixed(2)}}</em></span></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
</script>

<script type="text/x-handlebars-template" id="detailTemplate">
	{{ var orderStatusText = ['待付款','待审核','交易关闭','拿货中','打包中','配送中','交易成功','退款中','交易关闭']}}
	{{ var deliveryStatusText = ['', '待拿货', '拿货中', '缺货', '已拿货', '已拿货', '已拿货']}}
	{{ var refundStatusText = ['', '退货中', '退货中', '退货中', '退货中', '退货中', '退款中', '退款中', '已退款']}}
	<table class="tb-order tb-order-detail tb-order-edit">
		<thead>
			<tr>
				<th class="detail-col">商品</th>
				<th class="price-col">单价</th>
				<th class="count-col">数量</th>
				<th class="status-col">商品动态</th>
				<th class="amount-col">小计</th>
			</tr>
		</thead>
		<tbody>
			{{ _.each(orderDetails, function(item, index){ }}
			<tr class="tr-tb j-order" data-oid="{{=item.orderDetailsId}}" data-id="{{=item.itemId}}">
				<td>
					<dl class="order-item {{if(index==0){}}first{{}}} clearfix" data-oid="{{=item.orderDetailsId}}" data-id="{{=item.itemId}}">
						<dt class="detail-col">
							<div class="pic">
								<a href="/item/{{=item.itemId}}" target="_blank">
								<img src="{{=item.itemImg}}_230x230.jpg" alt="" width="70" view-src="{{=item.itemImg}}_230x230.jpg" class="j-img-view">
								</a>
							</div>
							<div class="info">
								<div class="info-title"><a href="/item/{{=item.itemId}}" target="_blank">{{=item.itemName}}</a></div>
								<div class="info-art-no">{{=item.itemSn}}#</div>
								<span class="info-shop"><a href="/shop/{{=item.shopId}}" target="_blank">{{=item.shopName}}</a></span>
							</div>
							<div class="sku item-props {{if(item.deliveryStatus<2){}}j-props{{}}}" data-id="{{=item.orderDetailsId}}" data-item-id="{{=item.itemId}}" data-shop-id="{{=item.shopId}}">
								{{if(item.deliveryStatus<2){}}
								<div class="edit j-edit" vda="action|editarea|xgsx|{{=orderId}}">修改</div>
								{{}}}
								<p class="sku-line">颜色：<span class="j-sku-color-{{=item.orderDetailsId}}">{{=(item.skuColor=='nocolor' ? '图片色' : item.skuColor) }}</span></p>
								<p class="sku-line">尺码：<span class="j-sku-size-{{=item.orderDetailsId}}">{{=(item.skuSize=='nosize' ? '均码' : item.skuSize) }}</span></p>

								<div class="sku-edit-popup">

								</div>
							</div>
							<div class="clear"></div>
						</dt>
					</dl>
				</td>
				<td class="price-col">
					<span class="yuan">¥</span><em>{{=parseFloat(item.skuPrice).toFixed(2)}}</em>
				</td>
				<td class="count-col">
					{{=item.itemNum}}
					<c:if test="${param.m==1}">
					{{if(item.deliveryStatus==3){}}
					<p class="count-tip">已拿{{=item.hasPurchaseNum}}件，缺货{{=item.notPurchaseNum}}件</p>
					{{}}}
					</c:if>
				</td>
				<td class="status-col">
					{{ if(item.refundStatus > 0){ }}
						<span>{{=refundStatusText[item.refundStatus]}}</span>
					{{ }else{ }}
						<span {{if(item.deliveryStatus!=0){}}class="status{{=item.deliveryStatus}}"{{}}}>{{=deliveryStatusText[item.deliveryStatus]}}</span>
						<c:if test="${param.m==1}">
							{{ if(item.deliveryStatus == 3 || item.deliveryStatus == 1 || item.deliveryStatus == 0){ }}
							<a data-price="{{=item.skuPrice}}" data-color="{{=item.skuColor}}" data-size="{{=item.skuSize}}" href="javascript:;" class='j-same-style' vda="action|editarea|ztk|{{=orderId}}">找同款</a>
							{{if(item.waitPurchaseNum+item.notPurchaseNum > 0){}}
							<a data-has="{{=item.hasPurchaseNum}}" data-wait="{{=item.waitPurchaseNum}}" data-count="{{=item.itemNum}}" data-ing="{{=item.ingPurchaseNum}}" data-not="{{=item.notPurchaseNum}}" data-status="{{=item.deliveryStatus}}" href="javascript:;" class='j-modify-amount' vda="action|editarea|xgsl|{{=orderId}}">修改数量</a>
							{{}}}
							{{ } }}

						</c:if>
					{{ } }}
				</td>
				<td class="amount-col red">
					¥ <em>{{=item.totalAmount.toFixed(2)}}</em>
				</td>
			</tr>
			{{ }) }}
			<tr class="tr-tb tr-tf">
			    <td rowspan="2" colspan="2" style="border-right:1px solid #EBEBEB;border-bottom:none;">
			        <c:if test="${1==0}">
			        <div class="">
			            <i class="vvicon check-item">&#xe627;</i>
			            <i class="vvicon uncheck-item">&#xe628;</i>
			            使用我的发货信息
			            <a href="#"><i class="vvicon">&#xe620;</i></a>
			        </div>
			        <div class="">
			            发货信息：
			            <span id="sendName">王晓春</span>
			            <em id="sendTel">18585252525</em>
			            <a href="#" class="btn btn-default btn-x-small" style="width: 40px;">编辑</a>
			        </div>
			        </c:if>
			    </td>
			    <td height="50" colspan="2" class="clearfix">
			        <span style="line-height: 30px;margin:10px 0 0 20px;display:block;width:60px;" class="fl">运费总计：</span>
			       	<c:if test="${param.m==1}">
			        <dl class="j-v-select v-select express-box fl dis" style="width:140px;margin:10px 0 0 20px;">
			            <dt>
			                <i></i>
			                <span>{{=expressName}}</span>
			            </dt>
			            <dd>

			                <ul class="j-v-select-ul"></ul>
			            </dd>
			        </dl>
			        </c:if>
			    </td>
			    <td class="tc amount-col red">
			    	<a href="/help/issue/daifa2.html" target="_blank"><i class="vvicon">&#xe620;</i></a>
			        <span class="yuan" style="margin-right: 3px;">¥</span><em class="j-exp-fee">{{=expressFee.toFixed(2)}}</em>
			    </td>
			</tr>
			<tr class="tr-tb tr-tf">
			    <td colspan="2"  style="border-bottom: none;line-height: 50px;text-align: left;" height="50">
			        <span style="margin-left:20px;">拿货费总计：</span>
			    </td>
			    <td class="amount-col red" style="border-bottom:none;">
			    	<a href="/help/issue/daifa2.html" target="_blank"><i class="vvicon">&#xe620;</i></a>
			        <span class="yuan">¥</span><em class="j-take-fee">{{=purchaseFee.toFixed(2)}}</em>
			    </td>
			</tr>
		</tbody>
	</table>
</script>

<script type="text/x-handlebars-template" id="skuTemplate">
	{{var sizeArray = size.split(',')}}
	{{var colorArray = color.split(',')}}
	{{var sizeId = size_id.split(',')}}
	{{var colorId = color_id.split(',')}}
	<div class="sku-edit-content" data-item-id="{{=itemId}}">
		{{if(change){}}
		<h1>{{=title}}</h1>
		{{}}}
	    <dl class="prop">
	        <dt>尺码：</dt>
	        <dd class="sizes">
	            <ul class="">
	                {{ if(size==''){ }}
	                <li data-pvid="nosize" data-size="nosize" class="j-prop-item selected">均码 <i class="vvicon"></i></li>
	                {{ }else{ }}
		                {{ _.each(sizeArray, function(el, index){ }}
		                <li data-pvid="{{=sizeId[index]}}" data-size="{{=el}}" class="j-prop-item {{if(itemSize == el){}}selected{{}}}">{{=el}} <i class="vvicon"></i></li>
		                {{ }); }}
	                {{ } }}
	            </ul>
	        </dd>
	    </dl>
	    <dl class="prop">
	        <dt>颜色：</dt>
	        <dd class="colors">
	            <ul class="">
	                {{ if(color==''){ }}
	                <li data-pvid="nocolor" data-color="nocolor" class="j-prop-item selected">图片色 <i class="vvicon"></i></li>
	                {{ }else{ }}
		                {{ _.each(colorArray, function(el,index){ }}
		                <li data-pvid="{{=colorId[index]}}" data-color="{{=el}}" class="j-prop-item {{if(itemColor == el){}}selected{{}}}">{{=el}} <i class="vvicon"></i></li>
		                {{ }); }}
	                {{ } }}
	            </ul>
	        </dd>
	    </dl>
	    {{if(change){}}
	    {{var diff = (discount_price-itemPrice).toFixed(2)}}
	    <dl class="prop">
	    	<dt>单价：</dt>
	    	<dd>
	    		 <span class="yuan">¥</span> <em id="selectPrice"> {{=discount_price}}</em>
	    		<span class="price-tip" {{if(diff==0){}}style="display: none;"{{}}}>
	    			（比原商品<span id="diffText">{{if(diff>0){}}贵{{}else{diff = Math.abs(diff)}}便宜{{}}}</span><span id="diffValue">{{=diff}}</span>元）
	    		</span>
	    	</dd>
	    </dl>
	    <div class="clear"></div>
    	<a href="javascript:;" class="btn-find-same">确定</a>
	    {{}}}
	    {{if(!change){}}
	    <div class="operate">
	        <a class="cancel j-cancel">取消</a>
	        <a class="add-cart j-cart-prop" data-id="" data-item_id="">确定</a>
	    </div>
	    {{}}}
	</div>
</script>


<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
	var _ORDERID = '${param.order_id}',
		_ORDEREDIT = '${param.m}'
    require(['order3/detail3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>

</body></html>
