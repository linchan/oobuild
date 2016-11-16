<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="cart3"/>
    <jsp:param name="cssHash" value="${cssHash.cart3}"/>
    <jsp:param name="title" value="个人中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="currentNav" value="99"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>
<style type="text/css" media="screen">
    .header_shop {
        border-bottom: 1px solid #e5e5e5;
    }
</style>

<div class="w user-w">
    <div class="user-left">
        <jsp:include page="usernav.jsp">
            <jsp:param name="bigClass" value="6"/>
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">


            <div class="cart3 purchase3">

                <div class="main-title">
                    拿货单
                </div>
                <table class="thead j-cart-head">
                    <thead>
                    <tr>
                        <th class="ckd">
                            <span class="checkbox j-checkbox-all">
                                <i class="vvicon i-unchecked">&#xe628;</i>
                                <i class="vvicon i-checked">&#xe627;</i>
                            </span>
                        </th>
                        <th width="110">
                            全选
                            <a class="del-items j-del-checked dis">批量删除</a>
                        </th>
                        <th width="398" class="tc">商品</th>
                        <th width="130">单价</th>
                        <th width="128">数量</th>
                        <th>总价</th>
                        <th width="86">操作</th>
                    </tr>
                    </thead>
                </table>

                <div class="list-content">
                    <!--json-->

                    <div class="loading3"></div>

                </div>
                <div class="empty-tip" style="display: none;">
                    <span class="vvicon">&#xe614;</span>
                    <div class="text">拿货单里没有任何商品，您可以去商品详情页进行添加。</div>
                </div>
                <script type="text/x-handlebars-template" id="template">

                    {{ _.each(data.recordList, function(shop){ }}
                    <table class="cart-list cart-body shop_{{=shop.id}}">
                        <thead>
                        <tr>
                            <th class="ckd">
                                <span class="checkbox j-checkbox-shop" data-id="{{=shop.id}}" data-count="{{=shop.item_count}}">
                                    <i class="vvicon i-unchecked">&#xe628;</i>
                                    <i class="vvicon i-checked">&#xe627;</i>
                                </span>
                            </th>
                            <th colspan="2" class="shop-info">
                                <span class="title">
                                    <a target="_blank" title="俏佳人" href="/shop/{{=shop.id}}">{{=shop.name}}</a>
                                    <a target="_blank" title="{{=shop.ww_nickname}}"
                                       href="http://www.taobao.com/webww/ww.php?ver=3&amp;siteid=cntaobao&amp;status=2&amp;charset=utf-8&amp;touid={{=shop.ww_nickname}}">
                                        <img style="margin:-4px 0 0 3px" align="absmiddle"
                                             src="http://www.vvic.com/api/online?nickname={{=shop.ww_nickname}}"
                                             alt="{{=shop.ww_nickname}}">
                                    </a>
                                </span>
                                <span class="address">{{=shop.subName}} {{=shop.floor}} 楼 {{=shop.position}}</span>
                                <span class="tel">电话：{{=shop.telephone}}</span>
                                <span class="qq">QQ：{{=shop.qq}}</span>
                            </th>
                        </tr>
                        </thead>

                        {{ _.each(shop.item_list, function(item){ }}
                        <tbody class="shop-item item_{{=item.id}}">
                        <tr>
                            <td valign="top" class="ckd">
                                <div class="inner">
                                    <span class="checkbox j-checkbox-item" data-id="{{=item.id}}">
                                        <i class="vvicon i-unchecked">&#xe628;</i>
                                        <i class="vvicon i-checked">&#xe627;</i>
                                    </span>
                                </div>
                            </td>
                            <td valign="top" class="pic">
                                <div class="inner">
                                    <a target="_blank" href="/item/{{=item.item_id}}" title="">
                                        <img width="60" src="{{=item.index_img_url}}_70x70.jpg" alt="">
                                    </a>
                                </div>

                            </td>
                            <td valign="top">
                                <div class="item-title inner">
                                    <a target="_blank" href="/item/{{=item.item_id}}" title="{{=item.title}}">
                                        {{=item.title}}
                                    </a>

                                    <div class="art_no j_clip_button ">{{=item.art_no}} #</div>
                                </div>

                                <table class="cart-item last">
                                    <tbody>
                                    <tr class="selected">
                                        <td class="color">

                                            <div class="item-props">
                                                <div class="edit j-edit" data-id="{{=item.id}}" data-shop-id="{{=shop.id}}">修改</div>

                                                <p class="sku-line">颜色：<span class="j-sku-color-{{=item.id}}">{{=item.color}}</span></p>
                                                <p class="sku-line">尺码：<span class="j-sku-size-{{=item.id}}">{{=item.size}}</span></p>

                                                <div class="sku-edit-popup">
                                                    <div class="sku-edit-content clearfix">
                                                        <dl class="prop">
                                                            <dt>尺码</dt>
                                                            <dd class="sizes">
                                                                <ul class="clearfix">
                                                                    {{ _.each(item.item_size, function(size, index){ }}
                                                                    <li data-pvid="{{-item.item_size_id[index]}}" data-size="{{=size}}" class="j-prop-item ">{{=size}} <i class=" vvicon"></i></li>
                                                                    {{ }); }}
                                                                </ul>
                                                            </dd>
                                                        </dl>
                                                        <dl class="prop">
                                                            <dt>颜色</dt>
                                                            <dd>
                                                                <ul class="clearfix">
                                                                    {{ _.each(item.item_color, function(color,index){ }}
                                                                    <li data-pvid="{{-item.item_color_id[index]}}" data-color="{{=color}}" class="j-prop-item ">{{=color}} <i class=" vvicon"></i></li>
                                                                    {{ }); }}
                                                                </ul>
                                                            </dd>
                                                        </dl>
                                                        <div class="operate">
                                                            <a class="cancel j-cancel">取消</a>
                                                            <a class="add-cart j-cart-prop" data-id="{{=item.id}}" data-item_id="{{=item.item_id}}">确定</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="single">
                                            <div class="inner">
                                                <span class="price"><span class="yuan">¥</span>

                                                    <span class="j-sku-price j-sku-price-{{=item.id}}">{{-_(item.discount_price).number2()}}</span>
                                                </span>

                                            </div>
                                        </td>
                                        <td class="amount">
                                            <div class="inner tc">
                                                <div class="amount-box clearfix ">
                                                    <span class="j-minus j-minus-{{=item.id}} {{ if(item.amount==1){ }}dis{{ } }}" data-id="{{=item.id}}">-</span>

                                                    <input maxlength="3" type="text" class="amount-ipt amount_{{=item.id}} j-amount"
                                                           data-id="{{=item.id}}" value="{{=item.amount}}">

                                                    <span class="j-plus j-plus-{{=item.id}} {{ if(item.amount==999){ }}dis{{ } }}" data-id="{{=item.id}}">+</span>
                                                </div>

                                                <span class="lack j-stock-less j-stock-less-{{=item.id}} {{ if(item.is_lack==0|| !item.lack_date){ }} hide {{ } }}" data-date="{{=item.lack_date}}">库存紧张</span>


                                            </div>
                                        </td>
                                        <td class="total">
                                            <div class="inner">
                                                <span class="price"><span class="yuan">¥</span>
                                                    <span class=" item-sum_{{=item.id}}"  data-price="{{=item.discount_price}}">{{- _(item.discount_price*item.amount).number2() }}</span>
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="del inner">
                                    <a class="j-move" data-id="{{=item.id}}">移入收藏夹</a>
                                    <a target="_blank" class="blue-btn" href="/samestyle/{{=item.item_id}}"
                                       title="{{=item.title}}">找同款
                                    </a>
                                    <a class="j-del" data-id="{{=item.id}}">删除</a>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                        {{ }); }}

                    </table>

                    {{ }); }}

                </script>


                <table class="cart-list cart-foot j-cart-foot" style="width:990px;display: none;">

                </table>
                <script type="text/x-handlebars-template" id="tpl-foot">
                    <tfoot>
                    <tr>
                        <td class="ckd">
                            <span class="checkbox j-checkbox-all {{=checked}}">
                                <i class="vvicon i-unchecked">&#xe628;</i>
                                <i class="vvicon i-checked">&#xe627;</i>
                            </span>
                        </td>
                        <td width="55">全选</td>
                        <td width="140">
                            <a class="j-del-checked dis del">批量删除</a>
                        </td>
                        <td width="130">卖家数量：{{=shopCount}}</td>
                        <td width="130">货品种类：{{=countItem}} 种</td>
                        <td width="130">数量总计：{{=countDetail}} 件</td>
                        <td style="text-align:right;padding:0 12px 0 0;">商品总金额：
                            <span class="price"><span class="yuan">¥</span> {{=countPrice}}</span>

                        </td>
                        <td>
                            <!--<a class="j-print print">
                                <i class="vvicon ico-print">&#xe621;</i>
                                打印拿货单
                            </a>-->
                        </td>
                        <td class="goOrder disabled j-btn-submit j-btn-print"> <i class="vvicon ico-print">&#xe621;</i> <span style="font-size:14px;">打印拿货单</span></td>
                    </tr>
                    </tfoot>
                </script>

            </div>

        </div>
    </div>
    <div class="clear"></div>
</div>




<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp">
    <jsp:param name="hideFixBar" value="1"/>
</jsp:include>
<script>
    require(['user3/cart3'], function (cart) {
        cart.init({
            type: 'purchase'
        })
    });
</script>
<jsp:include page="../common/third.jsp"/>

</body></html>
