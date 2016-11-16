<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header_shop">

    <div class="header_inner">
        <div class="w clearfix ">
        <c:if test="${param.regType == 'reg'}">
        <div class="login fr">
            <a href="${basePath}/login.html" vda="link|reg">已有账号，马上登录</a>
        </div>
        </c:if>
            <a href="/" title="搜款网VVIC" class="logo fl">
                <img src="${staticDomain}/statics/v2/css/img/logo/logo_shop.png" alt="">
            </a>

            <div class="stall-head fl">
                <div class="update-head-name">${param.title}</div>
            </div>

            <c:if test="${param.orderStatus > 0}">
                <div class="order-step">
                    <dl <c:if test="${param.orderStatus>0}">class="ready"</c:if>>
                        <dt>
                            下单
                        </dt>
                        <dd><i class="vvicon">&#xe617;</i></dd>
                        <dd class="step-number">1</dd>
                    </dl>
                    <dl <c:if test="${param.orderStatus>1}">class="ready"</c:if>>
                        <dt>
                            付款
                        </dt>
                        <dd><i class="vvicon">&#xe617;</i></dd>
                        <dd class="step-number">2</dd>
                    </dl>
                    <dl <c:if test="${param.orderStatus>2}">class="ready"</c:if>>
                        <dt>
                            拿货
                        </dt>
                        <dd><i class="vvicon">&#xe617;</i></dd>
                        <dd class="step-number">3</dd>
                    </dl>
                    <dl <c:if test="${param.orderStatus>3}">class="ready"</c:if>>
                        <dt>
                            发货
                        </dt>
                        <dd><i class="vvicon">&#xe617;</i></dd>
                        <dd class="step-number">4</dd>
                    </dl>
                </div>
            </c:if>

        </div>
    </div>

</div>
