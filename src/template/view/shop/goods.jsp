<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="stall3"/>
    <jsp:param name="cssHash" value="${cssHash.stall3}"/>
    <jsp:param name="title" value="档口中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="isShopCenter" value="1"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>
<div class="w user-w">
    <div class="user-left">
        <jsp:include page="shopnav.jsp">
            <jsp:param name="bigClass" value="4" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="main-title">
                <div class="fr">
                    <a class="btn btn-red btn-small set-phone lack-tips"  style="width: 90px;" id="addNewStyle" style="display:none;" target="_blank">提交新款</a>
                </div>
                商品信息
            </div>
            <div class="order-main">
                <div class="goods-list" id="goodsContent">
                    <div id="tabGoodsList">

                    </div>
                    <div class="data-tip-box">
                        <div class="loading3" style="height: 200px;" ></div>
                        <div class="empty-tip" style="">
                            <span class="vvicon">&#xe614;</span>
                            <div class="text">无记录</div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<script type="text/x-handlebars-template" id="template">
    <div class="tb-data-box">
        <table class="tb-order tb-goods">
            <thead>
                <tr>
                    <th width="90"></th>
                    <th width="190">商品信息</th>
                    <th width="100">一键上传</th>
                    <th width="100">收藏商品</th>
                    <th width="100">价格</th>
                    <th width="100">状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                {{ _.each(datas,function(item,index){ }}
                <tr>
                    <td>
                        <a href="/item/{{=item.id}}" target="_blank" alt="{{=item.title}}">
                            <img class="j-img-view lazy" data-original="{{=item.index_img_url}}_70x70.jpg" width="70" height="70" alt="{{=item.title}}" view-src="{{=item.index_img_url}}_230x230.jpg" />
                        </a>
                    </td>
                    <td class="text-left">{{=item.title}}</td>
                    <td>{{=item.upload_num_all || 0 }}</td>
                    <td>{{=item.fav_item_num | 0 }}</td>
                    <td>¥<strong class="price">{{=item.discount_price }}</strong></td>
                    <td class="j-select-box">
                        {{if(item.status_tb != 0){ }}
                        <!---->
                        <!--v-select-warm-->
                        <dl class="j-v-select v-select">
                            <dt>
                                <i class="vvicon">&#xe643;</i>
                                {{if(item.status == 0){ }}
                                <span>下架</span>
                                {{ }else{ }}
                                <span>上架</span>
                                {{ } }}
                            </dt>
                            <dd>
                                <ul class="j-v-select-ul" data-id={{=item.id}}>
                                    <li data-status="0"><span>下架</span></li>
                                    <li data-status="1"><span>上架</span></li>
                                </ul>
                            </dd>
                        </dl>
                        {{if(item.is_lack == 1){ }}
                        <p class="red">库存紧张</p>
                        {{ } }}
                        {{ }else{ }}
                        <div class="tb-down-tip">
                            <div class="lack-tip-box">
                                <span class="vvicon vvicon-down">&#xe620</span>
                                <div class="lack-outer">
                                    <a class="lack-txt" href="http://www.vvic.com/help/issueshop/dangkou5.html#e2" target="_blank">点击查看如何从淘宝恢复上架</a>
                                    <i></i>
                                </div>
                            </div>
                            已从淘宝下架
                        </div>
                        {{ } }}
                    </td>
                    <td>
                        <a title="修改商品" class="link" href="/shop/edit.html?sid={{=item.shop_id }}&id={{=item.id}}">修改商品</a>
                        <a href="javascript:;" class="link goods-refresh" data-tid="{{=item.tid}}">刷新商品</a>
                    </td>
                </tr>
                {{ }) }}

            </tbody>
        </table>
    </div>
    <div class="pagination" style="display:none;"></div>
 </script>

<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    require(['shop3/goods3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>

