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
            <jsp:param name="bigClass" value="4"/>
        </jsp:include>
    </div>
    <div class="user-main">
        <div class="main-wrap">
            <div class="packet-ctrl">
                <div class="main-title">
                    <div class="fr">
                        <a href="/user/favorite.html?m=1" title="生成数据包" class="p-btn">生成数据包
                        </a>
                    </div>
                    数据包
                </div>

                <div class="vv-msg">
                    <strong>提醒：</strong>
                    数据包必须解压到 C 盘根目录，上传时才不会丢失详情图片。
                    <a href="http://www1.vvic.com/sjbjc.html" title="数据包教程" target="_blank"
                       >查看使用教程 <font class="vvicon">&#xe62d;</font>
                    </a>
                </div>

                <div class="clear"></div>
            </div>

            <div class="packet-list j-list-content">
                <!---->
                <div class="loading3" style="height: 300px;"></div>
            </div>
            <script type="text/x-handlebars-template" id="tpl-item">
                {{ _.each(data, function(item, index){ }}
                <li {{if(index%6==5){}}class="last"{{}}}>
                    <div class="pic">
                        <a target="_blank" title="{{=item.title}}" href="/item/{{=item.item_id}}">
                            <img src="{{=item.pic_url}}_150x150.jpg"/>
                        </a>
                    </div>
                    <div class="text">
                        <a target="_blank" title="{{=item.title}}" href="/item/{{=item.item_id}}">
                            {{=item.title}}
                        </a>
                    </div>
                </li>
                {{ }); }}
            </script>
            <script type="text/x-handlebars-template" id="tpl">
                <table class="p-table">
                    <thead>
                    <tr>
                        <th class="blank"></th>
                        <th class="open"></th>
                        <th class="date">生成时间</th>
                        <th class="amount">商品数量</th>
                        <th class="amount">图片数量</th>
                        <th class="pic">文件大小</th>
                        <th class="ctrl">操作</th>
                        <th class="blank"></th>
                    </tr>
                    </thead>
                    {{ _.each(data, function(el){ }}
                    <tbody style="border-bottom:1px solid #ebebeb">
                    <tr class="j-toggle-more" data-id="{{=el.id}}">
                        <td class="blank"></td>
                        <td class="open">
                            <i class="vvicon plus">&#xe61a;</i>
                            <i class="vvicon minus" >&#xe61d;</i>
                        </td>
                        <td class="date">{{=el.ctime}}</td>
                        <td class="amount">{{=el.success_num}}</td>
                        <td class="amount">{{=el.img_quantity}}</td>
                        <td class="pic">{{- (el.zip_size / (1024 * 1024)).toFixed(2) }} M</td>
                        <td class="ctrl">
                            <a href="{{=el.zip_url}}" download="" target="_blank" title="下载"
                               class="blue-btn j-download">下载
                            </a>
                            <a href="javascript:;" class="blue-btn j-del" data-name="{{=el.zip_name}}">删除</a>
                        </td>
                        <td class="blank"></td>
                    </tr>
                    <tr style="display:none" class="j-items-{{=el.id}}">
                        <td class="blank"></td>
                        <td colspan="6" valign="top">

                            <ul class="item-list j-item-list-{{=el.id}}">
                                <!---->
                            </ul>
                        </td>
                        <td class="blank">
                            <div class="clear"></div>
                        </td>
                    </tr>
                    </tbody>
                    {{ }); }}
                </table>

                {{ if(data.length==0){ }}
                <div class="empty-tip">
                    <span class="vvicon">&#xe614;</span>
                    <div class="text">
                        数据包里还是空的
                    </div>
                </div>
                {{ } else { }}

                {{ } }}
            </script>
        </div>
    </div>
    <div class="clear"></div>
</div>


<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../common/footjs.jsp"/>
<script src="${staticDomain}/statics/lib/avalon/avalon.shim.js"></script>
<script>
    require(['user3/packet3'], function () {
    });
</script>
<jsp:include page="../common/third.jsp"/></body></html>
