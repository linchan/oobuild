<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${staticDomain}/statics/lib/require/require.js?v3.2.0"></script>
<script type="text/javascript" src="${staticDomain}/statics/lib/jquery/jquery.min.js?v3.2.0"></script>
<script type="text/javascript" src="${staticDomain}/statics/lib/underscore/underscore-min.js?v3.2.0"></script>
<script type="text/javascript">
	_.templateSettings = {
	    evaluate: /\{\{(.+?)\}\}/g,
	    interpolate: /\{\{=(.+?)\}\}/g,
	    escape: /\{\{-(.+?)\}\}/g
	}
</script>
<c:choose>
	<c:when test="${staticDomain eq 'http://dev.src.vvic.com'}">
		<script type="text/javascript" src="${staticDomain}/statics/v2/js/config.dev.js?${jsHash}"></script>
	</c:when>
	<c:when test="${staticDomain eq 'http://test.vvic.com'}">
		<script type="text/javascript" src="${staticDomain}/statics/v2/js/config.test.js?${jsHash}"></script>
	</c:when>
	<c:when test="${staticDomain eq 'http://rc.vvic.com'}">
		<script type="text/javascript" src="${staticDomain}/statics/v2/js/config.rc.js?${jsHash}"></script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript" src="${staticDomain}/statics/v2/js/config.js?${jsHash}"></script>
	</c:otherwise>
</c:choose>
<c:if test="${param.hideFixBar!=1}">
    <jsp:include page="sidebar.jsp"></jsp:include>
</c:if>
