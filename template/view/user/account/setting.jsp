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
            <jsp:param name="bigClass" value="1"/>
            <jsp:param name="msg" value="2" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="form-main">
                <h2 class="form-title">安全设置</h2>
                <div class="f-wrap">
                    <div class="loading3"></div>
                    <div class="f-wrap-tab" style="display: none;">
                        <dl class="text-box" id="userNameBox" style="display: none;">
                            <dt>用户名：</dt>
                            <dd class="long">
                                <span class="text-show" id="userName"></span>
                            </dd>
                        </dl>
                        <dl class="text-box">
                            <dt>手机号：</dt>
                            <dd class="middle">
                                <span class="text-read" id="userPhone"></span>
                            </dd>
                            <dd class="small">
                                <a href="javascript:;" class="btn btn-x-small" id="userPhoneConfirm"></a>
                            </dd>
                        </dl>
                        <dl class="text-box">
                            <dt>邮箱：</dt>
                            <dd class="middle">
                                <span class="text-read" id="userEmail"></span>
                            </dd>
                            <dd class="small">
                                <a href="javascript:;" class="btn btn-x-small" id="userEmailConfirm"></a>
                            </dd>
                        </dl>
                        <dl class="text-box">
                            <dt>登录密码：</dt>
                            <dd class="middle">
                                <input type="password" class="text-input"  value="xxxxxx" disabled="disabled" id="user"/>
                            </dd>
                            <dd class="small">
                                <a href="updatePassword.html" class="btn btn-x-small">修改</a>
                            </dd>
                        </dl>
                        <c:if test="${1==0}">
                        <dl class="text-box">
                            <dt>支付密码：</dt>
                            <dd class="middle">
                                <input type="password" class="text-input"  value="xxxxxx" disabled="disabled" />
                            </dd>
                            <dd class="small">
                                <a href="updatePayPassword.html" class="btn btn-x-small">绑定</a>
                            </dd>
                        </dl>
                        </c:if>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="clear"></div>
</div>


<jsp:include page="../../common/footer.jsp"/>
<jsp:include page="../../common/footjs.jsp"/>
<script src="${staticDomain}/statics/lib/avalon/avalon.shim.js"></script>
<script>

    require(['account3/setting3'], function(){});
</script>
<jsp:include page="../../common/third.jsp"/></body></html>
