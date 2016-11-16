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
<style>
    .layui-layer-dialog .layui-layer-content {
        padding: 10px 20px 30px;
    }
</style>
<div class="order refund">
	<form id="refundAddForm">
	<!-- 修改订单地址表单 -->
	<div class="o-msg">提示：申请退货退款需支付额外的手续费，搜款网会在收到退货商品后进行退货处理，货款将返还至您的资金账户上。搜款网只协助进行退货，不对退货成功负责； <a href="/help/issue/daifa6.html#e1" target="_blank">查看帮助中心 <i class="vvicon">&#xe62d;</i></a></div>
	<div class="o-box">
		<div class="o-box-t">
			申请退货服务

            <div class="o-order-info fr">
                订单号：<em id="orderNo"></em>
            </div>
		</div>
		<div class="o-box-main">
			<fieldset class="o-address">
				<div class="item clearfix">
					<label><span class="required">*</span>退货地址：</label>
					<input type="text" id="address" value="广州市天河区燕岭路 440 号第七栋（力源酒店附近），维胜仓储（收），020-38094242" readonly name="address" class="input-address" />
					<div class="btn btn-default btn-copy fl j_clip_button">复制</div>
					<span class="tips">
						<strong>注：</strong>退货包裹请发到此地址，拒收到付件
					</span>
				</div>
				<div class="item clearfix">
					<label><span class="required">*</span>退货快递单号：</label>
					<input type="text" name="expressNo" id="expressNo" />
					<span class="tips">
						请正确填写，确保退货包裹正常处理，什么是<a href="http://www.vvic.com/help/issue/daifa6.html#e1" target="_blank">退货快递单号 <font class="vvicon">&#xe620;</font></a>
					</span>
				</div>
                <div class="item clearfix">
					<label><span class="required">*</span>物流公司：</label>
                    <dl class="j-v-select v-select fl" id="expressName">
						<dt><span>选择物流公司</span><i></i></dt>
						<dd>
							<ul>
                                <li data-value='TTKDEX'><span>天天快递</span></li>
                                <li data-value='YTO'><span>圆通速递</span></li>
                                <li data-value='ZTO'><span>中通快递</span></li>
                                <li data-value='YUNDA'><span>韵达快递</span></li>
                                <li data-value='STO'><span>申通快递</span></li>
                                <li data-value='HTKY'><span>百世快递</span></li>
                                <li data-value='GTO'><span>国通快递</span></li>
                                <li data-value='EMS'><span>EMS</span></li>
                                <li data-value='EYB'><span>EMS经济快递</span></li>
                                <li data-value='POSTB'><span>邮政快递包裹</span></li>
                                <li data-value='SF'><span>顺丰速运</span></li>
                                <li data-value='UC'><span>优速快递</span></li>
                                <li data-value='DBKD'><span>德邦快递</span></li>
                                <li data-value='ZJS'><span>宅急送</span></li>
                                <li data-value='NEDA'><span>能达速递</span></li>
                                <li data-value='YCT'><span>黑猫宅急便</span></li>
                                <li data-value='SURE'><span>速尔</span></li>
                                <li data-value='LTS'><span>联昊通</span></li>
                                <li data-value='ESB'><span>E速宝</span></li>
                                <li data-value='LB'><span>龙邦速递</span></li>
                                <li data-value='HZABC'><span>飞远(爱彼西)配送</span></li>
                                <li data-value='CNEX'><span>佳吉快递</span></li>
                                <li data-value='QFKD'><span>全峰快递</span></li>
                                <li data-value='GDEMS'><span>广东EMS</span></li>
                                <li data-value='FEDEX'><span>联邦快递</span></li>
                                <li data-value='QRT'><span>增益速递</span></li>
                                <li data-value='UAPEX'><span>全一快递</span></li>
                                <li data-value='BJRFD'><span>如风达配送</span></li>
                                <li data-value='FAST'><span>快捷快递</span></li>
                                <li data-value='HOAU'><span>天地华宇</span></li>
							</ul>
						</dd>
					</dl>
					<input type="hidden" name="expressNameData" id="expressNameData" />
				</div>
				<div class="item clearfix">
					<label><span class="required">*</span>手机号码：</label>
					<input type="text" name="mobile" id="mobile" maxlength="11" placeholder="请输入您的手机号" >
                    <span class="tips">为确保您的退货正常处理，请保持您的联系电话畅通</span>
				</div>
			</fieldset>
		</div>
	</div>
	<!-- 修改订单地址表单 -->

	<div class="o-box refund-box">
		<div class="o-box-t">
			选择退货商品
		</div>
		<div class="o-box-main">
			<div class="order-detail-list" id="orderDetail">
				<div class="loading3" style="height: 200px"></div>
			</div>
		</div>
	</div>


	<div class="o-box o-foot mt20">
		<div class="o-foot-count">
            <span id="payText">退货手续费：</span><span class="yuan">¥</span><em id="handlingFee">0.00</em>
		</div>
<!-- 		<div class="o-foot-protocol checked j-protocol">
			<span class="check-txt">阅读并接受<a id="theP" href="http://www1.vvic.com/user_agreement.html" target="_blank">《搜款网代发服务协议》</a></span>
			<i class="vvicon check-item">&#xe627;</i><i class="vvicon uncheck-item">&#xe619;</i>
		</div> -->
		<div class="o-foot-btn mt10">
			<a href="/user/orders.html" class="o-btn-back">返回订单列表</a>
			<input class="disabled j_submit" vda="action|edit_submit|tjdd|${param.order_id}" type="submit" disabled="disabled" value="提交申请" />
		</div>
	</div>
	<div class="clear"></div>
	</form>
</div>

<script type="text/x-handlebars-template" id="detailTemplate">
	<table class="tb-order tb-refund-list">
		<thead>
			<tr>
				<th class="detail-col">商品</th>
				<th class="count-col">可退数量</th>
				<th class="ctrl-col">需退数量</th>
                <th class="reason-col">退货退款原因</th>
                <th class="btn-col"></th>
			</tr>
		</thead>
		<tbody>
			<tr class="tr-tb j-order">
				<td colspan="5" style="border-left:none;border-bottom:none;">
                    {{var count = 0}}
					{{ _.each(orderDetails, function(item, index){ }}

					<dl class="order-item {{if(index==0){}}first{{}}} {{if(item.skuStatus==0 || item.isSpecialOffer == 1){}}disabled{{}}} clearfix" data-oid="{{=item.orderDetailsId}}" data-id="{{=item.itemId}}">
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
							<div class="sku item-props">
								<p class="sku-line">颜色：{{=(item.skuColor=='nocolor' ? '图片色' : item.skuColor) }}</p>
								<p class="sku-line">尺码：{{=(item.skuSize=='nosize' ? '均码' : item.skuSize) }}</p>
							</div>
							<div class="clear"></div>
						</dt>
						<dd class="count-col">
							{{ var refundNum = (item.skuStatus==0 || item.isSpecialOffer == 1) ? 0 : item.returnNum }}
							{{=refundNum}}
                            {{count+=refundNum}}
						</dd>
						<dd class="ctrl-col">
							{{if(item.skuStatus==1 && item.isSpecialOffer == 0){}}
                                {{if(refundNum==0)}}
                                    无可退数量
                                {{else{}}
                                    <div class="amount-stock clearfix">
                                        <span class="stock">
                                            <a href="javascript:void(0);" title="减1" hidefocus="" class="v-reduce v-disable-reduce vvicon"></a>
                                            <input type="text" data-count="{{=refundNum}}" data-min="0" value="0" maxlength="3" name='refund-number' class="refund-number" data-odid="{{=item.orderDetailsId}}">
                                            <a href="javascript:void(0);" hidefocus="" class="v-increase vvicon" title="加1"></a>
                                        </span>
                                    </div>
                                {{}}}
                            {{ }else{ }}
                            	<div class="disabled-desc">
								{{if(item.skuStatus==1 && item.isSpecialOffer == 1){}}
									特价商品 <a href="/help/issue/daifa6.html" target="_blank"><font class="vvicon">&#xe620;</font></a>
								{{}else{}}
									下架商品 <a href="/help/issue/daifa6.html" target="_blank"><font class="vvicon">&#xe620;</font></a>
								{{ } }}
								</div>
							{{ } }}
						</dd>
                        <dd class="reason-col">
                            {{ if(item.skuStatus==1 && item.isSpecialOffer == 0 && refundNum != 0){ }}
                                <p class="tips">退货退款原因必填 <span class="red">*</span></p>
                                <p class="reason-text"></p>
                                <p class="reason-remark"></p>
                            {{ } }}
                        </dd>
                        <dd class="btn-col">
                            {{ if(item.skuStatus==1 && item.isSpecialOffer == 0 && refundNum != 0){ }}
                            <a href="javascript:;" class="btn btn-x-small btn-default j-reason-btn" id="reasonBtn_{{=item.orderDetailsId}}">填写原因</a>
                            {{ } }}
                        </dd>
					</dl>
					<div class="clear"></div>
					{{ }) }}

                    {{_.countStatus(count)}}
				</td>
			</tr>
		</tbody>
	</table>
</script>

<script type="text/x-handlebars-template" id="reasonTemplate">
<fieldset class="o-address reason-form">
    <div class="item clearfix">
        <label>退货原因：</label>
        <dl class="j-v-select v-select fl j-reason">
            <dt><span></span><i></i></dt>
            <dd>
                <ul>
                    <c:forEach items="${refund_reasons}" var="item" varStatus="stats">
                    <li data-value='${item.id}'><span>${item.reason_type}</span></li>
                    </c:forEach>
                </ul>
            </dd>
        </dl>
    </div>
    <div class="item clearfix">
        <label>退货说明：</label>
        <textarea name="remark" id="remark" rows="8" cols="40">{{=remark}}</textarea>
        <span class="tips">
            50个字
        </span>
    </div>
    <div class="err-info mt10" style="display: none;">
        <i class="vvicon">&#xe616;</i>
        <span></span>
    </div>
</fieldset>
</script>


<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<script>
    window.history.forward(1);
    window.page = 'refund';
    var _ORDERID = '${param.order_id}';
    require(['order3/refund_apply3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>

</body></html>
