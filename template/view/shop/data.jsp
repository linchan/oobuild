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
<div class="w user-w">
    <div class="user-left">
        <jsp:include page="shopnav.jsp">
            <jsp:param name="bigClass" value="3" />
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="main-title">
                档口数据
                <span class="data-tip" id="dataTip" style="display:none;">您的档口在所有档口中排<em id="score"></em>名，在<i id="marketName"></i> <i id="floor"></i> 楼的档口中排在第<em id="rank"></em>名。（档口排名由各项历史数据计算得出，排名靠前有助于提升搜索排名）</span>
            </div>

            <div class="order-main">
                <div class="order-list" id="order-content">
                    <div id="tabDataList">
                    </div>
                    <div class="data-tip-box">
                        <div class="loading3" style="height: 200px;" ></div>
                        <div class="empty-tip" style="">
                            <span class="vvicon">&#xe614;</span>
                            <div class="text">无记录</div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>

<script type="text/x-handlebars-template" id="template">
    <div class="tb-data-box">
        <h2 class="tb-data-title">累计数据<span>从 <em id="dataTime"></em> 开始统计</span></h2>
        <table class="tb-order tb-data">
            <thead>
                <tr>
                    <th width="33%">一键上传</th>
                    <th width="33%">收藏商品</th>
                    <th width="33%">关注档口数</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td id="totalUploadNum">{{= datas.totalUploadNum || 0}}</td>
                    <td id="totalFavItemNum">{{= datas.totalFavItemNum || 0}}</td>
                    <td id="totalFavShopNum">{{= datas.totalFavShopNum || 0}}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="tb-data-box tab-data-day">
        <h2 class="tb-data-title">每日数据</h2>
        <table class="tb-order tb-data">
            <thead>
                <tr>
                    <th width="25%">日期</th>
                    <th width="25%">一键上传</th>
                    <th width="25%">收藏商品</th>
                    <th width="25%">关注档口数</th>
                </tr>
            </thead>
            <tbody>
                {{ _.each(datas.recordList, function(item, index){ }}
                <tr>
                    <td>{{=item.cdate}}</td>
                    <td>{{=item.upload_num}}</td>
                    <td>{{=item.fav_item_num}}</td>
                    <td>{{=item.fav_shop_num}}</td>
                </tr>
                {{ }) }}
            </tbody>
        </table>
    </div>
    <div class="pagination" style="display:none;"></div>

 </script>




<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script>

    require(['shop3/data3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/>
</body>
</html>

