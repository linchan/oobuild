// 四级地址联动
(function($) {

    $.fn.region = function(config){
        var $this = $(this);
        var opt = {
            picker: '', //获取选取信息容器，用于表单验证
            countryid: 16185,
            country: '中国',
            provinceid: 0, //省份id
            province: '',
            cityid: 0, //城市id
            city: '',
            districtid: 0, //区县
            district: '',
            // zip: '#zipcode', //邮政编码选择器
            disabled: 0, //不可选区域 0 无 1 省  2 省市  3 省市县
            maxLevel: 3,
            render: false,
            fill: false,
            end: function(){
                return false;
            },
            fillEnd: function(){
                return false;
            }
        };
        var tab = [{
            name: "省份",
            level: 1,
            en: 'province'
        },{
            name: "城市",
            level: 2,
            en: 'city'
        },{
            name: "县区",
            level: 3,
            en: 'district'
        }];

        // console.log(regionData);
        var opts = $.extend(opt, config || {});

        var returnData = {
            countryid: opts.countryid,
            country: '中国',
            provinceid: opts.provinceid,
            province: opts.province,
            cityid: opts.cityid,
            city: opts.city,
            districtid: opts.districtid,
            district: opts.district
        };

        // 是否自动填充数据
        if(opts.provinceid > 0 || opts.province != ''){
            opts.render = true;
        }


        var $picker = null;
        if(opt.picker!=''){
            $picker = $(opt.picker);
        }

        var $regionDL,$regionDT,$regionDD,$regionTab,$regionCon;
        if(!$this.children().length){
            // 创建dom
            $regionDL = $('<dl class="v-select o-region"/>');
            $regionDT = $('<dt />');
            $regionDD = $('<dd class="clearfix" />');
            $regionTab = $('<ul class="region-tab clearfix" />');
            $regionCon = $('<div class="region-con clearfix" />');

            var arr1 = [],arr2 = [];

            $regionDT.html('<i></i><span class="regionText">'+(opts.render?'':'请选择省市区')+'</span>');
            $regionDL.append($regionDT).append($regionDD);


            $.each(tab, function(index, item){
                arr1.push('<li class="region-tab-t '+ (index==0?'curr':'') + (opts.disabled>0 && index<opts.disabled ?' disabled':'')+'" data-level="'+item.level+'">'+item.name+'</li>');
                arr2.push('<ul class="region-select '+item.en+'-list clearfix" style="display:none" data-level="'+item.level+'"></ul>');
            });

            var regionTabHtml = arr1.join('<li class="line"></li>');
            var regionConHtml = arr2.join('');
            $regionTab.html(regionTabHtml);
            $regionCon.html(regionConHtml);

            $regionDD.append($regionTab).append($regionCon);

            $this.append($regionDL);

            $('.province-list', $this).html('<li class="letters">A-G</li><li class="citys letter-A-G"></li><li class="letters">H-K</li><li class="citys letter-H-K"></li><li class="letters">L-S</li><li class="citys letter-L-S"></li><li class="letters">T-Z</li><li class="citys letter-T-Z"></li>');

            //  添加事件
            $regionDT.on('click', function(){
                $regionDL.addClass('showed');
            });

            // 省市区切换
            $('.region-tab li.region-tab-t', $this).not('.disabled').on('click', function(){
                goRegionLevel($(this));
            });

            // 信息选择
            $this.on('click', '.region-select a.select-item', function(){
                var $this = $(this),
                    _level = $this.data('level'),
                    _id = $this.data('id'),
                    _text = $this.data('name');
                // if(_id == 16550){
                //  layer.msg('G20峰会期间，快递公司暂不接受发往杭州的订单，不便之处请谅解', {time: 3000,area:['500px','auto']});
                //  return false;
                // }
                opts.render = false;
                if($this.hasClass('disabled')){
                    return false;
                }

                // if($this.hasClass('curr')){
                //  return false
                // }
                $this.closest('ul.region-select').find('a.select-item').removeClass('curr');
                $this.addClass('curr');

                // 填充邮政编码
                // if(opts.zip!=''){
                //  $(opts.zip).val($this.data('zip'))
                // }

                if($picker){
                    $picker.val('');
                }

                getRegionList(_id, _level);

                setReturnData(_id, _text, _level);
            });

            // 点击其他区域隐藏控件
            // $(document).on('click', function(e){
            //  e = e || window.event
            //  var $target = $(e.target)
            //  if(!$target.parents('#'+$this.attr('id')).length){
            //      hideRegion()
            //  }
            // })
        }else{
            $regionDL = $this.find('.o-region');
            $regionDT = $regionDL.children('dt');
            $regionDD = $regionDL.children('dd');
            $regionTab = $('.region-tab', $regionDD);
            $regionCon = $('.region-con', $regionDD);
            $('.citys').html('');
        }

        fillRegionData();

        // 数据初始化
        function fillRegionData(){
            for(var i=0;i<regionData.length;i++){
                var province = regionData[i],
                    currCss = '';

                if(opts.provinceid==province.areaId || (opts.fill && opts.province == province.areaName)){
                    currCss = ' curr';
                    if(opts.fill){
                        opts.provinceid = province.areaId;
                    }
                    setReturnData(opts.provinceid, province.areaName, 1);
                }
                var areaName = province.areaNameCn || province.areaName;
                // $("#letter-" + province.letter).append('<a class="select-item'+currCss+'" data-level="1" href="javascript:;" data-id="'+province.areaId+'" data-zip="'+province.areaCode+'">'+ areaName +'</a>')
                $(".letter-" + province.letter, $this).append('<a class="select-item'+currCss+'" data-level="1" href="javascript:;" data-id="'+province.areaId+'" data-name="'+province.areaName+'">'+ areaName +'</a>');
            }
            // 默认展示第一级信息
            $('.region-select:eq(0)', $this).show();

            // 初始化数据
            if(opts.provinceid > 0){
                getRegionList(opts.provinceid, 1, opts.cityid, function(){
                    if(opts.cityid > 0){
                        getRegionList(opts.cityid, 2, opts.districtid);
                    }
                });
            }
        }

        // 获取数据列表： id 选中的省市id；level 层级；defaultId 下级被选中的id
        function getRegionList(id, level, defaultId, cb){
            switch(level){
                case opt.maxLevel:
                    getRegionText(opt.maxLevel);
                    break;
                default:
                    areaListAsync(id, level, defaultId, cb);
                    break;
            }
        }

        // 填充数据列表： level 层级；listData　获取的信息列表；defaultId 下级被选中的id
        function renderRegionList(level, listData, defaultId){
            var listString = [],
                _level = level + 1,
                _len = listData.length,
                _text = '';

            for(var i=0;i<_len;i++){
                var item = listData[i],
                    _currCss = '',
                    _disabledCss = (opts.disabled > 0 && _level <= opts.disabled) ? ' disabled' : '';
                if(opts.fill){
                    if(level==1 && opts.city == item.areaName){
                        _currCss = 'curr';
                        _text = item.areaName;
                        opts.cityid = defaultId = item.areaId;
                    }
                    if(level==2 && opts.district == item.areaName){
                        _currCss = 'curr';
                        _text = item.areaName;
                        opts.districtid = defaultId = item.areaId;
                    }
                }else{
                    if(defaultId == item.areaId){
                        _currCss = 'curr';
                        _text = item.areaName;
                    }
                }

                var areaName = item.areaNameCn || item.areaName;
                // listString.push('<a class="select-item '+_currCss+_disabledCss+'" data-level="'+_level+'" href="javascript:;" data-id="'+item.areaId+'" data-zip="'+ item.areaCode +'">'+areaName+'</a>')
                listString.push('<a class="select-item '+_currCss+_disabledCss+'" data-level="'+_level+'" href="javascript:;" data-id="'+item.areaId+'" data-name="'+item.areaName+'">'+areaName+'</a>');
            }
            $('ul.region-select[data-level='+_level+']', $this).html(listString.join(''));
            if(_level==2){
                $('ul.region-select[data-level='+(_level+1)+']', $this).html('');
            }
            getRegionText(level);
            if(_len){
                goRegionLevel($('.region-tab li.region-tab-t[data-level='+_level+']', $this), _level);
            }

            if(_level==opt.maxLevel && defaultId){
                getRegionList(defaultId, opt.maxLevel);
            }

            if(defaultId > 0){
                setReturnData(defaultId, _text, _level);
            }

        }

        //跳转到相应层级列表tab id 选中的省市id；level 层级
        function goRegionLevel(el, level){
            var _level = level || el.data('level'),
                $select = $('.region-con ul.region-select[data-level='+_level+']', $this);
            el.siblings('li').removeClass('curr');
            el.addClass('curr');
            $select.siblings().hide();
            $select.show();
        }

        // 异步获取地址列表 目前只用于第四级
        function areaListAsync(id, level, defaultId, cb){

            $('.region-select[data-level='+(level+1)+']', $this).html(''); // 清空区域信息
            $.ajax({
                url: "/apic/area?parent_area_id=" + id,
                type: "get",
                dataType: "json",
                success: function(data){
                    if(data.code == 200){
                        if(data.data.areas.length){
                            renderRegionList(level, data.data.areas, defaultId);
                            cb && cb();
                        }else{
                            getRegionText(level);
                            endFun();
                        }
                    }
                }
            });
        }

        function endFun(){
            hideRegion();
            if($picker){
                $picker.val(returnData.province + returnData.city + returnData.district);
            }
            if(!opts.render){
                opts.end(returnData);
            }
            opts.fillEnd(returnData);
        }

        // 省市文字显示
        function getRegionText(level){
            var text = '';
            for(var i=1;i<=level;i++){
                text += $('.region-select[data-level='+i+'] a.select-item.curr', $this).text() + ' ';
            }
            $('.regionText', $this).text(text);
        }

        // 生成返回数据
        function setReturnData(id, text, level){
            switch(level){
                case 1:
                    returnData.provinceid = id;
                    returnData.province = text;
                    returnData.cityid = 0;
                    returnData.city = '';
                    returnData.districtid = 0;
                    returnData.district = '';
                    break;
                case 2:
                    returnData.cityid = id;
                    returnData.city = text;
                    returnData.districtid = 0;
                    returnData.district = '';
                    break;
                case 3:
                    returnData.districtid = id;
                    returnData.district = text;
                    break;
            }
            if(level==opt.maxLevel){
                endFun();
            }
        }

        // 控件隐藏
        function hideRegion(){
            $regionDL.removeClass('showed');
        }
    };
})(jQuery);
