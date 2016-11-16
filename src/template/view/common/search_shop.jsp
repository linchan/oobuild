<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header_shop header_fixed_able">

    <div class="header_inner">
        <div class="w clearfix">

            <a href="/" title="搜款网VVIC" class="logo fl"></a>

            <div class="stall-head fl" style="line-height: 1">
                <div class="stall-head-name"><span href="/shop/${shop.id}">${shop.name}</span></div>
                <div class="stall-head-desc mt10">${shop.remark}</div>
            </div>

            <div class="search">
                <form id="search_tab_content_self" action="/search.html" class="search_tab_content selected" method="get">
                    <div class="search_query_wrap">
                        <div class="tab-wraper">
                            <div class="tab icon-tag">
                                <ul class="triggers">
                                    <li class="trigger selected" data-action="#search_tab_content_self" data-searchtype="self">本档口</li>
                                    <li class="trigger last" data-action="#search_tab_content_full" data-searchtype="item">全站</li>
                                </ul>
                                <i class="arrow jib"></i>
                            </div>
                        </div>
                        <input type="text" autocomplete="off" class="search_query" value="${param.q}" name="q" disableautocomplete="disableautocomplete" placeholder="关键词、货号" />
                    </div>

                    <button type="submit" id="btnSearch" class="btn_search">
                        <i class="ico ico_search vvicon">&#xe606;</i>
                        搜 索
                    </button>

                    <a class="btn_cart" target="_blank" href="/cart.html">
                        购物车
                        <i class="vvicon">&#xe60f;</i>
                        <span class="num j-cart-amount"></span>
                    </a>
                </form>
                <form id="search_tab_content_full" action="/search.html" class="search_tab_content" method="get">

                    <div class="search_query_wrap">

                        <div class="tab-wraper">
                            <div class="tab icon-tag">
                                <ul class="triggers">
                                    <li class="trigger selected" data-action="#search_tab_content_full" data-searchtype="item">全 站</li>
                                    <li class="trigger last" data-action="#search_tab_content_self" data-searchtype="self">本档口</li>
                                </ul>
                                <i class="arrow jib"></i>
                            </div>
                        </div>

                        <input type="text" autocomplete="off" class="search_query" value="${param.searchKey}" name="q" disableautocomplete="disableautocomplete" placeholder="关键词、货号" />

                    </div>
                    <button type="submit" id="btnSearch" class="btn_search">
                        <i class="ico ico_search vvicon">&#xe606;</i>
                        搜 索
                    </button>
                    <a class="btn_cart" target="_blank" href="/cart.html">
                        购物车
                        <i class="vvicon">&#xe60f;</i>
                        <span class="num j-cart-amount"></span>
                    </a>

                </form>
            </div>
        </div>

    </div>

</div>
