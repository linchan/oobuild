webpackJsonp([0],[
/* 0 */
/***/ function(module, exports, require) {

	var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;/* WEBPACK VAR INJECTION */(function(require, $) {!(__WEBPACK_AMD_DEFINE_ARRAY__ = [require(1), require(3), require(2), require(10), require(7), require(6), require(12), require(13), require(11)], __WEBPACK_AMD_DEFINE_RESULT__ = (function(header, api, common, URLParser) {
	    var p = {
	        timer: {},
	        direction: 1,
	        timeout: 3000
	    }
	    var main = {
	        date: DATE,
	        bid: BID,
	        pid: PID,
	        tcid: TCID,
	        init: function() {
	            var that = this;
	            that.addEvent();
	
	            common.fixLazyload();
	
	            header.clearNewamout() //cgx
	
	            that.renderRecommend();
	            $("#Pagination").pagination(RECORDCOUNT,  {
	                num_edge_entries: 1, //边缘页数
	                callback: that.pageselectCallback,
	                items_per_page: PAGESIZE, //每页显示1项
	                prev_text: "前一页",
	                next_text: "后一页",
	                current_page: CURRENTPAGE - 1 || 0,
	                link_to: "javascript:;"
	            });
	
	            $.cookie('ORDERTYPE', ORDERTYPE, {expires: 365, path:'/'});
	        },
	        addEvent: function() {
	            var that = this;
	            $(document).on('click', '.ctrl .upload', function(){
	                var $this = $(this);
	                common.upFileBox( $this.attr('data-id'), $this.attr('data-vid'));
	            });
	            $(document).on('click', '.ctrl .addFav', function(){
	                var $this = $(this);
	                common.onCollectProduct($this.data('id'));
	            });
	            $(document).on('click', '.ctrl .collect', function(){
	                var id = $(this).attr('data-id');
	                common.onCollectProduct(id);
	            });
	
	            var _currentDay = new Date(DATE);
	            var _startDate = new Date('2015-12-04');
	            var _today = new Date();
	            $("#datetime").datepicker({
	                inputDate: DATE,
	                Month: _currentDay.getMonth() + 1,
	                Year: _currentDay.getFullYear(),
	                Day: _currentDay.getDate(),
	                picker:'.picker',
	                onReturn:function(data){
	                    var url = _WEB_Cfg.domain + "/new/" +data,
	                        _params = that.getUrlParams(),
	                        _paramsArray = []
	                    if((_params.currentPage !=  null && _params.currentPage != '') || _params.currentPage){
	                        delete _params.currentPage;
	                    }
	                    for(p in _params){
	                        if(_params[p] != '')
	                            _paramsArray.push(p+'='+_params[p])
	                    }
	                    if(_paramsArray.length>0){
	                        _paramsArray.unshift('?')
	                    }
	                    location.href = url + _paramsArray.join('&')
	                },
	                applyrule: function(){
	                    return  {
	                        startdate: _startDate,
	                        enddate: _today
	                    }
	                }
	            });
	
	            $("ul.checks li").on('click', function(){
	                var $this = $(this)
	                if($this.hasClass('selected')){
	                    $this.removeClass('selected')
	                }else{
	                     $this.addClass('selected')
	                }
	            })
	
	            $(".btn-service").on('click', function(){
	                var _params = that.getUrlParams(),
	                    _paramsArray = []
	                $('.o-item.service li').each(function(){
	                    var $item = $(this),
	                        serArray = {},
	                        serName = $item.data('name')
	                    if($item.hasClass('selected')){
	                        _params[serName] = '1'
	                    }else{
	                        _params[serName] = ''
	                    }
	                })
	                if((_params.currentPage !=  null && _params.currentPage != '') || _params.currentPage){
	                    delete _params.currentPage;
	                }
	                for(p in _params){
	                    if(_params[p] != '')
	                        _paramsArray.push(p+'='+_params[p])
	                }
	                location.search = _paramsArray.join('&')
	            })
	
	            $(".btn-style").on('click', function(){
	                var _params = that.getUrlParams(),
	                    _paramsArray = [],
	                    _styles = []
	                $('.o-item.styles li.selected span').each(function(){
	                    _styles.push($.trim($(this).text()))
	                })
	                _params.style = _styles.join(',')
	                if((_params.currentPage !=  null && _params.currentPage != '') || _params.currentPage){
	                    delete _params.currentPage;
	                }
	                for(p in _params){
	                    if(_params[p] != '')
	                        _paramsArray.push(p+'='+_params[p])
	                }
	                location.search = _paramsArray.join('&')
	            })
	
	            $(".cancel-service").bind('click', function(){
	                that.clearParams(['is_tx','is_sp','cloud_update','is_df'])
	            })
	            $(".cancel-style").bind('click',function(){
	                that.clearParams(['style'])
	            })
	
	            $(".art-no").bind('dblclick', function(){
	                var _text=$(this).text();
	            })
	
	            $('#fix-box').scrollToFixed();
	
	            $('.conditions li.c-item').on('mouseenter',function(){
	                $(this).addClass('hover')
	            }).on('mouseleave', function(){
	                $(this).removeClass('hover')
	            })
	        },
	        clearParams: function(_keys){
	            var that = this,
	                _params = that.getUrlParams(),
	                _paramsArray = []
	            for(var i=0;i<_keys.length;i++){
	                _params[_keys[i]] = ''
	            }
	            if((_params.currentPage !=  null && _params.currentPage != '') || _params.currentPage){
	                delete _params.currentPage;
	            }
	            for(p in _params){
	                if(_params[p] != '')
	                    _paramsArray.push(p+'='+_params[p])
	            }
	            location.search = _paramsArray.join('&')
	        },
	        renderRecommend: function(){
	            var $selector = $('.hot_goods .page-box')
	            $selector.pagination($('.hot_goods_list .item').length, {
	                current_page: 0,
	                num_edge_entries: 0,
	                items_per_page: 5,
	                num_display_entries: 0,
	                simple: true,
	                prev_text: '<span class="mp-prev vvicon">&#xe611;</span>',
	                next_text: '<span class="mp-next vvicon">&#xe60f;</span>',
	                callback: function (currentPage) {
	                    var $content = $('.hot_goods_list')
	                    $content.find('.data-split.showed').removeClass('showed').fadeOut(500)
	                    $content.find('.data-split').eq(currentPage).addClass('showed').fadeIn(500)
	                    cuvvic.sendShow($content)
	
	                    return false;
	                }
	            })
	
	            // 自动轮播
	            var self = this
	            p.timer = self.selectorSlide($selector, p.direction, p.timeout)
	
	            $('.hot_goods').hover(function(){
	                clearInterval(p.timer)
	            },function(){
	                p.timer = self.selectorSlide($selector, p.direction, p.timeout)
	            })
	        },
	        selectorSlide: function(selector, direction, times) {
	            return setInterval(function(){
	                var $next = $(selector).find('a.next'),
	                    $prev = $(selector).find('a.prev')
	                if(direction==0){
	                    if($prev.length){
	                        $prev.click()
	                    }else{
	                        $next.click()
	                        direction = 1
	                    }
	                }else{
	                    if($next.length){
	                        $next.click()
	                    }else{
	                        $prev.click()
	                        direction = 0
	                    }
	                }
	            }, times || 4000);
	        },
	        pageselectCallback: function(page_index){
	            var _page = parseInt(page_index) + 1,
	                _params = main.getUrlParams(),
	                _paramsArray = []
	            if(_page == CURRENTPAGE)
	                return
	            _params.currentPage = _page
	            for(p in _params){
	                if(_params[p] != '')
	                    _paramsArray.push(p+'='+_params[p])
	            }
	            location.search = _paramsArray.join('&')
	            return
	        },
	        getUrlParams: function(){
	            var _url = new URLParser(location.href),
	                _p = _url.getQuery(),
	                _params = _url._paramValues;
	            return _params
	        }
	    }
	
	    main.init();
	}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));
	
	/* WEBPACK VAR INJECTION */}.call(exports, require, require(9)))

/***/ },
/* 1 */,
/* 2 */,
/* 3 */,
/* 4 */,
/* 5 */,
/* 6 */,
/* 7 */,
/* 8 */,
/* 9 */,
/* 10 */
/***/ function(module, exports, require) {

	var __WEBPACK_AMD_DEFINE_ARRAY__, __WEBPACK_AMD_DEFINE_RESULT__;
	
	!(__WEBPACK_AMD_DEFINE_ARRAY__ = [], __WEBPACK_AMD_DEFINE_RESULT__ = (function() {
	
	    /**
	     * @projectDescription     Poly9's polyvalent URLParser class
	     *
	     * @author    Denis Laprise - denis@poly9.com - http://poly9.com
	     * @version    0.1
	     * @namespace    Poly9
	     *
	     * See the unit test file for more examples.
	     * URLParser is freely distributable under the terms of an MIT-style license.
	     */
	
	    if (typeof Poly9 == 'undefined') {
	        var Poly9 = {};
	    }
	
	    /**
	     * Creates an URLParser instance
	     *
	     * @classDescription    Creates an URLParser instance
	     * @return {Object}    return an URLParser object
	     * @param {String} url    The url to parse
	     * @constructor
	     * @exception {String}  Throws an exception if the specified url is invalid
	     */
	    Poly9.URLParser = function(url) {
	        var _this = this;
	
	        this._fields = {
	            'Username': 4,
	            'Password': 5,
	            'Port': 7,
	            'Protocol': 2,
	            'Host': 6,
	            'Pathname': 8,
	            'URL': 0,
	            'Querystring': 9,
	            'Fragment': 10
	        };
	
	        this._values = {};
	        this._regex = null;
	        this.version = 1;
	        this._regex = /^((\w+):\/\/)?((\w+):?(\w+)?@)?([^\/\?:]+):?(\d+)?(\/?[^\?#]+)?\??([^#]+)?#?(\w*)/;
	        this._paramValues = {};
	        var paramParsed = false;
	
	        for (var f in this._fields) {
	            this['get' + f] = this._makeGetter(f);
	        }
	
	        if (typeof url != 'undefined') {
	            this._parse(url);
	        }
	
	
	        var parseQueryString = function(hash) {
	            if (paramParsed) return _this._paramValues;
	            if (hash == null || hash.length <= 0) return null;
	            var items = hash.split("&"),
	                i, item;
	            for (i = 0, j = items.length; i < j; i++) {
	                item = items[i].split("=");
	                if (item.length === 2 && item[0].length > 0) {
	                    _this._paramValues[item[0]] = decodeURIComponent(item[1]);
	                }
	            }
	            paramParsed = true;
	            return _this._paramValues;
	        };
	
	        this.getQuery = function(key) {
	            var param = parseQueryString(_this.getQuerystring());
	            if (param == null) return null;
	            return param[key];
	        };
	    };
	
	    /**
	     * @method
	     * @param {String} url    The url to parse
	     * @exception {String}     Throws an exception if the specified url is invalid
	     */
	    Poly9.URLParser.prototype.setURL = function(url) {
	        this._parse(url);
	    };
	
	    Poly9.URLParser.prototype._initValues = function() {
	        for (var f in this._fields) {
	            this._values[f] = '';
	        }
	    };
	
	    Poly9.URLParser.prototype._parse = function(url) {
	        this._initValues();
	        var r = this._regex.exec(url);
	        if (!r) throw "DPURLParser::_parse -> Invalid URL";
	
	        for (var f in this._fields)
	            if (typeof r[this._fields[f]] != 'undefined') {
	                this._values[f] = r[this._fields[f]];
	            }
	    };
	
	    Poly9.URLParser.prototype._makeGetter = function(field) {
	        return function() {
	            return this._values[field];
	        };
	    };
	
	    return Poly9.URLParser
	}.apply(null, __WEBPACK_AMD_DEFINE_ARRAY__)), __WEBPACK_AMD_DEFINE_RESULT__ !== undefined && (module.exports = __WEBPACK_AMD_DEFINE_RESULT__));


/***/ },
/* 11 */,
/* 12 */
/***/ function(module, exports, require) {

	/* WEBPACK VAR INJECTION */(function(require, jQuery) {; (function($) {
	    if (!dateFormat || typeof (dateFormat) != "function") {
	        var dateFormat = function(format) {
	            var o = {
	                "M+": this.getMonth() + 1,
	                "d+": this.getDate(),
	                "h+": this.getHours(),
	                "H+": this.getHours(),
	                "m+": this.getMinutes(),
	                "s+": this.getSeconds(),
	                "q+": Math.floor((this.getMonth() + 3) / 3),
	                "w": "0123456".indexOf(this.getDay()),
	                "S": this.getMilliseconds()
	            };
	            if (/(y+)/.test(format)) {
	                format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	            }
	            for (var k in o) {
	                if (new RegExp("(" + k + ")").test(format))
	                    format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
	            }
	            return format;
	        };
	    }
	    if (!DateAdd || typeof (DateDiff) != "function") {
	        var DateAdd = function(interval, number, idate) {
	            number = parseInt(number);
	            var date;
	            if (typeof (idate) == "string") {
	                date = idate.split(/\D/);
	                eval("var date = new Date(" + date.join(",") + ")");
	            }
	            if (typeof (idate) == "object") {
	                date = new Date(idate.toString());
	            }
	            switch (interval) {
	                case "y": date.setFullYear(date.getFullYear() + number); break;
	                case "m": date.setMonth(date.getMonth() + number); break;
	                case "d": date.setDate(date.getDate() + number); break;
	                case "w": date.setDate(date.getDate() + 7 * number); break;
	                case "h": date.setHours(date.getHours() + number); break;
	                case "n": date.setMinutes(date.getMinutes() + number); break;
	                case "s": date.setSeconds(date.getSeconds() + number); break;
	                case "l": date.setMilliseconds(date.getMilliseconds() + number); break;
	            }
	            return date;
	        }
	    }
	    if (!DateDiff || typeof (DateDiff) != "function") {
	        var DateDiff = function(interval, d1, d2) {
	            switch (interval) {
	                case "d": //date
	                case "w":
	                    d1 = new Date(d1.getFullYear(), d1.getMonth(), d1.getDate());
	                    d2 = new Date(d2.getFullYear(), d2.getMonth(), d2.getDate());
	                    break;  //w
	                case "h":
	                    d1 = new Date(d1.getFullYear(), d1.getMonth(), d1.getDate(), d1.getHours());
	                    d2 = new Date(d2.getFullYear(), d2.getMonth(), d2.getDate(), d2.getHours());
	                    break; //h
	                case "n":
	                    d1 = new Date(d1.getFullYear(), d1.getMonth(), d1.getDate(), d1.getHours(), d1.getMinutes());
	                    d2 = new Date(d2.getFullYear(), d2.getMonth(), d2.getDate(), d2.getHours(), d2.getMinutes());
	                    break;
	                case "s":
	                    d1 = new Date(d1.getFullYear(), d1.getMonth(), d1.getDate(), d1.getHours(), d1.getMinutes(), d1.getSeconds());
	                    d2 = new Date(d2.getFullYear(), d2.getMonth(), d2.getDate(), d2.getHours(), d2.getMinutes(), d2.getSeconds());
	                    break;
	            }
	            var t1 = d1.getTime(), t2 = d2.getTime();
	            var diff = NaN;
	            switch (interval) {
	                case "y": diff = d2.getFullYear() - d1.getFullYear(); break; //y
	                case "m": diff = (d2.getFullYear() - d1.getFullYear()) * 12 + d2.getMonth() - d1.getMonth(); break;    //m
	                case "d": diff = Math.floor(t2 / 86400000) - Math.floor(t1 / 86400000); break;
	                case "w": diff = Math.floor((t2 + 345600000) / (604800000)) - Math.floor((t1 + 345600000) / (604800000)); break; //w
	                case "h": diff = Math.floor(t2 / 3600000) - Math.floor(t1 / 3600000); break; //h
	                case "n": diff = Math.floor(t2 / 60000) - Math.floor(t1 / 60000); break; //
	                case "s": diff = Math.floor(t2 / 1000) - Math.floor(t1 / 1000); break; //s
	                case "l": diff = t2 - t1; break;
	            }
	            return diff;
	
	        }
	    }
	    var userAgent = window.navigator.userAgent.toLowerCase();
	    $.browser.msie8 = $.browser.msie && /msie 8\.0/i.test(userAgent);
	    $.browser.msie7 = $.browser.msie && /msie 7\.0/i.test(userAgent);
	    $.browser.msie6 = !$.browser.msie8 && !$.browser.msie7 && $.browser.msie && /msie 6\.0/i.test(userAgent);
	    if ($.fn.noSelect == undefined) {
	        $.fn.noSelect = function(p) { //no select plugin by me :-)
	            if (p == null)
	                prevent = true;
	            else
	                prevent = p;
	            if (prevent) {
	                return this.each(function() {
	                    if ($.browser.msie || $.browser.safari) $(this).bind('selectstart', function() { return false; });
	                    else if ($.browser.mozilla) {
	                        $(this).css('MozUserSelect', 'none');
	                        $('body').trigger('focus');
	                    }
	                    else if ($.browser.opera) $(this).bind('mousedown', function() { return false; });
	                    else $(this).attr('unselectable', 'on');
	                });
	
	            } else {
	                return this.each(function() {
	                    if ($.browser.msie || $.browser.safari) $(this).unbind('selectstart');
	                    else if ($.browser.mozilla) $(this).css('MozUserSelect', 'inherit');
	                    else if ($.browser.opera) $(this).unbind('mousedown');
	                    else $(this).removeAttr('unselectable', 'on');
	                });
	
	            }
	        }; //end noSelect
	    };
	    $.fn.datepicker = function(o) {
	        var def = {
	            weekStart: 0,
	            weekName: ["日", "一", "二", "三", "四", "五", "六"], //week language support
	            monthName: ["一","二","三","四","五","六","七","八","九","十","十一","十二"],
	            monthp: '月',
	            Year: new Date().getFullYear(), //default year
	            Month: new Date().getMonth() + 1, //default month
	            Day: new Date().getDate(), //default date
	            today: new Date(),
	            btnOk: ' 确定 ',
	            btnCancel: ' 取消 ',
	            btnToday: ' 今天 ',
	            inputDate: null,
	            onReturn: false,
	            version: "1.1",
	            applyrule: false, //function(){};return rule={startdate,endate};
	            showtarget: null,
	            picker: "",
	            event: "hover",
	            callback: function(){}
	        };
	        $.extend(def, o);
	        var cp = $("#BBIT_DP_CONTAINER");
	        if (cp.length == 0) {
	            var cpHA = [];
	            cpHA.push("<div id='BBIT_DP_CONTAINER' class='bbit-dp' style='width:175px;z-index:999;'>");
	            if ($.browser.msie6) {
	                cpHA.push('<iframe style="position:absolute;z-index:-1;width:100%;height:205px;top:0;left:0;scrolling:no;" frameborder="0" src="about:blank"></iframe>');
	            }
	            cpHA.push("<table class='dp-maintable' cellspacing='0' cellpadding='0' style='width:175px;'><tbody><tr><td>");
	            //caption bar goes here
	            cpHA.push("<table class='bbit-dp-top' cellspacing='0'><tr><td class='bbit-dp-top-left'> <a id='BBIT_DP_LEFTBTN' href='javascript:void(0);' title='", "上一月", "' class='vvicon'>&#xe611;</a></td><td class='bbit-dp-top-center' align='center'><em><button id='BBIT_DP_YMBTN'></button></em></td><td class='bbit-dp-top-right'><a id='BBIT_DP_RIGHTBTN' href='javascript:void(0);' title='", "下一月", "' class='vvicon'>&#xe60f;</a></td></tr></table>");
	            cpHA.push("</td></tr>");
	            cpHA.push("<tr><td>");
	            //week
	            cpHA.push("<table id='BBIT_DP_INNER' class='bbit-dp-inner' cellspacing='0'><thead><tr>");
	            //calculat for week
	            for (var i = def.weekStart, j = 0; j < 7; j++) {
	                cpHA.push("<th><span>", def.weekName[i], "</span></th>");
	                if (i == 6) { i = 0; } else { i++; }
	            }
	            cpHA.push("</tr></thead>");
	            //to generat tBody, everything need to rebuilt
	            cpHA.push("<tbody></tbody></table>");
	            //end tbody
	            cpHA.push("</td></tr>");
	            // cpHA.push("<tr><td class='bbit-dp-bottom' align='center'><button id='BBIT-DP-TODAY'>", def.btnToday, "</button></td></tr>");
	            cpHA.push("</tbody></table>");
	            //for drop down to select year & month
	            cpHA.push("<div id='BBIT-DP-MP' class='bbit-dp-mp'  style='z-index:auto;'><table id='BBIT-DP-T' style='width: 175px; height: 193px' border='0' cellspacing='0'><tbody>");
	            cpHA.push("<tr>");
	            //tow buttons for Jan & Jul
	            cpHA.push("<td class='bbit-dp-mp-month' xmonth='0'><a href='javascript:void(0);'>", def.monthName[0], "</a></td><td class='bbit-dp-mp-month bbit-dp-mp-sep' xmonth='6'><a href='javascript:void(0);'>", def.monthName[6], "</a></td><td class='bbit-dp-mp-ybtn' align='middle'><a id='BBIT-DP-MP-PREV' class='bbit-dp-mp-prev'></a></td><td class='bbit-dp-mp-ybtn' align='middle'><a id='BBIT-DP-MP-NEXT' class='bbit-dp-mp-next'></a></td>");
	            cpHA.push("</tr>");
	            cpHA.push("<tr>");
	            cpHA.push("<td class='bbit-dp-mp-month' xmonth='1'><a href='javascript:void(0);'>", def.monthName[1], "</a></td><td class='bbit-dp-mp-month bbit-dp-mp-sep' xmonth='7'><a href='javascript:void(0);'>", def.monthName[7], "</a></td><td class='bbit-dp-mp-year'><a href='javascript:void(0);'></a></td><td class='bbit-dp-mp-year'><a href='javascript:void(0);'></a></td>");
	            cpHA.push("</tr>");
	            cpHA.push("<tr>");
	            cpHA.push("<td class='bbit-dp-mp-month' xmonth='2'><a href='javascript:void(0);'>", def.monthName[2], "</a></td><td class='bbit-dp-mp-month bbit-dp-mp-sep' xmonth='8'><a href='javascript:void(0);'>", def.monthName[8], "</a></td><td class='bbit-dp-mp-year'><a href='javascript:void(0);'></a></td><td class='bbit-dp-mp-year'><a href='javascript:void(0);'></a></td>");
	            cpHA.push("</tr>");
	            cpHA.push("<tr>");
	            cpHA.push("<td class='bbit-dp-mp-month' xmonth='3'><a href='javascript:void(0);'>", def.monthName[3], "</a></td><td class='bbit-dp-mp-month bbit-dp-mp-sep' xmonth='9'><a href='javascript:void(0);'>", def.monthName[9], "</a></td><td class='bbit-dp-mp-year'><a href='javascript:void(0);'></a></td><td class='bbit-dp-mp-year'><a href='javascript:void(0);'></a></td>");
	            cpHA.push("</tr>");
	
	            cpHA.push("<tr>");
	            cpHA.push("<td class='bbit-dp-mp-month' xmonth='4'><a href='javascript:void(0);'>", def.monthName[4], "</a></td><td class='bbit-dp-mp-month bbit-dp-mp-sep' xmonth='10'><a href='javascript:void(0);'>", def.monthName[10], "</a></td><td class='bbit-dp-mp-year'><a href='javascript:void(0);'></a></td><td class='bbit-dp-mp-year'><a href='javascript:void(0);'></a></td>");
	            cpHA.push("</tr>");
	
	            cpHA.push("<tr>");
	            cpHA.push("<td class='bbit-dp-mp-month' xmonth='5'><a href='javascript:void(0);'>", def.monthName[5], "</a></td><td class='bbit-dp-mp-month bbit-dp-mp-sep' xmonth='11'><a href='javascript:void(0);'>", def.monthName[11], "</a></td><td class='bbit-dp-mp-year'><a href='javascript:void(0);'></a></td><td class='bbit-dp-mp-year'><a href='javascript:void(0);'></a></td>");
	            cpHA.push("</tr>");
	            cpHA.push("<tr class='bbit-dp-mp-btns'>");
	            cpHA.push("<td colspan='4'><button id='BBIT-DP-MP-OKBTN' class='bbit-dp-mp-ok'>", def.btnOk, "</button><button id='BBIT-DP-MP-CANCELBTN' class='bbit-dp-mp-cancel'>", def.btnCancel, "</button></td>");
	            cpHA.push("</tr>");
	
	            cpHA.push("</tbody></table>");
	            cpHA.push("</div>");
	            cpHA.push("</div>");
	
	            var s = cpHA.join("");
	            if(def.event=='hover'){
	                $("#datetime").append(s);
	            }else{
	                $(document.body).append(s);
	            }
	            cp = $("#BBIT_DP_CONTAINER");
	
	            initevents();
	        }
	        function initevents() {
	            //1 today btn;
	            // $("#BBIT-DP-TODAY").click(returntoday);
	            cp.click(returnfalse);
	            $("#BBIT_DP_INNER tbody").click(tbhandler);
	            $("#BBIT_DP_LEFTBTN").click(prevm);
	            $("#BBIT_DP_RIGHTBTN").click(nextm);
	            // $("#BBIT_DP_YMBTN").click(showym);
	            $("#BBIT-DP-MP").click(mpclick).dblclick(mpdblclick);
	
	            $("#BBIT-DP-MP-PREV").click(mpprevy);
	            $("#BBIT-DP-MP-NEXT").click(mpnexty);
	            $("#BBIT-DP-MP-OKBTN").click(mpok);
	            $("#BBIT-DP-MP-CANCELBTN").click(mpcancel);
	        }
	        function mpcancel() {
	            $("#BBIT-DP-MP").animate({ top: -193 }, { duration: 200, complete: function() { $("#BBIT-DP-MP").hide(); } });
	            return false;
	        }
	        function mpok() {
	            def.Year = def.cy;
	            def.Month = def.cm + 1;
	            def.Day = 1;
	            $("#BBIT-DP-MP").animate({ top: -193 }, { duration: 200, complete: function() { $("#BBIT-DP-MP").hide(); } });
	            writecb();
	            return false;
	        }
	        function mpprevy() {
	            var y = def.ty - 10
	            def.ty = y;
	            rryear(y);
	            return false;
	        }
	        function mpnexty() {
	            var y = def.ty + 10
	            def.ty = y;
	            rryear(y);
	            return false;
	        }
	        function rryear(y) {
	            var s = y - 4;
	            var ar = [];
	            for (var i = 0; i < 5; i++) {
	                ar.push(s + i);
	                ar.push(s + i + 5);
	            }
	            $("#BBIT-DP-MP td.bbit-dp-mp-year").each(function(i) {
	                if (def.Year == ar[i]) {
	                    $(this).addClass("bbit-dp-mp-sel");
	                }
	                else {
	                    $(this).removeClass("bbit-dp-mp-sel");
	                }
	                $(this).html("<a href='javascript:void(0);'>" + ar[i] + "</a>").attr("xyear", ar[i]);
	            });
	        }
	        function mpdblclick(e) {
	            var et = e.target || e.srcElement;
	            var td = getTd(et);
	            if (td == null) {
	                return false;
	            }
	            if ($(td).hasClass("bbit-dp-mp-month") || $(td).hasClass("bbit-dp-mp-year")) {
	                mpok(e);
	            }
	            return false;
	        }
	        function mpclick(e) {
	            var panel = $(this);
	            var et = e.target || e.srcElement;
	            var td = getTd(et);
	            if (td == null) {
	                return false;
	            }
	            if ($(td).hasClass("bbit-dp-mp-month")) {
	                if (!$(td).hasClass("bbit-dp-mp-sel")) {
	                    var ctd = panel.find("td.bbit-dp-mp-month.bbit-dp-mp-sel");
	                    if (ctd.length > 0) {
	                        ctd.removeClass("bbit-dp-mp-sel");
	                    }
	                    $(td).addClass("bbit-dp-mp-sel")
	                    def.cm = parseInt($(td).attr("xmonth"));
	                }
	            }
	            if ($(td).hasClass("bbit-dp-mp-year")) {
	                if (!$(td).hasClass("bbit-dp-mp-sel")) {
	                    var ctd = panel.find("td.bbit-dp-mp-year.bbit-dp-mp-sel");
	                    if (ctd.length > 0) {
	                        ctd.removeClass("bbit-dp-mp-sel");
	                    }
	                    $(td).addClass("bbit-dp-mp-sel")
	                    def.cy = parseInt($(td).attr("xyear"));
	                }
	            }
	            return false;
	        }
	        function showym() {
	            var mp = $("#BBIT-DP-MP");
	            var y = def.Year;
	            def.cy = def.ty = y;
	            var m = def.Month - 1;
	            def.cm = m;
	            var ms = $("#BBIT-DP-MP td.bbit-dp-mp-month");
	            for (var i = ms.length - 1; i >= 0; i--) {
	                var ch = $(ms[i]).attr("xmonth");
	                if (ch == m) {
	                    $(ms[i]).addClass("bbit-dp-mp-sel");
	                }
	                else {
	                    $(ms[i]).removeClass("bbit-dp-mp-sel");
	                }
	            }
	            rryear(y);
	            mp.css("top", -193).show().animate({ top: 0 }, { duration: 200 });
	        }
	        function getTd(elm) {
	            if (elm.tagName.toUpperCase() == "TD") {
	                return elm;
	            }
	            else if (elm.tagName.toUpperCase() == "BODY") {
	                return null;
	            }
	            else {
	                var p = $(elm).parent();
	                if (p.length > 0) {
	                    if (p[0].tagName.toUpperCase() != "TD") {
	                        return getTd(p[0]);
	                    }
	                    else {
	                        return p[0];
	                    }
	                }
	            }
	            return null;
	        }
	        function tbhandler(e) {
	            var et = e.target || e.srcElement;
	            var td = getTd(et);
	            if (td == null) {
	                return false;
	            }
	            var $td = $(td);
	            if (!$(td).hasClass("bbit-dp-disabled")) {
	                var s = $td.attr("xdate");
	                cp.data("indata",stringtodate(s));
	                returndate();
	            }
	            return false;
	        }
	        function returnfalse() {
	            return false;
	        }
	
	        function stringtodate(datestr) {
	            try
	            {
	                var arrs = datestr.split('-');
	                var year = parseInt(arrs[0]);
	                var month = parseInt(arrs[1]) - 1;
	                var day = parseInt(arrs[2]);
	                return new Date(year, month, day);
	            }
	            catch(e)
	            {
	             return null;
	            }
	        }
	        function prevm() {
	            if (def.Month == 1) {
	                def.Year--;
	                def.Month = 12;
	            }
	            else {
	                def.Month--
	            }
	            writecb();
	            return false;
	        }
	        function nextm() {
	            if (def.Month == 12) {
	                def.Year++;
	                def.Month = 1;
	            }
	            else {
	                def.Month++
	            }
	            writecb();
	            return false;
	        }
	        function returntoday() {
	            cp.data("indata", new Date());
	            returndate();
	        }
	        function returndate() {
	            var ct = cp.data("ctarget");
	            var ck = cp.data("cpk");
	            var re = cp.data("onReturn");
	            var ndate = cp.data("indata")
	            var ads = cp.data("ads");
	            var ade = cp.data("ade");
	            var dis = false;
	            if (ads && ndate < ads) {
	                dis = true;
	            }
	            if (ade && ndate > ade) {
	                dis = true;
	            }
	            if (dis) {
	                return;
	            }
	            if (re && jQuery.isFunction(re)) {
	                re.call(ct[0], dateFormat.call(cp.data("indata"), 'yyyy-MM-dd'));
	            }else if(ct){
	                ct.val(dateFormat.call(cp.data("indata"), 'yyyy-MM-dd'));
	            }
	            ck.attr("isshow", "0");
	            cp.removeData("ctarget").removeData("cpk").removeData("indata").removeData("onReturn")
	            .removeData("ads").removeData("ade");
	            cp.css("visibility", "hidden");
	            ct = ck = null;
	            def.callback();
	        }
	        function writecb() {
	            var tb = $("#BBIT_DP_INNER tbody");
	            $("#BBIT_DP_YMBTN").html(def.Year + '年' + def.Month + '月');
	            var firstdate = new Date(def.Year, def.Month - 1, 1);
	
	            var diffday = def.weekStart - firstdate.getDay();
	            var showmonth = def.Month - 1;
	            if (diffday > 0) {
	                diffday -= 7;
	            }
	            var startdate = DateAdd("d", diffday, firstdate);
	            var enddate = DateAdd("d", 42, startdate);
	            var ads = cp.data("ads");
	            var ade = cp.data("ade");
	            var bhm = [];
	            var tds = dateFormat.call(def.today, 'yyyy-MM-dd');
	            var indata = cp.data("indata");
	            var ins = indata != null ? dateFormat.call(indata, 'yyyy-MM-dd') : "";
	            for (var i = 1; i <= 42; i++) {
	                if (i % 7 == 1) {
	                    bhm.push("<tr>");
	                }
	                var ndate = DateAdd("d", i - 1, startdate);
	                var tdc = [];
	                var dis = false;
	                if (ads && ndate < ads) {
	                    dis = true;
	                }
	                if (ade && ndate > ade) {
	                    dis = true;
	                }
	                if (ndate.getMonth() < showmonth) {
	                    tdc.push("bbit-dp-prevday");
	                }else if (ndate.getMonth() > showmonth) {
	                    tdc.push("bbit-dp-nextday");
	                }
	
	                if (dis) {
	                    tdc.push("bbit-dp-disabled");
	                }else {
	                    tdc.push("bbit-dp-active");
	                }
	
	                var s = dateFormat.call(ndate, 'yyyy-MM-dd');
	                if (s == tds) {
	                    tdc.push("bbit-dp-today");
	                }
	                if (s == ins) {
	                    tdc.push("bbit-dp-selected");
	                }
	
	                bhm.push("<td class='", tdc.join(" "), "' title='", dateFormat.call(ndate, 'yyyy-MM-dd'), "' xdate='", dateFormat.call(ndate, 'yyyy-MM-dd'), "'><a href='javascript:void(0);'><em><span>", ndate.getDate(), "</span></em></a></td>");
	                if (i % 7 == 0) {
	                    bhm.push("</tr>");
	                }
	            }
	            tb.html(bhm.join(""));
	        }
	        return $(this).each(function() {
	            var obj = $(this).addClass("bbit-dp-input"),
	                picker = $(def.picker),
	                _event = def.event
	            if(_event != 'hover'){
	                def.showtarget == null && obj.after(picker);
	            }
	            picker.on(_event, function(e) {
	                var isshow = $(this).attr("isshow");
	                //hide it initially
	                var me = $(this);
	                if (cp.css("visibility") == "visible") {
	                    cp.css(" visibility", "hidden");
	                }
	                if (isshow == "1") {
	                    me.attr("isshow", "0");
	                    cp.removeData("ctarget").removeData("cpk").removeData("indata").removeData("onReturn");
	                    return false;
	                }
	                var v = obj.val();
	                if(_event=='hover'){
	                    v = obj.data('cdata')
	                }
	                if (v != "") {
	                    v = stringtodate(v);
	                }
	                if (v == null || v == "") {
	                    def.Year = new Date().getFullYear();
	                    def.Month = new Date().getMonth() + 1;
	                    def.Day = new Date().getDate();
	                    def.inputDate = null
	                }else {
	                    def.Year = v.getFullYear();
	                    def.Month =v.getMonth() + 1;
	                    def.Day = v.getDate();
	                    def.inputDate = v;
	                }
	                cp.data("ctarget", obj).data("cpk", me).data("indata", def.inputDate).data("onReturn", def.onReturn);
	                if (def.applyrule && $.isFunction(def.applyrule)) {
	                    var rule = def.applyrule.call(obj, obj[0].id);
	                    if (rule) {
	                        if (rule.startdate) {
	                            cp.data("ads", rule.startdate);
	                        }
	                        else {
	                            cp.removeData("ads");
	                        }
	                        if (rule.enddate) {
	                            cp.data("ade", rule.enddate);
	                        }
	                        else {
	                            cp.removeData("ade");
	                        }
	                    }
	                }
	                else {
	                    cp.removeData("ads").removeData("ade")
	                }
	                writecb();
	
	
	                $("#BBIT-DP-T").height(cp.height());
	                var t = def.showtarget || obj;
	                var pos = t.offset();
	
	                var height = t.outerHeight();
	                var newpos = { left: pos.left, top: pos.top + height };
	                if(_event == 'hover'){
	                    newpos = { left: -1, top: height }
	                }
	                var w = cp.width();
	                var h = cp.height();
	                var bw = document.documentElement.clientWidth;
	                var bh = document.documentElement.clientHeight;
	                if ((newpos.left + w) >= bw) {
	                    newpos.left = bw - w - 2;
	                }
	                if ((newpos.top + h) >= bh) {
	                    newpos.top = pos.top - h - 2;
	                }
	                if (newpos.left < (_event=='hover'?-1:0)) {
	                    newpos.left = 10;
	                }
	                if (newpos.top < 0) {
	                    newpos.top = 10;
	                }
	                $("#BBIT-DP-MP").hide();
	                newpos.visibility = "visible";
	                cp.css(newpos);
	
	                if(_event=='hover'){
	                    $(this).attr("isshow", "1");
	                }else{
	                    $(document).one("click", function(e) {
	                        me.attr("isshow", "0");
	                        cp.removeData("ctarget").removeData("cpk").removeData("indata");
	                        cp.css("visibility", "hidden");
	                    });
	                }
	
	
	
	                return false;
	            })
	            if(_event == 'hover'){
	                picker.mouseleave(function(event) {
	                    $(this).attr("isshow", "0");
	                    cp.removeData("ctarget").removeData("cpk").removeData("indata");
	                    cp.css("visibility", "hidden");
	                });
	            }
	        });
	    };
	})(jQuery);
	
	/* WEBPACK VAR INJECTION */}.call(exports, require, require(9)))

/***/ },
/* 13 */
/***/ function(module, exports, require) {

	/* WEBPACK VAR INJECTION */(function(require, jQuery) {
	(function(a){a.isScrollToFixed=function(b){return !!a(b).data("ScrollToFixed")};a.ScrollToFixed=function(d,i){var m=this;m.$el=a(d);m.el=d;m.$el.data("ScrollToFixed",m);var c=false;var H=m.$el;var I;var F;var k;var e;var z;var E=0;var r=0;var j=-1;var f=-1;var u=null;var A;var g;function v(){H.trigger("preUnfixed.ScrollToFixed");l();H.trigger("unfixed.ScrollToFixed");f=-1;E=H.offset().top;r=H.offset().left;if(m.options.offsets){r+=(H.offset().left-H.position().left)}if(j==-1){j=r}I=H.css("position");c=true;if(m.options.bottom!=-1){H.trigger("preFixed.ScrollToFixed");x();H.trigger("fixed.ScrollToFixed")}}function o(){var J=m.options.limit;if(!J){return 0}if(typeof(J)==="function"){return J.apply(H)}return J}function q(){return I==="fixed"}function y(){return I==="absolute"}function h(){return !(q()||y())}function x(){if(!q()){var J=H[0].getBoundingClientRect();u.css({display:H.css("display"),width:J.width,height:J.height,"float":H.css("float")});cssOptions={"z-index":m.options.zIndex,position:"fixed",top:m.options.bottom==-1?t():"",bottom:m.options.bottom==-1?"":m.options.bottom,"margin-left":"0px"};if(!m.options.dontSetWidth){cssOptions.width=H.css("width")}H.css(cssOptions);H.addClass(m.options.baseClassName);if(m.options.className){H.addClass(m.options.className)}I="fixed"}}function b(){var K=o();var J=r;if(m.options.removeOffsets){J="";K=K-E}cssOptions={position:"absolute",top:K,left:J,"margin-left":"0px",bottom:""};if(!m.options.dontSetWidth){cssOptions.width=H.css("width")}H.css(cssOptions);I="absolute"}function l(){if(!h()){f=-1;u.css("display","none");H.css({"z-index":z,width:"",position:F,left:"",top:e,"margin-left":""});H.removeClass("scroll-to-fixed-fixed");if(m.options.className){H.removeClass(m.options.className)}I=null}}function w(J){if(J!=f){H.css("left",r-J);f=J}}function t(){var J=m.options.marginTop;if(!J){return 0}if(typeof(J)==="function"){return J.apply(H)}return J}function B(){if(!a.isScrollToFixed(H)||H.is(":hidden")){return}var M=c;var L=h();if(!c){v()}else{if(h()){E=H.offset().top;r=H.offset().left}}var J=a(window).scrollLeft();var N=a(window).scrollTop();var K=o();if(m.options.minWidth&&a(window).width()<m.options.minWidth){if(!h()||!M){p();H.trigger("preUnfixed.ScrollToFixed");l();H.trigger("unfixed.ScrollToFixed")}}else{if(m.options.maxWidth&&a(window).width()>m.options.maxWidth){if(!h()||!M){p();H.trigger("preUnfixed.ScrollToFixed");l();H.trigger("unfixed.ScrollToFixed")}}else{if(m.options.bottom==-1){if(K>0&&N>=K-t()){if(!L&&(!y()||!M)){p();H.trigger("preAbsolute.ScrollToFixed");b();H.trigger("unfixed.ScrollToFixed")}}else{if(N>=E-t()){if(!q()||!M){p();H.trigger("preFixed.ScrollToFixed");x();f=-1;H.trigger("fixed.ScrollToFixed")}w(J)}else{if(!h()||!M){p();H.trigger("preUnfixed.ScrollToFixed");l();H.trigger("unfixed.ScrollToFixed")}}}}else{if(K>0){if(N+a(window).height()-H.outerHeight(true)>=K-(t()||-n())){if(q()){p();H.trigger("preUnfixed.ScrollToFixed");if(F==="absolute"){b()}else{l()}H.trigger("unfixed.ScrollToFixed")}}else{if(!q()){p();H.trigger("preFixed.ScrollToFixed");x()}w(J);H.trigger("fixed.ScrollToFixed")}}else{w(J)}}}}}function n(){if(!m.options.bottom){return 0}return m.options.bottom}function p(){var J=H.css("position");if(J=="absolute"){H.trigger("postAbsolute.ScrollToFixed")}else{if(J=="fixed"){H.trigger("postFixed.ScrollToFixed")}else{H.trigger("postUnfixed.ScrollToFixed")}}}var D=function(J){if(H.is(":visible")){c=false;B()}};var G=function(J){(!!window.requestAnimationFrame)?requestAnimationFrame(B):B()};var C=function(){var K=document.body;if(document.createElement&&K&&K.appendChild&&K.removeChild){var M=document.createElement("div");if(!M.getBoundingClientRect){return null}M.innerHTML="x";M.style.cssText="position:fixed;top:100px;";K.appendChild(M);var N=K.style.height,O=K.scrollTop;K.style.height="3000px";K.scrollTop=500;var J=M.getBoundingClientRect().top;K.style.height=N;var L=(J===100);K.removeChild(M);K.scrollTop=O;return L}return null};var s=function(J){J=J||window.event;if(J.preventDefault){J.preventDefault()}J.returnValue=false};m.init=function(){m.options=a.extend({},a.ScrollToFixed.defaultOptions,i);z=H.css("z-index");m.$el.css("z-index",m.options.zIndex);u=a("<div />");I=H.css("position");F=H.css("position");k=H.css("float");e=H.css("top");if(h()){m.$el.after(u)}a(window).bind("resize.ScrollToFixed",D);a(window).bind("scroll.ScrollToFixed",G);if("ontouchmove" in window){a(window).bind("touchmove.ScrollToFixed",B)}if(m.options.preFixed){H.bind("preFixed.ScrollToFixed",m.options.preFixed)}if(m.options.postFixed){H.bind("postFixed.ScrollToFixed",m.options.postFixed)}if(m.options.preUnfixed){H.bind("preUnfixed.ScrollToFixed",m.options.preUnfixed)}if(m.options.postUnfixed){H.bind("postUnfixed.ScrollToFixed",m.options.postUnfixed)}if(m.options.preAbsolute){H.bind("preAbsolute.ScrollToFixed",m.options.preAbsolute)}if(m.options.postAbsolute){H.bind("postAbsolute.ScrollToFixed",m.options.postAbsolute)}if(m.options.fixed){H.bind("fixed.ScrollToFixed",m.options.fixed)}if(m.options.unfixed){H.bind("unfixed.ScrollToFixed",m.options.unfixed)}if(m.options.spacerClass){u.addClass(m.options.spacerClass)}H.bind("resize.ScrollToFixed",function(){u.height(H.height())});H.bind("scroll.ScrollToFixed",function(){H.trigger("preUnfixed.ScrollToFixed");l();H.trigger("unfixed.ScrollToFixed");B()});H.bind("detach.ScrollToFixed",function(J){s(J);H.trigger("preUnfixed.ScrollToFixed");l();H.trigger("unfixed.ScrollToFixed");a(window).unbind("resize.ScrollToFixed",D);a(window).unbind("scroll.ScrollToFixed",G);H.unbind(".ScrollToFixed");u.remove();m.$el.removeData("ScrollToFixed")});D()};m.init()};a.ScrollToFixed.defaultOptions={marginTop:0,limit:0,bottom:-1,zIndex:1000,baseClassName:"scroll-to-fixed-fixed"};a.fn.scrollToFixed=function(b){return this.each(function(){(new a.ScrollToFixed(this,b))})}})(jQuery);
	/* WEBPACK VAR INJECTION */}.call(exports, require, require(9)))

/***/ }
])
/*
//@ sourceMappingURL=new.bundle.js.map
*/