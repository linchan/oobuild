<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="user-menu">
	<c:choose>
		<c:when test="${param.msg == 1}">
			<dl <c:if test="${param.msgType==0}">class='curr'</c:if>>
				<dt><a href="/user/message.html" vda="link|homeleftbar|7"><span>所有消息</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl <c:if test="${param.msgType==5}">class='curr'</c:if>>
				<dt><a href="/user/message.html?t=5" vda="link|homeleftbar|75"><span>订单通知</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl <c:if test="${param.msgType==4}">class='curr'</c:if>>
				<dt><a href="/user/message.html?t=4" vda="link|homeleftbar|74"><span>上下架通知</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<c:if test="${cookie.ut.value == '1'}">
			<dl <c:if test="${param.msgType==3}">class='curr'</c:if>>
				<dt><a href="/user/message.html?t=3" vda="link|homeleftbar|73"><span>备货提醒</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl <c:if test="${param.msgType==2}">class='curr'</c:if>>
				<dt><a href="/user/message.html?t=2" vda="link|homeleftbar|72"><span>档口通知</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			</c:if>
			<dl <c:if test="${param.msgType==1}">class='curr'</c:if>>
				<dt><a href="/user/message.html?t=1" vda="link|homeleftbar|71"><span>系统消息</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
		</c:when>


		<c:when test="${param.msg == 2}">
		<!--新增加账户设置banner-->
			<dl <c:if test="${param.bigClass==1}">class='curr'</c:if>>
				<dt><a href="/user/account/setting.html"><span>安全设置</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl <c:if test="${param.bigClass==2}">class='curr'</c:if>>
				<dt><a href="/user/account/profile.html"><span>个人资料</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl <c:if test="${param.bigClass==3}">class='curr'</c:if>>
				<dt><a href="/user/account/address.html"><span>地址管理</span></a><i class="vvicon">&#xe60f;</i></dt>
				<dd>
					<a href="/user/account/address.html" <c:if test="${param.smallClass==1}">class='curr'</c:if>><span>收货信息</span></a>
					<!-- <a href="/user/account/addressSend.html" <c:if test="${param.smallClass==2}">class='curr'</c:if>><span>发货信息</span></a> -->
				</dd>
			</dl>
			<c:if test="${1==0}">
			<dl <c:if test="${param.bigClass==4}">class='curr'</c:if>>
				<dt><a href="/user/account/cash.html"><span>提现设置</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl <c:if test="${param.bigClass==5}">class='curr'</c:if>>
				<dt><a href="/user/account/authorize.html"><span>第三方授权</span></a><i class="vvicon">&#xe60f;</i></dt>
				<dd>
					<a href="/user/account/buyer.html" <c:if test="${param.smallClass==1}">class='curr'</c:if>><span>买手</span></a>
					<a href="/user/account/shop.html" <c:if test="${param.smallClass==2}">class='curr'</c:if>><span>档口</span></a>
				</dd>
			</dl>
			</c:if>
		</c:when>


		<c:otherwise>
			<dl <c:if test="${param.bigClass==1}">class='curr'</c:if>>
				<dt><a href="/user/home.html" vda="link|homeleftbar|1"><span>我的个人中心</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl class="access-btn <c:if test="${param.bigClass==2}">curr</c:if>">
				<dt><a href="/user/orders.html" vda="link|homeleftbar|2"><span>我的订单</span></span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl class="access-btn <c:if test="${param.bigClass==9}">curr</c:if>" >
				<dt><a href="/user/return.html" vda="link|homeleftbar|9"><span>退货记录</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl class="access-btn <c:if test="${param.bigClass==7}">curr</c:if>" >
				<dt><a href="/user/bill.html" vda="link|homeleftbar|7"><span>交易记录</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl class='big <c:if test="${param.bigClass==3}">curr</c:if>'>
				<dt><a href="/user/favorite.html" vda="link|homeleftbar|3"><span>收藏夹</span></a><i class="vvicon">&#xe60f;</i></dt>
				<dd>
					<a href="/user/favorite.html" vda="link|homeleftbar|31" <c:if test="${param.smallClass==1}">class='curr'</c:if>><span>收藏商品</span></a>
					<a href="/user/follow.html" vda="link|homeleftbar|32" <c:if test="${param.smallClass==2}">class='curr'</c:if>><span>关注档口</span></a>
				</dd>
			</dl>
			<dl <c:if test="${param.bigClass==6}">class='curr'</c:if>>
				<dt><a href="/user/purchase.html" vda="link|homeleftbar|6"><span>拿货单</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl <c:if test="${param.bigClass==8}">class='curr'</c:if>>
				<dt><a href="/user/favoriteUpload.html" vda="link|homeleftbar|8"><span>上传历史</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
			<dl <c:if test="${param.bigClass==4}">class='curr'</c:if>>
				<dt><a href="/user/packet.html" vda="link|homeleftbar|4"><span>数据包</span></a><i class="vvicon">&#xe60f;</i></dt>
			</dl>
		</c:otherwise>
	</c:choose>
</div>
