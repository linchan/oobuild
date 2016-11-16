<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="stall3"/>
    <jsp:param name="cssHash" value="${cssHash.stall3}"/>
    <jsp:param name="title" value="档口中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="isShopCenter" value="1"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>
<link href="${staticDomain}/statics/lib/datepick/dp.css" rel="stylesheet" type="text/css" />
<div class="w user-w">
    <div class="user-left">
        <jsp:include page="shopnav.jsp">
            <jsp:param name="bigClass" value="2" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="main-title">
                档口订单
                <div class="fr">
                    <span class="account-info">
                        账户余额：
                        <span class="yuan">¥</span><em id="userMoney">0.00</em>
                    </span>
                    <a href="/shop/applysettlement.html" class="btn btn-red btn-small apply-btn"  style="width: 110px;display: none;">申请开通在线结算</a>
                    <a href="http://www.vvic.com/help/issueshop/dangkou1.html" target="_blank"><i class="vvicon warning apply-btn" style="display: none;">&#xe620;</i></a>
                    <a href="/user/withdraw.html" class="btn btn-red btn-small btn-withdraw"  style="width: 60px;display: none;">提现</a>
                </div>
            </div>

            <div class="order-main mt5">
                <div class="vv-tag order-tag">
                    <ul>
                        <li<c:if test="${param.type eq null}"> class='curr'</c:if>><a href="/shop/orders.html" data-type='1'>拿货记录</a></li>
                        <li<c:if test="${param.type eq 2}"> class='curr'</c:if>><a href="/shop/orders.html?type=2" data-type='2'>退货记录</a></li>
                    </ul>
                    <c:if test="${param.type == null && 1==0}">
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
                <div class="order-list mt10" id="order-content">
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
    <table class="tb-order tb-shop-order">
        <thead>
            <tr>
                <th class="detail-col">商品</th>
                <th class="price-col">拿货价</th>
                <th class="count-col">数量</th>
                <c:choose>
                    <c:when test="${param.type==2}">
                        <th class="amount-col">实付款</th>
                    </c:when>
                    <c:otherwise>
                        <th class="amount-col">实收款</th>
                    </c:otherwise>
                </c:choose>
                <th class="operate-col">操作</th>
            </tr>
        </thead>
        {{ var orderStatusText = ['待付款','待审核','交易关闭','拿货中','拿货中','配送中','交易成功','退款中','交易关闭']}}
        {{ var deliveryStatusText = ['', '待拿货', '拿货中', '缺货', '已拿货', '已拿货', '已拿货']}}
        {{ var refundStatusText = ['', '退货中', '退货中', '退货中', '退货中', '退货中', '退款中', '退款中', '已退款']}}
        {{ _.each(data.datas, function(el){ }}
        <tbody data-ono="{{=el.shop_order_no}}">
            <tr class="blank"><td colspan="5"></td></tr>
            <tr class="tr-th tr-info">
                <td colspan="5">
                    <span>
                        <em>{{- _(el.create_time).formatDate('yyyy-MM-dd hh:mm')}}</em>
                    </span>
                    {{ if(el.shop_order_no!=0){ }}
                    <span>
                        订单号：<em>{{=el.shop_order_no}}</em>
                    </span>
                    {{ } }}
                    <span>拿货员：{{=el.nickname}}</span>
                </td>
            </tr>
            <tr class="tr-tb j-order">
                <td colspan="3">
                    {{ _.each(el.lists, function(item, index){ }}
                    <dl class="order-item {{if(index==0){}}first{{}}} clearfix">
                        <dt class="detail-col">
                            <div class="pic">
                                <a href="/item/{{=item.item_id}}" target="_blank"><img src="{{=item.index_img_url}}_230x230.jpg" view-src="{{=item.index_img_url}}_230x230.jpg" class="j-img-view" alt="" width="70"></a>
                            </div>
                            <div class="info">
                                <div class="info-title"><a href="/item/{{=item.item_id}}" target="_blank">{{=item.title}}</a></div>
                                <div class="info-art-no" title="{{=item.sn}}#">{{=item.sn}}#</div>
                                <span class="info-shop"><a href="/shop/{{=item.shop_id}}" target="_blank">{{=item.shop_name}}</a></span>
                            </div>
                            <div class="sku">
                                {{ if(item.color != '') { }}
                                <div class="sku-color" title="{{=item.color=='nocolor'?'图片色':item.color}}">颜色：{{=item.color=='nocolor'?'图片色':item.color}}</div>
                                {{ } }}
                                {{ if(item.size != '') { }}
                                <div class="sku-size" title="{{=item.size=='nosize'?'均码':item.size}}">尺码：{{=item.size=='nosize'?'均码':item.size}}</div>
                                {{ } }}
                            </div>
                            <div class="clear"></div>
                        </dt>
                        <dd class="price-col"><span class="yuan">¥</span><em>{{=item.discount_price}}</em></dd>
                        <dd class="count-col">
                            {{=item.got_num}}
                            <c:if test="${param.type!=2}">
                            {{if(item.lack_num>0){}}
                            <p class="desc">需拿{{=item.num}}件</p>
                            <p class="desc">缺货{{=item.lack_num}}件</p>
                            {{}}}
                            </c:if>
                        </dd>
                    </dl>
                    <div class="clear"></div>
                    {{ }) }}
                </td>
                <td class="amount-col">
                    <p class="price">
                        <span class="yuan">¥</span><em>{{=el.amount}}</em>
                    </p>
                    {{ if(el.pay_type==1){ }}
                        <p class="desc">余额结算</p>
                    {{ }else{ }}
                        <p class="desc">现金结算</p>
                    {{ } }}
                </td>
                <td class="operate-col" data-oid="{{=el.orderId}}">
                    <a href="javascript:;" class="j-service" vda="action|editarea|lxkf|{{=el.orderStatus}}">客服咨询</a>
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

<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    var _TYPE = "${param.type}" || 1,
        _PAGE = '${param.p}',
        _KEYWORDS = '${param.q}',
        _STARTDATE = '${param.startDate}',
        _ENDDATE = '${param.endData}';
    require(['shop3/order3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>

