var api = require('common/api')
// var tpl = require('text!' + _WEB_Cfg.domain +'/static/quicklogin.html')
// var css = require('css!'+_WEB_Cfg.staticPath + '/css/qlogin3.css')
require('layer')


	var SMSDELAY = 100; //短信重发间隔
	var _VERIFYCODEURL = "/apic/verifyCode/generate";
	var Main = function () {};

	var showError = function(text){
		$('.err-info').show();
		$('.err-info span').text(text);
	};
	var hideError = function(){
		$('.err-info').hide();
		$('.err-info span').text('');
	};
	$.extend(Main.prototype, {
		isShow:0,//是否显示验证码,默认0不显示
		goHref:'',
		smsDelay:true,//发送短信验证码
		smsDelayInterval:'',
		smsSendTag:false,//是否发送短信验证码
		autoVal:0,//记录自动登录值
		userNameExist:'',//存储已经存在的用户名
		doNotReload: false,
		init: function(href, doNotReload, cb){
			var self = this;
			if(href){
				self.goHref = href;
			}
			if(doNotReload){
				self.doNotReload = true;
			}
			if($.isFunction(cb)){
				self.cb = cb;
			}
			self.showLoginBox();
		},
		showLoginBox:function(){
			var self = this;
			self.closeLoginBox();
			$.ajax({
				url: _WEB_Cfg.domain +'/static/quicklogin.html',
				type: 'get',
				dataType: 'html',
				success: function(data){
					console.log(data);
				}
			})


			$(document.body).append(tpl);
			self.setPositionLoginBox();
			$('.qlogin').show();
			cuvvic.sendShow("", $('#submitLogin'));
			self.setAuto();
			self.addEvent();
		},
		setPositionLoginBox:function(){
			var _height = $(window).height(),
				_boxHeight = 280;
			$('.qlogin').css({top:(_height - _boxHeight)/2 + 'px'});
		},
		setAuto:function(){
			var _auto = $.cookie('userLoginAuto');
			if(_auto && _auto == 1){
				$('.v-single-check').addClass('checked');
				$('#auto').val(1);
			}
		},

		closeLoginBox:function(){
			this.smsSendTag = false;
			this.isShow = 0;
			$('.w-loginbg,.qlogin').remove();
		},
		addEvent: function(){
			var self = this;
			var _errorIcon = '<i class="vvicon error-icon">&#xe616;</i>';
			var myValidate = $('#j-qlogin-form').validate({
					debug: true,
					onfocusout: false,
					focusInvalid:false,
					focusCleanup:true,
					rules:{
						username: "required",
						password: "required",
						secCode:{
							required:function(){
								return (self.isShow != 0)?true:false;
							}
						},
						//用户是否要发送手机验证码
						smsCode:{
							required:function(){
								$('#smsBox').removeClass('hide');
								return self.smsSendTag;
							}
						}
					},
					messages: {
						username: '请输入登录账户',
						password: '请输入登录密码',
						secCode: '请输入验证码',
						smsCode:'请输入短信验证码'
					},
					errorPlacement: function (error, element) {
					},

					showErrors:function(errorMap,errorList){
						var _errorArray = [];
						if(errorList.length <= 0){
							return false;
						}

						var errorName = $(errorList[0].element).attr('id'),
							$box = '';

						if(errorName == 'secCode'){
							$('#codeBox').removeClass('hide');
							$box = $('#secCode').parent();
						}else if(errorName == 'smsCode'){
							$('#smsBox').removeClass('hide');
							$box = $('.sms-input');
						}else{
							$box = $('#' + errorName).parents('dl');
						}

						for(var i in errorMap){
							_errorArray.push(errorMap[i]);
						}
						self.errorTip(_errorArray[0]);
						$box.addClass('error-focus');
					},
					submitHandler: function () {
						$('#names-error').remove();
						self.login();
					}
				});

			$('.v-single-check').on('click', function(){
				var $this = $(this);
				if($this.hasClass('checked')){
					$this.removeClass('checked');
					$('#auto').val(0);
				}else{
					$this.addClass('checked');
					$('#auto').val(1);
				}
			});

			$('.code-btn').on('click', function(){
				self.changeCode();
			});

			$("#username").blur(function(){
				var _name = $(this).val(),
					$this = this;
				if($.trim(_name).length > 0){
					self.sendShowCode(_name);
				}
			});

			$('input[type="text"],input[type="password"]').focus(function(){
				$('#names-error').remove();
				$('.error-focus').removeClass('error-focus');
				self.activeSendSmsBtn();
				if($(this).attr('name') == 'secCode' || $(this).attr('name') == 'smsCode'){
					$(this).parent('dd').removeClass('error-focus').addClass('focus');
					return;
				}
				$(this).parents('dl').removeClass('error-focus').addClass('focus');
			}).blur(function(){
				self.activeSendSmsBtn();
				if($(this).attr('name') == 'secCode' || $(this).attr('name') == 'smsCode'){
					$(this).parent('dd').removeClass('focus');
					return;
				}
				$(this).parents('dl').removeClass('focus');
			});

			$('.sms-btn').on('click',function(){
				if(self.smsSendTag && !$(this).hasClass('btn-disable')){
					self.sendSms();
				}
			});

			$('.qlogin-close').on('click',function(){
				self.closeLoginBox();
			});

			$(window).resize(function(){
				self.setPositionLoginBox();
			});
		},

		//错误提示的封装
		errorTip:function(txt){
			var _inner = '<label id="names-error" class="error" for="names"><i class="vvicon error-icon">&#xe616;</i>' + txt + '</label>';
			$('#names-error').remove();
			$('.error-focus').removeClass('error-focus');
			$('.login-other').prepend(_inner);
		},
		errorWarm:function(index){
			switch (index){
				case 1:
					$('#secCode').parent().addClass('error-focus');
					break;
				case 2:
					$('#password').parents('dl').addClass('error-focus');
					break;
				case 3:
					$('#userPhoneCode').parent().addClass('error-focus');
					break;
				default:
					$('#password').parents('dl').addClass('error-focus');
					break;
			}
		},
		login: function(){
			var self = this,
				_data =  {
					username: $("#username", $('.qlogin')).val(),
					password: $("#password").val(),
					auto: $("#auto").val(),
					user_key: $.cookie('user_key') || ''
				};
			// console.log(_data);
			self.autoVal = _data['auto'];
			///是否显示验证码
			if(self.isShow != 0){
				var addSecCode = $('#secCode').val();
				if(addSecCode != '' || addSecCode.length > 0){
					_data['secCode'] = addSecCode;
				}else{
					self.errorTip('请输入图形验证码');
					$('.code-input').addClass('error-focus');
					return false;
				}

			}
			//短信验证码
			if(self.smsSendTag){
				var addSmsCode = $('#userPhoneCode').val();
				if(addSmsCode != '' || addSmsCode.length > 0){
					_data['smsCode'] = addSmsCode;
				}else{
					self.errorTip('请输入短信验证码');
					$('.sms-input').addClass('error-focus');
					return false;
				}

			}

			api.service.account.login(_data, function(data){
				if(data.code != 200){
					self.isShow = 1;
					self.changeCode();
					self.errorTip(data.message);
					//显示验证码
					$('#codeBox').removeClass('hide').find('input').val('');
					// 防止用户多次登录。
					setTimeout(function(){self.isLogin = false}, 2000);
					self.isShow = 1;
					self.errorWarm(data.error_type);
					//用户手机号未激活的
					if(data.code == 509){
						self.smsSendTag = true;
						$('#smsBox').removeClass('hide');
					}
					return false;
				}
				self.isLogin=true;
				self.smsSendTag = false;
				self.closeLoginBox();
				self.isShow = 0;

				self.setCookies(data.data);

				if(self.goHref != '' || self.goHref.length > 0){
					/*var _tag = window.open('about:blank');
					_tag.location.href = self.goHref;*/
					/**阻止浏览器拦截**/
					var _a = document.createElement('a');
					_a.setAttribute('href',self.goHref);
					_a.setAttribute('target','_blank');
					_a.setAttribute('id','windonGoHref');
					// 防止反复添加
					if(!document.getElementById('windonGoHref')) {
						document.body.appendChild(_a);
					}
					_a.click();
				}
				if(!self.doNotReload){
					var dateTime = new Date(new Date() - 24 * 60 * 60 * 1000);
					$.cookie('user_key', '', {path: '/', expires: dateTime});
					window.location.reload();
				}else{
					if($.isFunction(self.cb)){
						self.cb();
					}
				}
				$("body").on('keyup',function(e){
					if(e.which==13){
						$("a.layui-layer-btn0").click();
					}
				});
				return;
			});
		},
		changeCode: function(){
			var time = new Date();
			$('#secCodeImg').attr('src', _VERIFYCODEURL + '?' + time.getTime());
		},
		setCookies: function(_user){
			var _expires = 1,
				self = this;
			if(self.autoVal==1){
				_expires = 30;
			}

			// 用户类型
			var _ut = _user.type; //用户类型
			$.cookie('ut', _ut , { path: '/', expires: _expires });
			// 用户id
			$.cookie('uid', _user.id , { path: '/' , domain: '.vvic.com', expires: _expires });
			// 用户username
			$.cookie('umc', _user.mobile_confirm, { path: '/' , expires: _expires});
			$.cookie('mobile', _user.mobile, { path: '/' , expires: _expires});
			// 拿货单数量
			$.cookie('pn', _user.pack_amount, { path: '/' , expires: _expires});
			$.cookie('defaultShopId', _user.default_shop_id, { path: '/' , expires: _expires});
			$.cookie('defaultShopName', _user.default_shop_name, { path: '/' , expires: _expires});
			$.cookie('uno', _user.orders_amount, { path: '/' , expires: _expires});
			$.cookie('userLoginAuto',self.autoVal,{ path: '/' , expires: _expires*3});
		},
		//短信验证码
		sendSms: function() {
			var $this = this,
				$btn = $('.sms-btn'),
				_data={
					username: $("#username", $('.qlogin')).val(),
					password: $("#password").val(),
					secCode: $("#secCode").val()
				};
			if($("#secCode").val() == '' || $("#secCode").val().length <= 0){
				$this.errorTip('请输入图形验证码');
				$('.code-input').addClass('error-focus');
				return false;
			}
			api.getData('/apic/getSmsCode','get',_data,function(data){
				var _obj=data,
					status=_obj.code;
				switch(!0){
					case (status==200):{
						$btn.addClass('btn-disable');
						layer.msg('已发送手机短信验证码');
						//loginVm.smsDelay = SMSDELAY
						$btn.text('重新发送(' + SMSDELAY + '秒)');
						$this.smsDelayInterval = setInterval(function() {
							if (SMSDELAY < 2) {
								$this.smsDelay = false;
								$btn.text('获取短信验证码').removeClass('btn-disable');
								clearInterval($this.smsDelayInterval);
								return;
							}
							SMSDELAY--;
							$btn.text('重新发送(' + SMSDELAY + '秒)');
						}, 1000);
						return;
						break;
					}
				}
				layer.msg(_obj.message);
				$this.smsDelay=true;
				$btn.text('获取短信验证码').removeClass('btn-disable');

			});
			return false;
		},
		//获取短信验证按钮激活
		activeSendSmsBtn:function(){
			var username = $("#username").val(),
				password = $("#password").val(),
				secCode = $('#secCode').val(),
				sendSms = this.smsSendTag;
			if(sendSms && username && password && secCode){
				$('.sms-btn').removeClass('btn-disabled');
			}else{
				$('.sms-btn').addClass('btn-disabled');
			}

		},
		//发送图形验证码
		sendShowCode:function(name){
			var	self = this,
				_data = {username:$('#username').val()},
				_name = name;
			if(self.userNameExist == _name){
				return false;
			}else{
				self.userNameExist = _name;
				self.isShow = 0;
				self.smsSendTag = false;
				$('#smsBox,#codeBox').addClass('hide');
			}
			api.service.user.loginShowCode(_data, function(r){
				$('#codeBox').find('input').val('');
				if(r && r.code == 200){
					var _is_show = r.data.is_show;
					if(_is_show != 0){
						self.isShow = _is_show;
						$('#codeBox').removeClass('hide');
					}else{
						self.isShow = 0;
						$('#codeBox').addClass('hide');
					}
				}
			});
		}
	});

	var main = new Main();
	module.exports = main;
