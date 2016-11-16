<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="header3_wrap ${param.fixdHeaderClassName}">

    <div class="header_inner">
        <div class="header3 clearfix">

            <a href="/" class="logo" vda="link|logo">
                <img src="${staticDomain}/statics/v2/css/img/common/logo_v3.png" alt="">
            </a>
            <div class="location"></div>

            <div class="search">
                <div class="search_tab_top">
                    <a class="item selected" href="#search_tab_content_q">商品</a>
                    <i class="search_tab_line">|</i>
                    <a class="item" href="#search_tab_content_shop">档口</a>
                </div>
                <form id="search_tab_content_q" action="/search.html" class="search_tab_content selected" method="get">
                    <div class="search_query_wrap">
                        <div class="tab-wraper">
                            <div class="tab icon-tag">
                                <ul class="triggers">
                                    <li class="trigger selected" data-action="#search_tab_content_q" data-searchtype="item">商品</li>
                                    <li class="trigger last" data-action="#search_tab_content_shop" data-searchtype="shop">档口</li>
                                </ul>
                                <i class="arrow jib"></i>
                            </div>
                        </div>
                        <input id="q" type="text" autocomplete="off" class="search_query" value="${param.q}" name="q" disableautocomplete="disableautocomplete" placeholder="关键词、货号" />
                    </div>

                    <button type="submit" id="btnSearch" class="btn_search">
                        <i class="ico ico_search vvicon">&#xe606;</i>
                        搜索
                    </button>

                    <a class="btn_cart" target="_blank" href="/cart.html">
                        购物车
                        <i class="vvicon">&#xe60f;</i>
                        <span class="num j-cart-amount"></span>
                    </a>
                    <div class="search_keywords">
                        <c:forEach items="${item_suggests}" var="item">
                            <a href="${item.href_url}" vda="link|search_item" class="item">${item.keyword}</a>
                        </c:forEach>
                    </div>
                </form>
                <form id="search_tab_content_shop" action="/shopsearch.html" class="search_tab_content" method="get">

                    <div class="search_query_wrap">

                        <div class="tab-wraper">
                            <div class="tab icon-tag">
                                <ul class="triggers">
                                    <li class="trigger" data-action="#search_tab_content_shop" data-searchtype="shop">档口</li>
                                    <li class="trigger selected last" data-action="#search_tab_content_q" data-searchtype="item">商品</li>
                                </ul>
                                <i class="arrow jib"></i>
                            </div>
                        </div>

                        <input id="searchKey" type="text" autocomplete="off" class="search_query" value="${param.searchKey}" name="searchKey" disableautocomplete="disableautocomplete" placeholder="档口名称、档口号、旺旺号" />

                    </div>
                    <button type="submit" id="btnSearch" class="btn_search">
                        <i class="ico ico_search vvicon">&#xe606;</i>
                        搜索
                    </button>
                    <a class="btn_cart" target="_blank" href="/cart.html">
                        购物车
                        <i class="vvicon">&#xe60f;</i>
                        <span class="num"></span>
                    </a>

                    <div class="search_keywords">
                        <c:forEach items="${shop_suggests}" var="item">
                            <a href="${item.href_url}" vda="link|search_shop" class="item">${item.keyword}</a>
                        </c:forEach>
                    </div>
                </form>
                <div class="more-words" style="display:none" id="gov_search_suggest">
                    <div class="search-img">
                         <c:if test="${search_bar_ad.img_url != '' && search_bar_ad.img_url != null}">
                            <a href="${search_bar_ad.href_url}" class="j-vda ishide" vda="link|searchbar|${search_bar_ad.id}" title="${search_bar_ad.title}" target="_blank">
                                <img src="${search_bar_ad.img_url}" width="160" height="240" />
                            </a>
                        </c:if>
                    </div>
                    <ul> </ul>
                </div>
            </div>

        </div>
    </div>

</div>
