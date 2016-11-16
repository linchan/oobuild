<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="user3"/>
    <jsp:param name="cssHash" value="${cssHash.user3}"/>
    <jsp:param name="title" value="生成数据包"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>

<div class="w user-w">
    <div class="vv-msg"><strong>提示：</strong>设置数据包模板，生成更便捷！<a href="javascript:;" id="setTpl" class="blue-btn">设置模板 <font class="vvicon">&#xe62d;</font></a></div>
        <div class="create-data" id="packetContent">
            <div class="loading3" style="height: 300px;"></div>
        </div>
      </div>
    </div>
</div>

<div id="templ" style="display:none;" class="clearfix">
    <div class="tempWrap clearfix">
        <div class="fl wrap-l">价格</div>
        <div class="fl wrap-r">
            <div class="v-radio" style="margin:5px 0 10px">
                <span class="checked mr30" data-type="0">
                    <i class="vvicon">&#xe618;</i>
                    <i class="vvicon un-checked">&#xe619;</i>
                    增加固定金额
                </span>

                <span data-type="1">
                    <i class="vvicon">&#xe618;</i>
                    <i class="vvicon un-checked">&#xe619;</i>
                    增加固定比例
                </span>
            </div>


            <!-- <div class="linesup priceTemplContainer">
                <span class="lu-Ele">
                    <a data-type="0" class="easyRadio checked"><i class="vvicon">&#xe618;</i>增加固定金额</a></span>
                <span class="lu-Ele">
                    <a data-type="1" class="easyRadio"><i class="vvicon">&#xe619;</i>增加固定比例</a>
                </span>
            </div> -->
            <div style="margin:5px 0;" class="short">
                <input id="tempVal"/>
                <span class="j-symbol"></span>
                <span class="tips j-tips" style="margin-left: 10px;">
                    <span class="j-tips-0"></span>
                    <span class="j-tips-1" style="display:none;"></span>
                </span>
            </div>
        </div>
        <div class="fl wrap-l">宝贝详情</div>
        <div class="fl wrap-r">
            <div class="ta-box">
                <div class="ta-tag">
                    <span class="curr">正文前</span>
                    <span class="sec">正文后</span>
                </div>
                <div class="clear"></div>
                <div class="ta-content">
                    <textarea id="front"></textarea>
                    <textarea style="display:none" id="back"></textarea>
                </div>
            </div>
        </div>
        <div class="clear"></div>
        <div class="btns clearfix"><a ms-click="cancelTempl" class="cancel j-cancel">取消</a><a class="set j-set-temp">设置</a></div>
    </div>
</div>

<div id="progress" style="display:none;">
  <div role="progressbar" data-goal="-50" aria-valuemin="-100" aria-valuemax="0" class="progress">
    <div class="progress__bar"><span class="progress__label"></span></div>
  </div>
  <div class="layer-loading">数据生成中，请耐心等待</div>
</div>

<script type="text/x-handlebars-template" id="tpl">
    <div class="c-list">
        {{ _.each(items, function(el, index){ }}
        <dl data-tid="{{=el.tid}}" data-id="{{=el.id}}" {{ if((index+1)==items.length){ }}class="last"{{ } }}>
            <dt>
                <img data-original="{{=el.index_img_url}}_120x120.jpg" class="lazy"/></dt>
            <dd>
                <ul>
                    <li class="label">商品标题</li>
                    <li class="ipt long">
                        <input type="text" class="ipt-title" value="{{=el.title}}"/>
                    </li>
                    <li class="desc">商品标题建议不超过 30 个字</li>
                    <li class="label">商家编码</li>
                    <li class="ipt">
                        <input type="text" class="ipt-code" value="{{=el.code}}"/>
                    </li>
                    <li class="label">零售价格</li>
                    <li class="ipt">
                        <input type="text" class="ipt-price" value="{{=el.market_price}}" class="j-market-price" ms-change="change()"/>
                    </li>
                    <li class="desc fh">元</li>
                    <li class="desc">批发价 {{=el.price}} 元</li>
                </ul>
            </dd>
        </dl>
        {{ }) }}
        {{ if(items.length==0){ }}
        <div class="empty-tip">
            <span class="vvicon">&#xe614;</span>
            <div class="text">
                数据包里还是空的
            </div>
        </div>
        {{ } }}
        <div class="clear"></div>
    </div>
    {{ if(items.length!=0){ }}
    <div class="c-ctrl">
        <a href="javascript:history.go(-1);" class="btn-back">返回上一页</a>
        <a class="btn-create">生成数据包</a></div>
     {{ } }}
</script>

<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    var _IDS = '${param.ids}',
        _IMG = '${param.img}'
    require(['user3/packet_create3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/></body></html>
