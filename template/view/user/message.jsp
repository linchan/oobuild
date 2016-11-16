<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="user3"/>
    <jsp:param name="cssHash" value="${cssHash.user3}"/>
    <jsp:param name="title" value="消息中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>

<div class="w user-w">
    <div class="user-left">
        <jsp:include page="usernav.jsp">
            <jsp:param name="bigClass" value="0"/>
            <jsp:param name="msg" value="1" />
            <jsp:param name="msgType" value="${param.t}" />

        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="packet-ctrl">
                <div class="main-title">
                    <c:choose>
                        <c:when test="${param.t == '1'}">
                            系统消息
                        </c:when>
                        <c:when test="${param.t == '2'}">
                            档口通知
                        </c:when>
                        <c:when test="${param.t == '3'}">
                            备货提醒
                        </c:when>
                        <c:when test="${param.t == '4'}">
                            上下架通知
                        </c:when>
                        <c:when test="${param.t == '5'}">
                            订单通知
                        </c:when>
                        <c:otherwise>
                            所有消息
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="clear"></div>
            </div>

            <div class="message j-list-content">
                <!---->
                <div class="loading3" style="height: 300px;"></div>
                <script type="text/x-handlebars-template" id="tpl">
                    {{ _.each(recordList, function(el, index){ }}
                        {{ var _url = {0:'',1:"http://www1.vvic.com/help1.html",2:"/user/account/updatePassword.html", 3:"/shop/" + el.shop_id, 4:"/item/" + el.item_id, 5:"/item/" + el.item_id, 6:"/shop/list.html<c:if test="${cookie.ut.value==0}">?ut=1</c:if>", 7:"/shop/list.html", 8:"/shop/setting.html?sid="+el.shop_id, 9:"/user/orders.html?q="+el.order_no, 10:"/user/orders.html?q="+el.order_no, 12:"/shop/goods.html?sid="+el.shop_id, 14:"/shop/stocking.html?sid="+el.shop_id} }}
                    <c:if test="0">
                    <!--//1 注册成功 跳转新手指引-->
                    <!--//2 密码存在安全风险 跳转帐户设置页-->
                    <!--//3 关注的档口有上新 跳转[我是档口]-[商品列表]-->
                    <!--//4 上传的商品已经下架 跳转商品详情页-->
                    <!--//5 上传的商品信息已更新 跳转商品详情页-->
                    <!--//6 档口审核通过 跳转档口详情页-->
                    <!--//7 档口审核被拒 跳转档口设置页-->
                    <!--//8 档口消息审核未通过 跳转档口设置页-->
                    <!--//9 支付提醒 跳转订单列表页并带订单id-->
                    <!--//10 缺货 跳转订单列表页并带订单id-->
                    </c:if>
                    <a href="{{=_url[el.type]}}" target="_blank">
                    <dl {{if(index+1 == recordList.length){}}class="last"{{}}}>
                        <dt>
                            {{ if([3,4,5,9,10].indexOf(el.type) == -1){ }}
                            <img src="${staticDomain}/statics/v2/css/img/user/default.png" width="70" height="70" />
                            {{ }else{ }}
                            <img src="{{=el.img_url}}_100x100.jpg" width="70" height="70" />
                            {{ } }}
                        </dt>
                        <dd class="txt {{el.status?'':'unread'}}">
                            <div class="title">
                                {{=el.title}}
                            </div>
                            <div class="info">
                                {{=el.content}}
                            </div>
                            <div class="date">{{=el.ctime}}</div>
                        </dd>
                        <dd class="ctrl">
                            查看详情 <font class="vvicon">&#xe62d;</font>
                        </dd>
                    </dl>
                    </a>
                    {{ }) }}

                    {{ if(recordCount==0){ }}
                    <div class="empty-tip">
                        <span class="vvicon">&#xe614;</span>
                        <div class="text">
                            消息里还是空的
                        </div>
                    </div>
                    {{ } else { }}

                    {{ } }}
                </script>

            </div>

            <div id="Pagination" class="pagination"><!-- 这里显示分页 --></div>

        </div>
    </div>
    <div class="clear"></div>
</div>


<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script src="${staticDomain}/statics/lib/avalon/avalon.shim.js"></script>
<script>
    var _MSGTYPE = '${param.t}',
        _CURRENTPAGE = '${param.currentPage}' || 1
    require(['user3/message3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/></body></html>
