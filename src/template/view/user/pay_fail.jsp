<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="pay3"/>
    <jsp:param name="cssHash" value="${cssHash.pay3}"/>
    <jsp:param name="title" value="支付失败"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="currentNav" value="99"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>


<div class="pay3 w">

    <div class="list-content">
        <div class="pay3_box pay_fail">

            <i class="vvicon" style="color:#fb658a">
                &#xe62e;
            </i>
            <h2>
                <p>以下是你的支付信息</p>
                <c:choose>
                    <c:when test="${param.type=='balance'}">
                        <p>支付方式：账户余额</p>
                    </c:when>
                    <c:otherwise>
                        <p>支付方式：支付宝账户 ${param.alipay_no}</p>
                    </c:otherwise>
                </c:choose>
                <p>
                    支付金额：
                    <span class="yuan">¥</span>
                    <span class="price">${param.total_fee}</span>
                </p>

            </h2>
            <p class="desc">如有疑问请拨打         400-6789-888            联系客服</p>

            <div class="pay_btns">
                <a href="/user/orders.html" class="btn_return" vda="action|editarea|wddd">返回我的订单</a>

                <a href="/user/pay.html?orderId=${param.order_id}" class="btn_repay j-btn-repay" vda="action|editarea|cxzf">重新支付</a>
            </div>


        </div>
    </div>

    <script type="text/x-handlebars-template" id="template">


    </script>


</div>


<jsp:include page="../common/footer.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<jsp:include page="../common/footjs.jsp"/>
<script>
    require(['order3/pay3'], function (pay) {
        // pay.fail();
    });
</script>
<jsp:include page="../common/third.jsp"/>

</body></html>
