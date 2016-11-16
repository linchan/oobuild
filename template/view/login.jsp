<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="login3"/>
    <jsp:param name="cssHash" value="${cssHash.login3}"/>
    <jsp:param name="title" value="欢迎登录"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="headerName" value="simple" />
    <jsp:param name="hideNav" value="1" />

</jsp:include>

<div class="login-warp">
	<!--login-code-->
	<div class="login-main login-bg-1 w" >
		<div class="login-text" style="display: none;">
			<!--<img src="${staticDomain}/statics/v2/css/img/user/login_text1.png" width="450" alt="">-->
			<img src="" width="450"/>
		</div>
		<div class="login-pannel">

			<form name="myForm" id="j-form">
			<div class="login-form">
				<div class="form-title">
					<strong>账户登录</strong>
				</div>
				<div class="form-main">
					<dl class="clearfix">
						<dt class="vvicon">&#xe634;</dt>
						<dd>
							<input type="text" id="username" name="username" placeholder="邮箱/手机号" />
						</dd>
					</dl>
					<dl class="clearfix">
						<dt class="vvicon">&#xe633;</dt>
						<dd>
							<input type="password" id="password" name="password" placeholder="密码" />
						</dd>
					</dl>
					<dl class="code clearfix hide" id="codeBox">
						<dd class="code-input">
							<input type="text" id="secCode" name="secCode" placeholder="请输入验证码" />
						</dd>
						<dd class="code-img">
							<img width="110" id="secCodeImg" height="40" alt="验证码" src="/apic/verifyCode/generate">
						</dd>
						<dd class="code-btn">换一张</dd>
					</dl>
					<dl class="code clearfix hide" id="smsBox">
							<dd class="sms-input">
								<input type="text" id="userPhoneCode" placeholder="请输入短信验证码" maxlength="6" name="smsCode" />
							</dd>
						<dd class="small">
							<a class="btn btn-red sms-btn" href="javascript:;">获取短信验证码</a>
						</dd>
					</dl>
					<div class="login-other clearfix" >
						<a href="/findpwd.html" class="fr" vda="link|login" >忘记密码</a>
						<label class="v-single-check">
							<i class="vvicon check-false" vda="action|login|xczddl|0">&#xe628;</i><i class="vvicon check-true"  vda="action|login|xczddl|1">&#xe627;</i>下次自动登录
						</label>
					</div>

					<input type="hidden" name="auto" id="auto" value="0" />
					<input type="submit" class="btn btn-x-big btn-primary mt20" value="登&nbsp;录" id="submit"  vda="action|login|dl" />
					<p class="mt20 tc"><a href="/reg.html" vda="link|login">没有账号，立即注册</a></p>
				</div>
			</div>
			</form>
		</div>
	</div>
</div>


<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp">
	 <jsp:param name="hideFixBar" value="1" />
</jsp:include>
<script>
	var _VERIFYCODEURL = "/apic/verifyCode/generate";
	var _REURL = "${param.reurl}";
    require(['web3/login3'], function () {
    });
</script>
<jsp:include page="common/third.jsp"/>
</body></html>
