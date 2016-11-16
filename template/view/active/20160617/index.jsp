<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<style>
    html,body{

        min-width:1255px;
    }
    .banner {
        width: 100%;
        height: 550px;
        overflow: hidden;
        position: relative;
        background: url(../../static/active/20160617/imgs/banner.jpg) no-repeat center center;
    }

    .banner .link {
        position: absolute;
        width: 146px;
        height: 40px;
        bottom: 20px;
        left: 50%;
        margin-left: 353px;
    }

    .wrap {
        width: 100%;
        background-image: url(../../static/active/20160617/imgs/bg_wrap.jpg);
    }

    .wrap2 {
        width: 100%;
        background: url(../../static/active/20160617/imgs/bg.jpg) center center;
    }

    .auto {
        width: 1255px;
        margin: 0 auto;
        position: relative;
    }

    .rule {
        display: block;
        margin-bottom: -9px;
    }

    .nav-wrap {
        height: 87px;
        margin-bottom: 47px;
        background-image: url(../../static/active/20160617/imgs/bg_nav.jpg);
    }

    .nav {
        margin-left: 170px;
    }

    .nav li {
        margin: 17px 27px 0 0;
        float: left;
        display: inline;
    }

    .nav_item {
        width: 208px;
        height: 61px;
        display: block;
    }

    .nav_item1 {
        background-image: url(../../static/active/20160617/imgs/nav_1.png);
    }

    .nav_item2 {
        background-image: url(../../static/active/20160617/imgs/nav_2.png);
    }

    .nav_item3 {
        background-image: url(../../static/active/20160617/imgs/nav_3.png);
    }

    .nav_item4 {
        background-image: url(../../static/active/20160617/imgs/nav_4.png);
    }

    .active {
        margin-bottom: 47px;
    }

    .active1 {
        height: 1141px;
        background-image: url(../../static/active/20160617/imgs/goods_1.jpg);
    }

    .active2 {
        height: 1376px;
        background-image: url(../../static/active/20160617/imgs/goods_2.jpg);
    }

    .active3 {
        height: 1362px;
        background-image: url(../../static/active/20160617/imgs/goods_3.jpg);
    }

    .active4 {
        height: 1345px;
        background-image: url(../../static/active/20160617/imgs/goods_4.jpg);
    }

    .active .box {
        background-color: #fff;
        position: relative;
    }

    .tc {
        text-align: center;
    }

    .active2_text {
        top: 227px;
        left: 865px;
        width: 396px;
        height: 53px;
        position: absolute;
        background-image: url(../../static/active/20160617/imgs/text_basic.png);
    }
    .active3_text {
        top: 227px;
        left: -41px;
        width: 480px;
        height: 53px;
        position: absolute;
        background-image: url(../../static/active/20160617/imgs/text_summer.png);
    }
    .active4_text {
        top: 227px;
        left: 848px;
        width: 433px;
        height: 53px;
        position: absolute;
        background-image: url(../../static/active/20160617/imgs/text_summer2.png);
    }
    .active .item {
        width: 363px;
        height: 548px;
        overflow: hidden;
        text-indent: -999px;
        position: absolute;
        /*background-color: rgba(255, 0, 0, 0.36);*/
    }

    .active1 .item1 {
        top: 10px;
        left: 425px;
    }

    .active1 .item2 {
        top: 391px;
        left: 33px;
    }

    .active1 .item3 {
        top: 577px;
        left: 471px;
    }

    .active1 .item4 {
        top: 278px;
        left: 855px;
    }

    .active2 .item1 {
        top: 153px;
        left: 33px;
    }

    .active2 .item2 {
        top: 61px;
        left: 465px;
    }

    .active2 .item3 {
        left: 35px;
        top: 777px;
    }

    .active2 .item4 {
        top: 777px;
        left: 450px;
    }

    .active2 .item5 {
        top: 777px;
        left: 862px;
    }

    .active3 .item1 {
        top: 43px;
        left: 434px;
    }

    .active3 .item2 {
        top: 133px;
        left: 861px;
    }

    .active3 .item3 {
        left: 35px;
        top: 765px;
    }

    .active3 .item4 {
        top: 765px;
        left: 450px;
    }

    .active3 .item5 {
        top: 765px;
        left: 862px;
    }

    .active4 .item1 {
        top: 133px;
        left: 33px;
    }

    .active4 .item2 {
        top: 41px;
        left: 455px;
    }

    .active4 .item3 {
        left: 32px;
        top: 747px;
    }

    .active4 .item4 {
        top: 747px;
        left: 448px;
    }

    .active4 .item5 {
        top: 747px;
        left: 862px;
    }

</style>

<div class="wrap">
    <div class="banner">
        <a href="http://www1.vvic.com/skwhd.html" class="link" target="_blank"></a>
    </div>

    <div class="nav-wrap">
        <div class="auto">
            <ul class="nav">
                <li>
                    <a href="#active1" class="nav_item nav_item1"></a>
                </li>
                <li>
                    <a href="#active2" class="nav_item nav_item2"></a>
                </li>
                <li>
                    <a href="#active3" class="nav_item nav_item3"></a>
                </li>
                <li>
                    <a href="#active4" class="nav_item nav_item4"></a>
                </li>
            </ul>
        </div>
    </div>

    <div class="auto tc">
        <img src="../../static/active/20160617/imgs/img_rules.png" alt="" class="rule ">
    </div>

    <div class="active active1 auto" id="active1">
        <a href="http://www.vvic.com/item/2400321?f=/nzc/langdingpage" target="_blank" class="item item1" title="韩版背带连衣裙条纹两件套">韩版背带连衣裙条纹两件套</a>
        <a href="http://www.vvic.com/item/2400367?f=/nzc/langdingpage" target="_blank" class="item item2" title="无袖雪纺衫阔腿套装韩版两件套">无袖雪纺衫阔腿套装韩版两件套</a>
        <a href="http://www.vvic.com/item/2401684?f=/nzc/langdingpage" target="_blank" class="item item3" title="韩版休闲蝴蝶结T恤背带裤套装">韩版休闲蝴蝶结T恤背带裤套装</a>
        <a href="http://www.vvic.com/item/2378492?f=/nzc/langdingpage" target="_blank" class="item item4" title="条纹系带领巾宽松短袖白色连衣裙">条纹系带领巾宽松短袖白色连衣裙</a>
    </div>

</div>
<div class="wrap2">
    <div class="active active2 auto" id="active2">
        <a href="http://www.vvic.com/item/2309285?f=/nzc/langdingpage" target="_blank" class="item item1" title="夏季韩版宽松碎花雪纺衫中长款">夏季韩版宽松碎花雪纺衫中长款</a>
        <a href="http://www.vvic.com/item/1986230?f=/nzc/langdingpage" target="_blank" class="item item2" title="小三角欧美风长袖百搭纯色短袖">小三角欧美风长袖百搭纯色短袖</a>
        <a href="http://www.vvic.com/item/2340840?f=/nzc/langdingpage" target="_blank" class="item item3" title="夏装新款镂空露肩雪纺衫">夏装新款镂空露肩雪纺衫</a>
        <a href="http://www.vvic.com/item/2273392?f=/nzc/langdingpage" target="_blank" class="item item4" title="日系学院风椰树绣花短袖T恤">日系学院风椰树绣花短袖T恤</a>
        <a href="http://www.vvic.com/item/2401861?f=/nzc/langdingpage" target="_blank" class="item item5" title="一字领镂空刺绣蝙蝠袖花边短袖">一字领镂空刺绣蝙蝠袖花边短袖</a>
        <i class="active2_text"></i>
    </div>
    <div class="active active3 auto" id="active3">
        <a href="http://www.vvic.com/item/2401757?f=/nzc/langdingpage" target="_blank" class="item item1" title="韩版吊带内衬蕾丝连衣裙套装">韩版吊带内衬蕾丝连衣裙套装</a>
        <a href="http://www.vvic.com/item/2396569?f=/nzc/langdingpage" target="_blank" class="item item2" title="三色新款露肩黑白撞色连衣裙">三色新款露肩黑白撞色连衣裙</a>
        <a href="http://www.vvic.com/item/2401483?f=/nzc/langdingpage" target="_blank" class="item item3" title="镂空不规则荷叶边半身裙套装">镂空不规则荷叶边半身裙套装</a>
        <a href="http://www.vvic.com/item/2311858?f=/nzc/langdingpage" target="_blank" class="item item4" title="修身淑女雪纺裙子两件套">修身淑女雪纺裙子两件套</a>
        <a href="http://www.vvic.com/item/2262436?f=/nzc/langdingpage" target="_blank" class="item item5" title="清新彩虹吊带背心裙子两件套">清新彩虹吊带背心裙子两件套</a>
        <i class="active3_text"></i>
    </div>
    <div class="active active4 auto" id="active4">
        <a href="http://www.vvic.com/item/2400260?f=/nzc/langdingpage" target="_blank" class="item item1" title="大脚裤阔腿裤女九分裤流苏裤">大脚裤阔腿裤女九分裤流苏裤</a>
        <a href="http://www.vvic.com/item/2400259?f=/nzc/langdingpage" target="_blank" class="item item2" title="流苏高腰牛仔短裤复古休闲短裤">流苏高腰牛仔短裤复古休闲短裤</a>
        <a href="http://www.vvic.com/item/2400278?f=/nzc/langdingpage" target="_blank" class="item item3" title="夏装宽松纯色镂空个性直筒短裤">夏装宽松纯色镂空个性直筒短裤</a>
        <a href="http://www1.vvic.com/skwhd.html" target="_blank" class="item item4" title="学院风高腰黑白色牛仔短裤">学院风高腰黑白色牛仔短裤</a>
        <a href="http://www.vvic.com/item/2319080?f=/nzc/langdingpage" target="_blank" class="item item5" title="高腰休闲百搭宽松麻料黑色阔腿裤a字短裤女">高腰休闲百搭宽松麻料黑色阔腿裤a字短裤女</a>
        <i class="active4_text"></i>
    </div>
</div>