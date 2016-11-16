<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../../common/header.jsp">
    <jsp:param name="cssName" value="user3"/>
    <jsp:param name="cssHash" value="${cssHash.user3}"/>
    <jsp:param name="title" value="账户设置"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>

<div class="w user-w">
    <div class="user-left">
        <jsp:include page="../usernav.jsp">
            <jsp:param name="bigClass" value="3"/>
            <jsp:param name="smallClass" value="1"/>
            <jsp:param name="msg" value="2" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="form-main">
                <h2 class="form-title">收货信息</h2>
                <div class="f-wrap">
                    <form name="myForm" id="addressForm">
                    <fieldset class="o-address">
                        <div class="item clearfix">
                            <label><span class="required">*</span>所在地区：</label>
                            <div id="regionBox"></div>
                            <input type="hidden" id="region" name="region" />
                            <div class="address-error" id="unSupportAddress" for="address1">你的收货地址不在配送范围内</div>
                        </div>
                        <div class="item clearfix">
                            <label><span class="required">*</span>详细地址：</label>
                            <input type="text" class="input-address j-input-address" name="address" id="address">
                        </div>
                        <div class="item clearfix" style="display: none;">
                            <label>邮政编码：</label>
                            <input type="zipcode" value="510000" name="zip_code" maxlength="6" id="zip_code">
                        </div>
                        <div class="item clearfix">
                            <label><span class="required">*</span>收货人：</label>
                            <input type="text" name="consignee" id="consignee">
                        </div>
                        <div class="item clearfix">
                            <label><span class="required">*</span>手机号码：</label>
                            <input type="mobile" name="mobile" id="mobile" maxlength="11" class="input-mobile" data-msg-mobile="请填写正确的收货人手机号">
                            <label class="label-tel">固定号码：</label>
                            <input type="text" name="tel1" id="tel1" class="input-area_no j-tel-0" placeholder="区号" maxlength="4">
                            <input type="text" name="tel2" id="tel2" class="input-tel j-tel-1" placeholder="电话号码" maxlength="8">
                            <input type="hidden" class="j-tel" id="telephone" name="telephone">
                        </div>
                        <div class="item clearfix">
                            <label>&nbsp;</label>
                            <i class="vvicon checked j-checkbox" data-value="1" style="display:none;">&#xe627;</i>
                            <i class="vvicon j-checkbox" data-value="0" >&#xe628;</i>
                            设为默认收货地址
                            <input type="hidden" value="0" name="is_default" id="is_default" />
                        </div>
                        <div class="item clearfix">
                            <label>&nbsp;</label>
                            <input type="submit" id="add" class="btn btn-primary" value="新增收货地址" />
                            <input type="button" id="cancel" class="btn btn-default" name="cancel" id="cancel" value="取消" style="margin-left:10px;display: none;">
                            <input type="hidden" id="id" name="id" value="" />
                        </div>
                        <div class="clear"></div>
                    </fieldset>

                    </form>
                </div>

                <p class="address-info">已保存了 <em id="addressCount">0</em> 条地址，还能保存 <em id="addressLeftCount">0</em> 条地址</p>
                <table class="tab tab-address">
                    <thead>
                        <tr>
                            <th width="100" class="tc">收货人</th>
                            <th>所在地区</th>
                            <th>详细地址</th>
                            <th width="100">电话</th>
                            <!-- <th width="80">邮编</th> -->
                            <th width="150">操作</th>
                        </tr>
                    </thead>
                    <tbody id="addressListBody">
                        <tr>
                            <td colspan="6">
                                <div class="loading3" style="height: 100px;"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
    <div class="clear"></div>
</div>


<script type="text/x-handlebars-template" id="addressTpl">
    {{ _.each(addresses, function(item, index){ }}
    <tr data-id="{{=item.id}}">
        <td class="tc">{{=item.consignee}}</td>
        <td>{{=item.country}} {{=item.province}} {{=item.city}} {{=item.area}}</td>
        <td>{{=item.address}}</td>
        <td>
            {{=item.mobile}}
            {{if(item.mobile==''){}}
                {{=item.telephone}}
            {{}}}
        </td>
        <!-- <td>{{=item.zip_code}}</td> -->
        <td>
            {{if(item.is_default){}}
            <a href="javascript:;" class="btn btn-default btn-x-small btn-edit default-address fr">默认地址</a>
            {{}else{}}
            <a href="javascript:;" class="btn btn-primary btn-x-small btn-edit btn-set fr j-address-set">设为默认</a>
            {{}}}
            <a href="javascript:;" class="j-address-edit">修改</a>
            <span class="split">|</span>
            <a href="javascript:;" class="j-address-delete">删除</a>
        </td>
    </tr>
    {{ }) }}
</script>


<jsp:include page="../../common/footer.jsp"/>
<jsp:include page="../../common/footjs.jsp"/>
<script>
    require(['account3/address3'], function(){});
</script>
<jsp:include page="../../common/third.jsp"/></body></html>
