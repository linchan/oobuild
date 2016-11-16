<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="pageTitle" value="" />
<c:choose>
    <c:when test="${pkey=='reg'}">
        <c:set var="pageTitle" value="注册成功" />
    </c:when>
    <c:when test="${pkey=='email'}">
        <c:set var="pageTitle" value="验证邮箱" />
    </c:when>
    <c:when test="${pkey=='pay'}">
        <c:set var="pageTitle" value="支付成功" />
    </c:when>
    <c:otherwise>

    </c:otherwise>
</c:choose>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="success3"/>
    <jsp:param name="cssHash" value="${cssHash.success3}"/>
    <jsp:param name="title" value="${pageTitle}"/>
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

            <i class="vvicon">
                &#xe624;
            </i>

            <c:choose>
                <c:when test="${pkey=='reg' || pkey=='email'}">
                    <h2>
                    <!-- <c:if test="${pkey=='reg'}">
                        欢迎来到搜款网，为了您的账户安全，建议您先去激活邮箱。<br />
                    </c:if> -->
                    验证邮件已成功发送到您的邮箱，请在 24 小时内登录完成激活</h2>
                    <a href="javascript:;" class="btn btn-primary btn-x-big go-email-host" style="display:none;margin-right:10px;">前往邮箱</a>
                    <c:choose>
                        <c:when test="${pkey=='reg' || param.type=='activation'}">
                            <a href="/resendEmail.html?email=${param.email}" class="btn btn-default btn-x-big">重新发送验证邮件</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/user/account/setting.html" class="btn btn-default btn-x-big">重新修改邮箱</a>
                        </c:otherwise>
                    </c:choose>

                    <div class="email-action">
                        <ul>
                            <li class="h2">没有收到验证邮件</li>
                            <li>1. 网络通讯异常可能会造成邮件丢失，请重新获取或稍后再试</li>
                            <li>2. 请核实邮箱是否正常使用，并检查垃圾邮箱夹</li>
                            <li>3. 邮箱填写错误，可前往<a class="red" href="/user/account/updateEmail.html?email=${param.email}">修改邮箱</a></li>
                        </ul>
                    </div>
                </c:when>
                <c:when test="${pkey=='pay'}">
                    <h2>
                        <span>你已经成功付款</span>
                        <span class="yuan">¥</span>
                        <span class="price">${param.total_fee}</span>

                    </h2>
                    <p>我们将立即为您处理订单</p>
                    <c:choose>
                        <c:when test="${param.type == 'refund'}">
                            <a href="/user/refund_detail.html?order_id=${param.order_id}" class="btn_return">查看退款<span class="count">（5 秒）</span></a>
                        </c:when>
                        <c:otherwise>
                            <a href="/user/orders.html" class="btn_return">返回我的订单<span class="count">（5 秒）</span></a>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>
        </div>

    </div>

</div>


<jsp:include page="common/footer.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<jsp:include page="common/footjs.jsp"/>
<script>
    var RETURNURL = _WEB_Cfg.domain + '/user/orders.html';
    var _EMAIL = '${param.email}';
    var _TYPE = '${param.type}';
    require(['web3/success3'], function (p) {
        <c:choose>
            <c:when test="${pkey=='reg' || pkey=='email'}">
                p.reg();
            </c:when>
            <c:when test="${pkey=='pay'}">
                p.pay();
            </c:when>
            <c:otherwise>
            </c:otherwise>
        </c:choose>
    });
</script>
<jsp:include page="common/third.jsp"/>

</body></html>
