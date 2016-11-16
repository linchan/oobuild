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
            <jsp:param name="bigClass" value="5" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="main-title">
                档口设置
            </div>

            <div class="form-main add">
                <div class="f-wrap">
                    <div class="f-title"><h3>档口地址</h2></div>
                    <div class="f-wrap-tab">
                        <dl class="text-box clearfix">
                            <dt>省份：</dt>
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
                        <dl class="text-box clearfix">
                            <dt>商品标签：</dt>
                            <dd class="long">
                                <i class="v-checkbox v-item-tag checkIsPreSell" data-target="is_pre_sell"></i> 预售
                                <input type="hidden" value="" name="is_pre_sell" id="is_pre_sell" />
                                <i class="v-checkbox v-item-tag checkIsSpecialOffer ml20" data-target="is_special_offer"></i> 特价
                                <input type="hidden" value="" name="is_special_offer" id="is_special_offer" />
                            </dd>
                            <dd class="err"></dd>
                        </dl>
                        <input type="hidden" value="" id="discountPrice" name="discountPrice" />
                        <dl class="text-box other clearfix" style="overflow:visible ">
                            <dt><span class="red">*</span> 商品价格：</dt>
                            <dd style="width: 850px;">
                                <table class="sku-table">
                                    <thead>
                                        <tr>
                                            <th width="140">颜色</th>
                                            <th width="140">尺码</th>
                                            <th width="140">单价（元）</th>
                                            <th width="100">一口价</th>
                                            <th>
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
                                        </tr>
                                    </thead>
                                    <tbody id="skuMap">
                                        <tr>
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
    {{ _.each(skumaps, function(item, index){ }}
        <tr>
            <td>{{=item.color}}</td>
            <td>{{=item.size}}</td>
            <td class="tb-price">
                <input type="text" data-old-price="{{=item.discount_price}}" class="input-price {{if(item.is_checked){}}ykj{{}}}" name="sku-price" value="{{=item.discount_price}}" />
                <a href="javascript:;" class="btn btn-default btn-x-small btn-batch">批量</a>
            </td>
            <td>
                <i class="v-checkbox {{if(item.is_checked==1){}}checked{{}}} checkedLabel"></i>
                <input type="hidden" value="{{=item.is_checked}}" id="isChecked_{{=item.id}}" name="isChecked_{{=item.id}}" class="checkedValue">
            </td>
            <td>
                <div class="v-radio j-v-radio" data-target="isLack_{{=item.id}}">
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
                <input type="hidden" class="lackValue" name="isLack_{{=item.id}}" id="isLack_{{=item.id}}" value="{{=item.is_lack}}">
            </td>
        </tr>
    {{ }) }}
</script>

<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    var _GOODSID = '${param.id}',
        _MAXLENGTH = 60;
    require(['shop3/save3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>

