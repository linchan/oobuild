define(['common/header', 'common/api', 'common/web', 'common/URLParser', 'pagination', 'lazyload', 'datepick', 'scrolltofixed', 'common/search'], function(header, api, common, URLParser) {
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
});
