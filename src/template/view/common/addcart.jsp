<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/x-handlebars-template" id="cartTemplate">
<div class="product-intro pop-cart clearfix">
    <div class="name">
        <h1>{{=item.title}}</h1>
    </div>

    <div class="price-time-buyer">
        <div class="v-price d-price">
            <div class="p-name">单价</div>
            <div class="p-value">
                {{ if(price_type == 1){ }}
                    <strong class="yuan">¥</strong>
                    <strong class="sale">{{=item.discount_price}}</strong>
                {{ }else if(price_type == 2){ }}
                    <strong class="yuan">¥</strong>
                    <strong class="sale">{{=rang_price}}</strong>
                {{ }else{ }}
                    <strong class="yuan" style="display: none;">¥</strong><strong class="sale" style="color: #9c9c9c;">档口设置错误</strong>

                    <a class="error_link" target="_blank" href="http://www1.vvic.com/jgcw.html" style="font-size: 12px;color: #999;margin-left: 5px;" vda="link|itemdetail">查看原因</a>
                {{ } }}
                {{ if(item.is_pre_sell==1){ }}
                    <i class="type-tip">预售商品无法下单</i>
                {{ }else{ }}
                    {{ if(item.is_special_offer==1){ }}
                        <i class="type-tip">特价商品不退不换</i>
                    {{ } }}
                {{ } }}
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <dl class="summary v-sku clearfix" id="j-buy">
        <div class="close j-buy vvicon" id="j-buy-close">&#xe60a;</div>
        {{ if(item.size!=''){ }}
            <dd class="fl choice">
                <div class="name">尺码</div>
                <div class="value goods-choice">
                    <ul>
                        {{ var sizeArray = item.size.split(',') }}
                        {{ _.each(sizeArray, function(el){ }}
                            <li class='selectSize' data-size="{{=el}}">
                                <a href="javascript:;">{{=el}}</a>
                            </li>
                        {{ }) }}
                    </ul>
                    <div class="clear"></div>
                </div>
            </dd>
        {{ } }}
        <dd class="fl choice">
            {{ var colorArray = item.color.split(',') }}
            {{ if(item.color_pics.length){ }}
                <div class="name color" style="margin-top:15px;">颜色</div>
                <div class="value color-choice">
                    <ul class="clearfix">
                        {{ _.each(item.color_pics, function(el, index){ }}
                            <li class='selectColorPic selectColor' data-color="{{=colorArray[index]}}" data-index="{{=index}}">
                                {{ if(el!=''){ }}
                                <a>
                                    <img src="{{=el}}_40x40.jpg"/>
                                </a>
                                {{ }else{ }}
                                <a class="text_item">{{=colorArray[index]}}</a>
                                {{ } }}
                            </li>
                        {{ }) }}
                    </ul>
                    <div class="clear"></div>
                </div>
            {{ }else{ }}
                {{ if(item.color != ''){ }}
                    <div class="name">颜色</div>
                    <div class="value goods-choice">
                        <ul>
                            {{ _.each(colorArray, function(el){ }}
                                <li class='selectColor' data-color="{{=el}}">
                                    <a href="javascript:;">{{=el}}</a>
                                </li>
                            {{ }) }}
                        </ul>
                    </div>
                {{ } }}
            {{ } }}
        </dd>
        <dd class="fl amount j-parts">
            <div class="name">数量</div>
            <div class="value amount-stock">
                <span class="stock" id="J_Stock">
                    <a href="javascript:void(0);" title="减1" hidefocus="" class="v-reduce vvicon v-disable-reduce">&#xe61e;</a>
                    <input id="j_iptAmount" type="text" value="1" maxlength="3" title="请输入购买量">
                    <a href="javascript:void(0);" hidefocus="" class="v-increase vvicon" title="加1">&#xe61b;</a>
                    <a href="http://www1.vvic.com/invertory_status.html" target="_blank" class="stock-tips j-stock-less" style="display:none;" data-tip="">库存紧张</a>
                </span>
            </div>
        </dd>
        <dd class="fl parts j-parts">
            <div class="name">配件</div>
            <div class="value parts-ck">
                <i>
                    <span class="vvicon j-ckb-0">&#xe628;</span>
                    <span class="vvicon j-ckb-1">&#xe627;</span>
                </i>
                <div class="parts-text">有</div>
            </div>
        </dd>
        <dd class="fl j-buy" style="margin-top:20px">
            <div class="name">&nbsp;</div>
            <div class="value">
                <div class='btn-buy j-btn-confirm {{if(item.color!='' || size!=''){}}btn-disable-buy{{}}}' vda="action|itemdetail|addconfirm">确认</div>
            </div>
        </dd>
    </dl>
    <div class="btns j-unbuy clearfix">
        <div class="buy-guild" style="display:none;"></div>
        {{ if(price_type < 3){ }}
            <div class="btn btn-primary btn_add_cart btn_red j-vda ishide {{ if(item.art_no=='' || item.is_pre_sell == 1){ }}btn-disabled{{}}}" vda="action|itemdetail|addcart">加入购物车</div>
        {{ } }}
    </div>
    <div class="pop-cart-pic">
        <img src="{{=item.index_img_url}}_230x230.jpg" alt="title">
    </div>
</div>
</script>
