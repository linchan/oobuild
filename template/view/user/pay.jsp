<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="pay3"/>
    <jsp:param name="cssHash" value="${cssHash.pay3}"/>
    <jsp:param name="title" value="支付"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="currentNav" value="99"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>


<div class="pay3 w">

    <div class="list-content">
        <!--json-->

        <div class="loading3" style="height: 200px;"></div>

    </div>

</div>

<script type="text/x-handlebars-template" id="template">

    <div class="top">
            应付金额：
            <span class="red">
                <span class="yuan">¥</span>
                <span class="price">
                    {{-data.totalAmount.toFixed(2)}}
                </span>
            </span>
        <!--<div class="text">请在提交订单后 48 小时内完成支付。</div>-->

    </div>

    <div class="orders-list">

        {{ _.each(data.orders, function(item){ }}
        <div class="citem">
            <h2>订单号： <span class="num">{{=item.orderNo}}</span></h2>
            <p>商品将发送给 {{=item.consignee}}，物流方式为 {{=item.expressName}}。<!--如果立即完成支付，预计的拿货时间为：{{=item.timeOut}}。 --></p>
        </div>
        {{ }); }}


    </div>

    <div class="pay-types">

        <h2>支付方式</h2>

        <table class="pay-list">
            {{ var notEnough = data.userMoney < data.totalAmount ? true : false }}
            {{ var payType = ''}}
            {{ _.each(data.payconfigs, function(item){ }}
                {{ if(item.isOnline){ }}
                {{if(item.isDefault && item.payCode =='balance' && !notEnough){}}
                    {{payType='balance'}}
                {{}else{}}
                    {{if(payType=='' && item.payCode!='balance'){}}
                        {{payType=item.payCode}}
                    {{}}}
                {{}}}
                <tr class="citem pay-{{=item.payCode}} j-pay-type {{if(item.payCode==payType){}}selected{{}}} {{if(notEnough && item.payCode=='balance'){}}disabled{{}}}" data-code="{{=item.payCode}}">
                    <td width="20"></td>
                    <td width="34">
                        <i class="vvicon radio checked">&#xe618;</i>
                        <i class="vvicon radio unchecked">&#xe619;</i>
                    </td>
                    <td width="26">
                        <img align="absmiddle" src="${staticDomain}/statics/v2/css/img/bank/{{=item.payCode}}.png" height="16" alt="">
                    </td>
                    <td {{if(item.payCode=='balance'){}}class="pay-balance-amount"{{}}}>
                        {{=item.payName}}
                        {{if(item.payCode=='balance'){}}：<span class="yuan">¥</span><em>{{= data.userMoney}}</em> {{if(notEnough){}}<span style="font-size:12px;margin-left:15px;">余额不足</span>{{}}}
                        {{}}}
                    </td>
                </tr>
                {{ } }}
            {{ }); }}
            <tr class="j-pay-form" {{if(payType!='balance'){}}style="display: none;"{{}}}>
                <td colspan="4">
                    <div class="form-main pay">
                        <div class="f-wrap">
                            <div class="f-wrap-tab">
                                <dl class="text-box clearfix">
                                    <dt><span class="red">*</span> 绑定手机：</dt>
                                    <dd class="mr10">
                                        {{if(mobile){}}
                                            {{=mobile}}
                                        {{}else{}}
                                            <a class="btn btn-primary btn-small" href="">立即绑定</a><span style="color:#9c9c9c;">为了您的资金安全，请先绑定手机</span>
                                        {{}}}
                                    </dd>
                                    {{if(mobile!=''){}}
                                    <dd class="middle">
                                        <a class="j-modify-mobile" href="/user/account/setting.html" style="display: none;" target="_blank">修改</a>
                                    </dd>
                                    {{}}}
                                </dl>
                                {{if(mobile!=''){}}
                                <dl class="text-box">
                                    <dt>验证码：</dt>
                                    <dd>
                                        <input maxlength="4" type="text" id="secCode" name="secCode" placeholder="请输入验证码" />
                                    </dd>
                                    <dd class="code-img ml10">
                                        <img width="80" class="j-code-img" id="secCodeImg" height="30" alt="验证码" src="/apic/verifyCode/generate">
                                    </dd>
                                    <dd class="code-btn ml10" style="cursor: pointer;">换一张</dd>
                                </dl>
                                <dl class="text-box j-sms clearfix">
                                    <dt><span class="red">*</span> 短信验证码：</dt>
                                    <dd class="mr10">
                                        <input type="text" name="smsCode" id="smsCode" maxlength="6">
                                    </dd>
                                    <dd>
                                        <span style="width: 100px;" class="btn btn-default j-btn-sms" id="getSms">获取短信验证码</span>
                                    </dd>
                                    <dd class="err"></dd>
                                </dl>
                                {{}}}
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

        <div class="btn btn-primary btn-x-big j-btn-pay" style="width: 160px;" vda="action|pay_submit|zf">立即支付</div>

        <form id="goForm" target="_blank" method="post" >

        </form>
    </div>


</script>


<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<script>
    ORDERID ='${param.orderId}'
    PAYNO = '${param.payNo}'
    PAYTYPE = '${param.type}'
    var _VERIFYCODEURL = "/apic/verifyCode/generate";
    require(['order3/pay3'], function (pay) {
        pay.init();
    });
</script>
<jsp:include page="../common/third.jsp"/>

</body></html>
