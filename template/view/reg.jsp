<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="reg3"/>
    <jsp:param name="cssHash" value="${cssHash.reg3}"/>
    <jsp:param name="title" value="欢迎注册"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="headerName" value="simple" />
    <jsp:param name="hideNav" value="1" />
    <jsp:param name="regType" value="reg" />
</jsp:include>
<div class="w reg clearfix">
	<jsp:include page="vvicprotocol.jsp"/>
	<form>
		<div class="reg-warp">
			<div class="reg-inner">

				<div class="reg-from">
					<ul class="reg-nav">
						<li class="current" data-type="0">我是买手</li>
						<li data-type="1">我的档口</li>
					</ul>
					<div class="form-main">
			          <dl class="text-box" id="typePhone">
			            <dt>手机号码</dt>
			            <dd class="long">
			              <input id="userName" name="userName" maxlength="11" type="text" placeholder="请输入手机号码"  />
			            </dd>

			          </dl>

			          <dl class="text-box hide" id="typeMail">
			            <dt>邮箱</dt>
			            <dd class="long">
			              <input id="userEmail" name="userEmail" type="text" placeholder="请输入邮箱"  />
			            </dd>

			          </dl>

			          <dl class="text-box">
			            <dt>密码</dt>
			            <dd class="long">
			              <input id="userPsd" name="userPwd" maxlength="20" minlength="8" type="password" placeholder="必须包括字母和数字，8-20字符" />
			            </dd>

			          </dl>
			          <dl class="text-box">
			            <dt>确认密码</dt>
			            <dd class="long">
			              <input id="userRPsd" name="userPwdConfirm" maxlength="20" minlength="8" type="password" placeholder="请确认密码" />
			            </dd>

			          </dl>
			          <dl class="text-box">
			            <dt>验证码</dt>
			            <dd class="s-long">
			              <input id="userCode" name="userCode" placeholder="请输入验证码" />
			            </dd>
			            <dd class="small">
			            	<img width="120" height="40" alt="验证码" src="" id="codeImage">
			            </dd>
			            <dd class="x-small">
			            	<a href="javascript:;" class="blue-btn onChangeCode">换一张</a>
			            </dd>
			          </dl>
			          <dl class="text-box" id="smsBox">
			            <dt>短信验证码</dt>
			            <dd class="s-long">
			              <input id="userPhoneCode" name="userPhoneCode"type="text" placeholder="请输入短信验证码">
			            </dd>
			            <dd class="small">
			              <a class="btn btn-disabled" id="onGetSms" href="javascript:;">获取短信验证码</a>
			            </dd>

			          </dl>
			          <dl class="text-box text-box-last">
			            <dt><b>&nbsp;</b></dt>
			            <dd class="long auto" id="error-layer">
			            	<label class="v-single-check">
								<em class="vvicon check-false" style="display: none;">&#xe628;</em><em class="vvicon check-true">&#xe627;</em>阅读并同意
							</label>
							<input type="hidden" name="auto" id="auto" value="1" />
			            	<a href="javascript:;" class="blue-btn showprotocol">《搜款网用户协议》</a>

			            </dd>
			          </dl>
			          <div class="clearfix"></div>
			          <div class="btn-box">
			            <input value="注 册" type="button" class="form-btn" vda="action|reg|zc">
			          </div>
			          <div class="form-foot">
			          	<div class="reg-form-foot">
			          		<a href="javascript:;" title="邮箱注册" class="reg-type" id="regType" vda="action|reg|yxzc" >通过邮箱注册</a>
			          		<input type="hidden" id="regType" value="0" />
			          	</div>

			          </div>
			        </div>
				</div>
			</div>

		</div>
	</form>
</div>

<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp">
	 <jsp:param name="hideFixBar" value="1" />
</jsp:include>
<script>
    require(['web3/reg3'], function () {
    });
</script>
<jsp:include page="common/third.jsp"/>
</body></html>
