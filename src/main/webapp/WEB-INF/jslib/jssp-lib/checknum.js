imports('jssp-lib/checknum.js');
imports("jssp-lib/cryptutil.js");
/**
 * @class ValidationCode
 * <pre>
 * 实现了一个校验码组件。
 * 使用方法：
 * 	显示校验码。在 jssp 中，校验码输入框后填入 [% ValidationCode.generate(120, 60); %]
 * 	检验校验码。在处理提交表单时，使用 ValidationCode.check(request[输入参数]) true/false 判断校验码是否通过。检验成功后，最好调用 ValidationCode.release() 释放占用的session资源
 * 
 * 输出代码中已经自动实现了校验码点击刷新。
 * </pre> 
 * */
function ValidationCode(){}

/**
 * 生成校验码。最终会在输出流输出一个 IMG 标记。
 * @param width
 * @param height
 * @returns 无
 */
ValidationCode.generate = function(width, height){
	
	var randomCode = java.util.UUID.randomUUID().toString(); 
	var nextCode = java.util.UUID.randomUUID().toString();
	
	var gen = {
		cb : function (req, resp, session, servlet, out, engine, runner){
			response.setHeader("Content-Disposition", "attachment; filename=validation.dat");
			var o = new com.softview.web.RandomVaricationCodeGenerator().generateWithCaptcha(width || 300, height || 100);
			session['validationCode'] = o.code;
			out.write(o.image);
			setHttpCallback(nextCode, this);
			session['validateionCodeStub'] = nextCode;
		}
	};
	gen.id = randomCode;
	setHttpCallback(gen);
	gen.id = nextCode;
	setHttpCallback(gen);
	session['validateionCodeStub'] = nextCode;
	
	out.print('<img src="' + randomCode + '.jsspcb" ' +
			 'onclick="javascript:this.src=\''+nextCode+'.jsspcb?\'" + new Date()*1"/>');
};

ValidationCode.generateImageDataUri = function(width, height){
	
	var o = new com.softview.web.RandomVaricationCodeGenerator().generateWithCaptcha(width || 320, height || 80);
	logger.info('code = ' + o.code.toUpperCase());
	logger.info('sha1 = ' + encryptSha1(o.code.toUpperCase()));
	session['validationCode'] = o.code.toUpperCase();
	var obj = {
		     sha1 : new String(encryptSha1(o.code.toUpperCase())), 
		     imageDataUri : 'data:image/png;base64,' + org.apache.commons.codec.binary.Base64.encodeBase64String(o.image)		//encodeBase64URLSafeString
	     }	

	return obj;
};


/**
 * 检验校验码是否正确
 * @param input 用户录入的校验码
 * @returns {Boolean}
 */
ValidationCode.check = function(input){
	return input == session['validationCode'];
};

/**
 * 释放占用的 SESSION 资源。在 check 成功后调用。
 */
ValidationCode.release = function(){
	var stub = session['validateionCodeStub'];
	session[stub] = null;
	session['validationCode'] = null;
};
