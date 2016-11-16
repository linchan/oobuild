<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="pay3"/>
    <jsp:param name="cssHash" value="${cssHash.pay3}"/>
    <jsp:param name="title" value="修改订单"/>
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
            <i class="vvicon warning">
                &#xe631;
            </i>
            <h2>
                <span>订单 ${param.orderSn} 修改失败。请联系客服</span>
            </h2>
            <p>商品状态发生变化无法进行修改</p>

            <a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDAyNjY5M18zNjE3MDZfODAwMDI2NjkzXzJf" target="_blank" class="btn_return btn_repay">联系客服</a>
        </div>

    </div>

</div>


<jsp:include page="common/footer.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<jsp:include page="common/footjs.jsp"/>
<script>
    require(function (pay) {
        pay.success()
    });
</script>
<jsp:include page="common/third.jsp"/>

</body></html>
