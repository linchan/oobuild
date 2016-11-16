<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../../common/header.jsp">
    <jsp:param name="cssName" value="account3"/>
    <jsp:param name="cssHash" value="${cssHash.account3}"/>
    <jsp:param name="title" value="账户设置"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>

<div class="w user-w">
    <div class="user-left">
        <jsp:include page="../usernav.jsp">
            <jsp:param name="bigClass" value="2"/>
            <jsp:param name="msg" value="2" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="form-main">
                <h2 class="form-title">个人资料</h2>
                <div class="f-wrap" >
                    <div class="loading3"></div>
                    <div class="f-wrap-tab" style="display: none;">
                        <dl class="text-box" id="userNameBox" style="display: none;">
                            <dt>用户名：</dt>
                            <dd class="long">
                                <span class="text-show" id="userName"></span>
                            </dd>
                        </dl>
                        <dl class="text-box">
                            <dt>昵称：</dt>
                            <dd class="long">
                                <input type="text" id="nickName" maxlength="20"/>
                            </dd>
                            <dd class="text-name-tip">4-20 字符之间，中文占 2 个字符</dd>
                        </dl>
                        <dl class="text-box">
                            <dt>QQ：</dt>
                            <dd class="long">
                                <input type="text" id="qq"/>
                            </dd>
                        </dl>
                        <dl class="text-box">
                            <dt>旺旺号：</dt>
                            <dd class="long">
                                <input type="text" id="wwh"/>
                            </dd>
                        </dl>
                        <dl class="text-box text-inter">
                            <dt>兴趣：</dt>
                            <dd class="xx-long">
                                <span class="interest-intro">请选择感兴趣的分类，我们会提供最精准的推荐</span>
                                <div class="account-interest" id="interestList"></div>
                            </dd>
                        </dl>
                        <dl class="text-box error-outer unvisibly">
                            <dt>&nbsp;</dt>
                            <dd class="long">
                                <p class="error-box">
                                    <i class="vvicon error-icon">&#xe616;</i>
                                    <span class="error-text"></span>
                                </p>
                            </dd>
                        </dl>
                        <div class="clear"></div>
                        <div class="btn-box">
                            <a href="javascript:;" class="form-btn" id="updateEmailSubmit">提交</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="clear"></div>
</div>


<jsp:include page="../../common/footer.jsp"/>
<jsp:include page="../../common/footjs.jsp"/>
<script>

    require(['account3/profile3'], function () {
    });
</script>
<jsp:include page="../../common/third.jsp"/></body></html>
