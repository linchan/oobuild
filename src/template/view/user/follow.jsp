<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="user3"/>
    <jsp:param name="cssHash" value="${cssHash.user3}"/>
    <jsp:param name="title" value="个人中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>

<div class="w user-w">
    <div class="user-left">
        <jsp:include page="usernav.jsp">
            <jsp:param name="bigClass" value="3"/>
            <jsp:param name="smallClass" value="2"/>
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">


            <div class="care">

                <div class="care-content">
                    <div class="loading3" style="height: 400px;"></div>
                    <!--json-->
                </div>
                <script type="text/x-handlebars-template" id="template">

                    <div class="main-bar clearfix">
                        <div class="fl">关注档口</div>
                        <div class="fr">共关注档口
                            <span class="num">{{=data.recordCount}}</span>
                            个
                        </div>
                    </div>

                    {{ _.each(data.recordList, function(el,index){ }}
                    <dl class="care-list clearfix">
                        <dt>
                        <h3>
                            <a href="/shop/{{=el.id}}">{{=el.name}}</a>
                        </h3>
                        <div class="shop-icon">
                             {{ if(el.cloud_update==1){ }}<i class="miao j-v-tip" data-tip="miao"></i>{{ } }}
                            {{ if(el.authenticated==1){ }}
                            <i class="cert j-v-tip" data-tip="cert"></i>
                            {{ } }}
                            <i class="top{{=el.top}} j-v-tip" data-top="{{=el.top}}" data-tip="top"></i>
                            <i class="shop-year-icon year{{=el.years}} j-v-tip" data-tip="year" data-date="{{=el.start_business_date}}"></i>
                        </div>
                        <ul>
                            <li>地址：{{=el.marketName}} {{=el.floor}}楼</li>
                            <li>主营：{{=el.shopCategory}}</li>
                            <li>上新时间：{{=el.up_time}}</li>
                            <li>商品数量：{{=el.itemsAmount}}</li>
                        </ul>
                        <div class="btns clearfix">
                            <a class="btn j-cancel-follow" data-id="{{=el.id}}" data-index="{{=index}}" vda="action|shopinfo|qxgz">取消关注</a>
                            <a href="/shop/{{=el.id}}" target="_blank" class="btn" vda="action|shopinfo|dkh">进入档口
                            </a>
                        </div>
                        </dt>
                        <dd class="goods-list  small-list">
                            <ul class="care-goods-list clearfix">
                                {{ _.each(el.itemsList, function(item, index){ }}
                                <li>
                                    <div class="item">

                                        <div class="pic">
                                            <a target="_blank" href="/item/{{=item.id}}" class="j-vda" vda="tp|itemcard|{{=item.id}}|0|0|{{=index+1}}">
                                                <img src="{{=item.index_img_url}}_190x190.jpg"/>
                                            </a>
                                        </div>
                                        <div class="desc">
                                            <div class="info clearfix">

                                                <div class=" price">
                                                    <span class="yuan">¥</span>{{=item.discount_price}}
                                                </div>
                                                <!--<i class="fl ico_item_active_0 ico_item_active"></i></div>-->
                                                <div class="title">
                                                    <a target="_blank" href="/item/{{=item.id}}" vda="spbt|itemcard|{{=item.id}}|0|0|{{=index+1}}">
                                                        {{=item.title}}
                                                    </a>
                                                </div>
                                                <div class="clearfix shop-name-box">
                                                    <div class="fr num j_clip_button art_no_{{=item.art_no}}"> {{=item.art_no}}#</div>

                                                    <div class="service-icon service-icon-tg shown_sp_{{=item.is_sp}} shown_tx_{{=item.is_tx}} shown_df_{{=item.is_df}} fl">
                                                        <div class="s-item sp j-v-tip" data-tip="sp"><i></i></div>
                                                        <div class="s-item tx j-v-tip" data-tip="tx"><i></i></div>
                                                        <div class="s-item df j-v-tip" data-tip="df"><i></i></div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                </li>
                                {{ }); }}

                            </ul>
                        </dd>
                    </dl>



                    {{ }); }}
                    {{ if(data.recordCount==0){ }}


                    <div class="empty-tip" style="">
                        <span class="vvicon">&#xe614;</span>
                        <div class="text">没有关注任何档口</div>
                    </div>


                    {{ } }}
                    {{ if(data.recordCount>0){ }}

                    <div class="pagination" style="padding-bottom: 0;">
                        <!--分页-->
                    </div>

                    {{ } }}
                </script>

            </div>


        </div>
    </div>
    <div class="clear"></div>
</div>


<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    require(['user3/follow3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/></body></html>
