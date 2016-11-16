<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="stall3"/>
    <jsp:param name="cssHash" value="${cssHash.stall3}"/>
    <jsp:param name="title" value="申请开通在线结算"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="isShopCenter" value="1"/>
    <jsp:param name="hideNav" value="1"/>
    <jsp:param name="settlement" value="1"/>
</jsp:include>
<div class="w user-w">
    <div class="vv-msg warning" style="display: none;">您提供的信息审核失败，请填写正确的信息重新申请。</div>

    <div class="form-main apply">
        <form id="applyForm" name="myForm">
        <div class="f-wrap">
            <div class="f-wrap-tab">
                <dl class="text-box clearfix">
                    <dt>档口名称：</dt>
                    <dd class="long">
                        <input type="text" name="shop_name" readonly="readonly" id="shopName" value="" />
                    </dd>
                </dl>
                <dl class="text-box clearfix">
                    <dt>档口地址：</dt>
                    <dd class="x-long" style="width: 300px;">
                        <input type="text" style="width: 280px;" name="shop_address" readonly="readonly" id="shopAddress" value="" />
                    </dd>
                </dl>
                <dl class="text-box clearfix">
                    <dt><span class="red">*</span> 真实姓名：</dt>
                    <dd class="long">
                        <input type="text" name="real_name" id="realName" />
                    </dd>
                    <dd class="err"></dd>
                    <dd class="desc">请填写与「支付宝账户」匹配的真实姓名</dd>
                </dl>
                <dl class="text-box clearfix">
                    <dt><span class="red">*</span> 支付宝账户：</dt>
                    <dd class="long">
                        <input type="text" name="alipay_account" id="alipayAccount" />
                    </dd>
                    <dd class="err"></dd>
                </dl>
                <dl class="text-box clearfix">
                    <dt>身份证号码：</dt>
                    <dd class="long">
                        <input type="text" name="identification_no" id="identificationNo" />
                    </dd>
                    <dd class="err"></dd>
                </dl>
                <dl class="text-box clearfix">
                    <dt><span class="red">*</span> 绑定手机：</dt>
                    <dd class="long mr10">
                        <input type="text" name="mobile" readonly="readonly" value="" id="mobile" maxlength="11">
                    </dd>
                    <dd class="middle">
                        <a href="/user/account/setting.html" target="_blank">修改</a>
                    </dd>
                </dl>
                <dl class="text-box j-status clearfix" style="height: 32px;">
                    <dt><span class="red">*</span> 图形验证码：</dt>
                    <dd class="code-input mr10">
                        <input type="text" id="secCode" maxlength="4" name="secCode" placeholder="请输入验证码" />
                    </dd>
                    <dd class="mr10">
                        <img width="100" style="width: 100px;height:30px;" id="secCodeImg" height="30" alt="验证码" src="/apic/verifyCode/generate">
                    </dd>
                    <dd><a href="javascript:;" class="code-btn">换一张</a></dd>
                    <dd class="err"></dd>
                </dl>
                <dl class="text-box j-status clearfix">
                    <dt><span class="red">*</span> 短信验证码：</dt>
                    <dd class="mr10">
                        <input type="text" name="smsCode" id="smsCode" maxlength="6">
                    </dd>
                    <dd>
                        <span style="width: 100px;" class="btn btn-default" id="getSms">获取短信验证码</span>
                    </dd>
                    <dd class="err"></dd>
                </dl>
            </div>
        </div>
        <div class="f-wrap-protocol j-status">
            <label class="v-single-check">
                <i class="vvicon check-false" style="display: none;">&#xe628;</i><i class="vvicon check-true">&#xe627;</i>我已阅读并同意接受 <a href="javascript:;" class="showprotocol">《搜款网资金账户使用协议》</a>
                <input type="hidden" name="readed" id="readed" value="1" />
            </label>
        </div>
        <div class="f-wrap-foot mt10 j-status">
            <input class="btn btn-primary btn-x-big" type="submit" id="ok" value="提交" />
            <input type="hidden" name="shop_id" id="shopId" value="" />
        </div>
        </form>
    </div>
</div>
<jsp:include page="../vvicaccountprotocol.jsp"/>
<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    require(['shop3/apply3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>

