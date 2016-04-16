/**
 * @requires jquery.validate.js
 * @author ZhangHuihua@msn.com
 */
(function($){
	if ($.validator) {
		$.validator.addMethod("alphanumeric", function(value, element) {
			return this.optional(element) || /^\w+$/i.test(value);
		}, "Letters, numbers or underscores only please");
		
		$.validator.addMethod("lettersonly", function(value, element) {
			return this.optional(element) || /^[a-z]+$/i.test(value);
		}, "Letters only please"); 
		
		/**
		 * @author whj
		 * old : ^[0-9- \(\)]{7,30}$
		 * new : ^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$
		 */
		$.validator.addMethod("phone", function(value, element) {
			return this.optional(element) || /^(((0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?)|(1[3-9]\d{9}))$/.test(value);
		}, "Please specify a valid phone number");
		
		$.validator.addMethod("postcode", function(value, element) {
			return this.optional(element) || /^[0-9 A-Za-z]{5,20}$/.test(value);
		}, "Please specify a valid postcode");
		
		$.validator.addMethod("date", function(value, element) {
			value = value.replace(/\s+/g, "");
			if (String.prototype.parseDate){
				var $input = $(element);
				var pattern = $input.attr('dateFmt') || 'yyyy-MM-dd';
	
				return !$input.val() || $input.val().parseDate(pattern);
			} else {
				return this.optional(element) || value.match(/^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/);
			}
		}, "Please enter a valid date.");
		
		/**
		 * @author whj
		 * 手机号码验证
		 * 目前已知就13、14、15、17、18号段、随实际变更
		 */
		$.validator.addMethod("mobile", function(value, element) {
			return this.optional(element) || /^1[3|4|5|7|8|][0-9]{9}$/.test(value);
		}, "Please specify a valid mobile number");
		
		/**
		 * @author whj
		 * 身份证验证
		 */
		$.validator.addMethod("identitycard", function(value, element) {
			return this.optional(element) || /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(value);
		}, "Please specify a valid identity card");
		
		/**
		 * @author whj
		 * 浮点数验证
		 */
		$.validator.addMethod("floatNum", function(value, element) {
			return this.optional(element) || /(^(\d+)(.\d+)?$)/.test(value);
		}, "Please specify a valid float number");
		
		/**
		 * @author whj
		 * 车牌号码验证
		 * /^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/
		 */
		$.validator.addMethod("truckPlate", function(value, element) {
			return this.optional(element) || /(^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$)/.test(value);
		}, "Please specify a valid truck plate");
		
		/*自定义js函数验证
		 * <input type="text" name="xxx" customvalid="xxxFn(element)" title="xxx" />
		 */
		$.validator.addMethod("customvalid", function(value, element, params) {
			try{
				return eval('(' + params + ')');
			}catch(e){
				return false;
			}
		}, "Please fix this field.");
		
		$.validator.addClassRules({
			date: {date: true},
			alphanumeric: { alphanumeric: true },
			lettersonly: { lettersonly: true },
			phone: { phone: true },
			postcode: {postcode: true}, 
			/**
			 * @author whj
			 */
			mobile: {mobile:true},
			identitycard: {identitycard:true},
			floatNum: {floatNum:true},
			truckPlate: {truckPlate:true}
		});
		$.validator.setDefaults({errorElement:"span"});
		$.validator.autoCreateRanges = true;
		
	}

})(jQuery);