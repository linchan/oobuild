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

<style>
    table.tb-order.tb-refund-detail .amount-col {
        width: 80px;
    }
    table.tb-order.tb-refund-detail .count-col {
        width: 90px;
        padding: 0 5px;
    }
    table.tb-order.tb-refund-detail .remark-col {
        width: 125px;
        padding-left: 5px;
        padding-right: 5px;
    }
    table.tb-order.tb-refund-detail .order-item dd.count-col {
        padding: 20px 5px;
    }
</style>

<link href="${staticDomain}/statics/lib/datepick/dp.css" rel="stylesheet" type="text/css" />
<div class="w user-w">
    <div class="user-left">
        <jsp:include page="usernav.jsp">
            <jsp:param name="bigClass" value="9" />
            <jsp:param name="smallClass" value="0" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="main-title" style="border-bottom:2px solid #EBEBEB">
                退货记录
            </div>

            <div class="order-main">
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
                    <div class="return-status fl">
                        <span class="status-title">退货状态：</span>
                        <dl class="v-select j-v-select" id="returnStatus">
                            <dt><span>全部</span><i></i></dt>
                            <dd>
                                <ul>
                                    <li data-value=''><span>全部</span></li>
                                    <li data-value='1'><span>待收货</span></li>
                                    <li data-value='2'><span>退货中</span></li>
                                    <li data-value='3'><span>退款中</span></li>
                                    <li data-value='4'><span>退款完成</span></li>
                                </ul>
                            </dd>
                        </dl>
                    </div>
                    <c:if test="${param.t == null}">
                    <div class="order-search fr" style="margin-top:0;">
                        <a id="searchOrder">搜索订单</a>
                        <input type="text" id="Q" value="${param.q}" placeholder="退货订单号、退货快递单号" />
                    </div>
                    </c:if>
                    <div class="clear"></div>
                </div>
                <div class="order-list" id="order-content">
                    <div class="loading3" style="height: 200px"></div>
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
        {{ _.each(data.listData, function(el){ }}
        <tbody data-rid="{{=el.refundId}}" data-rno="{{=el.refundNo}}">
            <tr class="blank"><td colspan="6"></td></tr>
            <tr class="tr-th tr-title">
                <td colspan="6">
                    <div class="tr-title-link">
                        {{if(el.refundStatus==4){}}
                        <a href="javascript:;" class="j-failed">寄回失败商品</a>
                        {{}}}
                        <a href="javascript:;" class="j-service" vda="action|editarea|lxkf|{{=el.orderStatus}}">客服咨询</a>
                    </div>
                    <span class="tr-title-status">
                        {{=refundStatusText[el.refundStatus] }}
                    </span>
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
                    <span>配送信息: {{=el.expressName}} <em>{{=el.expressNo}}</em></span>
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
                            <div class="lack-tips return-reason" style="display: inline">
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
                        <dd class="count-col">
                            {{=item.successNum ? item.successNum : ''}}
                        </dd>
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
                    <a href="/user/bill.html" style="width: 90px;" class="btn btn-default btn-x-small">查看交易记录</a>
                    {{}}}
                </td>
            </tr>
        </tbody>
        {{ })}}
    </table>

    {{ if(data=='{}'){ }}
    <div class="empty-tip">
        <span class="vvicon">&#xe614;</span>
        <div class="text">无记录</div>
    </div>
    {{ } }}
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
    require(['order3/return3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>

