<!DOCTYPE html>
<%@ page language="java" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="renderer" content="webkit">
    <title>${param.title} 搜款网 - 真实档口一手货源</title>
    <meta name="keywords" content="${param.keywords}">
    <meta name="description" content="${param.desc}">
    <link rel="stylesheet" type="text/css" href="${staticDomain}/statics/v2/css/${param.cssName}.css?${param.cssHash}">
    <link href="${staticDomain}/favicon.ico" type="image/x-icon" rel="shortcut icon">
</head>
<body class="body_${param.cssName}">
<c:if test="${param.headerName!='user'}">
    <div class="top_ban_60">
        <c:forEach items="${top_banners}" var="item" varStatus="itemStats">
            <a href="${item.href_url}" vda="tp|top_banner|0|0|0|${item.id}" target="_blank" class="j-vda top_ban_item ishide" style="display:none">
                <img src="${item.img_url}" alt="">
            </a>
        </c:forEach>
        <div class="inner">
            <i class="close"></i>
        </div>
    </div>
</c:if>

<c:if test="${param.headerName != 'simple'}">
<jsp:include page="topbar.jsp"/>
</c:if>

<!-- logo，搜索 -->
<c:choose>
    <c:when test="${param.headerName=='shop'}">
        <jsp:include page="search_shop.jsp"/>
        <!--<jsp:include page="search_update.jsp"/>-->
    </c:when>
    <c:when test="${param.headerName=='user'}">
        <jsp:include page="search_user.jsp"/>
    </c:when>
    <c:when test="${param.headerName=='help'}">
        <jsp:include page="search_help.jsp"/>
    </c:when>
    <c:when test="${param.headerName=='active'}">
    </c:when>
    <c:when test="${param.headerName=='simple'}">
        <jsp:include page="simple.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="search.jsp"/>
    </c:otherwise>
</c:choose>
<!-- logo，搜索 -->

<!-- 分类，导航 , 档口首页隐藏-->
<c:if test="${param.hideNav!=1}">
    <div class="index_nav <c:if test='${param.isHome==1}'> ishome</c:if>">

        <div class="index_nav_inner">

            <div class="nav_drop">
                <div class="title">
                    <i class="fr ico_nav_drop_menu vvicon">&#xe615;</i>
                    <a href="/list.html" vda="link|category" target="_blank">全部分类</a>
                </div>

                <div class="nav_drop_menu">
                    <c:forEach items="${cates}" var="cat" begin="0" end="3">
                        <div class="menu_item clearfix">
                            <a href="/list.html#pid/${cat.pid}" vda="link|category" class="title clearfix">
                                <c:if test="${cat.pid==6}"><i></i></c:if>
                                <span>${cat.pname}</span>
                            </a>
                            <c:forEach items="${cat.showList}" var="item">
                                <a href="${item.href_url}" vda="link|category" class="item">${item.cname}</a>
                            </c:forEach>
                        </div>
                    </c:forEach>

                </div>

                <div class="nav_expend">

                    <c:forEach items="${cates}" var="cat">

                        <c:set var="catad" value="${cat.ad}"/>
                        <c:choose>
                            <c:when test="${fn:length(catad.img_url) > 0}">
                                <c:set var="hascatad" value="hascatad"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="hascatad" value=""/>
                            </c:otherwise>
                        </c:choose>

                        <div class="nav_item clearfix ${hascatad} pid_${cat.pid}">
                            <div class="nav_expend_txt">
                                <div class="inner">
                                    <c:forEach items="${cat.list}" var="item" varStatus="stats">
                                        <dl>
                                            <dt>
                                                <a hr1ef="/list.html#pid/${cat.pid}/tagid/${item.tag_id}" vda="link|category">${item.tag_name}</a></dt>
                                            <dd>
                                                <ul>
                                                    <c:forEach items="${item.catlist}" var="cat">
                                                        <li>
                                                            <a href="${cat.href_url}" vda="link|category">${cat.cname}</a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </dd>
                                        </dl>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="nav_expend_ad">
                                <div class="inner">
                                    <a href="${catad.href_url}" class="j-vda ishide" vda="tp|category|${catad.item_id}|${catad.shop_id}|0|0" target="_blank">
                                        <img src="${catad.img_url}" alt="">
                                    </a>
                                </div>
                            </div>
                        </div>

                    </c:forEach>


                </div>
            </div>

            <div class="nav_item_list">
                <c:set var="item1" value="" />
                <c:set var="item2" value="" />
                <c:set var="item3" value="" />
                <c:set var="item4" value="" />
                <c:set var="item5" value="" />
                <c:set var="item6" value="" />
                <c:set var="item7" value="" />
                <c:set var="item8" value="" />
                <c:set var="item9" value="" />
                <c:choose>
                    <c:when test="${param.currentNav==1}">
                        <c:set var="item1" value="selected" />
                    </c:when>
                    <c:when test="${param.currentNav==2}">
                        <c:set var="item2" value="selected" />
                    </c:when>
                    <c:when test="${param.currentNav==3}">
                        <c:set var="item3" value="selected" />
                    </c:when>
                    <c:when test="${param.currentNav==4}">
                        <c:set var="item4" value="selected" />
                    </c:when>
                    <c:when test="${param.currentNav==5}">
                        <c:set var="item5" value="selected" />
                    </c:when>
                    <c:when test="${param.currentNav==6}">
                        <c:set var="item6" value="selected" />
                    </c:when>
                    <c:when test="${param.currentNav==7}">
                        <c:set var="item7" value="selected" />
                    </c:when>
                    <c:when test="${param.currentNav==8}">
                        <c:set var="item8" value="selected" />
                    </c:when>
                    <c:when test="${param.currentNav==9}">
                        <c:set var="item9" value="selected" />
                    </c:when>
                     <c:when test="${param.currentNav==9}">
                        <c:set var="item10" value="selected" />
                    </c:when>
                    <c:otherwise>
                    </c:otherwise>
                </c:choose>

                <a href="/" class="item ${item1}" vda="link|navbar" title="首页">首页</a>
                <a href="/markets.html" class="item ${item2}" vda="link|navbar" title="市场导航">市场导航</a>
                <a href="/new.html" class="item ${item3} j_clear_newamount" vda="link|navbar" title="每日新款">
                    每日新款
                    <span class="newamount-box">
                        <span class="newamount"></span>
                        <span class="vvicon">&#xe612;</span>
                    </span>
                </a>
                <a href="/foreign.html" class="item ${item4}" vda="link|navbar" title="外贸爆款">外贸爆款</a>
                <a href="/hotsale.html" class="item ${item5}" vda="link|navbar" title="当季热卖">当季热卖</a>
                <a href="/list.html#/pid/2" class="item item6 ${item6} h-item pid" vda="link|navbar" title="品质男装">品质男装</a>
                <a href="/shoes.html" class="item ${item7}" vda="link|navbar" title="潮流鞋靴">潮流鞋靴</a>
                <a href="/list.html#/pid/6/bid/44" class="item item10 ${item10} h-item pid" vda="link|navbar" title="狮岭箱包">狮岭箱包</a>
                <a href="/agency.html" class="item ${item8}" vda="link|navbar" title="商品代发">商品代发</a>
                <a href="/rent.html" class="item ${item9}" vda="link|navbar" title="档口租赁">档口租赁</a>
            </div>

        </div>

    </div>
</c:if>

<!-- 分类，导航 -->
