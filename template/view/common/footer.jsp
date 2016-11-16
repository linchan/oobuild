
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="footer3_wrap">
    <div class="footer3">

        <div class="top_links">
            <a href="/about.html" class="item" title="关于我们" vda="link|bottom">关于我们</a>
            |
            <a href="/contact.html" class="item" title="联系我们" vda="link|bottom">联系我们</a>
            |
            <a href="/join.html" class="item" title="加入我们" vda="link|bottom">加入我们</a>
        </div>

        <div class="copy">
            Copyright © 2011-2015 vvic.com <a style="color:#9c9c9c;" href="http://www.miitbeian.gov.cn/" target="_blank">粤 ICP 备 12070150 号-2</a>
        </div>

        <div class="secur" >
            <a class="item" target="_blank" href="http://webscan.360.cn/index/checkwebsite?url=vvic.com">
                <img src="${staticDomain}/statics/v2/css/img/common/footer_360.png" alt="">
            </a>
            <a class="item" target="_blank" href="https://credit.szfw.org/CX20160526015387370182.html" id="___szfw_logo___">
                <img src="${staticDomain}/statics/v2/css/img/common/footer_sincerity.png" alt="">
            </a>
            <script type='text/javascript'>(function(){document.getElementById('___szfw_logo___').oncontextmenu= function(){return false;}})();</script>
        </div>
        <div class="links">
            <c:forEach items="${friendLinks}" var="item">
                <a href="${item.link}" target="_blank" title="${item.name}" class="item">${item.name}</a>
            </c:forEach>
        </div>

    </div>
</div>
