<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="common/header.jsp">
<jsp:param name="headerName" value="active"/>
<jsp:param name="cssName" value="shop3"/>
<jsp:param name="cssHash" value="${cssHash.shop3} -"/>
<jsp:param name="title" value="${id=='ranking'?'沙河档口排行榜':''}"/>
<jsp:param name="desc"
           value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
<jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
<jsp:param name="hideNav" value="1"/>

</jsp:include>

<jsp:include page="active/${id}/index.jsp"/>

<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>
<script>
<c:choose>
	<c:when test="${id=='ranking'}">
		require(['active3/ranking3'])
	</c:when>
	<c:otherwise>
		require(['common3/web3', 'common3/header3'])
	</c:otherwise>
</c:choose>
</script>
<jsp:include page="common/third.jsp"/></body></html>
