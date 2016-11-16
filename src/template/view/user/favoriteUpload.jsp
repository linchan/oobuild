<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="user3"/>
    <jsp:param name="cssHash" value="${cssHash.user3}"/>
    <jsp:param name="title" value="个人中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>

<div class="w user-w">
    <div class="user-left">
        <jsp:include page="usernav.jsp">
            <jsp:param name="bigClass" value="8"/>
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="fav-main">

                <div class="main-bar clearfix " style="overflow: hidden;">

                    <div class="fl">上传历史</div>
                    <div class="fr">
                        <ul class='mctrl <c:if test="${param.m==1}">selected</c:if>'>
                            <li class='btn j-batch <c:if test="${param.m==1}">selected</c:if>'>
                                <span class="cancel">取消管理</span>
                                <span class="m">批量管理</span>
                            </li>
                            <li class="data j-create-data">
                                <i class="vvicon">&#xe60c;</i>
                                <span>生成数据包</span>
                            </li>
                            <li class="del j-cancel-history">
                                <i class="vvicon">&#xe625;</i>
                                <span>删除历史</span>
                            </li>

                            <li class="selectall j-selectall">
                                <i class="vvicon uncheck">&#xe628;</i>
                                <i class="vvicon ischeck">&#xe627;</i>
                                <span>全选</span>
                            </li>
                        </ul>
                    </div>
                </div>


                <div class="clear"></div>

                <!-- tag -->
                <div class="vv-tag mt10">
                    <ul>
                        <li<c:if test="${param.type eq null}"> class='curr'</c:if>><a href="/user/favoriteUpload.html">上架商品</a></li>
                        <li<c:if test="${param.type eq 'down'}"> class='curr'</c:if>><a href="/user/favoriteUpload.html?type=down">下架商品</a></li>
                    </ul>
                    <c:if test="${param.type == null}">
                    <div class="order-search fr">
                        <a id="searchOrder">搜索</a>
                        <input type="text" value="${param.q}" id="Q" placeholder="货号" />
                    </div>
                    </c:if>
                    <div class="fav-count-info fr">
                        共 <em>${page.recordCount}</em> 个商品
                    </div>
                </div>


                <div class="screen mt10">

                    <div class="screen-content">
                        <c:forEach items="${item_cat_list}" var="el" varStatus="status">
                        <c:set var="catLength" value="${fn:length(item_cat_list)}"></c:set>
                        <div class="nav-category clearfix show-more <c:if test='${catLength==status.count}'>last</c:if>">
                            <div class="nc-key">${el.parentName}：</div>

                            <div class="nc-value clearfix" style="width: auto;">
                                <div class="types" style="width:870px;">
                                    <c:forEach items="${el.categoryList}" var="type">
                                    <c:choose>
                                        <c:when test="${param.type == 'down'}">
                                            <a class="<c:if test='${param.tcid==type.tcid}'>selected</c:if>" href="/user/favorite.html?tcid=${type.tcid}&type=down" vda="link|fliter">${type.name}(${type.amount})</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="<c:if test='${param.tcid==type.tcid}'>selected</c:if>" href="/user/favorite.html?tcid=${type.tcid}" vda="link|fliter">${type.name}(${type.amount})</a>
                                        </c:otherwise>
                                    </c:choose>
                                    </c:forEach>
                                </div>

                            </div>
                        </div>
                        </c:forEach>
                    </div>

                </div>

                <div class='goods-list small-list mt20 clearfix <c:if test="${param.m==1}">selected</c:if>' style="width:990px">
                    <ul class="clearfix goods-content">
                        <c:forEach items="${page.recordList}" var="item" varStatus="status">
                        <li>
                            <div class="mask j-mask <c:if test='${item.status==1}'>unSoldOut</c:if>" data-id="${item.id}">
                                <i class="vvicon check">&#xe624;</i>
                                <i class="vvicon checkbg">&#xe626;</i>
                            </div>


                            <div class="item item_status_${item.status}">

                                <div class="pic">
                                    <div class="cancelFav j-item-cancel" data-id="${item.id}">
                                        <i class="vvicon">&#xe625;</i>
                                        <div class="cancel-bg"></div>
                                    </div>

                                    <a target="_blank" class="j-vda" vda="tp|itemcard|${item.id}|0|0|${status.count}" href="/item/${item.id}">
                                        <img src="${item.index_img_url}_190x190.jpg"/>
                                    </a>
                                    <c:choose>
                                        <c:when test="${item.status==1}">
                                            <c:choose>
                                                <c:when test="${item.is_pre_sell==1 || item.art_no=='' || item.support_cart != 1}">
                                                    <div class="ctrl one clearfix">
                                                        <a href="javascript:;" class="j-fav" data-id="${item.id}" vda="sc|itemcard|${item.id}|0|0|${status.count}"><span>收藏</span>
                                                        </a>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="ctrl clearfix">
                                                        <div class="line"></div>
                                                        <span class="j-addcart" vda="gwc|itemcard|${item.id}|0|0|${status.count}" data-id="${item.id}">加入购物车</span>

                                                        <span class="j-fav" data-id="${item.id}" vda="sc|itemcard|${item.id}|0|0|${status.count}">收藏
                                                        </span>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="ctrl clearfix">
                                                <a target="_blank" href="/samestyle/${item.id}" vda="ztk|itemcard|${item.id}|0|0|${status.count}">
                                                    <span>找同款</span>
                                                </a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="desc">
                                    <div class="info clearfix">
                                        <span class="fr up_time">
                                            <fmt:formatDate  value="${item.ctime}" pattern="M月dd日"/> 上传
                                        </span>
                                        <c:choose>
                                            <c:when test="${item.status==1}">
                                                <div class="price">
                                                    <span class="yuan">¥</span>${item.discount_price}
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="status0">已下架</div>
                                            </c:otherwise>
                                        </c:choose>
                                        <!--<i class="fl ico_item_active_0 ico_item_active"></i></div>-->
                                        <div class="title">
                                            <a target="_blank" href="/item/${item.id}" vda="spbt|itemcard|${item.id}|0|0|${status.count}">
                                                ${item.title}
                                            </a>
                                        </div>
                                        <div class="clearfix shop-name-box">
                                            <div class="fr num j_clip_button">
                                                <c:if test="${item.art_no!=''}">${item.art_no}#</c:if>
                                                <c:if test="${item.art_no==''}">无货号</c:if>
                                            </div>
                                            <a target="_blank" class="shop-name" href="/shop/${item.shop_id}"
                                               title="${item.marketName} ${item.position}" vda="dkmc|itemcard|0|${item.shop_id}|0|${status.count}">
                                                <span class="inner">${item.marketName} ${item.position}</span>
                                            </a>
                                        </div>

                                    </div>
                                    <div class="foot clearfix">
                                        <div class="fl pos tb">
                                            <a target="_blank" class="vam" href="/shop/${item.shop_id}"
                                               title="${item.shop_name}" vda="dkmc|itemcard|0|${item.shop_id}|0|${status.count}">${item.shop_name}
                                            </a>
                                            <a target="_blank" title="${item.shop_name}"
                                               href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid=${item.ww_nickname}" vda="ww|itemcard|0|0|0|${status.count}">
                                                <img class="lazy" style="display: inline;"
                                                     data-original="http://www.vvic.com/api/online?nickname=${item.ww_nickname}">
                                            </a>

                                            <div class="triangle triangle-up1"></div>
                                            <div class="triangle triangle-up2"></div>
                                        </div>
                                        <div class="service-icon fr">
                                            <c:if test="${item.is_pre_sell==1}"><div class="s-item ys"><i></i></div></c:if>
                                            <c:if test="${item.is_sp==1}"><div class="s-item sp j-v-tip" data-tip="sp"><i></i></div></c:if>
                                            <c:if test="${item.is_tx==1}"><div class="s-item tx j-v-tip" data-tip="tx"><i></i></div></c:if>
                                            <c:if test="${item.is_df==1}"><div class="s-item df j-v-tip" data-tip="df"><i></i></div></c:if>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <c:if test="${page.recordCount==0}">
                        <div class="empty-tip"><i class="vvicon">&#xe614;</i>
                            <div class="text">没有任何上传历史记录。</div>
                        </div>
                    </c:if>
                </div>

                <div class="clear"></div>

                <div class="pagination j-pagination" style="padding-bottom: 0;"></div>
            </div>

        </div>
    </div>
    <div class="clear"></div>
</div>
<jsp:include page="../common/addcart.jsp"/>
<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    var _M = "${param.m}",
        _TYPE = "${param.type}",
        _TCID = "${param.tcid}",
        _RECORDCOUNT = "${page.recordCount}",
        _CURRENTPAGE = parseInt("${page.currentPage}") || 1,
        _PAGESIZE = "${page.pageSize}";
    var _SKUMAP,_ITEMID,_TID,_DISCOUNTPRICE,_SOLDOUT,_SIZEID,_COLOR,_SIZE,_SUPPORT;
    require(['user3/history3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/></body></html>
