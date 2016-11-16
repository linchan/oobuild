<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="rent3"/>
    <jsp:param name="cssHash" value="${cssHash.rent3}"/>
    <jsp:param name="title" value="档口租赁 -"/>
    <jsp:param name="keywords" value="国大,大西豪,女人街,国投,富丽,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖国大、大西豪、女人街、国投、富丽、新金马、大时代、宝华、鞋城、圣迦、佰润、西街、新潮都、非凡、柏美等批发市场。"/>
    <jsp:param name="currentNav" value="9"/>
</jsp:include>
<c:set var="bid" value="${param.bid}"></c:set>

<div class="w clearfix">
    <div class="breadcrumb clearfix">

        <span class="fr extra-info">
            <a title="发布" class="addrent-btn j-btn-addrent" vda="action|button|fb">发布</a>
            <a class="addrent-btn j-btn-refresh" style="display: none;" vda="action|button|zd">置顶</a>
        </span>
    </div>
    <div class="screen">
        <div class="nav-category clearfix nav-market ">
            <div class="nc-key">市场：</div>
            <div class="nc-value">
                <!--show-more-->
                <c:set var="showmore" value=""/>
                <c:if test="${fn:length(param.bid)>0}">
                    <c:set var="showmore" value="show-more"/>
                </c:if>
                <div id="listMarket" class="types ${showmore}">
                    <a href="/rent.html" class="h-item bid" vda="link|fliter|0">全部</a>
                    <c:forEach items="${markets}" var="item"  varStatus="midState">
                        <c:set var="classname" value=""/>
                        <c:if test="${item.bid==param.bid}">
                            <c:set var="classname" value="selected"/>
                        </c:if>
                        <a href="?bid=${item.bid}" class="h-item bid bid_${item.bid} ${classname}" title="${item.bname}" vda="link|fliter|${midState.index+1}">${item.bname}</a>
                    </c:forEach>
                </div>

                <c:choose>
                    <c:when test="${fn:length(param.bid)>0}">
                        <div style="display:block" class="more close">
                            <span>收起</span>
                            <i></i>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="display:block" class="more open">
                            <span>更多</span>
                            <i></i>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

        <c:if test="${bid>0}">
            <div class="nav-category last clearfix nav-floor">
                <div class="nc-key">楼层：</div>
                <div class="nc-value">
                    <div id="listFloor" class="types">
                        <a href="?bid=${bid}" class="h-item bid" vda="link|fliter|0">全部</a>
                        <c:forEach items="${markets}" var="market" >
                            <c:if test="${market.bid==bid}">
                                <c:forEach items="${market.floors}" var="item" varStatus="midState">

                                    <c:set var="subclassname" value=""/>
                                    <c:if test="${item.floor==param.floor&&item.subarea==param.subarea&&midState.index==param.fi}">
                                        <c:set var="subclassname" value="selected"/>
                                    </c:if>

                                    <a href="?bid=${bid}&amp;floor=${item.floor}&amp;subarea=${item.subarea}&amp;subBid=${item.subBid}&amp;fi=${midState.index}" class="h-item bid bid ${subclassname}" vda="link|fliter|${midState.index+1}">


                                        <c:choose>
                                            <c:when test="${item.subName!=item.bname}">
                                                ${item.subName}
                                            </c:when>
                                            <c:otherwise>
                                                ${item.floor}楼 ${item.subarea}
                                            </c:otherwise>
                                        </c:choose>

                                    </a>
                                </c:forEach>
                            </c:if>

                        </c:forEach>

                    </div>
                    <!--<div style="display:block" class="more open">
                        <span>更多</span>
                        <i></i>
                    </div>-->
                </div>
            </div>
        </c:if>
    </div>


    <div>
        <div class="store mt10">
            <div class="j-list-content">
                <!---->
                <div class="loading3" style="height:200px;"></div>
            </div>

            <div class="clear"></div>

            <div class="pagination j-pagination" style="padding-bottom: 0;"></div>

            <script type="text/x-handlebars-template" id="template">

                <table>
                    <thead>
                    <tr>
                        <th width="170">更新时间</th>
                        <th width="200">档口号</th>
                        <th width="80">档口大小</th>
                        <th>描述</th>
                        <th width="80">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {{ _.each(data.recordList, function(item,index){ }}
                    <tr>
                        <td>{{=item.update_time}}</td>
                        <td>{{=item.marketName}} {{=item.floor}} 楼 {{=item.position}}</td>
                        <td>
                            {{ if(item.shop_size==1){ }}
                            整档
                            {{ } }}
                            {{ if(item.shop_size==2){ }}
                            半档
                            {{ } }}
                            {{ if(item.shop_size==3){ }}
                            1/4 档
                            {{ } }}
                        </td>
                        <td>{{=item.remark}}</td>
                        <td>
                            <a href="javascript:;" title="联系档主" class="blue-btn j-btn-contact" data-index="{{=index}}" vda="action|content|lxdz">联系档主</a>
                        </td>
                    </tr>
                    {{ }); }}
                    </tbody>
                </table>
                {{ if(data.recordCount==0){ }}
                <div class="empty-tip">
                    <i class="vvicon">&#xe614;</i>
                    <div class="text">
                        <div>抱歉没有找到相关的信息</div>
                    </div>
                </div>
                {{ } }}
            </script>

        </div>

        <script type="text/x-handlebars-template" id="showContact">
            <div class="p-article" style="display:block">
                <h3 class="p-title">联系档口</h3>
                <ul class="p-content">
                    {{=item.contacts_name}}，电话 {{=item.telephone}}。联系时，请说是在 VVIC 搜款网上看到的。谢谢！
                </ul>
            </div>
        </script>

    </div>
</div>

<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>

<script>
    var FIXEDAMOUNT = parseInt('${fixed_amount}');

    require(['web3/rent3'], {});
</script><%@ include file="common/third.jsp"%></body></html>
