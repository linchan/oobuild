<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
   <meta charset="utf-8">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="renderer" content="webkit">
    <title>出错了 - 搜款网 - 广州最大的网批平台</title>
  <meta name="keywords" content="网店货源,淘宝货源,服装批发,网批,广州服装批发,沙河,一键上传,一件代发,VVIC 搜款网">
  <meta name="description" content="VVIC 搜款网是广州最大的网批平台，覆盖沙河、十三行、白马、解放南等批发市场，提供一键上传、一件代发等功能。找网店货源、淘宝货源，搜款就上搜款网。
  ">
  <link rel="stylesheet" type="text/css" href="${staticDomain}/statics/v2/css/404.css?a99563b98a">
  <link href="${staticDomain}/favicon.ico" type="image/x-icon" rel="shortcut icon">
  </head>
  <body>
    <div class="page-404">
      <div class="w clearfix">
        <div class="bg">
          <div class="bg-round">
            <div class="bg-padding">
              <div class="ico_search"></div>
              <div id="text" class="text">抱歉，<br/> 服务器出错了！</div>
            </div>
          </div>
        </div>
        <div class="btns"><a href="http://wpa.b.qq.com/cgi/wpa.php?ln=1&amp;key=XzgwMDAyNjY5M18zNjE3MDZfODAwMDI2NjkzXzJf" target="_blank" class="btn-default">联系客服</a><a href="/" class="btn-danger">返回搜款网<span id="downcount" class="downcount">(5)</span></a></div>
      </div>
    </div>
    <script>
      (function (win, doc) {
          var count = 5,
                  timer,
                  search = win.location.search,
                  $ = function (str) {
                      return doc.getElementById(str)
                  },
                  getQueryString = function (name) {
                      var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                      var r
                      var href = location.href
                      var index = href.indexOf('?')

                      if (index > href.indexOf('#')) {
                          var search = href.substr(index + 1)
                          r = search.match(reg)
                      } else {
                          r = window.location.search.substr(1).match(reg);
                      }

                      if (r != null) return unescape(r[2]);
                      return null;
                  },
                  index = (getQueryString('t') || 1) - 1


          timer = setInterval(function () {

              if (count == 0) {
                  clearInterval(timer)
                  $('downcount').style.display = 'none'
                  win.location.href = win.location.origin
                  return
              }
              count = count - 1
              $('downcount').innerHTML = '(' + count + ')'

          }, 1000)


      })(this, this.document)
    </script>
  </body>
</html>
