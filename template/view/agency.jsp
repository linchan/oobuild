<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="common/header.jsp">
	<jsp:param name="cssName" value="agency3" />
	<jsp:param name="cssHash" value="${cssHash.agency3}" />
 	<jsp:param name="title" value="代发 -" />
	<jsp:param name="keywords" value="国大,大西豪,女人街,国投,富丽,VVIC 搜款网"/>
	<jsp:param name="desc" value="VVIC 搜款网是广州最大的网批平台，覆盖国大、大西豪、女人街、国投、富丽、新金马、大时代、宝华、鞋城、圣迦、佰润、西街、新潮都、非凡、柏美等批发市场。"/>
 	<jsp:param name="currentNav" value="8" />
</jsp:include>

<div class="w clearfix">
    <div class="vv-msg clearfix">
      <div class="txt none">
        <strong>提醒：</strong>VVIC 搜款网只提供代发网站的信息发布及展示，并没有与代发团队形成合作，无法保证代发团队 100% 可靠。寻找代发团队请谨慎分辨，寻求专业、大型的代发，请尽量在 VVIC 搜款网上缴纳保证金的代发团队。如果代发需预存款，只存每次拿货所需的款项，并且选择支付宝担保交易，以确保资金安全。
      </div>
    </div>
    <div class="clearfix"></div>
    <div id="agencyList">
        <div class="loading3" style="height:200px;"></div>
        <script type="text/x-handlebars-template" id="agencyTemplate">
            <dl class="stall-dl">
              <dt class="tline clearfix"><span class="cell addr-cell">代发团队</span><span class="cell name-cell">团队介绍</span><span class="cell type-cell">保证金</span><span class="cell contact-cell">入驻时间</span><span class="cell ctrl-cell">操作</span></dt>

              {{ _.each(list, function(el, index){ }}
              <dd class="dline clearfix"><span class="cell addr-cell">{{=el.title}}</span><span class="cell name-cell">{{=el.intro}}</span><span class="cell type-cell">{{=el.margin=="true" ? ' 已缴纳' : '-'}}</span><span class="cell contact-cell">{{=el.date}}</span><span class="cell ctrl-cell"> <a href="{{=el.url}}" vda="link|content" target="_blank" title="进入官网" class="link">进入官网</a></span></dd>
              {{ }) }}
            </dl>
        </script>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/footjs.jsp"/>
<script>
	var FIXEDAMOUNT = parseInt('${fixed_amount}');

	require(['web3/agency3']);
</script>
<%@ include file="common/third.jsp"%>
</body>
</html>
