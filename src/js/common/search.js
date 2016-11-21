require(['common/api', 'common/web', 'cookie'], function (api, common) {
    //实现搜索输入框的输入提示js类
    var lastKeyWords,
        matchListCache = {},
        hotDatas = [];
    var oSearchSuggest = function (searchFuc) {
        // function oSearchSuggest(searchFuc) {
        var searchsubmit = $('#btnSearch'),
            input = $('#q'),
            suggestWrap = $('#gov_search_suggest'),
            key = "",
            init = function () {
                var hotWords = searchsubmit.siblings('.search_keywords').children('a.item');
                hotWords.each(function(){
                    hotDatas.push($(this).text());
                });

                input.bind('focus', function () {
                    var _q = $.trim(input.val());
                    if (_q == '') {
                        var aData =  [];
                        if ($.cookie('searchHistory')) {
                            aData = $.cookie('searchHistory').split(',');
                        }else{
                            aData = hotDatas;
                        }
                        searchSuggest.dataDisplay(aData, true);
                    } else {
                        sendKeyWordToBack();
                    }
                });
                input.bind('keyup', sendKeyWord);
                input.bind('blur', function () {
                    setTimeout(hideSuggest, 300);
                });
                $("form#search_tab_content_q").submit(function(e){
                    if(suggestWrap.find('li.selected').length > 0){
                        console.log(suggestWrap.find('li.selected').eq(0).find('a').attr('href'));
                        location.href = suggestWrap.find('li.selected').eq(0).find('a').attr('href');
                        return false;
                    }
                    var _q  = $('#q').val().trim();
                    if(_q==''){
                        location.href = '/search.html';
                        return false;
                    }else{
                        if(_q.indexOf(' ') > -1){
                            _q = encodeURIComponent(_q);
                            location.href = '/search.html?q='+_q;
                            return false;
                        }
                    }
                });
                $("form#search_tab_content_shop").submit(function(e){
                    var _q  = $('#searchKey').val().trim();
                    if(_q==''){
                        location.href = '/shopsearch.html';
                        return false;
                    }else{
                        if(_q.indexOf(' ') > -1){
                            _q = decodeURIComponent(_q);
                            location.href = '/shopsearch.html?searchKey='+_q;
                            return false;
                        }
                    }
                });
            },
            hideSuggest = function () {
                suggestWrap.hide();
            },
        //发送请求，根据关键字到后台查询
            sendKeyWord = function (event) {
                //键盘选择下拉项
                if (suggestWrap.css('display') == 'block' && event.keyCode == 38 || event.keyCode == 40 || event.keyCode == 13) {
                    var current = suggestWrap.find('li.selected');
                    if (event.keyCode == 38) {
                        if (current.length > 0) {
                            var prevLi = current.removeClass('selected').prev();
                            if (prevLi.length > 0) {
                                prevLi.addClass('selected');
                                input.val(prevLi.attr('q'));
                            }
                        } else {
                            var last = suggestWrap.find('li:last');
                            last.addClass('selected');
                            input.val(last.attr('q'));
                        }
                    } else if (event.keyCode == 40) {
                        if (current.length > 0) {
                            var nextLi = current.removeClass('selected').next();
                            if (nextLi.length > 0) {
                                nextLi.addClass('selected');
                                input.val(nextLi.attr('q'));
                            }
                        } else {
                            var first = suggestWrap.find('li:first');
                            first.addClass('selected');
                            input.val(first.attr('q'));
                        }
                    }
                    //输入字符
                } else {
                    var valText = $.trim(input.val());
                    if (valText == '' || valText == key) {
                        return;
                    }
                    searchFuc(valText);
                    key = valText;
                }
            };
        //请求返回后，执行数据展示
        this.dataDisplay = function (data, isHistory) {
            if (data.length <= 0) {
                suggestWrap.hide();
                return;
            }
            if (data.length >= 10) {
                data.length = 10;
                // $(".search-img").show()
            }

            //往搜索框下拉建议显示栏中添加条目并显示
            var li, _q,
                tmpFrag = document.createDocumentFragment();
            suggestWrap.find('ul').html('');
            for (var i = 0; i < data.length; i++) {
                li = document.createElement('LI');
                var _item = data[i];
                if (_item.tcid) {
                    _q = lastKeyWords;
                    li.innerHTML = '<a href="/search.html?tcid=' + _item.tcid + '&q=' + encodeURIComponent(_q) + '" title="' + _q + '" target="_blank"><div class="title"><span class="q">' + _q + '</span><span class="cate">在<span>' + _item.tcname + ' </span>分类下搜索</span></div></a>';
                    li.title = _q;
                } else {
                	if(isHistory){
                    	_q = _item;
                	}else{
                    	_q = _item[0];
                	}
                    li.innerHTML = '<a href="/search.html?q=' + encodeURIComponent(_q) + '" title="' + _q + '"><div class="title"><span class="q">' + _q + '</span></div></a>';
                    li.title = _q;
                }
                li.setAttribute('q', _q);
                tmpFrag.appendChild(li);
            }
            suggestWrap.find('ul').append(tmpFrag);
            suggestWrap.show();
            cuvvic.sendShow('', $('#gov_search_suggest .search-img a:eq(0)'));
            //为下拉选项绑定鼠标事件,实现鼠标点击选取
            suggestWrap.find('li').hover(function () {
                suggestWrap.find('li').removeClass('selected');
                $(this).addClass('selected');
            }, function () {
                $(this).removeClass('selected');
            }).bind('mousedown', function () {
                input.val(this.title);
                suggestWrap.hide();
                searchsubmit.click();
            });
        };
        init();
    };
    //实例化输入提示的JS,参数为进行查询操作时要调用的函数名
    var searchSuggest = new oSearchSuggest(common.throttle(sendKeyWordToBack, 800, true, true)) //cgx

    //这是一个模似函数，实p现向后台发送ajax查询请求，并返回一个查询结果数据，传递给前台的JS,再由前台JS来展示数据。本函数由程序员进行修改实现查询的请求
    //参数为一个字符串，是搜索输入框中当前的内容
    function sendKeyWordToBack() {
        var sSearchKey = $.trim($("#q").val() || '');
        $("#q").bind("input propertychange", function (event) {
            sSearchKey = $("#q").val();
        });
        if (matchListCache[sSearchKey + '']) {
            searchSuggest.dataDisplay(matchListCache[sSearchKey + '']);
            return;
        }
        $.ajax({
            url: "/rest/suggest", //后台webservice里的方法名称根据自己需要实现返回数据位json
            type: "get",
            dataType: "json",
            async: false,
            contentType: "application/json; charset=utf-8",
            data: {q: sSearchKey},
            traditional: false,
            beforeSend: function (x) {
                x.setRequestHeader("Content-Type", "application/json; charset=utf-8");
            },
            success: function (data) {
                var aData = [],
                    _data = data.data;
                lastKeyWords = sSearchKey;
                aData = formatSuggestData(sSearchKey, _data);
                searchSuggest.dataDisplay(aData);
            },
            error: function (msg, e) {
                // $("#filter_stationType").html("SQL语句有错误");
            },
            complete: function (x) {
            }
        });
    }

    function formatSuggestData(q, aData) {
        var list = [],
            cats = aData.cats || [],
            suggests = aData.suggests || [];
        list = $.merge(cats, suggests);
        matchListCache[q + ''] = list;
        return list;
    }
});
