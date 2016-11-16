<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="cssName" value="user3"/>
    <jsp:param name="cssHash" value="${cssHash.user3}"/>
    <jsp:param name="headerTitle" value="交易记录"/>
    <jsp:param name="title" value="个人中心"/>
    <jsp:param name="keywords" value="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网"/>
    <jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。"/>
    <jsp:param name="isHome" value="0"/>
    <jsp:param name="headerName" value="user"/>
    <jsp:param name="hideNav" value="1"/>
</jsp:include>
<link href="${staticDomain}/statics/lib/datepick/dp.css" rel="stylesheet" tradeType="text/css" />
<div class="w user-w">
    <c:set var="dateType" value="${param.date==null ? 4 : param.date}"></c:set>
    <c:set var="dataParamPage" value="${param.pageNo==null ? 1 : param.pageNo}"></c:set>
    <c:set var="dataParam" value="date=${dateType}"></c:set>
    <c:if test="${param.startDate!=null && param.endDate != null}">
        <c:set var="dataParam" value="startDate=${param.startDate}&endDate=${param.endDate}"></c:set>
    </c:if>
    <div class="user-left">
        <jsp:include page="usernav.jsp">
            <jsp:param name="bigClass" value="7"/>
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="bill-main">
                <div class="main-bar clearfix ">
                    <div class="fl">交易记录</div>
                    <div class="fr">
                        账户余额：<span class="yuan">¥</span><em id="userMoney">0.00</em>
                        <a style="margin-left:10px;" href="/user/withdraw.html" class="btn btn-red btn-small">提现</a>
                    </div>
                </div>

                <div class="clear"></div>
                <div class="screen">
                    <div class="screen-content">
                        <div class="nav-category clearfix">
                            <div class="nc-key">时间：</div>
                            <div class="order-date-section">
                                <div class="date-select clearfix">
                                    <input tradeType="text" readonly="readonly" class="input-date j-date" id="startDate" placeholder="选择时间">
                                </div>
                                <span class="vvicon split">&#xe61e;</span>
                                <div class="date-select clearfix">
                                    <input tradeType="text" readonly="readonly" class="input-date j-date" id="endDate" placeholder="选择时间">
                                </div>
                                <div class="date-search j-date-search">搜索</div>
                            </div>
                            <div class="nc-value clearfix" style="width: auto;">
                                <div class="types" style="width:520px;padding-left:20px;">
                                    <a <c:if test="${(param.startDate =='' || param.startDate==null) && (param.endDate == ''||param.endDate==null) && param.date==1}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&tradeType=${param.tradeType}&date=1" vda="link|fliter">今天</a>
                                    <a <c:if test="${(param.startDate =='' || param.startDate==null) && (param.endDate == ''||param.endDate==null) && param.date==2}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&tradeType=${param.tradeType}&date=2" vda="link|fliter">昨天</a>
                                    <a <c:if test="${(param.startDate =='' || param.startDate==null) && (param.endDate == ''||param.endDate==null) && param.date==3}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&tradeType=${param.tradeType}&date=3" vda="link|fliter">最近1周</a>
                                    <a <c:if test="${((param.startDate =='' || param.startDate==null) && (param.endDate == ''||param.endDate==null)) && (param.date==4 || param.date=='' || param.date==0 || param.date == null)}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&tradeType=${param.tradeType}&date=4" vda="link|fliter">最近1个月</a>
                                    <a <c:if test="${(param.startDate =='' || param.startDate==null) && (param.endDate == ''||param.endDate==null) && param.date==5}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&tradeType=${param.tradeType}&date=5" vda="link|fliter">最近3个月</a>
                                </div>
                            </div>
                        </div>
                        <div class="nav-category clearfix">
                            <div class="nc-key">分类：</div>
                            <div class="nc-value clearfix" style="width: auto;">
                                <div class="types" style="width:870px;">
                                    <a <c:if test="${param.tradeType==''||param.tradeType==0||param.tradeType==null}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&${dataParam}" vda="link|fliter">全部</a>
                                    <a <c:if test="${param.tradeType==1}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&${dataParam}&tradeType=1" vda="link|fliter">下单</a>
                                    <a <c:if test="${param.tradeType==2}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&${dataParam}&tradeType=2" vda="link|fliter">补差价</a>
                                    <a <c:if test="${param.tradeType==3}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&${dataParam}&tradeType=3" vda="link|fliter">退差价</a>
                                    <a <c:if test="${param.tradeType==4}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&${dataParam}&tradeType=4" vda="link|fliter">退款</a>
                                    <a <c:if test="${param.tradeType==7}">class="selected"</c:if> href="/user/bill.html?tradeStatus=${param.tradeStatus}&${dataParam}&tradeType=7" vda="link|fliter">提现</a>
                                    <a class='j-shop-type <c:if test="${param.tradeType==5}">selected</c:if>' style="display:none;"  href="/user/bill.html?tradeStatus=${param.tradeStatus}&${dataParam}&tradeType=5" vda="link|fliter">卖货</a>
                                    <a class="j-shop-type <c:if test="${param.tradeType==6}">selected</c:if>" style="display:none;" href="/user/bill.html?tradeStatus=${param.tradeStatus}&${dataParam}&tradeType=6" vda="link|fliter">售后</a>
                                </div>
                            </div>
                        </div>
                        <div class="nav-category clearfix">
                            <div class="nc-key">状态：</div>
                            <div class="nc-value clearfix" style="width: auto;">
                                <div class="types" style="width:870px;">
                                    <a <c:if test="${param.tradeStatus==''||param.tradeStatus==0||param.tradeStatus==null}">class="selected"</c:if> href="/user/bill.html?tradeType=${param.tradeType}&${dataParam}" vda="link|fliter">全部</a>
                                    <a <c:if test="${param.tradeStatus==1}">class="selected"</c:if> href="/user/bill.html?tradeType=${param.tradeType}&${dataParam}&tradeStatus=1" vda="link|fliter">进行中</a>
                                    <a <c:if test="${param.tradeStatus==3}">class="selected"</c:if> href="/user/bill.html?tradeType=${param.tradeType}&${dataParam}&tradeStatus=3" vda="link|fliter">支付成功</a>
                                    <a <c:if test="${param.tradeStatus==4}">class="selected"</c:if> href="/user/bill.html?tradeType=${param.tradeType}&${dataParam}&tradeStatus=4" vda="link|fliter">支付失败</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bill-list mt20" id="billContent">
                    <div class="loading3" style="height: 300px"></div>
                    <div class="empty-tip" style="display:none">
                        <i class="vvicon">&#xe614;</i>
                        <div class="text">没有任何记录</div>
                    </div>
                </div>

                <div class="pagination j-pagination" style="padding-bottom: 0;"></div>
            </div>

        </div>
    </div>
    <div class="clear"></div>
</div>

<script type="text/x-handlebars-template" id="itemTemplate">
    <table>
        <thead>
            <tr>
                <th style="width:70px">时间</th>
                <th>名称</th>
                <th>订单号</th>
                <th>金额</th>
                <th>交易流水号</th>
                <th>状态</th>
            </tr>
        </thead>
        <tbody>
        {{var tardeStatusText= ['','进行中','待审核','成功','失败']}}
        {{var payTypeText=['', '支付宝支付', '余额支付', '现金支付', '混合支付']}}
        {{ _.each(listData, function(item, index){ }}
            <tr class="{{if(index%2==0){}}odd{{}else{}}even{{}}}" title="{{if(item.tradeType==7 && item.tradeStatus == 1){}}款项将于提交申请的下一个工作日内到账{{}}}">
                <td class="col-date">
                    {{- _(item.createTime).formatDate('yyyy-MM-dd')}}
                    <p class="date-hm">{{- _(item.createTime).formatDate('hh:mm')}}</p>
                </td>
                <td class="col-info">
                    {{=item.tradeName}}
                    <p class="info-desc">{{=item.tradeBody}}</p>
                </td>
                <td><em>{{=item.orderNo}}</em></td>
                <td>
                    <em class="price">{{=item.processType==2?'-':'+'}}{{=item.amount.toFixed(2)}}</em>
                    <p style="color:#9c9c9c;">{{=payTypeText[item.payType]}}</p>
                </td>
                <td><em>{{=item.payNo}}</em></td>
                <td nowrap="nowrap" class="col-status">
                    {{=tardeStatusText[item.tradeStatus]}}
                    {{ if(item.tradeStatus==4){ }}
                        <p class="fail-reason" data-title="{{=item.tradeMsg?item.tradeMsg:item.adminNote}}" style="color:#9c9c9c;">{{=item.tradeMsg?item.tradeMsg:item.adminNote}}</p>
                    {{ } }}
                </td>
            </tr>
        {{ }) }}
        </tbody>
    </table>
</script>

<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>
    var DATE = '${param.date}'
    var ENDDATE = '${param.endDate}'
    var STARTDATE = '${param.startDate}'
    var PAGENO = '${param.pageNo}'
    require(['user3/bill3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/></body></html>
