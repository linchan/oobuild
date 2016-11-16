<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="cart3"/>
    <jsp:param name="cssHash" value="${cssHash.cart3}"/>
    <jsp:param name="title" value="打印拿货单"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="currentNav" value="99"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>

<style>
    .w ,.top_bar_inner {
        width: 1080px !important;
    }

    .header_shop .logo {
        background: none;
    }

    .header_shop .logo img {
        display: block;
    }
</style>
<div class="print-list">

    <div class="list-content">
        <!--json-->

        <div class="loading3" style="height: 200px;"></div>
    </div>

    <script type="text/x-handlebars-template" id="tpl">

        <div id="print-time" style="display:none"><span>{{=date}} </span>生成</div>
        <table class="mt20">
            <thead>
            <tr>
                <th>地址</th>
                <th>档口</th>
                <th>货号</th>
                <th>属性</th>
                <th>单价</th>
                <th>数量</th>
                <th>联系人/手机号</th>
            </tr>
            </thead>
            <tbody>
            {{ _.each(data.recordList, function(item){ }}
            <tr>
                <td>{{=item.subName}} {{=item.floor}}楼</td>
                <td>{{=item.position}}</td>
                <td>{{=item.art_no}}</td>
                <td>{{- item.color == "nocolor" ? '' : item.color}} {{- item.size == "nosize" ? '' : item.size}}</td>
                <td>¥ {{- Number(item.discount_price).toFixed(2) }}</td>
                <td>{{=item.amount}}</td>
                <td>{{=item.contacts_name}} {{=item.telephone}}</td>
            </tr>

            {{ }); }}

            </tbody>
        </table>

        {{ if(data.recordList.length==0){ }}
        <div class="empty-tip">
            <span class="vvicon">&#xe614;</span>
            <div class="text">
                没有找到相关商品
            </div>
        </div>

        {{ } }}
    </script>

</div>


<jsp:include page="../common/footjs.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<script>
    window.IDS = '${param.ids}'

    require(['user3/print3'], function () {

    });
</script>
<jsp:include page="../common/third.jsp"/>

</body></html>
