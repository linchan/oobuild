<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="stall3"/>
    <jsp:param name="cssHash" value="${cssHash.stall3}"/>
    <jsp:param name="title" value="提交新款"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="isShopCenter" value="1"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>
<div class="w user-w">
    <div class="main-wrap">
        <div class="addstyle-wrap">
            <div class="vv-msg"><strong>提醒：</strong>因为近期淘宝屏蔽爬虫，导致网站同步数据变慢，档主可选择手动提交商品的淘宝上新链接。</div>
        <div class="form-wrap">
            <div class="addstyle-label">输入淘宝链接：</div>
            <div class="addstyle-box">
                <textarea id="urlContent"></textarea>
                <div class="form-msg">
                    <p class="tip">可以一次性输入多条链接，每行一条。商品 ID 必须正确，其他参数无限制。</p>
                    <p class="error"></p>
                </div>
            </div>
        </div>
        <a href="javascript:;" class="btn btn-primary btn-x-big">提交</a>
    </div>
</div>
<div class="clear"></div>
</div>



<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    require(['shop3/addstyle3'], function () {
    });
</script>
    <jsp:include page="../common/third.jsp"/>
    </body>
</html>

