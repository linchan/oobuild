<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="user3"/>
    <jsp:param name="cssHash" value="${cssHash.user3}"/>
    <jsp:param name="title" value="个人中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>
<link href="${staticDomain}/statics/lib/datepick/dp.css" rel="stylesheet" type="text/css" />
<div class="w user-w">
	<div class="user-left">
		<jsp:include page="usernav.jsp">
			<jsp:param name="bigClass" value="2" />
			<jsp:param name="smallClass" value="0" />
		</jsp:include>
	</div>
	<div class="user-main">
		<div class="main-wrap">
			<div class="main-title">
				我的订单
			</div>

			<div class="order-main">
				<div class="vv-tag order-tag">
					<ul>
						<li<c:if test="${param.t eq null}"> class='curr'</c:if>><a href="/user/orders.html" data-type=''>所有订单</a></li>
						<li<c:if test="${param.t eq '0'}"> class='curr'</c:if>><a href="/user/orders.html?t=0" data-type='0'>待付款</a></li>
						<li<c:if test="${param.t eq '3'}"> class='curr'</c:if>><a href="/user/orders.html?t=3" data-type='3'>拿货中</a></li>
						<li<c:if test="${param.t eq '5'}"> class='curr'</c:if>><a href="/user/orders.html?t=5" data-type='5'>配送中</a></li>
						<!-- <li<c:if test="${param.t eq '6'}"> class='curr'</c:if>><a href="/user/orders.html?t=6" data-type='6'>交易成功</a></li> -->
						<li<c:if test="${param.t eq '7'}"> class='curr'</c:if>><a href="/user/orders.html?t=7" data-type='7'>退货退款</a></li>
						<!-- <li<c:if test="${param.t eq '2'}"> class='curr'</c:if>><a href="/user/orders.html?t=2" data-type='2'>交易关闭</a></li> -->
					</ul>
					<c:if test="${param.t == null}">
					<div class="order-search fr">
						<a id="searchOrder">搜索订单</a>
						<input type="text" id="Q" placeholder="订单号、收货人姓名、快递单号" />
					</div>
					</c:if>
				</div>
				<div class="order-srceen">
					<div class="order-date-section">
						<span>时间：</span>
						<div class="date-select clearfix">
							<input type="text" readonly="readonly" class="input-date j-date" id="startDate" placeholder="选择时间">
						</div>
						<span class="vvicon split">&#xe61e;</span>
						<div class="date-select clearfix">
							<input type="text" readonly="readonly" class="input-date j-date" id="endDate" placeholder="选择时间">
						</div>
						<div class="date-search j-date-search">搜索</div>
					</div>
					<div class="clear"></div>
				</div>
				<div class="loading3" style="height: 200px"></div>
				<div class="order-list" id="order-content">
				</div>
				<div class="empty-tip" style="display: none">
					<span class="vvicon">&#xe614;</span>
				    <div class="text">无记录</div>
				</div>
				<div class="pagination">
	                <!--分页-->
	            </div>
			</div>
		</div>
	</div>
	<div class="clear"></div>
</div>

<script type="text/x-handlebars-template" id="template">
	<table class="tb-order">
		<thead>
			<tr>
				<th class="detail-col">商品</th>
				<th class="price-col">单价</th>
				<th class="count-col">数量</th>
				<th class="status-col">商品动态</th>
				<th class="amount-col">实付款</th>
				<th class="operate-col">操作</th>
			</tr>
		</thead>
		{{ var orderStatusText = ['待付款','待审核','交易关闭','拿货中','拿货中','配送中','交易成功','退款中','交易关闭']}}
		{{ var deliveryStatusText = ['', '待拿货', '拿货中', '缺货', '已拿货', '已拿货', '已拿货']}}
		{{ var refundStatusText = ['', '退货中', '退货中', '退货中', '退货中', '退货中', '退款中', '退款中', '已退款']}}
		{{ _.each(data.listData, function(el){ }}
		<tbody data-oid="{{=el.orderId}}" data-ono="{{=el.orderNo}}">
			<tr class="blank"><td colspan="6"></td></tr>
			<tr class="tr-th tr-title">
				<td colspan="6">
					<div class="tr-title-link">
						{{ if(el.orderStatus == 3 || el.orderStatus == 5 || el.orderStatus == 6 || el.orderStatus == 7){ }}
						{{ } }}
						{{ if(el.orderStatus == 2 || el.orderStatus == 8){ }}
							<a href="javascript:;" class="j-order-del"><i class="vvicon">&#xe625;</i> 删除</a>
						{{ }else{ }}
							<a href="javascript:;" class="j-service" vda="action|editarea|lxkf|{{=el.orderStatus}}">客服咨询</a>
						{{ } }}

						<c:if test="${1==0}">
						<a href="/user/order_detail.html?order_id={{=el.orderId}}" target="_blank" vda="action|editarea|ddxq">订单详情</a>
						</c:if>
					</div>
					<span class="tr-title-status">
						{{=orderStatusText[el.orderStatus] }}
					</span>
				</td>
			</tr>
			<tr class="tr-th tr-info">
				<td colspan="6">
					<span>
						<em>{{- _(el.createTime).formatDate('yyyy-MM-dd')}}</em>
					</span>
					<span>
						订单号：<em>{{=el.orderNo}}</em>
					</span>
					<span>收货信息：{{=el.consignee}} {{=el.city}} <em>{{=el.mobile}} {{=el.tel}}</em></span>
				</td>
			</tr>
			<tr class="tr-tb j-order">
				<td colspan="4">
					{{ _.each(el.orderDetails, function(item, index){ }}
					<dl class="order-item {{if(index==0){}}first{{}}} clearfix">
						<dt class="detail-col">
							<div class="pic">
								<a href="/item/{{=item.itemId}}" target="_blank"><img src="{{=item.itemImg}}_230x230.jpg" view-src="{{=item.itemImg}}_230x230.jpg" class="j-img-view" alt="" width="70"></a>
							</div>
							<div class="info">
								<div class="info-title"><a href="/item/{{=item.itemId}}" target="_blank">{{=item.itemName}}</a></div>
								<div class="info-art-no" title="{{=item.itemSn}}#">{{=item.itemSn}}#</div>
								<span class="info-shop"><a href="/shop/{{=item.shopId}}" target="_blank">{{=item.shopName}}</a></span>
							</div>
							<div class="sku">
								{{ if(item.skuColor != '') { }}
								<div class="sku-color">颜色：{{=item.skuColor=='nocolor'?'图片色':item.skuColor}}</div>
								{{ } }}
								{{ if(item.skuSize != '') { }}
								<div class="sku-size">尺码：{{=item.skuSize=='nosize'?'均码':item.skuSize}}</div>
								{{ } }}
							</div>
							<div class="clear"></div>
						</dt>
						<dd class="price-col"><span class="yuan">¥</span><em>{{=item.skuPrice.toFixed(2)}}</em></dd>
						<dd class="count-col">{{=item.itemNum}}</dd>
						<dd class="status-col">
							{{ if(el.orderStatus != 2 && el.orderStatus != 8){ }}

								{{ if(item.refundStatus > 0){ }}
									<span>{{=refundStatusText[item.refundStatus]}}</span>
								{{ }else{ }}
									<span class="status{{=item.deliveryStatus}}">{{=deliveryStatusText[item.deliveryStatus]}}</span>

									{{ if(item.deliveryStatus == 2 || item.deliveryStatus == 3){ }}
										<div class="lack-tips express-view take-view" data-odid="{{=item.orderDetailsId}}">
											{{var expressLink = _.getExpressQuery(el.expressCode)}}
											<a class="btn btn-default btn-x-small d-view-btn" href="javascript:;" target="_blank" vda="action|editarea|ckxq">查看详情</a>
											<div class="lack-txt express-info">
												<ol class="delivery-list">
													<div class="loading3" style="height: 80px"></div>
												</ol>
												{{if(item.deliveryStatus == 3){}}
												<div class="express-more">
													需要找同款，去
													<a href="/user/order_detail.html?order_id={{=el.orderId}}&amp;m=1" vda="action|editarea|xgdd">修改订单<i class="vvicon">&#xe62d;</i></a>
												</div>
												{{}}}
											</div>
											<i></i>
										</div>
									{{ } }}
								{{ } }}
							{{ } }}
						</dd>
					</dl>
					<div class="clear"></div>
					{{ }) }}
				</td>
				<td class="amount-col">
					<p class="price {{if(el.orderStatus == 0){}}un-pay{{}}}">
						<span class="yuan">¥</span><em>{{=el.orderAmount.toFixed(2)}}</em>
					</p>
					<p class="other-price">(含运费 <span class="yuan">¥</span><em>{{=el.expressFee.toFixed(2)}}</em>)</p>
					<p class="other-price">(含拿货费 <span class="yuan">¥</span><em>{{=el.purchaseFee.toFixed(2)}}</em>)</p>
				</td>
				<td class="operate-col" data-oid="{{=el.orderId}}">
					{{var dateStatus = _(el.createTime).checkDateStatus()}}
					{{ if(el.orderStatus == 0){ }}
						<a href="/user/pay.html?orderId={{=el.orderId}}" vda="action|editarea|zf" target="_blank" class="btn btn-primary pay-btn">立即支付</a>
					{{ } }}
					{{ if(el.orderStatus == 3 && dateStatus){ }}
					<a href="/user/order_detail.html?order_id={{=el.orderId}}&amp;m=1" vda="action|editarea|xgdd">修改订单</a>
					{{ } }}
					{{ if((el.orderStatus == 0 || el.orderStatus == 3) && dateStatus){ }}
					<a href="javascript:;" class="j-cancel-order" vda="action|editarea|qxdd">取消订单</a>
					{{ } }}
					{{if(el.orderStatus == 5){}}
						<a href="javascript:;" class="btn btn-primary pay-btn j-confirm-get" vda="action|editarea|qrsh">确认收货</a>
					{{}}}
					{{ if(el.orderStatus == 6){ }}
						<p class="btn-block">
							<a href="javascript:;" class="j-refund" vda="action|editarea|sqth">
								申请退货
							</a>

							<a class="guild" href="http://www.vvic.com/help/issue/daifa6.html" target="_blank">
								<i class="vvicon warning">&#xe620;</i>
							</a>
						</p>
					{{ } }}
					{{ if(el.applyForReturn == 1){}}
						<a href="/user/refund_detail.html?order_id={{=el.orderId}}" class="red" target="_blank" vda="action|editarea|cktk">查看退款</a>
					{{ } }}
					{{ if(el.orderStatus > 2 && el.expressNo != '' && el.orderStatus !=8 ){ }}
						<div class="lack-tips express-view" data-expressno="{{=el.expressNo}}">
							{{var expressLink = _.getExpressQuery(el.expressCode)}}
							<a href="http://www.kuaidi100.com/all/{{=expressLink}}.shtml?mscomnu={{=el.expressNo}}" target="_blank" vda="action|editarea|ckwl" {{if(el.orderStatus == 3){}}style="color:#EF3664"{{}}}>查看物流</a>
							<div class="lack-txt express-info">
								<div class="express-name clearfix">
									<!-- <span vda="action|editarea|fz" class="btn btn-default btn-x-small fr j_clip_button" style="width: 40px;">复制</span> -->
									{{=el.expressName}}：<em>{{=el.expressNo}}</em>
								</div>
								<div class="express-more">
									<a href="http://www.kuaidi100.com/all/{{=expressLink}}.shtml?mscomnu={{=el.expressNo}}" target="_blank" vda="action|editarea|ckwl">查看物流详情<i class="vvicon">&#xe62d;</i></a>
								</div>
							</div>
							<i></i>
						</div>
					{{ } }}
				</td>
			</tr>
		</tbody>
		{{ })}}
	</table>
 </script>


 <div id="layer-content" style="display: none;">
     <div class="order_success_layer" style="padding: 0 20px 20px">
         <div class="vv-msg">请先将订单号复制给客服，方便客服快速为您解决问题。</div>
         <dl>
             <dt>订单号：</dt>
             <dd>
                 <input type="text" value="" class="orderno j-layer-orderno" readonly>
                 <span class="btn-copy j_clip_button">复制</span>
             </dd>
         </dl>
         <div class="bottom">
             <a href="javascript:;" class="btn-cancel j-btn-cencel">取消</a>
             <a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDAyNjY5M18zNjE3MDZfODAwMDI2NjkzXzJf"
                target="_blank" class="btn-qq j-btn-qq" style="float: left;">联系客服
             </a>
             <div class="clear"></div>
         </div>
     </div>

 </div>


<script type="text/x-handlebars-template" id="takeTemplate">
	{{ _.each(data, function(item, index){ }}
	<li {{if(index==0){}}class="curr"{{}}}>
		<p class="d-list-title">{{=_.formatDate(item.operateTime, 'MM月dd日 hh:mm')}} {{=item.trackDesc.split('$BR$')[0]}}</p>
		{{ if(index==0){ }}
		<p class="d-list-desc">
			{{=item.trackDesc.split('$BR$')[1]}}
		</p>
		{{}}}
	</li>
	{{ }) }}
	{{if(!data.length){}}
		<li class="empty">暂无最新状态</li>
	{{}}}
</script>

<script type="text/x-handlebars-template" id="cancelTemplate">
	<div class="cancel-box">
		<div class="vv-msg">取消订单可能产生手续费，手续费将从退款金额中直接扣除。<a href="http://www1.vvic.com/fee_announcement.html" target="_blank">查看费用说明 <font class="vvicon">&#xe62d;</font></a></div>
		<ul class="amount-info clearfix">
			<li class="label">已拿货商品数：</li>
			<li><em>{{=item.hasPurchaseNum}}</em> 件</li>
			<li class="label">拿货中商品数：</li>
			<li><em>{{=item.ingPurchaseNum}}</em> 件</li>
			<li class="label">拿货手续费：</li>
			<li>{{=item.purchaseFee}} 元/件</li>
			<li class="label">退货手续费：</li>
			<li>{{=item.refundFee}} 元/件</li>
			<li class="count">
				手续费总计：<em>{{=item.totalFefundFee}}</em> 元
			</li>
		</ul>
		<div class="cancel-from">
			<div class="cancel-form-dl clearfix">
				<div class="cancel-form-dt">原因：</div>
				<div class="cancel-form-dd">
					<dl class="j-v-select v-select" id="reason">
						<dt><span>请选择取消理由</span><i></i></dt>
						<dd>
							<ul class="j-v-select-ul">
								{{_.each(reasonsList, function(item,index){}}
								<li value='{{=item.dict_value}}'><span>{{=item.dict_value}}</span></li>
								{{})}}
							</ul>
						</dd>
					</dl>
					<!-- <select name="reason" id="reason">
						<option value="">请选择取消理由</option>
						{{_.each(reasonsList, function(item,index){}}
						<option value="{{=item.dict_value}}">{{=item.dict_value}}</option>
						{{})}}
					</select> -->
				</div>
			</div>
			<div class="cancel-form-dl clearfix">
				<div class="cancel-form-dt">备注：</div>
				<div class="cancel-form-dd">
					<textarea name="remark" placeholder="最多输入50个字符" maxlength="50" id="remark" cols="30" rows="10"></textarea>
				</div>
			</div>
		</div>
		<div class="err-info mt10">
		    <i class="vvicon">&#xe616;</i>
		    <span></span>
		</div>
	</div>
</script>


<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
	window._TYPE = "${param.t}";
	window._PAGE = '${param.p}';
	window._KEYWORDS = '${param.q}';
	window._STARTDATE = '${param.startDa;e}';
	window._ENDDATE = '${param.endData}';
	window.expressCodeMap = {
		'ZTO' : 'zt',
		'YUNDA' : 'yd'
	}
	window._SIDEBARHELP = true;
    require(['order3/list3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>

