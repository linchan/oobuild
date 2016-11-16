<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="help3"/>
    <jsp:param name="cssHash" value="${cssHash.help3}"/>
    <jsp:param name="title" value="帮助中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="hideNav" value="1"/>
    <jsp:param name="helpIndex" value="1"/>
    <jsp:param name="headerName" value="help"/>
</jsp:include>

<div class="help-warp" style="background:none;">
    <div class="help-search">
        <div class="w">
            <div class="search_tab_content selected ">
                <div class="search_query_wrap">
                    <input id="helpKeyWord" type="text" autocomplete="off" class="search_query" value="${param.keyword}" name="helpKeyWord" disableautocomplete="disableautocomplete" placeholder="请输入问题关键词">
                </div>
                <button type="submit" id="btnHelpSearch" class="btn_search" vad="action|search|ss">
                    <i class="ico ico_search vvicon">&#xe606;</i>
                    搜索
                </button>
            </div>
        </div>
    </div>
    <div class="help-main w">
    <c:choose>
        <c:when test="${param.keyword != null && param.keyword != ''}">
            <div class="help-box mt20 help-result clearfix" id="helpResult">
                <div class="loading3" style="height:200px;"></div>
            </div>
        </c:when>
        <c:otherwise>
            <h1>自助服务</h1>
            <div class="help-service clearfix">
                <c:choose>
                    <c:when test="${tkey == 'shop'}">
                        <a href="/shop/list.html" target="_blank" title="档口入驻" class="help-service-item" vda="action|self_service|xgdd">
                            <em class="vvicon">&#xe639;</em>
                            <span>档口入驻</span>
                        </a>
                        <a href="/shop/list.html" target="_blank" title="档口认领" class="help-service-item" vda="action|self_service|dkrl">
                            <em class="vvicon">&#xe638;</em>
                            <span>档口认领</span>
                        </a>
                        <a href="/shop/list.html" target="_blank" title="档口信息修改" class="help-service-item" vda="action|self_service|dkxxxg">
                            <em class="vvicon">&#xe63a;</em>
                            <span>档口信息修改</span>
                        </a>
                        <a href="http://tb.vvic.com/AccessTokenRegister.aspx" target="_blank" title="申请秒更新" class="help-service-item" vda="action|self_service|sqmgx">
                            <em class="vvicon">&#xe63d;</em>
                            <span>申请秒更新</span>
                        </a>
                        <a href="/shop/setting.html" target="_blank" title="申请实拍" class="help-service-item last" vda="action|self_service|sqsp">
                            <em class="vvicon">&#xe63e;</em>
                            <span>申请实拍</span>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="/user/orders.html" target="_blank" title="查询订单" class="help-service-item" vda="action|self_service|cxdd">
                            <em class="vvicon">&#xe636;</em>
                            <span>查询订单</span>
                        </a>
                        <a href="/user/orders.html" target="_blank" title="修改订单" class="help-service-item" vda="action|self_service|xgdd">
                            <em class="vvicon">&#xe640;</em>
                            <span>修改订单</span>
                        </a>
                        <a href="/user/orders.html" target="_blank" title="取消订单" class="help-service-item" vda="action|self_service|qxdd">
                            <em class="vvicon">&#xe63c;</em>
                            <span>取消订单</span>
                        </a>
                        <a href="/user/orders.html" target="_blank" title="查看物流" class="help-service-item" vda="action|self_service|ckwl">
                            <em class="vvicon">&#xe637;</em>
                            <span>查看物流</span>
                        </a>
                        <a href="/findpwd.html" target="_blank" title="忘记密码" class="help-service-item last" vda="action|self_service|wjmm">
                            <em class="vvicon">&#xe63f;</em>
                            <span>忘记密码</span>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
            <h1>热门问题</h1>
            <div class="help-box help-qa clearfix" id="helpQaList">
                <div class="loading3" style="height: 200px;"></div>
            </div>
            <h1>联系我们</h1>
            <div class="help-box help-contact clearfix">
                <dl class="contact-kf clearfix">
                    <dt><i class="vvicon">&#xe641;</i></dt>
                    <dd>
                        <h3>在线客服</h3>
                        <p>在线对话，为您解决遇到的问题</p>
                        <a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDAyNjY5M18zNjE3MDZfODAwMDI2NjkzXzJf" class="btn btn-default btn-small" target="_blank" vda="action|search|zxkf">立即咨询</a>
                    </dd>
                </dl>

                <dl class="contact-tel clearfix">
                    <dt><i class="vvicon">&#xe63b;</i></dt>
                    <dd>
                        <h3><em>400-8070-929</em></h3>
                        <p>
                            热线时间：<br />
                            周一至周五 9:00 - 20:00<br />
                            周六至周日 10:00 - 18:00
                        </p>
                    </dd>
                </dl>
            </div>
        </c:otherwise>
    </c:choose>
    </div>
</div>



<script type="text/x-handlebars-template" id="listTemplate">
    {{ _.each(tags, function(item, index){ }}
    <dl class="help-qa-list{{if(index==4){}} last{{}}}">
        <dt>
            {{=item.text}}
        </dt>
        <dd>
            {{ var subLength = 0}}
            {{ _.each(item.list, function(sub){ }}
                {{ if(sub.hot=='true'){ }}
                    {{if(sub.link!=''){}}
                        <a href="{{=sub.link}}" target="_blank" vda="link|top_questions">{{=sub.text}}</a>
                    {{}else{}}
                        <a href="/help/issue${tkey}/{{=sub.page}}.html" target="_blank" vda="link|top_questions">{{=sub.text}}</a>
                    {{}}}
                    {{subLength++}}
                {{ } }}
            {{ }) }}
            {{ _.each(item.list, function(sub, index){ }}
                {{if(index==0 && subLength > 1){}}
                    {{if(sub.link!=''){}}
                        <a href="{{=sub.link}}" target="_blank" vda="link|top_questions">查看更多 <i class="vvicon">&#xe62d;</i></a>
                    {{}else{}}
                        <a href="/help/issue${tkey}/{{=sub.page}}.html" target="_blank" vda="link|top_questions">查看更多 <i class="vvicon">&#xe62d;</i></a>
                    {{}}}
                {{}}}
            {{ }) }}
        </dd>
    </dl>
    {{ }) }}
</script>


<script type="text/x-handlebars-template" id="resultTemplate">
    {{if(list.length){}}
    <div class="help-result-q fl">您想问的是：</div>
    {{}}}
    <div class="help-result-box fl">
        {{if(list.length){}}
        <ul class="help-result-list" style="margin-bottom: 10px;">
            {{ _.each(list, function(item, index){ }}
                <li>
                {{if(item.link!=''){}}
                    <a href="{{=item.link}}" target="_blank" vda="link|top_questions">{{=index+1}}.{{=item.text}}</a>
                {{}else{}}
                    <a href="/help/issue{{=item.type}}/{{=item.page}}.html" target="_blank" vda="link|top_questions">{{=index+1}}.{{=item.text}}</a>
                {{}}}
                </li>
            {{ }) }}
        </ul>
        {{}else{}}
            <p class="mt10" style="color:#333;">根据您当前提供内容，没有找到相关的答案。请您输入简洁、完整的问题，继续提问
            </p>
        {{}}}
        <p>如果上述答案没有帮您解决问题，您可以咨询<a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDAyNjY5M18zNjE3MDZfODAwMDI2NjkzXzJf" target="_blank" vda="action|search|zxkf"><i class="vvicon">&#xe603;</i>在线客服</a></p>
    </div>
</script>

<jsp:include page="../common/footer.jsp" >
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>

<jsp:include page="../common/footjs.jsp"/>
<script>
    var _PAGETYPE = "${tkey}",
        _KEYWORD = "${param.keyword}";
    require(['help3/index3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>
