<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="actName" value="" />
<c:choose>
<c:when test="${param.type=='bind'}">
    <c:set var="actName" value="绑定" />
</c:when>
<c:when test="${param.type=='update'}">
    <c:set var="actName" value="修改" />
</c:when>
<c:otherwise>
    <c:set var="actName" value="验证" />
</c:otherwise>
</c:choose>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="success3"/>
    <jsp:param name="cssHash" value="${cssHash.success3}"/>
    <jsp:param name="title" value="${actName}邮箱"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="currentNav" value="99"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>


<div class="pay3 w">

    <div class="list-content">
        <div class="pay3_box">
            <div class="loading3" style="height: 200px;"></div>
            <div class="email-success" style="display: none;">
                <i class="vvicon">
                    &#xe624;
                </i>
                <h2>
                    <span>${param.email} 邮箱${actName}成功</span>
                </h2>
                <a href="/" class="btn btn-primary btn-x-big">返回搜款网首页</a>
            </div>
            <div class="email-failed" style="display: none;">
                <i class="vvicon error">
                    &#xe62e;
                </i>
                <c:choose>
                    <c:when test="${param.type=='bind'}">
                        <h2>
                            <span>${param.email} 邮箱绑定失败</span>
                        </h2>
                        <a href="/user/account/setting.html" class="btn btn-default btn-x-big" id="sendEmail">重新绑定邮箱</a>
                    </c:when>
                    <c:when test="${param.type=='update'}">
                        <h2>
                            <span>${param.email} 邮箱修改失败</span>
                        </h2>
                        <a href="/user/account/setting.html" class="btn btn-default btn-x-big" id="sendEmail">重新修改邮箱</a>
                    </c:when>
                    <c:otherwise>
                        <h2>
                            <span>${param.email} 邮箱验证失败</span>
                        </h2>
                        <a href="/resendEmail.html?email=${param.email}" class="btn btn-default btn-x-big" id="sendEmail">重新发送验证邮件</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>


<jsp:include page="common/footer.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<jsp:include page="common/footjs.jsp"/>
<script>
    var EMAIL = "${param.email}";
    var VALIDATECODE = "${param.validateCode}";
    require(['web3/emailactive3'], function () {
    });
</script>
<jsp:include page="common/third.jsp"/>

</body></html>
