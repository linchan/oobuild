<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="help3"/>
    <jsp:param name="cssHash" value="${cssHash.help3}"/>
    <jsp:param name="title" value="帮助中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="hideNav" value="1"/>
    <jsp:param name="helpIndex" value="0"/>
    <jsp:param name="headerName" value="help"/>
</jsp:include>

<style type="text/css" media="screen">
    .header_shop {
        border-bottom: 1px solid #e5e5e5;
    }
</style>

<div class="w mt20 help-warp clearfix">
    <div class="help-nav fl" id="helpList">
        <div class="loading3" style="height: 200px;"></div>
    </div>
    <div class="help-content fr" id="content">
        <div class="loading3" style="height: 200px;"></div>
    </div>
</div>

<script type="text/x-handlebars-template" id="listTemplate">
    {{ _.each(tags, function(item){ }}
    <dl {{if(item.current==1){}}class="curr"{{}}}>
        <dt>
            {{=item.text}}
            <i></i>
        </dt>
        <dd>
            {{ _.each(item.list, function(sub){ }}
                {{if(sub.link!=''){}}
                    <a href="{{=sub.link}}" data-page="{{=sub.page}}" {{if(sub.current==1){}}class="curr"{{}}} target="_blank">{{=sub.text}}</a>
                {{}else{}}
                    <a href="/help/issue${tkey}/{{=sub.page}}.html" data-pag="{{=sub.page}}" {{if(sub.current==1){}}class="curr"{{}}}>{{=sub.text}}</a>
                {{}}}
            {{ }) }}
        </dd>
    </dl>
    {{ }) }}
</script>


<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    var _PAGENAME = "${pkey}";
    var _PAGETYPE = "${tkey}";
    var _KEYWORD = '';
    require(['help3/issue3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>


</body></html>
