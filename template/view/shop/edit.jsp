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
<link href="${staticDomain}/statics/lib/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<div class="w user-w">
    <div class="user-left">
        <jsp:include page="shopnav.jsp">
            <jsp:param name="bigClass" value="4" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="main-title">
                修改商品
            </div>

            <div class="vv-msg" style="margin-top:0;"><strong>提示：</strong>更新的商品信息只会在搜款网显示，不会影响您的淘宝店铺。</div>

            <div class="form-main edit">
                <div class="f-wrap">
                    <div class="f-wrap-tab">
                        <dl class="text-box clearfix">
                            <dt>商品名称：</dt>
                            <dd class="tb-title">
                                <input type="text" maxlength="60" name="title" id="title" value="" />
                                <div class="length-count">
                                    <em id="titleLength">0</em>/60
                                </div>
                            </dd>
                            <dd class="err"></dd>
                        </dl>
                        <dl class="text-box other clearfix">
                            <dt>商品首图：</dt>
                            <dd class="x-long">
                                <div class="img-box">
                                    <div class="img">
                                        <img src="${staticDomain}/statics/v2/css/img/blank.gif" style="background: url(${staticDomain}/statics/v2/css/img/none.png) no-repeat center;" id="indexImg" height="180" />
                                    </div>
                                    <div class="up-img">
                                        <input style="display: none;" id="file_upload" name="file_upload" type="file" value="更换图片">
                                    </div>
                                    <input type="hidden" id="indexImgUrl" name="indexImgUrl" value="" />
                                </div>
                            </dd>
                        </dl>
                        <dl class="text-box text-box-new clearfix">
                            <dt>商品标签：</dt>
                            <dd class="long">
                                <i class="v-checkbox v-item-tag checkIsPreSell" data-target="is_pre_sell"></i> 预售
                                <input type="hidden" value="" name="is_pre_sell" id="is_pre_sell" />
                                <span class="text-box-tip">标为预售的商品无法在搜款网下单，到货后需要及时取消勾选</span>
                            </dd>
                            <dd class="long">
                                <i class="v-checkbox v-item-tag checkIsSpecialOffer" data-target="is_special_offer"></i> 特价
                                <input type="hidden" value="" name="is_special_offer" id="is_special_offer" />
                                <span class="text-box-tip">标为特价的商品不退不换</span>
                            </dd>
                            <dd class="err"></dd>
                        </dl>
                        <input type="hidden" value="" id="discountPrice" name="discountPrice" />
                        <dl class="text-box other text-box-bottom clearfix" style="overflow:visible ">
                            <dt class="text-box-label"><span class="red">*</span> 商品管理：</dt>
                            <dd style="width: 910px;">
                                <table class="sku-table">
                                    <thead>
                                        <tr>
                                            <th width="160">颜色</th>
                                            <th width="120">尺码</th>
                                            <th width="160">单价（元）</th>
                                            <th width="120">一口价</th>
                                            <th width="170">
                                                <dl class="j-v-select v-select">
                                                    <dt>
                                                        <i></i>
                                                        <span>批量操作</span>
                                                    </dt>
                                                    <dd>
                                                        <ul class="j-v-select-ul">
                                                            <li data-lack="0"><span>有货</span></li>
                                                            <li data-lack="1"><span>缺货</span></li>
                                                        </ul>
                                                    </dd>
                                                </dl>
                                            </th>
                                            <th>上架</th>
                                        </tr>
                                    </thead>
                                    <tbody id="skuMap">
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>

                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="f-wrap-foot mt10 j-status">
                    <input class="btn btn-primary btn-x-big" type="button" id="ok" value="提交" />
                    <a href="/shop/goods.html" style="margin-left:20px;">返回上一页</a>
                    <input type="hidden" name="shop_id" id="shopId" value="" />
                </div>
            </div>

        </div>
    </div>
    <div class="clear"></div>
</div>

<script type="text/x-handlebars-template" id="skuTemplate">
    <!--
    淘宝下架tr加上class="tb-lack-down"
    下架class="tb-opt-down"
    上架：class="tb-opt-up"
    -->
    {{ _.each(skumaps, function(item, index){ }}
        <tr class="{{ if(item.status_tb == 0){ }}tb-lack-down {{ }else{ }} {{ if(item.status == 0){ }}tb-opt-down{{ }else{ }}tb-opt-up{{ } }}{{ } }}">
            <td>{{=item.color}}</td>
            <td>{{=item.size}}</td>
            <td class="tb-price">
                <div class="opt-show">
                    <input type="text" data-old-price="{{=item.discount_price}}" class="input-price {{if(item.is_checked){}}ykj{{}}}" name="sku-price" value="{{=item.discount_price}}" />
                    <a href="javascript:;" class="btn btn-default btn-x-small btn-batch">批量</a>
                </div>
                <div class="opt-unshow"><strong>{{=item.discount_price}}</strong></div>
            </td>
            <td class="tb-deal-price">
                <div class="opt-able" {{if( statusTb == 0 || status == 0){}} style="display:none" {{}}}>
                    <i class="v-checkbox {{if(item.is_checked==1){}}checked{{}}} checkedLabel"></i>
                    <input type="hidden" value="{{=item.is_checked}}" id="isChecked_{{=item.id}}" name="isChecked_{{=item.id}}" class="checkedValue">
                </div>
                <div class="opt-unable {{if(item.is_checked==1){ }} opt-unable-checked{{ }else{ }} opt-unable-unchecked {{ } }}" {{if( statusTb == 0 || status == 0){}} style="display:block" {{}}}>
                    <i class="vvicon vvicon-check">&#xe64b;</i>
                    <i class="vvicon vvicon-uncheck">&#xe64c;</i>
                </div>
            </td>
            <td>
                <div class="v-radio j-v-radio opt-able" data-target="isLack_{{=item.id}}" {{if( statusTb == 0 || status == 0){}} style="display:none" {{}}}>
                    <span class="mr30 {{if(item.is_lack==0){}}checked{{}}}" data-value="0">
                        <i class="vvicon">&#xe618;</i>
                        <i class="vvicon un-checked">&#xe619;</i>
                        有货
                    </span>

                    <span {{if(item.is_lack==1){}} class="checked"{{}}} data-value="1">
                        <i class="vvicon">&#xe618;</i>
                        <i class="vvicon un-checked">&#xe619;</i>
                        缺货
                    </span>
                </div>
                <div class="v-radio j-v-radio opt-unable" {{if( statusTb == 0 || status == 0){}} style="display:block" {{}}}>
                    <span class="mr30" data-value="0">
                    <i class="vvicon vvicon-unradio {{if( statusTb == 0 || status == 0){}}v-checkbox-unable{{}}}" >&#xe64a;</i>
                    有货
                    </span>

                    <span data-value="1">
                    <i class="vvicon vvicon-unradio {{if( statusTb == 0 || status == 0){}}v-checkbox-unable{{}}}" >&#xe64a;</i>
                    缺货
                    </span>
                </div>
                <input type="hidden" class="lackValue" name="isLack_{{=item.id}}" id="isLack_{{=item.id}}" value="{{=item.is_lack}}">
            </td>
            <td>
                {{ if(item.status_tb == 0){ }}
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
                {{ }else{ }}
                <i class="vvicon v-checkbox-unable" {{if( statusTb == 0 || status == 0){}} style="display:block;"{{ }else{ }} style="display:none;" {{}}}>{{if(item.status==1){}} &#xe64b; {{ }else{ }} &#xe64c; {{ } }}</i>
                <i class="v-checkbox {{if(item.status==1){}}checked{{}}} j-up-down" {{if( statusTb == 0 || status == 0){}}  style="display:none;" {{}}}></i>
                {{ } }}
                <input type="hidden" value="{{=item.status_tb}}" class="j-tb-status"/>
                <input type="hidden" value="{{=item.status}}" class="j-updown-status" data-status="{{=item.status}}"/>
            </td>
        </tr>
    {{ }) }}
</script>

<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    var _GOODSID = '${param.id}',
        _MAXLENGTH = 60;
    require(['shop3/edit3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>

