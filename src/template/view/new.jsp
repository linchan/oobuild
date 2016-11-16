<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="common/header.jsp">
    <jsp:param name="cssName" value="newstyle3" />
    <jsp:param name="cssHash" value="${cssHash.newstyle3}" />
    <jsp:param name="title" value="每日新款 -" />
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网" />
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。" />
    <jsp:param name="currentNav" value="3" />
</jsp:include>

<link href="${staticDomain}/statics/lib/datepick/dp.css" rel="stylesheet" type="text/css" />
<div style="height: 10px;"></div>
<div id="fix-box">
    <div class="w">
        <div class="new-header">
            <ul class="conditions">
                <li class="c-item">
                    <div class="trigger"> <i></i>
                        <span>
                            <c:choose>
                                <c:when test="${params.pid == '' && params.tcid == ''}">
                                    分类
                                </c:when>
                                <c:when test="${params.pid != '' && params.tcid == ''}">
                                    ${params.pname}
                                </c:when>
                                <c:otherwise>
                                    ${params.tcname}
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="line"></div>
                    <div class="overlay">
                        <div class="o-item">
                            <a href="/new/${page.date}?bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}&currentPage=${page.currentPage}" class="all" vda="link|fliter">全部</a>
                            <div class="lady-cate fl">
                                <a vda="link|fliter" href="/new/${page.date}?pid=1&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}" class="big <c:if test="${params.pid eq 1}"> selected</c:if>">女装</a>
                                <div class="sub-list">
                                    <c:forEach items="${female_cat_list}" var="cate">
                                        <a vda="link|fliter" href="/new/${page.date}?pid=1&tcid=${cate.dict_key}&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}"<c:if test="${cate.dict_key eq params.tcid}"> class="selected"</c:if>>${cate.dict_value}</a>
                                    </c:forEach>
                                    <a vda="link|fliter" href="/new/${page.date}?pid=1&tcid=999999&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}"<c:if test="${params.ofe eq 1}"> class="selected"</c:if>>其他女装</a>
                                </div>
                            </div>
                            <div class="other-cate fr">
                                <a vda="link|fliter" href="/new/${page.date}?pid=2&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}" class="big<c:if test="${params.pid eq 2}"> selected</c:if>">男装</a>
                                <a vda="link|fliter" href="/new/${page.date}?pid=3&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}" class="big<c:if test="${params.pid eq 3}"> selected</c:if>">鞋</a>
                                <a vda="link|fliter" href="/new/${page.date}?pid=4&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}" class="big<c:if test="${params.pid eq 4}"> selected</c:if>">内衣</a>
                                <a vda="link|fliter" href="/new/${page.date}?pid=5&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}" class="big<c:if test="${params.pid eq 5}"> selected</c:if>">母婴用品</a>
                                <a vda="link|fliter" href="/new/${page.date}?pid=6&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}" class="big<c:if test="${params.pid eq 6}"> selected</c:if>">配件箱包</a>
                                <a vda="link|fliter" href="/new/${page.date}?pid=7&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}" class="big<c:if test="${params.pid eq 7}"> selected</c:if>">户外运动</a>
                                <a vda="link|fliter" href="/new/${page.date}?pid=8&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}" class="big<c:if test="${params.pid eq 8}"> selected</c:if>">美妆饰品</a>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </li>
                <li class="c-item">
                    <div class="trigger"> <i></i><span><c:choose>
                                <c:when test="${params.market_name == ''}">
                                    全部市场
                                </c:when>
                                <c:otherwise>
                                    ${params.market_name}
                                </c:otherwise>
                            </c:choose></span></div>
                    <div class="line"></div>
                    <div class="overlay">
                        <div class="o-item">
                            <a vda="link|fliter" href="/new/${page.date}?pid=${params.pid}&tcid=${params.tcid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}" class="all">全部市场</a>
                            <div id="marketList">
                                <c:forEach items="${marketList}" var="market">
                                    <a vda="link|fliter" href="/new/${page.date}?pid=${params.pid}&tcid=${params.tcid}&bid=${market.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}" class="big <c:if test="${market.bid == params.bid}"> selected</c:if>">${market.name}</a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </li>
                <c:if test="${fn:length(styles) > 0}">
                <li class="c-item">
                    <div class="trigger"> <i></i><span>风格</span><c:if test="${params.style != ''}"><span class="value" title="风格: ${params.style}">: ${params.style}</span></c:if></div>
                    <div class="line"></div>
                    <div class="overlay">
                        <div class="o-item o-item-btns styles">
                            <ul class="checks">
                                <c:forEach items="${styles}" var="style">
                                    <c:set var="className" value=""></c:set>
                                    <c:forEach items="${params.style}" var="currStyle" >
                                        <c:if test="${style == currStyle}">
                                            <c:set var="className" value="selected"></c:set>
                                        </c:if>
                                    </c:forEach>
                                <li class="${className}">
                                    <i class="vvicon">&#xe608;</i>
                                    <span>${style}</span>
                                </li>
                                </c:forEach>
                            </ul>
                            <div class="btns">
                                <div class="btn cancel-style">取消选择</div>
                                <div class="btn btn-fill btn-style">确定</div>
                            </div>
                        </div>
                    </div>
                </li>
                </c:if>
                <li class="c-item">
                    <div class="trigger"> <i></i><span>服务</span><c:if test="${params.service != ''}"><span class="value" title="服务: ${params.service}">: ${params.service}</span></c:if></div>
                    <div class="line"></div>
                    <div class="overlay">
                        <div class="o-item o-item-btns service">
                            <ul class="checks">
                                <li data-name="is_tx" class="is_tx<c:if test="${params.is_tx == '1'}"> selected</c:if>">
                                    <i class=" vvicon">&#xe608;</i>
                                    <span>退现</span>
                                </li>
                                <li data-name="is_sp" class="is_sp<c:if test="${params.is_sp == '1'}"> selected</c:if>">
                                    <i class=" vvicon">&#xe608;</i>
                                    <span>实拍</span>
                                </li>
                                <li data-name="cloud_update" class="is_mgx<c:if test="${params.cloud_update == '1'}"> selected</c:if>">
                                    <i class=" vvicon">&#xe608;</i>
                                    <span>秒更新</span>
                                </li>
                                <li data-name="is_df" class="is_df<c:if test="${params.is_df == '1'}"> selected</c:if>">
                                    <i class=" vvicon">&#xe608;</i>
                                    <span>一件代发</span>
                                </li>
                            </ul>
                            <div class="btns">
                                <div class="btn cancel-service">取消选择</div>
                                <div class="btn btn-fill btn-service">确定</div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="c-item date picker" id="datetime" data-cdata="${page.date}">
                    <div class="trigger"> <i></i><span><c:choose>
                                <c:when test="${params.is_today == '1'}">
                                    今天
                                </c:when>
                                <c:otherwise>
                                    ${page.date}
                                </c:otherwise>
                            </c:choose></span></div>
                </li>
            </ul>
            <!-- <div class="new-count fr">
                共 ${page.recordCount} 件相关商品
            </div> -->
            <div class="new-order fr">
                <a vda="link|fliter" href="/new/${page.date}?pid=${params.pid}&tcid=${params.tcid}&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}&order_type=2" class='order-t<c:if test="${params.order_type == 2}"> order-curr</c:if>'>时间排序</a>
                <a vda="link|fliter" href="/new/${page.date}?pid=${params.pid}&tcid=${params.tcid}&bid=${params.bid}&style=${params.style}&is_tx=${params.is_tx}&is_sp=${params.is_sp}&is_df=${params.is_df}&cloud_update=${params.cloud_update}&order_type=1" class='order-q<c:if test="${params.order_type == 1}"> order-curr</c:if>'>质量排序</a>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>

<div class="w">
    <div id="container" class="goods-list new-list clearfix">
        <div id="pageLoadResult" style="display: hidden;"></div>
        <div id="pageResult">
            <ul class="clearfix">
                <c:forEach items="${page.recordList}" var="item" varStatus="status">
                    <li>
                        <c:if test="${item.focus == 1}">
                            <i class="isFocus"></i>
                        </c:if>
                        <div class="item">
                            <div class="pic">
                                <a target="_blank" href="/item/${item.id}" class="j-vda" vda="tp|itemcard|${item.id}|0|0|${status.count}" title="${item.title}"> <img alt="" class="lazy" data-original="${item.index_img_url}_230x230.jpg"> </a>
                                <div class="ctrl clearfix">
                                    <span class="upload" data-id="${item.tid}" data-price="${item.
                                    discount_price}" data-vid="${item.id}" vda="yjsc|itemcard|${item.id}|0|0|${status.count}">一键上传</span>
                                    <span class="addFav" data-id="${item.id}" vda="sc|itemcard|${item.id}|0|0|${status.count}">收藏</span>
                                    <a target="_blank" href="/samestyle/${item.id}" vda="ztk|itemcard|${item.id}|0|0|${status.count}"> <span>找同款</span> </a>
                                </div>
                            </div>
                            <div class="desc">
                                <div class="info clearfix">
                                    <div class="fl price"> <span class="yuan">¥</span>${item.discount_price}</div>
                                    <i class="fl ico_item_active_${item.is_active} ico_item_active"></i>

                                    <c:if test="${params.order_type == '2'}">
                                    <div class="fr">
                                    <fmt:formatDate pattern="HH:mm" var="formatDates" value="${item.up_time}" />
                                        <c:out value="${formatDates}" /> 上新
                                    </div>
                                    </c:if>
                                </div>
                                <div class="foot clearfix">
                                    <div class="pos fl tb">
                                        <span class="vam"><a target="_blank" title="" vda="dkmc|itemcard|0|${item.shop_id}|0|${status.count}" href="/shop/${item.shop_id}">${item.shop_name}</a></span>
                                        <a target="_blank" vda="ww|itemcard|0|0|0|${status.count}" style="display:inline" title="" href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid=${item.ww_nickname}"><img class="vam lazy" data-original="/api/online?nickname=${item.ww_nickname}" /></a>
                                        <div class="more-info">
                                            <div class="shop-pos">${item.marketName} ${item.floor}楼 ${item.position}</div>
                                            <c:if test="${item.authenticated == 1 || item.cloud_update == 1 || item.years > 1 || item.is_gold_shop == 1}">
                                                <div class="shop-icon fl">
                                                    <c:if test="${item.authenticated == 1}">
                                                        <i class="cert j-v-tip" data-tip="cert"></i>
                                                    </c:if>
                                                    <c:if test="${item.cloud_update == 1}">
                                                        <i class="miao j-v-tip" data-tip="miao"></i>
                                                    </c:if>
                                                    <c:if test="${item.top > 0}">
                                                        <i class="top${item.top} j-v-tip" data-top="${item.top}"
                                                           data-tip="top"></i>
                                                    </c:if>
                                                    <c:if test="${item.years > 1}">
                                                        <i class="shop-year-icon year${item.years} j-v-tip"
                                                             data-date='${item.start_business_date}' data-tip="year"></i>
                                                    </c:if>
                                                    <div class="clear"></div>
                                                </div>
                                                <c:if test="${item.is_gold_shop == 1}">
                                                <div class="shop-gold fr">
                                                    <img src="${staticDomain}/statics/v2/css/img/common/gold.png" width="19">
                                                </div>
                                                </c:if>
                                            </c:if>
                                            <div class="clear"></div>
                                        </div>
                                        <div class="triangle triangle-up1"></div>
                                        <div class="triangle triangle-up2"></div>
                                    </div>
                                    <div class="art-no j_clip_button">
                                        ${item.art_no}<c:if test="${item.art_no!=''}">#</c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <c:if test="${page.recordCount eq 0}">
            <div class="empty-tip">
                <span class="vvicon">&#xe614;</span>
                <div class="text">
                    <c:choose>
                        <c:when test="${page.recordCount eq 0 && params.pid == '' && params.tcid == '' && params.bid == '' && params.style == '' &&  params.cloud_update == '' && params.service == ''}">
                            <div>当天没有上新商品</div>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${params.pid != '' || params.tcid != '' || params.bid != '' || params.style != '' || params.clound_update == 1 || params.service != ''}">
                                <div>筛选条件太多啦，没有找到相关商品</div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>
        <div id="Pagination" class="pagination"><!-- 这里显示分页 --></div>
    </div>

    <c:set var="hotItemLength" value="${fn:length(hot_items)}"></c:set>
    <c:if test="${hotItemLength>0}">
    <div class="hot_goods imgs_slide" style="padding-bottom: 0">
        <div class="title">
            <div class="mini-page fr page-box"></div>
            人气商品
        </div>
        <div class="hot_goods_list " style="height:385px;">
            <c:forEach items="${hot_items}" var="item" varStatus="state">
                <c:if test='${state.index % 5==0}'>
                    <div class='data-split <c:if test="${state.index==0}">showed</c:if>'<c:if test="${state.index!=0}"> style="display:none"</c:if>>
                </c:if>

                <div class="item" id="${item.id}" shop-id="${item.shop_id}">
                    <div href="${item.href_url}" class="img_box">
                        <span class="bd">
                            <c:forEach items="${item.img_url}" var="img_url" varStatus="states">
                                <c:if test="${states.index==0}">
                                    <c:set var="firsrclass" value="first"/>
                                </c:if>
                                <c:if test="${states.index!=0}">
                                    <c:set var="firsrclass" value=""/>
                                </c:if>
                                <a href="${item.href_url}" class="li ${firsrclass} j-vda" vda="tp|hotcard|${item.item_id}|0|0|${state.count}" target="_blank">
                                    <img src="${img_url}" class="img" alt="" />
                                </a>
                            </c:forEach>
                        </span>
                    </div>
                    <p class="info">
                        <c:choose>
                            <c:when test="${item.price_type eq 1}">
                                <span class="price"><span class="yuan">¥</span> ${item.discount_price}</span>
                            </c:when>
                            <c:when test="${item.price_type eq 2}">
                                <span class="price"><span class="yuan">¥</span> ${item.discount_price}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="price_error">价格错误</span>
                            </c:otherwise>
                        </c:choose>

                        <a href="/shop/${item.shop_id}" vda="dkmc|hotcard|0|${item.shop_id}|0|${state.count}" target="_blank" class="name j-vda" title="${item.shop_name}">
                            <c:if test="${item.is_gold_shop == 1}">
                                <img src="${staticDomain}/statics/v2/css/img/common/gold.png" aglin="absmiddle" width="19">
                            </c:if>
                            ${item.shop_name}
                        </a>
                    </p>
                </div>
                <c:if test='${state.index % 5==4 || state.count == hotItemLength}'>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
    </c:if>
</div>

<jsp:include page="common/footer.jsp" />
<jsp:include page="common/footjs.jsp" />
<script>
    var DATE = '${page.date}',
        PID = '${params.pid}',
        TCID = '${params.tcid}',
        BID = '${params.bid}',
        PAGECOUNT = '${page.pageCount}',
        PAGESIZE = '${page.pageSize}',
        RECORDCOUNT = '${page.recordCount}',
        CURRENTPAGE = '${page.currentPage}',
        ORDERTYPE = '${params.order_type}';
    require(['web3/new3'], function(){

    });
</script>
<jsp:include page="common/third.jsp" />
</body>
</html>
