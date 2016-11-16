<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 顶部工具栏 -->
<div class="top_bar">
    <div class="top_bar_inner ">
        <div class="fl">
            <a href="/login.html" vda="link|topbar" class="item unlog" title="登录" style="display:none;">登录</a>
            <a href="/reg.html" target="_blank" vda="link|topbar" class="item unlog" title="免费注册" style="display:none;">免费注册</a>
            <div class="item islog" style="display:none;">
                <a href="/user/account/setting.html" vda="link|topbar" class="top">
                    您好，
                    <span id="username"></span>
                    <i class="jib"></i>
                </a>
                <div class="menu">
                    <a href="/user/account/setting.html" vda="link|topbar" class="menu-item" title="账户设置">账户设置</a>
                    <a href="javascript:;" class="menu-item doLogout" title="退出">退出</a>
                </div>
            </div>
            <a href="/user/message.html" vda="link|topbar" target="_blank" class="item islog" title="消息" style="display:none;">消息
                <span class="red messageUnRead"></span>
            </a>
        </div>


       <!--  <c:if test="${param.headerName=='item'||param.headerName=='shop'||param.headerName=='active'||param.headerName=='user'}">
            <div class="fl">
                <a href="/" class="item" title="搜款网首页">搜款网首页</a>
                <a href="/markets.html" class="item" title="市场导航">市场导航</a>
                <a href="/new.html" class="item" title="每日新款">每日新款</a>
            </div>
        </c:if> -->

        <div class="fr">
            <c:if test="${param.hideNav==1}">
            <a href="/" class="item">搜款网首页</a>
            </c:if>

            <div class="item">
                <a href="/user/home.html" vda="link|topbar" class="top">
                    个人中心
                    <i class="jib"></i>
                </a>
                <div class="menu">
                    <!-- <a href="/user/favorite.html" vda="link|topbar" class="menu-item">上传历史</a> -->
                    <a href="/user/packet.html" vda="link|topbar" class="menu-item">数据包</a>
                    <a href="/user/purchase.html" vda="link|topbar" class="menu-item">拿货单</a>
                </div>
            </div>

            <a href="/user/orders.html" vda="link|topbar" target="_blank" class="item islog">我的订单
                <span class="red orderUnRead"></span>
            </a>

            <div class="item">
                <a href="/user/favorite.html" vda="link|topbar" class="top" title="收藏夹">
                    收藏夹
                    <i class="jib"></i>
                </a>
                <div class="menu">
                    <a href="/user/favorite.html" vda="link|topbar" class="menu-item" title="收藏商品">收藏商品</a>
                    <a href="/user/follow.html" vda="link|topbar" class="menu-item" title="关注档口">关注档口</a>
                </div>
            </div>


            <div class="item">
                <a href="/shop/stocking.html" class="top">
                    我是档口
                    <i class="jib"></i>
                </a>
                <div class="menu">
                    <a href="/shop/stocking.html" vda="link|topbar" class="menu-item" title="备货提醒">备货提醒</a>
                    <a href="/shop/data.html" vda="link|topbar" class="menu-item" title="档口数据">档口数据</a>
                    <!-- <a href="/shop/data.html" vda="link|topbar" class="menu-item" title="拿货记录">拿货记录</a> -->
                    <a href="/shop/addstyle.html" vda="link|topbar" target="_blank" class="menu-item" title="新款提交">新款提交</a>
                    <a href="/shop/list.html" vda="link|topbar" target="_blank" class="menu-item" title="档口入驻">档口入驻</a>
                </div>
            </div>

            <a href="/help/index.html" vda="link|topbar" target="_blank" class="item" title="帮助中心">帮助中心</a>
            <!-- <a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDAyNjY5M18zNjE3MDZfODAwMDI2NjkzXzJf" target="_blank" class="item" vda="link|topbar" title="在线客服">在线客服</a> -->

            <div class="item sitemap">
                <i class="block"></i>
                <a href="javascript:;" class="top">
                    网站导航
                    <i class="jib"></i>
                </a>
                <div class="menu" style="width:330px;">
                    <ul class="clearfix">
                        <li>
                            <strong>榜单</strong>
                            <a href="/active/ranking.html" vda="link|topbar" class="menu-item">档口排行榜</a>
                            <em>&nbsp;</em>
                            <!-- <a href="/user/follow.html" vda="link|topbar" class="menu-item">商品排行榜</a> -->
                        </li>
                        <li>
                            <strong>工具</strong>
                            <a href="/tools.html" vda="link|topbar" class="menu-item">一键上传</a>
                            <!-- <a href="#" vda="link|topbar" class="menu-item">批量下单</a> -->
                            <em>&nbsp;</em>
                        </li>
                        <li class="last" style="width: 80px;">
                            <strong>资讯</strong>
                            <a href="http://www1.vvic.com/syfw.html" vda="link|topbar" class="menu-item">摄影服务</a>
                            <!-- <a href="/user/agency.html" vda="link|topbar" class="menu-item">代发公司</a> -->
                            <a href="http://www1.vvic.com/hgnvgwdh.html" vda="link|topbar" class="menu-item">韩国网站导航</a>
                        </li>
                        <!-- <li class="last">
                            <strong>频道</strong>
                            <a href="/foreign.html" vda="link|topbar" class="menu-item">外贸爆款</a>
                            <em>&nbsp;</em>
                            <em>&nbsp;</em>
                        </li> -->
                    </ul>
                </div>
            </div>
        </div>

        <div class="clear"></div>

    </div>
</div><!-- 顶部工具栏 -->
