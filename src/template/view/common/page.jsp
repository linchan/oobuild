<%@ page language="java" pageEncoding="UTF-8"%>
<div class="row">
		<div class="col-xs-12">
				<ul class="pager" style="text-align:right">
					<c:if test="${pagination.firstPage}"><li><a style="background-color:#CCD1D9" href="javascript:pageQuery('First')">首页</a></li></c:if>
				    <c:if test="${!pagination.firstPage}"><li><a style="background-color:#CCD1D9">首页</a></li></c:if>
				    <c:if test="${pagination.hasPrePage}"><li><a style="background-color:#CCD1D9" href="javascript:pageQuery('Previous')">上一页</a></li></c:if>
				    <c:if test="${!pagination.hasPrePage}"><li><a style="background-color:#CCD1D9">上一页</a></li></c:if>
				    <c:if test="${pagination.hasNextPage}"><li><a style="background-color:#CCD1D9" href="javascript:pageQuery('Next')">下一页</a></li></c:if>
				    <c:if test="${!pagination.hasNextPage}"><li><a style="background-color:#CCD1D9">下一页</a></li></c:if>
				    <c:if test="${pagination.lastPage}"><li><a style="background-color:#CCD1D9" href="javascript:pageQuery('Last')">尾页</a></li></c:if>
				    <c:if test="${!pagination.lastPage}"><li><a style="background-color:#CCD1D9">尾页</a></li></c:if>
				  	<li style="margin-left: 10px">总记录：<strong style="color:#428bca">${pagination.recordCount }</strong></li>
				  	<li style="margin-left: 10px">页码：<strong style="color:#428bca">${pagination.currentPage }</strong>/<strong style="color:#428bca">${pagination.pageCount }</strong></li>
				  	<li style="margin-left: 10px">转到第</li>
				  	<li><input class="serach-control" id="jumpPageNo"  type="text" value="${pagination.currentPage}" style="width:40px"  maxlength="8" 
				  						onkeypress="return event.keyCode>=48&&event.keyCode<=57"
										onpaste="return !clipboardData.getData('text').match(/\D/)"
										ondragenter="return false" style="ime-mode:Disabled">页</li>
				  	<li><a style="background-color:#CCD1D9" href="javascript:pageQuery('Go')">GO</a></li>
				</ul>
		</div>
</div>

