<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${staticDomain}/statics/v2/css/ranking3.css?${cssHash.ranking3}">
<div class="header_shop">
    <div class="header_inner">
        <div class="w clearfix ">
            <a href="/" title="搜款网VVIC" class="logo fl">
                <img src="${staticDomain}/statics/v2/css/img/logo/logo_shop.png" alt="">
            </a>
            <div class="stall-head fl">
                <div class="update-head-name">沙河档口经营排名-9月</div>
            </div>
        </div>
    </div>
</div>

<div class="w ranking-warp clearfix">
        <!-- <div class="loading3" style="height: 100px"></div> -->
    <div class="rk-left">
        <div class="rk-floor" id="floorNav">
            <ul>
                <li data-mark="1" class="floor1" vda="action|quicknav|floornav">
                    <span>第 1 名 - 第 50 名</span>
                </li>
                <li data-mark="50" class="floor2" vda="action|quicknav|floornav">
                    <span>第 51 名 - 第 100 名</span>
                </li>
                <li data-mark="101" class="floor3" vda="action|quicknav|floornav">
                    <span>第 101 名 - 第 200 名</span>
                </li>
                <li data-mark="201" class="floor4" vda="action|quicknav|floornav">
                    <span>第 201 名 - 第 300 名</span>
                </li>
                <li data-mark="301" class="floor5" vda="action|quicknav|floornav">
                    <span>第 301 名 - 第 400 名</span>
                </li>
                <li data-mark="401" class="floor6" vda="action|quicknav|floornav">
                    <span>第 401 名 - 第 500 名</span>
                </li>
                <li data-mark="501" class="floor7" vda="action|quicknav|floornav">
                    <span>第 501 名 - 第 600 名</span>
                </li>
                <li data-mark="601" class="floor8" vda="action|quicknav|floornav">
                    <span>第 601 名 - 第 700 名</span>
                </li>
                <li data-mark="701" class="floor9" vda="action|quicknav|floornav">
                    <span>第 701 名 - 第 800 名</span>
                </li>
                <li data-mark="801" class="floor10" vda="action|quicknav|floornav">
                    <span>第 801 名 - 第 900 名</span>
                </li>
                <li data-mark="901" class="floor11" vda="action|quicknav|floornav">
                    <span>第 901 名 - 第 1000 名</span>
                </li>
            </ul>
        </div>
    </div>
    <div class="rk-main">
        <div class="rk-box clearfix">
            <div class="rk-top">
                <div class="rk-title clearfix">
                    <img src="${staticDomain}/statics/v2/css/img/ranking/top100.png" alt="" height="42">
                    <div class="rk-tips">
                        排名基于搜款网内部数据，包含上新、上传、收藏、关注、服务质量等综合维度。<br/>
                        想看自家档口排名，点击“<a href="http://www.vvic.com/shop/list.html" target="_blank" style="color:#ef3664;">我的档口数据</a>”
                    </div>
                </div>
            </div>
            <div id="rankTopContentA">
                <div class="loading3" style="height:300px;"></div>
                <script type="text/x-handlebars-template" id="topTemplateA">
                    {{ _.each(list1, function(list, index){ }}
                    <div class="rk-list clearfix">
                        {{ if(index<2){ }}
                        <div class="rk-list-head clearfix">
                            <div class="fl rk-list-name">档口</div>
                            <div class="fl rk-list-address">档口地址</div>
                            <div class="fl rk-list-mark">分值</div>
                        </div>
                        {{ } }}
                        <ul class="rk-list-body" {{if(index % 2==0){}}style="border-right:1px solid #EBEBEB;"{{}}}>
                            {{ _.each(list.list, function(sub, subindex){ }}
                            {{ var url = (sub.id.indexOf('http://') == -1 ? '/shop/' : '') + sub.id}}
                            <a href="{{=url}}" title="{{=sub.title}}" target="_blank">
                            <li class="shop_{{=index*25 + subindex + 1}}">
                                <div class="fl rk-list-name">
                                    <i class="rk-list-value{{=index*25 + subindex + 1}}">{{=index*25 + subindex + 1}}</i>
                                    <span>{{=sub.title}}</span>
                                </div>
                                <div class="fl rk-list-address">
                                    {{=sub.address}}
                                </div>
                                <div class="fl rk-list-mark">
                                    {{=sub.mark}}
                                </div>
                            </li>
                            </a>
                            {{ }) }}
                        </ul>
                    </div>
                    {{ if(index==1){ }}
                    <div class="clear"></div>
                    <div class="rk-list-tips">
                        <span>01-50</span>
                    </div>
                    {{ } }}
                    {{ }) }}
                </script>
            </div>
        </div>

        <div class="rk-box" style="margin-top: 30px;">
            <div class="rk-top">
                <div class="rk-title clearfix">
                    <img src="${staticDomain}/statics/v2/css/img/ranking/top1000.png" alt="" height="42">
                </div>
            </div>
            <div id="rankTopContentB">
                <div class="loading3" style="height:300px;"></div>
                <script type="text/x-handlebars-template" id="topTemplateB">
                    {{ _.each(list2, function(list, index){ }}
                    <div class="rk-list-col clearfix" id="floor_{{=list.name}}">
                        {{ _.each(list.list, function(sub, subindex){ }}
                        {{ if(subindex % 20==0){ }}
                        <ul>
                        {{ } }}
                            <li class="shop_{{=index*100+subindex+101}}">
                                <span class="value">{{=index*100+subindex+101}}</span>
                                {{ var url = (sub.id.indexOf('http://') == -1 ? '/shop/' : '') + sub.id}}
                                <a href="{{=url}}" title="{{=sub.title}}" target="_blank">{{=sub.title}}</a>
                            </li>
                        {{ if(subindex % 20 == 19){ }}
                        </ul>
                        {{ } }}
                        {{ }) }}
                    </div>
                    <div class="clear"></div>
                    {{ if(index+1<list2.length){ }}
                    <div class="rk-list-tips">
                        <span>{{=list.name}}</span>
                    </div>
                    {{ } }}
                    {{ }) }}
                </script>
            </div>
        </div>

    </div>
</div>
