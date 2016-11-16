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
            <jsp:param name="smallClass" value="2"/>
            <jsp:param name="msg" value="2" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="form-main">
                <h2 class="form-title">发货信息</h2>
                <div class="vv-msg"><strong>通知：</strong>快递单上默认的寄件人和电话会填搜款网仓库的信息，如果有电话打来，我们会说自己是仓库，请联系卖家处理。如果你有特殊要求寄件人打印你的姓名和电话，可以在提交
信息时勾选「使用我的发货信息」，我们可以按照您的要求打印。但是如果曝光在运输中出现任何问题，快递将直接联系你，我们就不知情了，需要你自行处理。</div>
                <div class="f-wrap">
                    <div class="loading3" style="height: 200px;"></div>
                    <form name="myForm" id="addressForm">
                    <fieldset class="o-address">
                        <div class="item clearfix">
                            <label><span class="required">*</span>发货人：</label>
                            <input type="text" name="consignee" id="consignee">
                            <span class="desc">填写真实姓名，否则部分快递拒绝收件</span>
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
                            <input type="submit" id="add" class="btn btn-primary" value="提交" />
                            <input type="hidden" id="id" name="id" value="" />
                            <input type="hidden" id="type" name="type" value="2" />
                        </div>
                        <div class="clear"></div>
                    </fieldset>

                    </form>

                </div>


            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<jsp:include page="../../common/footer.jsp"/>
<jsp:include page="../../common/footjs.jsp"/>
<script>
    require(['account3/addrsend3'], function(){});
</script>
<jsp:include page="../../common/third.jsp"/></body></html>
