<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="order3"/>
    <jsp:param name="cssHash" value="${cssHash.order3}"/>
    <jsp:param name="title" value="确认订单"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="currentNav" value="99"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
    <jsp:param name="orderStatus" value="1"/>
</jsp:include>


<div class="order">
    <div class="o-box">
        <form name="myForm" id="j-form">
            <div class="o-box-t" address-type="add" >
                 <i class="vvicon close">&#xe619;</i><i class="vvicon open">&#xe618;</i> 填写收货地址
            </div>
            <div class="o-box-main"style="height: 275px;display: none;">
                <fieldset class="o-address" style="padding: 20px 0;">
                    <div class="item clearfix">
                        <label><span class="required">*</span>所在地区：</label>
                        <div id="regionBox"></div>
                        <input type="hidden" class="add-rule" id="region" name="region" />
                        <div class="address-error" id="unSupportAddress" for="address1">你的收货地址不在配送范围内</div>
                    </div>
                    <div class="item clearfix">
                        <label><span class="required">*</span>详细地址：</label>
                        <textarea name="address" id="address" class="input-address j-input-address add-rule" cols="30" rows="10"></textarea>
                    </div>
                    <!-- <div class="item clearfix" style="display: none;">
                        <label>邮政编码：</label>
                        <input type="zipcode" name="zipcode" maxlength="6" id="zipcode" class="add-rule" />
                    </div> -->
                    <div class="item clearfix">
                        <label><span class="required">*</span>收货人：</label>
                        <input type="text" name="consignee" id="consignee" class="add-rule" />
                        <span class="desc"><span class="red">注：</span>请填写真实姓名，否则部分快递拒绝收件</span>
                    </div>
                    <div class="item clearfix">
                        <label><span class="required">*</span>手机号码：</label>
                        <input type="text" name="mobile" id="mobile" maxlength="11" class="input-mobile add-rule" data-msg-mobile="请填写正确的收货人手机号">
                        <label class="label-tel">固定号码：</label>
                        <input type="text" name="tel0" id="tel0" class="input-area_no j-tels j-tel-0" placeholder="区号" maxlength="4">
                        <input type="text" name="tel1" id="tel1" class="input-tel j-tels j-tel-1" placeholder="电话号码" maxlength="8">
                        <input type="hidden" class="j-tel add-rule" id="tel" name="tel">
                    </div>
                    <div class="clear"></div>
                </fieldset>

                <div class="o-match">
                    <p>粘贴淘宝收货地址：</p>
                    <p>
                        <textarea style="margin-top:5px;" class="long-address" id="matchAddress" cols="30" rows="10" name="matchAddress" placeholder="小强，13800138000，020-88888888，广东省 广州市 天河区 燕岭路440号第七栋，510510" vda="action|confirm|ztdz"></textarea>
                    </p>
                    <p class="desc">操作指引：粘贴淘宝「订单详情」的收货地址到输入框内，自动帮您填写地址，若匹配失败，请手动完善地址</p>
                </div>
            </div>

            <div class="o-box-t j-user-address" address-type="select" style="margin-top:1px;display:none;">
                 <i class="vvicon close">&#xe619;</i><i class="vvicon open">&#xe618;</i> 常用收货地址
            </div>
            <div class="o-box-main j-user-address" style="display: none;">
                <div class="address-list clearfix" id="addressList">
                    <div class="loading3" style="height: 100px"></div>
                </div>
            </div>
        </form>
    </div>

    <div class="o-box">
        <div class="o-box-t">
            确定订单信息
        </div>
        <div class="o-box-main">
            <div class="order-detail-list" id="orderDetail">
                <div class="loading3" style="height: 200px"></div>
            </div>
        </div>
    </div>


    <div class="o-box o-foot">
        <!--<div class="o-foot-amount">
             <table width="100%">
                <tr>
                 <td>手续费总计：</td>
                 <td><em>6.00</em>元</td>
                </tr>
                <tr>
                    <td>商品总金额：</td>
                    <td nowrap="nowrap" class="o-foot-price"><span class="yuan">¥</span><em class="j-goods-price"></em> </td>
                </tr>
            </table>
        </div> -->
        <div class="o-foot-count">
            应付总额：<span class="yuan" style="margin-left:5px">¥</span><em class="j-total-price" style="margin-left: -2px;"></em>
        </div>
        <div class="o-foot-protocol checked j-foot-checkbox">
            <span class="check-txt">阅读并接受<a id="theP" href="http://www1.vvic.com/user_agreement.html" target="_blank">《搜款网代发服务协议》</a></span>
            <i class="vvicon check-item ">&#xe627;</i>
            <i class="vvicon uncheck-item">&#xe628;</i>
        </div>
        <div class="o-foot-btn">
            <a href="/cart.html" class="o-btn-back" vda="action|confirm|back_cart">返回购物车</a>
            <input type="submit" value="提交订单" class="j-btn-submit" vda="action|confirm|tjdd" />
            <span id="errorUp" style="display: none;"></span>
        </div>
    </div>

    <div class="clear"></div>
</div>

<script type="text/x-handlebars-template" id="detailTemplate">
    {{ var orderStatusText = ['待付款','待审核','交易关闭','拿货中','打包中','配送中','交易成功','退款中','交易关闭']}}
    {{ var deliveryStatusText = ['', '待拿货', '拿货中', '缺货', '已拿货', '已拿货', '已拿货']}}
    {{ var refundStatusText = ['', '退货中', '退货中', '退货中', '退货中', '退货中', '退款中', '退款中', '已退款']}}
    <table class="tb-order tb-order-detail">
        <thead>
        <tr>
            <th class="detail-col">商品</th>
            <th class="price-col">单价</th>
            <th class="count-col">数量</th>
            <th class="amount-col">小计</th>
        </tr>
        </thead>
        <tbody>
            {{ _.each(cartList, function(item, index){ }}
            <tr class="tr-tb j-order">
                <td>
                    <dl class="order-item {{if(index==0){}}first{{}}} clearfix">
                        <dt class="detail-col">
                            <div class="pic">
                                <a href="/item/{{=item.item_id}}" target="_blank">
                                    <img src="{{=item.index_img_url}}_230x230.jpg" view-src="{{=item.index_img_url}}_230x230.jpg" class="j-img-view" alt="" width="70">
                                </a>
                            </div>
                            <div class="info">
                                <div class="info-title">
                                    <a href="/item/{{=item.item_id}}" target="_blank">{{=item.title}}</a>
                                </div>
                                <div class="info-art-no">{{=item.art_no}}#</div>
                                <span class="info-shop">{{=item.shop_name}}</span>
                            </div>
                            <div class="sku" style="padding-left:20px;">
                                {{ if(item.color != '') { }}
                                <div class="sku-color">颜色：{{=item.color=='nocolor'?'图片色':item.color}}</div>
                                {{ } }}
                                {{ if(item.size != '') { }}
                                <div class="sku-size">尺码：{{=item.size=='nosize'?'均码':item.size}}</div>
                                {{ } }}
                            </div>
                            <div class="clear"></div>
                        </dt>
                    </dl>
                </td>
                <td class="price-col">
                    <span class="yuan">¥</span><em>{{- item.discount_price.toFixed(2) }}</em>
                </td>
                <td class="count-col">
                    {{=item.amount}}
                    <!--<p class="count-tip">已拿1件，缺货1件</p>-->
                </td>
                <td class="amount-col red">
                    <span class="yuan">¥</span><em>{{- (item.amount*item.discount_price).toFixed(2) }}</em>
                </td>
            </tr>
            {{ }) }}
            <tr class="tr-tb tr-tf">
                <td rowspan="2" style="border-right:1px solid #EBEBEB;border-bottom:none;">
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
                    <dl class="j-v-select v-select express-box fl dis" style="width:140px;margin:10px 0 0 20px;">
                        <dt>
                            <i></i>
                            <span>快递</span>
                        </dt>
                        <dd>
                            <ul class="j-v-select-ul"></ul>
                        </dd>
                    </dl>
                </td>
                <td class="tc amount-col red">
                    <a href="/help/issue/daifa2.html" target="_blank"><i class="vvicon">&#xe620;</i></a>
                    <span class="yuan" style="margin-right: 3px;">¥</span><em class="j-exp-fee">0.00</em>
                </td>
            </tr>
            <tr class="tr-tb tr-tf">
                <td colspan="2"  style="border-bottom: none;line-height: 50px;text-align: left;" height="50">
                    <span style="margin-left:20px;">拿货费总计：</span>
                </td>
                <td class="amount-col red" style="border-bottom:none;">
                    <a href="/help/issue/daifa2.html" target="_blank"><i class="vvicon">&#xe620;</i></a>
                    <span class="yuan">¥</span><em class="j-take-fee"></em>
                </td>
            </tr>
        </tbody>
    </table>
</script>

<script type="text/x-handlebars-template" id="addressTemplate">
    <ul class="clearfix">
        {{ _.each(addresses, function(item, index){ }}
        {{ var classString = '' }}
        {{ if((item.is_default==1 && toSelectAddressId ==0) || toSelectAddressId==item.id){ }}
            {{ classString = 'class="selected"' }}
            {{- _.setAddressInfo(item.id) }}
        {{ } }}
        <li {{=classString}} data-addressid="{{=item.id}}">
            <dl>
                <dt>{{=item.province}} {{=item.city}} ({{=item.consignee}} 收)</dt>
                <dd>
                    <p class="address-full">
                        {{=item.area}} {{=item.address}} {{=item.mobile}} {{=item.telephone}}
                    </p>
                    <a href="javascript:;" class="address-edit">修改</a>
                </dd>
                {{ if(item.is_default==1){ }}
                <dd class="default-info">默认地址</dd>
                {{ } }}
                <dd class="selected-icon"><i class="vvicon">&#xe608;</i></dd>
            </dl>
        </li>
        {{ }) }}
        {{ if(addresses.length<10){ }}
        <li class="add">
            <a href="javascript:;" class="add" id="addAddress">
                <i class="vvicon">&#xe61b</i>
                <span>添加收货地址</span>
            </a>
        </li>
        {{}}}
    </ul>
</script>

<script type="text/x-handlebars-template" id="expressTemplate">
    {{_.each(data.express_list, function(item){ }}
    {{if(item.reachable){}}
    <li data-expressCode="{{=item.expressCode}}"
        data-expressId="{{=item.expressId}}"
        data-expressAmount="{{=item.reachable ? item.expressAmount.amount : 0}}"
        data-expressFee="{{=item.reachable ? item.expressAmount.amount : 0}}"
        data-expressName="{{=item.expressFullName}}"
        data-branchName="{{=item.branchName}}"
        data-expressBranchId="{{=item.expressBranchId}}"
        data-branchCode="{{=item.branchCode}}">
        <a>
            <span>{{=item.expressFullName}}</span>（¥ <em>{{- (item.reachable ? item.expressAmount.amount : 0).toFixed(2)}}</em>）
        </a>
    </li>
    {{}else{}}
        <li class="disabled"><a><span>{{=item.expressFullName}}</span>（不支持）</a></li>
    {{}}}
    {{ }); }}
</script>

<div id="layer-address" style="display: none">
    <form name="addressForm" id="j-address-form">
    <fieldset class="o-address" style="padding: 20px 0 10px;">
        <div class="item clearfix">
            <label><span class="required">*</span>所在地区：</label>
            <div id="windowRegionBox"></div>
            <input type="hidden" name="region" id="editRegion"  />
            <div class="address-error" id="unSupportAddress" for="address1">你的收货地址不在配送范围内</div>
        </div>
        <div class="item clearfix">
            <label><span class="required">*</span>详细地址：</label>
            <textarea name="address" id="editAddress" class="input-address j-input-address" cols="30" rows="10"></textarea>
        </div>
        <!-- <div class="item clearfix" style="display: none;">
            <label>邮政编码：</label>
            <input type="zipcode" name="zipcode" maxlength="6" id="editZipcode">
        </div> -->
        <div class="item clearfix">
            <label><span class="required">*</span>收货人：</label>
            <input type="text" name="consignee" id="editConsignee">
            <span class="desc"><span class="red">注：</span>请填写真实姓名，否则部分快递拒绝收件</span>
        </div>
        <div class="item clearfix">
            <label><span class="required">*</span>手机号码：</label>
            <input type="mobile" name="mobile" id="editMobile" maxlength="11" class="input-mobile" data-msg-mobile="请填写正确的收货人手机号">
        </div>
        <div class="item clearfix">
            <label>固定号码：</label>
            <input type="text" name="tel0" id="editTel0" class="input-area_no j-tels j-tel-0" placeholder="区号" maxlength="4">
            <input type="text" name="tel1" id="editTel1" class="input-tel j-tels j-tel-1" placeholder="电话号码" maxlength="8">
            <input type="hidden" class="j-tel" id="editTel" name="telephone">
        </div>
        <div class="item clearfix mt10">
            <label>&nbsp;</label>
            <input type="button" style="width:90px;margin-left:112px;" class="btn btn-default btn-x-big" value="取消" name="cancel" id="cancelAddAddress"/>
            <input type="submit" style="width:90px;margin-left: 10px;" class="btn btn-primary btn-x-big" value="保存" name="submit" />
            <input type="hidden" id="editId" name="id" value="" />
        </div>
        <div class="clear"></div>
    </fieldset>
    </form>
</div>

<div id="layer-content" style="display: none;">
    <div class="order_success_layer">
        <dl>
            <dt>订单金额：</dt>
            <dd>

                <span class="price ">
                    <span class="yuan">¥</span>
                    <span class="j-layer-price"></span>
                </span>

            </dd>
        </dl>
        <dl>
            <dt>订单号：</dt>
            <dd>
                <input type="text" value="22222" class="orderno j-layer-orderno" readonly>
                <span class="btn-copy j_clip_button">复制</span>
            </dd>
        </dl>
        <div class="msg-tip j-tip-copy">
            复制订单号，联系客服进行付款。
        </div>

        <div class="err-tip j-tip-intro" style="display: none;">
            <i class="vvicon">&#xe616;</i>
            请勾选 搜款网代发服务介绍
        </div>
        <!--<div class="err-tip j-tip-copy" style="display: none;">-->
            <!--<i class="vvicon">&#xe616;</i>-->
            <!--请先点击复制按钮-->
        <!--</div>-->
        <div class="bottom">
            <div class="fl">
                <i class="checkbox checked vvicon j-layer-checkbox"></i>
                同意
                <a target="_blank" href="http://www1.vvic.com/user_agreement.html">搜款网代发服务介绍</a>
            </div>

            <div class="fr">
                <a href="" style="display: none;" target="_blank" class="btn-link j-btn-link"></a>
                <a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDAyNjY5M18zNjE3MDZfODAwMDI2NjkzXzJf"
                   target="_blank" class="btn-qq j-btn-qq">联系客服
                </a>
            </div>
        </div>
    </div>

</div>

<jsp:include page="../common/footer.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<jsp:include page="../common/footjs.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<script>
    var _IDS = '${param.ids}'
    require(['order3/confirm3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>

</body></html>
