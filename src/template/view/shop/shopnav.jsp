<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="user-menu">
	<dl <c:if test="${param.bigClass==1}">class='curr'</c:if>>
		<dt><a href="/shop/stocking.html" vda="link|shopleftbar|1"><span>备货提醒</span></a><i class="vvicon">&#xe60f;</i></dt>
	</dl>
	<dl <c:if test="${param.bigClass==2}">class='curr'</c:if>>
		<dt><a href="/shop/orders.html" vda="link|shopleftbar|2"><span>档口订单</span></span></a><i class="vvicon">&#xe60f;</i></dt>
	</dl>
	<dl <c:if test="${param.bigClass==3}">class='curr'</c:if>>
		<dt><a href="/shop/data.html" vda="link|shopleftbar|3"><span>档口数据</span></a><i class="vvicon">&#xe60f;</i></dt>
	</dl>
	<dl <c:if test="${param.bigClass==4}">class='curr'</c:if>>
		<dt><a href="/shop/goods.html" vda="link|shopleftbar|4"><span>商品信息</span></a><i class="vvicon">&#xe60f;</i></dt>
	</dl>
	<dl <c:if test="${param.bigClass==5}">class='curr'</c:if>>
		<dt><a href="/shop/setting.html" vda="link|shopleftbar|5"><span>档口设置</span></a><i class="vvicon">&#xe60f;</i></dt>
	</dl>
</div>
