<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="pay3"/>
    <jsp:param name="cssHash" value="${cssHash.pay3}"/>
    <jsp:param name="title" value="退款成功"/>
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
            <h2>
                <span>已成功退款</span>
                <span class="yuan">¥</span>
                <span class="price">${param.ra}</span>
                <span>到你的搜款网账户，可以前往「交易记录」页进行提现</span>
            </h2>
            <p>你的账户余额为：<span class="yuan">¥</span> <span class="price">${param.ua}</span></p>

            <a href="/user/orders.html" vda='action|edit_submit|wddd' class="btn_return">返回我的订单</a>
            <a href="/user/bill.html" vda="action|edit_submit|qtx" class="btn_repay">去提现</a>
        </div>

    </div>

</div>


<jsp:include page="../common/footer.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<jsp:include page="../common/footjs.jsp"/>
<script>
    var TOTAL_FEE = '${param.total_fee}'
    var RETURNURL = _WEB_Cfg.domain + '/user/orders.html'
    require(['order3/pay3'], function (pay) {
        // pay.success()
    });
</script>
<jsp:include page="../common/third.jsp"/>

</body></html>
