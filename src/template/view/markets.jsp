<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="common/header.jsp">
	<jsp:param name="cssName" value="markets3" />
	<jsp:param name="cssHash" value="${cssHash.markets3}" />
 	<jsp:param name="title" value="市场导航 -" />
	<jsp:param name="keywords" value="国大,大西豪,女人街,国投,富丽,VVIC 搜款网"/>
	<jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖国大、大西豪、女人街、国投、富丽、新金马、大时代、宝华、鞋城、圣迦、佰润、西街、新潮都、非凡、柏美等批发市场。"/>
 	<jsp:param name="currentNav" value="2" />
</jsp:include>


<div class="w market clearfix">
	<div class="mk-ban mt10">
		<div class="mk-slide" style="height: 260px;">

			<c:if test="${fn:length(cover_list)>1}">
				<div class="silder-btn next"><i></i></div>
				<div class="silder-btn prev"><i></i></div>
			</c:if>

			<div class="bd" style="visibility: hidden;">
				<ul>
					<c:forEach items="${cover_list}" var="cover" varStatus="stats">

						<li>
							<c:choose>
								<c:when test="${cover.href_url =='' || cover.href_url=='#'}">
									<a class="j-vda<c:if test="${stats.index != 0}"> ishide</c:if>" vda="tp|marketbanner|0|0|0|${stats.count}">
										<img src="${cover.img_url}" alt="${cover.tips_title}"  width="1190" height="260">
									</a>
								</c:when>
								<c:otherwise>
									<a class="j-vda<c:if test="${stats.index != 0}"> ishide</c:if>" href="${cover.href_url}" target="_blank" title="${cover.tips_title}" vda="tp|marketbanner|0|0|0|${stats.count}">
									<img src="${cover.img_url}" alt="${cover.tips_title}" width="1190" height="260">
									</a>
								</c:otherwise>
							</c:choose>
						</li>
					</c:forEach>

				</ul>
			</div>
		</div>
	</div>
	<div class="mk-list">
		<ul>
			<li class="cate"><a href="http://www1.vvic.com/map.html" vda="link|content" target="_blank"><i></i><span>档口地图</span></a></li>
			<li class="item"><a target="_blank" href="/shops/19" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(19).jpg" alt="国大" /></a></li>
			<li class="item"><a target="_blank" href="/shops/12" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(12).jpg" alt="大西豪" /></a></li>
			<li class="item"><a target="_blank" href="/shops/10" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(10).jpg" alt="大时代" /></a></li>
			<li class="item"><a target="_blank" href="/shops/13" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(13).jpg" alt="女人街" /></a></li>
			<li class="item last"><a target="_blank" href="/shops/14" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(14).jpg" alt="国投" /></a></li>
			<li class="item"><a target="_blank" href="/shops/15" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(15).jpg" alt="富丽" /></a></li>
			<li class="item"><a target="_blank" href="/shops/18" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(18).jpg" alt="跨客城" /></a></li>
			<li class="item"><a target="_blank" href="/shops/11" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(11).jpg" alt="宝华" /></a></li>
			<li class="item"><a target="_blank" href="/shops/24" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(24).jpg" alt="鞋城" /></a></li>
			<li class="item"><a target="_blank" href="/shops/37" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(37).jpg" alt="圣迦" /></a></li>
			<li class="item last"><a target="_blank" href="/shops/17" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(17).jpg" alt="柏美" /></a></li>
			<li class="item"><a target="_blank" href="/shops/34" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(34).jpg" alt="三晟" /></a></li>
			<li class="item"><a target="_blank" href="/shops/21" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(21).jpg" alt="西街" /></a></li>
			<li class="item"><a target="_blank" href="/shops/20" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(20).jpg" alt="新潮都" /></a></li>
			<li class="item"><a target="_blank" href="/shops/16" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(16).jpg" alt="非凡" /></a></li>
			<li class="item"><a target="_blank" href="/shops/23" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(23).jpg" alt="佰润" /></a></li>
			<li class="item last"><a target="_blank" href="/shops/25" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(25).jpg" alt="新金马" /></a></li>
			<li class="item"><a target="_blank" href="/shops/42" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(42).jpg" alt="十三行" /></a></li>
			<li class="item"><a target="_blank" href="/shops/39" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(39).jpg" alt="欣欣网批" /></a></li>
			<li class="item"><a target="_blank" href="/shops/35" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(35).jpg" alt="南城" /></a></li>
			<li class="item"><a target="_blank" href="/shops/36" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(36).jpg" alt="金纱" /></a></li>
			<li class="item"><a target="_blank" href="/shops/26" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(26).jpg" alt="老金马" /></a></li>
			<li class="item last"><a target="_blank" href="/shops/28" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(28).jpg" alt="万佳" /></a></li>
			<li class="item"><a target="_blank" href="/shops/41" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(41).jpg" alt="益民" /></a></li>
			<li class="item"><a target="_blank" href="/shops/27" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(27).jpg" alt="新百佳" /></a></li>
			<li class="item"><a target="_blank" href="/shops/29" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(29).jpg" alt="西苑鞋汇" /></a></li>
			<li class="item"><a target="_blank" href="/shops/43" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(43).jpg" alt="景叶" /></a></li>
			<li class="item"><i class="hot"></i><a target="_blank" href="/shops/44" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(44).jpg" alt="狮岭" /></a></li>
			<li class="item last"><a target="_blank" href="/shops/22" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(22).jpg" alt="机筑巷" /></a></li>
			<li class="item empty"></li>
			<li class="item empty"></li>
			<li class="item"><a target="_blank" href="/shops/38" vda="link|content"><img src="${staticDomain}/statics/v2/css/img/market/mk_logo_(38).jpg" alt="周边" /></a></li>
			<li class="item empty"></li>
			<li class="item empty"></li>
			<li class="item empty last"></li>
		</ul>
	</div>
	<div class="clear"></div>

	<div class="hot_shops mt20" style="position: relative;">
	    <div class="title" style="height: 37px;">
	        <div class="mini-page fr page-box"></div>
	        推荐档口
	    </div>
	    <c:set var="goodShopLength" value="${fn:length(good_shops)}"></c:set>
	    <c:forEach items="${good_shops}" var="shop" varStatus="stats">
	    <c:if test='${stats.index % 5==0}'>
	        <div class='data-split <c:if test="${stats.index==0}">showed</c:if>'<c:if test="${stats.index!=0}"> style="display:none"</c:if>>
	        <div class="hot_shops_tabs">
	    </c:if>
	            <c:choose>
	                <c:when test="${stats.index==0 || stats.index % 5 == 0}">
	                    <c:set var="classname" value="selected"/>
	                </c:when>
	                <c:otherwise>
	                    <c:set var="classname" value=""/>
	                </c:otherwise>
	            </c:choose>
	            <div class="item_box">
	                <a href="#hot_shops_list_${stats.index}" class="item ${classname} tab_item tab_item_${stats.count}">
	                    ${shop.shop_name}
	                    <span class="tab_item_bg"></span>
	                </a>
	            </div>
	            <div id="hot_shops_list_${stats.index}" class="hot_shops_list ${classname} ">
	                <c:forEach items="${shop.items}" var="item" varStatus="itemStats">
	                    <c:choose>
	                        <c:when test="${item.type==1}">
	                            <a target="_blank" href="/shop/${item.shop_id}"
	                               vda="tp|recommendshop|0|${item.shop_id}|0|${itemStats.count}" class="item item_shop j-vda" id="${item.id}" shop-id="${item.shop_id}">
	                                <img src="${item.img_url}|260w_390h" alt="">
	                                <div class="info">
	                                    <div class="info_bg"></div>
	                                    <div class="desc">${fn:substring(item.shop_remark, 0, 12)}</div>
	                                    <div class="pos">${item.marketName} ${item.position}</div>
	                                    <div class="link" title="${item.tips_title}">
	                                        <div class="link_bg"></div>
	                                        进入档口
	                                    </div>
	                                </div>
	                            </a>
	                        </c:when>
	                        <c:otherwise>
	                            <a href="${item.href_url}" class="item j-vda"
	                               vda="tp|recommendshop|${item.item_id}|${item.shop_id}|0|${itemStats.count}"
	                                id="${item.id}" shop-id="${item.shop_id}" target="_blank">
	                                <img src="${item.img_url}|260w_390h" alt="">
	                                <span class="info">
	                                    <span class="info_bg"></span>
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
	                                </span>
	                            </a>
	                        </c:otherwise>
	                    </c:choose>

	                </c:forEach>
	            </div>
	    <c:if test='${stats.index % 5==4 || stats.count == goodShopLength}'>
	        </div></div>
	    </c:if>
	    </c:forEach>
	</div>
</div>


<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>
<script>
	var FIXEDAMOUNT = parseInt('${fixed_amount}');
	require(['markets3/markets3'], function(){});
</script>
<%@ include file="common/third.jsp"%>
</body>
</html>
