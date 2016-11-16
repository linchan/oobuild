<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="user3"/>
    <jsp:param name="cssHash" value="${cssHash.user3}"/>
    <jsp:param name="title" value="提现"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>
<style type="text/css">
    body.body_user3 .header_shop {
        border-bottom: none;
    }
</style>
<div class="w">
    <div class="vv-msg">为什么提现失败，<a href="http://www.vvic.com/help/issue/daifa7.html#f2" target="_blank">查看帮助 <font class="vvicon">&#xe62d;</font></a></div>
</div>
<div class="draw w" id="mainPanel">
    <c:set var="listLength" value="${fn:length(bank_list)}"></c:set>
    <div class="draw-title">
        <div class="draw-title-count fl">账户金额：<span>¥ <em>${userMoney}</em></span></div>
        <c:if test="${listLength>0}"><a class="draw-edit-btn fr" style="display: none;" href="javascript:;">修改提现账户</a></c:if>
    </div>
    <div class="draw-section">
        <c:if test="${listLength>0}">
        <span class="draw-section-tip">选择提现账户</span>
        <ul class="account-list clearfix">
            <c:forEach items="${bank_list}" var="item" varStatus="stats">
            <li <c:if test='${item.isDefault==1}'>class="checked"</c:if> data-account='${item.bankAccount}' data-id='${item.bankId}' data-real='${item.realName}'>
                <i class="vvicon v-radio-checked">&#xe618;</i>
                <i class="vvicon v-radio">&#xe619;</i>
                <i class="vvicon i-alipay ml10">&#xe649;</i>
                <span>支付宝 ${item.bankAccount}</span>
            </li>
            </c:forEach>
        </ul>
        <span class="draw-section-tip mt10">提现金额</span>
        <div class="draw-form clearfix">
            <p><input id="withdrawValue" type="text">元</p>
            <div class="form-err">
                <div class="err-info">
                    <i class='vvicon'>&#xe616;</i>
                    <span></span>
                </div>
            </div>
            <button id="next" style="float:left">下一步</button>
        </div>
        </c:if>
        <c:if test="${listLength==0}">
        <span class="draw-section-tip">选择提现账户</span>
        <a class="draw-btn" style="display: none;" href="javascript:;">
            <i class="vvicon">&#xe61a;</i>
            添加提现账户
        </a>
        </c:if>
    </div>
</div>

<div class="draw draw-confirm w" id="nextPanel" style="display: none;">
    <div class="draw-title">
        <h2>确定提现信息</h2>
    </div>
    <div class="draw-section">
        <div class="form-main mt10">
            <input type="hidden" id="comfirmBankId">
            <dl class="text-box">
                <dt>账户信息：</dt>
                <dd class="long">
                    <i class="vvicon i-alipay">&#xe649;</i>
                    <span id="comfirmBankType">支付宝</span>：<span id="comfirmBankAccount"></span>
                </dd>
            </dl>
            <dl class="text-box">
                <dt>提现金额：</dt>
                <dd class="red">
                    ¥ <em id="comfirmAmount"></em>
                </dd>
            </dl>
            <dl class="text-box">
                <dt>到账时间：</dt>
                <dd>
                    <span id="comfirmAcceptTime"></span> 前
                </dd>
            </dl>
            <dl class="text-box">
                <dt>绑定手机号：</dt>
                <dd>
                    <span class="bindedMobile"></span>
                    <a href="javascript:;" class="ml10 j-edit-mobile" target="_blank">修改</a>
                </dd>
            </dl>
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
            <dl class="text-box">
                <dt>短信验证码：</dt>
                <dd>
                    <input id="comfirmVerifyCode" value=""  name="mobileVerifyCode" maxlength="6" type="text">
                </dd>
                <dd class="sms">
                    <button class="btn j-btn-sms">获取短信验证码</button>
                </dd>
            </dl>
            <div class="err-info mt10" style="width: 330px;">
                <i class="vvicon">&#xe616;</i>
                <span></span>
            </div>
            <div class="btn-box clearfix">
                <a href="javascript:;" class="btn form-btn btn-disabled fl" id="ok" style="width: 178px;">申请提现</a>
                <a href="javascript:;" class="form-btn-link fl j-back">返回上一步</a>
            </div>
        </div>
    </div>
</div>

<script type="text/x-handlebars-template" id="addTemplate">
    <div class="form-main mt10">
        <input type="hidden" value="{{=bankId}}" name="userBankId" id="userBankId" />
        <div class="vv-msg">请输入提现帐号已认证的真实姓名，避免提现失败，<a href="http://www1.vvic.com/withdraw_1.html" target="_blank">查看帮助 <font class="vvicon">&#xe62d;</font></a></div>
        <dl class="text-box">
            <dt><span class="red">*</span>真实姓名：</dt>
            <dd>
                <input id="realName" value="{{=realName}}" name="realName" type="text">
            </dd>
            <dd class="ml10">
                <span class="red">注：</span>需与支付宝姓名保存一致
            </dd>
        </dl>
        <dl class="text-box">
            <dt><span class="red">*</span>支付宝账户：</dt>
            <dd class="long">
                <input id="userAliPay" value="{{=bankAccount}}" name="userAliPay" type="text">
            </dd>
        </dl>
        <dl class="text-box">
            <dt>绑定手机号：</dt>
            <dd>
                <span class="bindedMobile">{{=mobile}}</span>
                <a href="/user/account/updatePhone.html?mobile={{=fullMobile}}" class="ml10 j-edit-mobile" target="_blank">修改</a>
            </dd>
        </dl>
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
        <dl class="text-box">
            <dt>短信验证码：</dt>
            <dd>
                <input id="mobileVerifyCode" value=""  name="mobileVerifyCode" maxlength="6" type="text">
            </dd>
            <dd class="sms">
                <button class="btn j-btn-sms">获取短信验证码</button>
            </dd>
        </dl>
        <div class="err-info mt10">
            <i class="vvicon">&#xe616;</i>
            <span></span>
        </div>
    </div>
</script>

<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    var _VERIFYCODEURL = "/apic/verifyCode/generate";
    require(['user3/withdraw3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/></body></html>
