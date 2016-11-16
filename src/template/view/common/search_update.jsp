<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header_shop ${param.fixdHeaderClassName}">

    <div class="header_inner">
        <div class="w clearfix ">

            <a href="/" title="搜款网VVIC" class="logo fl"></a>

            <div class="stall-head fl">
                <div class="update-head-name">上传成功</div>
            </div>
            <div class="search_tab_top">
                <a class="item selected" href="#search_tab_content_q">商品</a>
                <i class="search_tab_line">|</i>
                <a class="item" href="#search_tab_content_shop">档口</a>
            </div>

            <form id="search_tab_content_q" class="search fl search_tab_content" action="/search.html" style="display: block;">

                <div class="search_query_wrap">
                    <div class="tab-wraper">
                        <div class="tab icon-tag">
                            <ul class="triggers">
                                <li class="trigger selected" data-action="#search_tab_content_q"
                                    data-searchtype="item">商品
                                </li>
                                <li class="trigger last" data-action="#search_tab_content_shop" data-searchtype="shop">
                                    档口
                                </li>
                            </ul>
                            <i class="arrow jib"></i>
                        </div>
                    </div>
                    <input type="text" autocomplete="off" class="search_query" value="${param.q}" name="q"
                           disableautocomplete="disableautocomplete" placeholder="关键词、货号"/>

                </div>
                <input type="submit" value="搜索" class="btn_search" autocomplete="off"
                       disableautocomplete="disableautocomplete"/>

            </form>
            <form id="search_tab_content_shop" class="search fl search_tab_content" action="/shopsearch.html">

                <div class="search_query_wrap">
                    <div class="tab-wraper">
                        <div class="tab icon-tag">
                            <ul class="triggers">
                                <li class="trigger " data-action="#search_tab_content_shop"
                                    data-searchtype="shop">
                                    档口
                                </li>
                                <li class="trigger selected last" data-action="#search_tab_content_q" data-searchtype="item">
                                    商品
                                </li>
                            </ul>
                            <i class="arrow jib"></i>
                        </div>
                    </div>
                    <input type="text" autocomplete="off" class="search_query" value="${param.q}" name="q"
                           disableautocomplete="disableautocomplete" placeholder="档口名称、档口号、旺旺号"/>

                </div>
                <input type="submit" value="搜索" class="btn_search" autocomplete="off"
                       disableautocomplete="disableautocomplete"/>

            </form>
        </div>
    </div>

</div>
