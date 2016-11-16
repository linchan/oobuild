<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header_shop">

    <div class="header_inner">
        <div class="w clearfix ">

            <a href="/" title="搜款网VVIC" class="logo fl">
                <img src="${staticDomain}/statics/v2/css/img/logo/logo_shop.png" alt="">
            </a>

            <div class="stall-head fl">
                <div class="update-head-name">${param.title}</div>
            </div>


            <c:choose>
                <c:when test="${param.helpIndex==1}">
                    <ul class="help-tag clearfix">
                        <li <c:if test="${tkey!='shop'}">class="curr"</c:if>>
                            <a href="/help/index.html">通用版</a>
                        </li>
                        <li <c:if test="${tkey=='shop'}">class="curr"</c:if>>
                            <a href="/help/index_shop.html">档口版</a>
                        </li>
                    </ul>
                </c:when>
                <c:otherwise>

                    <div class="help-top-search fl">
                        <form id="search_help" action="/help/index.html" class="search_tab_content selected" method="get">
                            <div class="search_query_wrap">
                                <input id="helpKeyWord" type="text" autocomplete="off" class="search_query" value="" name="keyword" disableautocomplete="disableautocomplete" placeholder="请输入问题关键词" />
                            </div>

                            <button type="submit" id="btnHelpSearch" class="btn_search">
                                <i class="ico ico_search vvicon">&#xe606;</i>
                                搜索
                            </button>
                        </form>
                    </div>

                    <div class="help-top-tel fr">
                        <i class="vvicon">&#xe642;</i>
                        客服热线<em>400-807-0929</em>
                    </div>
                </c:otherwise>
            </c:choose>


        </div>
    </div>

</div>
