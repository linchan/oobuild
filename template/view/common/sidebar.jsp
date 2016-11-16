<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="J-global-toolbar">
    <div class="toolbar-wrap J-wrap">
        <div class="toolbar">
            <div class="toolbar-panels J-panel">
                <div style="visibility: hidden;" class="J-content toolbar-panel tbar-panel-cart toolbar-animate-out">
                    <div class="tbar-panel-header J-panel-header">
                        <div class="tbar-op clearfix">
                            <div class="check-all fl">
                                <i class="v-checkbox j-checkbox-all"></i> 全选
                            </div>
                            <a href="/cart.html" class="link-cart fr"><i></i><em class="title">查看全部</em></a>
                        </div>
                        <div id="J-cart-tips" class="tbar-tipbox mt10 clearfix hide">
                            <span class="tip-text fl">还没有登录，登录后商品将被保存</span>
                            <a href="javascript:;" class="btn btn-primary btn-x-small tip-btn J-login fr">登录</a>
                        </div>
                    </div>
                    <div class="tbar-panel-main nano" id="sideCartBox">
                        <div class="tbar-panel-content nano-content">
                            <div id="J-cart-render">
                                <div class="tbar-cart-list" id="sideCartlist">
                                    <div class="loading3" style="height: 100px"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tbar-panel-footer clearfix J-panel-footer">
                        <div class="jtc-number">已选商品 <em class="J-count">0</em></div>
                        <div class="jtc-sum"> <span class="yuan">¥</span> <em class="J-total">0.00</em> </div>
                        <a class="jtc-btn J-btn btn btn-primary btn-x-big btn-disabled" href="javascript:;" vda="action|sidebar|js">去结算</a>
                    </div>
                </div>
            </div>

            <div class="toolbar-header"></div>

            <div class="toolbar-tabs J-tab">
                <div style="display: none;" class="toolbar-tab tbar-tab-help j-fixed-help">
                    <i class="tab-ico vvicon">&#xe64d;</i>
                    <em class="tab-text">帮助</em>
                    <div class="tbar-panel-help j-tbar-help">
                        <h2>常见问题</h2>
                        <ul>
                            <li>
                                <a href="http://www.vvic.com/help/issue/daifa4.html" target="_blank">缺货怎么处理？</a>
                            </li>
                            <li>
                                <a href="http://www.vvic.com/help/issue/daifa6.html#e1" target="_blank">如何申请退货？</a>
                            </li>
                            <li>
                                <a href="http://www.vvic.com/help/issue/daifa6.html#e1" target="_blank">如何查看退货进度？</a>
                            </li>
                            <li>
                                <a href="http://www.vvic.com/help/issue/daifa7.html#f1" target="_blank">如何查看退款？</a>
                            </li>
                            <li>
                                <a href="http://www.vvic.com/help/issue/daifa7.html#f2" target="_blank">余额怎么提现？</a>
                            </li>

                            <li class="more">
                                <a href="/help/index.html" target="_blank">查看更多 <i class="vvicon">&#xe62d;</i></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="toolbar-tab tbar-tab-cart j-fixed-cart">
                    <i class="tab-ico vvicon">&#xe623;</i>
                    <em class="tab-text">购<br/>物<br/>车<br/></em>
                    <span class="tab-sub j-cart-amount"></span>
                </div>
                <div class="toolbar-tab">
                    <a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&key=XzgwMDAyNjY5M18zNjE3MDZfODAwMDI2NjkzXzJf" target="_blank" class="item" title="客服" vda="action|fastguidance|lxkf">
                        <i class="tab-ico vvicon">&#xe62b;</i>
                        <em class="tab-text">客服</em>
                    </a>
                </div>
                <div class="toolbar-tab">
                    <a href="http://www.diaochapai.com/survey/61820640-c41b-4f05-ab6f-95556eba74e7" target="_blank" class="item" title="反馈" vda="action|fastguidance|fk">
                        <i class="tab-ico vvicon">&#xe62a;</i>
                        <em class="tab-text">反馈</em>
                    </a>
                </div>
                <div class="toolbar-tab tbar-tab-top J-top">
                    <i class="ico  vvicon" style="font-size: 18px;">&#xe629;</i>
                </div>
            </div>

            <div class="toolbar-line"></div>
        </div>
    </div>
</div>

<script type="text/x-handlebars-template" id="sideCartTemplate">
    {{ _.each(data.recordList, function(shop){ }}
    <table class="side-cart-list shop_{{=shop.id}} cart-body">
        <thead>
        <tr>
            <th class="ckd">
                <span class="checkbox j-checkbox-shop" data-id="{{=shop.id}}" data-count="{{=shop.item_count}}">
                    <i class="vvicon i-unchecked">&#xe628;</i>
                    <i class="vvicon i-checked">&#xe627;</i>
                </span>
            </th>
            <th colspan="4" class="shop-info">
                <span class="title">
                    <a target="_blank" title="{{=shop.name}}" href="/shop/{{=shop.id}}">{{=shop.name}}</a>
                </span>
            </th>
        </tr>
        </thead>

        {{ _.each(shop.item_list, function(item){ }}
        <tbody class="shop-item item_{{=item.id}} item_status_{{=item.status}}">
        <tr>
            <td class="ckd">
                {{ if(item.status==0){ }}
                    下架
                {{ }else{ }}
                <span class="checkbox checkbox_status_{{=item.status}}  j-checkbox-item" data-id="{{=item.id}}">
                    <i class="vvicon i-unchecked">&#xe628;</i>
                    <i class="vvicon i-checked">&#xe627;</i>
                </span>
                {{ } }}
            </td>
            <td class="pic">
                <a target="_blank" href="/item/{{=item.item_id}}" title="{{=item.title}}">
                    <img width="50" src="{{=item.index_img_url}}_70x70.jpg" alt="">
                </a>
            </td>
            <td class="sku">
                <p class="sku-line">{{=(item.color=='nocolor' ? '图片色' : item.color) }}</p>
                <p class="sku-line">{{=(item.size=='nosize' ? '均码' : item.size) }}</p>
            </td>
            <td class="amount">
                {{ if(item.status == 1){ }}
                    <div class="amount-box clearfix ">
                        <span class="j-minus j-minus-{{=item.id}} {{ if(item.amount==1){ }}dis{{ } }}" data-id="{{=item.id}}"><i class="vvicon">&#xe61d;</i></span>

                        <input maxlength="3" type="text" class="amount-ipt amount_{{=item.id}} j-amount"
                               data-id="{{=item.id}}" value="{{=item.amount}}">

                        <span class="j-plus j-plus-{{=item.id}} {{ if(item.amount==999){ }}dis{{ } }}" data-id="{{=item.id}}"><i class="vvicon">&#xe61a;</i></span>
                    </div>
                {{ } else{ }}
                    <div class="tc">{{=item.amount}}</div>
                {{ } }}
            </td>
            <td class="total tr">
                <span class="yuan">¥</span>
                <span class="price item-sum_{{=item.id}}" data-price="{{=item.discount_price}}">{{- _(item.discount_price*item.amount).number2() }}</span>
            </td>
        </tr>
        </tbody>
        {{ }); }}
    </table>
    {{ }); }}
    {{ if(data.recordList.length == 0){ }}
    <div class="empty-tip" style="width: 290px;margin: 40px auto;">
        <span class="vvicon" style="width: 60px;">&#xe614;</span>
        <div class="text">您的购物车还是空的，快去选购商品吧！</div>
    </div>
    {{ } }}
</script>
<link rel="stylesheet" href="${staticDomain}/statics/lib/jquery.nanoscroller/nanoscroller.css">
<script>
    require(['common3/sidebar3'],function(sideBar){
        sideBar.init();
    });
</script>
