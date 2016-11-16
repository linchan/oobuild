<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="order3"/>
    <jsp:param name="cssHash" value="${cssHash.order3}"/>
    <jsp:param name="title" value="退货退款"/>
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
<div class="order refund">
    <div class="loading3" style="height: 200px"></div>
    <div class="order-list refund-list" id="refund-content">
    </div>
</div>

<script type="text/x-handlebars-template" id="template">
	<table class="tb-order tb-refund-detail">
		<thead>
			<tr>
				<th class="detail-col">商品</th>
				<th class="count-col">需退数量</th>
				<th class="count-col">已退数量</th>
				<th class="price-col">退款金额</th>
				<th class="remark-col">退货反馈</th>
				<th class="amount-col">退款总金额</th>
			</tr>
		</thead>
		{{ var refundStatusText = ['', '待收货', '退货中', '退款中', '退款完成']}}
        {{ _.each(data, function(el){ }}
        {{ var refundDesc = ['', '搜款网确认收货后将立即为您退货', '搜款网已确认收货，将于 '+el.descDate+' 前完成退货', '搜款网将于 '+el.descDate+' 前完成退款', '']}}
		<tbody data-oid="{{=el.orderId}}" data-ono="{{=el.orderNo}}">
			<tr class="blank"><td colspan="6"></td></tr>
			<tr class="tr-th tr-title">
				<td colspan="6">
					<div class="tr-title-link">
                        {{if(el.sendBackFailedGoods){}}
						<a href="javascript:;" class="j-failed">寄回失败商品</a>
                        {{}}}
                        <a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDAyNjY5M18zNjE3MDZfODAwMDI2NjkzXzJf" vda="action|editarea|lxkf|{{=el.orderStatus}}" target="_blank">客服咨询</a>
					</div>
					<span class="tr-title-status">
						{{=refundStatusText[el.refundStatus] }}
					</span>
                    <span style="padding-left:20px;">{{=refundDesc[el.refundStatus]}}</span>
				</td>
			</tr>
			<tr class="tr-th tr-info">
				<td colspan="6">
					<span>
						<em>{{- _(el.createTime).formatDate('yyyy-MM-dd')}}</em>
					</span>
					<span>
						退货订单号：<em>{{=el.refundNo}}</em>
					</span>
                    <span>配送信息：{{=el.expressName}} <em>{{=el.expressNo}}</em></span>
				</td>
			</tr>
			<tr class="tr-tb j-order">
				<td colspan="5">
					{{ _.each(el.orderRefundDetails, function(item, index){ }}
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
						<dd class="count-col">
                            <em>
                                {{=item.returnNum }}
                            </em>
                            {{ if(item.returnReasonId){ }}
                            <div class="lack-tips" style="display: inline">
                                <dl class="j-v-select v-select">
                                    <dt>
                                        <i></i>
                                        <span>退货原因</span>
                                    </dt>
                                </dl>
                                <div class="lack-txt">
                                    退货原因：{{=item.returnReason}}
                                    <p>{{=item.returnDesc}}</p>
                                </div>
                                <i></i>
                            </div>

                            {{ } }}
                        </dd>
                        {{ if(el.refundStatus > 1){ }}
						<dd class="count-col">{{=item.successNum ? item.successNum : ''}}</dd>
						<dd class="price-col">
                            {{if(el.refundStatus==4){}}
                            <span class="yuan">¥</span><em>{{=item.refundAmount.toFixed(2)}}</em>
                            {{}}}
						</dd>
                        <dd class="remark-col">
							{{=item.successNum ? item.returnFailReason : ''}}
                        </dd>
                        {{ } }}
					</dl>
					<div class="clear"></div>
					{{ }) }}
				</td>
				<td class="amount-col">
                    {{if(el.refundStatus==4){}}
                    <p class="price">
                        <span class="yuan">¥</span><em>{{=el.refundAmount.toFixed(2)}}</em>
                    </p>
                    <a href="/user/bill.html" class="btn btn-default btn-x-small" target="_blank">查看交易记录</a>
                    {{}}}
				</td>
			</tr>
		</tbody>
		{{ })}}
	</table>
 </script>

<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<script>
	var _ORDERID = '${param.order_id}'
    require(['order3/refund_detail3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>

</body></html>
