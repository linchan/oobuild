<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="user3"/>
    <jsp:param name="cssHash" value="${cssHash.user3}"/>
    <jsp:param name="title" value="档口中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="isShopCenter" value="1"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>
<div class="w user-w">
    <div class="user-left">
        <jsp:include page="shopnav.jsp">
            <jsp:param name="bigClass" value="1" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="main-title">
                备货提醒
                <div class="fr">
                    <a href="/shop/setting.html#mobile" class="btn btn-red btn-small set-phone lack-tips"  style="width: 90px;">设置联系电话
                        <div class="lack-txt">
                            设置接收备货提醒短信的手机号
                        </div>
                        <i></i>
                    </a>
                </div>
            </div>

            <div class="vv-msg" style="margin-top:5px;"><strong>提示：</strong>因买手订单可能会调整，实际拿货数以现场确认为准</div>

            <div class="order-main">
                <div class="loading3" style="height: 200px"></div>
                <div class="order-list" id="order-content">
                </div>
                <div class="empty-tip" style="display: none;">
                    <span class="vvicon">&#xe614;</span>
                    <div class="text">无记录</div>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<script type="text/x-handlebars-template" id="template">
    <table class="tb-order tb-stocking">
        <thead>
            <tr>
                <th class="detail-col">商品</th>
                <th class="price-col">单价</th>
                <th class="count-col">数量</th>
                <th class="amount-col">小计</th>
                <th class="stock-col">库存</th>
            </tr>
        </thead>
        {{ var orderStatusText = ['待付款','待审核','交易关闭','拿货中','拿货中','配送中','交易成功','退款中','交易关闭']}}
        {{ var deliveryStatusText = ['', '待拿货', '拿货中', '缺货', '已拿货', '已拿货', '已拿货']}}
        {{ var refundStatusText = ['', '退货中', '退货中', '退货中', '退货中', '退货中', '退款中', '退款中', '已退款']}}


        {{ _.each(data.na_huo_zhong, function(el){ }}
        <tbody>
            <tr class="blank"><td colspan="5"></td></tr>
            <tr class="tr-th tr-title">
                <td colspan="3">
                    <span class="tr-title-status">
                        拿货中
                    </span>
                </td>
                <td colspan="2" rowspan="2">
                    <dl class="take-info">
                        <dt>
                            <i class="mask"></i>
                            <img class="take-avatar" src="{{=el.avatar!='' && el.avatar!= null && el.avatar!='null'?el.avatar:'${staticDomain}/statics/v2/css/img/shop/head_default.png'}}" width="60" height="60" alt="">
                        </dt>
                        <dd>
                            <p>预计于 <em>{{=el.take_time}}</em> 上门拿货</p>
                            <p>拿货员：<em>{{=el.nickname}}</em></p>
                            <p>手机号：{{=el.mobile}}</p>
                        </dd>
                    </div>
                </td>
            </tr>
            <tr class="tr-th tr-info">
                <td colspan="3">
                    <span>拿货码：<em>{{=el.take_code}}</em></span>
                    <span>商品数量：<em>{{=el.category_num}}</em> 种</span>
                    <span>总计件数：<em>{{=el.total_num}}</em> 件</span>
                    <span>总计金额：<span style="margin-right:3px">¥</span><em class="price">{{=el.total_price}}</em></span>
                    {{ if(data.check_status != 1){ }}
                    <a class="red" href="/shop/applysettlement.html" target="_blank">申请开通在线结算</a> <a href="http://www.vvic.com/help/issueshop/dangkou1.html" target="_blank"><i class="vvicon warning">&#xe620;</i></a>
                    {{ } }}
                </td>
            </tr>
            {{ _.each(el.datas, function(item, index){ }}
            <tr class="tr-tb  j-order">
                <td>
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
                                {{ if(item.skuColor != '') { }}
                                <div class="sku-color">颜色：{{=item.color=='nocolor'?'图片色':item.color}}</div>
                                {{ } }}
                                {{ if(item.size != '') { }}
                                <div class="sku-size">尺码：{{=item.size=='nosize'?'均码':item.size}}</div>
                                {{ } }}
                            </div>
                            <div class="clear"></div>
                        </dt>
                    </dl>
                    <div class="clear"></div>
                </td>
                <td class="price-col"><span class="yuan">¥</span><em>{{=item.discount_price}}</em></td>
                <td class="count-col">{{=item.num}}</td>
                <td class="amount-col">
                    <span class="yuan">¥</span><em>{{=item.price}}</em>
                </td>
                <td class="stock-col">
                    <div class="stock-info">
                        <div class="edit j-edit">修改</div>
                        {{ if(item.is_lack == 0){ }}
                            有货
                        {{ }else{ }}
                            <span class="red">缺货</span>
                            <p style="margin-top:3px;">
                            {{ if(item.is_modify){ }}
                            {{- _(item.lack_time).formatDate('MM月dd日')}}标记缺货
                            {{ }else{ }}
                            {{- _(item.lack_time).formatDate('MM月dd日')}}拿货时缺货
                            {{ } }}
                            </p>
                            <p>请尽快备货</p>
                        {{ } }}

                        <div class="sku-edit-popup">
                            <div class="sku-edit-content">
                                <dl class="prop">
                                    <dt>库存</dt>
                                    <dd class="sizes">
                                        <ul class="">
                                            <li data-status="0" class="j-prop-item {{if(item.is_lack){}}selected{{}}}">缺货 <i class=" vvicon"></i></li>
                                            <li data-status="1" class="j-prop-item {{if(!item.is_lack){}}selected{{}}}">有货 <i class="vvicon"></i></li>
                                        </ul>
                                    </dd>
                                </dl>
                                <div class="operate">
                                    <a class="cancel j-cancel">取消</a>
                                    <a class="add-cart j-stock-prop" data-skuid="{{=item.sku_id}}" data-shopid="{{=item.shop_id}}" data-itemid="{{=item.item_id}}" data-status="{{=item.is_lack}}">确定</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            {{ }) }}
        </tbody>
        {{ })}}

        {{ if(data.dai_na_huo.total_num>0){ }}
        <tbody>
            <tr class="blank"><td colspan="5"></td></tr>
            <tr class="tr-th tr-title">
                <td colspan="5">
                    <span class="tr-title-status">
                        待拿货
                    </span>
                </td>
            </tr>
            <tr class="tr-th tr-info">
                <td colspan="5">
                    <span>商品数量：<em>{{=data.dai_na_huo.category_num}}</em> 种</span>
                    <span>总计件数：<em>{{=data.dai_na_huo.total_num}}</em> 件</span>
                    <span>总计金额：<span style="margin-right: 3px;">¥</span><em>{{=data.dai_na_huo.total_price}}</em></span>
                    {{ if(data.check_status != 1){ }}
                    <a class="red" href="/shop/applysettlement.html" target="_blank">申请开通在线结算</a> <a href="http://www.vvic.com/help/issueshop/dangkou1.html" target="_blank"><i class="vvicon warning">&#xe620;</i></a>
                    {{ } }}
                </td>
            </tr>
            {{ _.each(data.dai_na_huo.datas, function(item, index){ }}
            <tr class="tr-tb j-order">
                <td>
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
                                {{ if(item.skuColor != '') { }}
                                <div class="sku-color">颜色：{{=item.color=='nocolor'?'图片色':item.color}}</div>
                                {{ } }}
                                {{ if(item.size != '') { }}
                                <div class="sku-size">尺码：{{=item.size=='nosize'?'均码':item.size}}</div>
                                {{ } }}
                            </div>
                            <div class="clear"></div>
                        </dt>
                    </dl>
                    <div class="clear"></div>

                </td>
                <td class="price-col"><span class="yuan">¥</span><em>{{=item.discount_price}}</em></td>
                <td class="count-col">{{=item.num}}</td>
                <td class="amount-col">
                    <span class="yuan">¥</span><em>{{=item.price}}</em>
                </td>
                <td class="stock-col">
                    <div class="stock-info">
                        <div class="edit j-edit">修改</div>
                        {{ if(item.is_lack == 0){ }}
                            有货
                        {{ }else{ }}
                            <span class="red">缺货</span>
                            <p style="margin-top:3px;">
                            {{ if(item.is_modify){ }}
                            {{- _(item.lack_time).formatDate('MM月dd日')}}标记缺货
                            {{ }else{ }}
                            {{- _(item.lack_time).formatDate('MM月dd日')}}拿货时缺货
                            {{ } }}
                            </p>
                            <p>请尽快备货</p>
                        {{ } }}

                        <div class="sku-edit-popup">
                            <div class="sku-edit-content">
                                <dl class="prop">
                                    <dt>库存</dt>
                                    <dd class="sizes">
                                        <ul class="">
                                            <li data-status="0" class="j-prop-item {{if(item.is_lack){}}selected{{}}}">缺货 <i class=" vvicon"></i></li>
                                            <li data-status="1" class="j-prop-item {{if(!item.is_lack){}}selected{{}}}">有货 <i class="vvicon"></i></li>
                                        </ul>
                                    </dd>
                                </dl>
                                <div class="operate">
                                    <a class="cancel j-cancel">取消</a>
                                    <a class="add-cart j-stock-prop" data-skuid="{{=item.sku_id}}" data-shopid="{{=item.shop_id}}" data-itemid="{{=item.item_id}}" data-status="{{=item.is_lack}}">确定</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            {{ }) }}
        </tbody>
        {{ } }}
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
    var _TYPE = "${param.t}",
        _PAGE = '${param.p}',
        _KEYWORDS = '${param.q}',
        _STARTDATE = '${param.startDate}',
        _ENDDATE = '${param.endData}',
        _SHOPID = '${param.sid}';
    require(['shop3/stocking3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>

