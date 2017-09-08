function Browser() {
};

/**
 * 检查是什么浏览器
 * 
 * @param userAgent
 *            从 request.getHeader('user-agent') 获取
 * @returns {ie|firefox|opera|chrome|safari : 'product name', ver : 版本号}
 */
Browser.detect = function(userAgent) {
	var browser = {};
	userAgent = userAgent.toLowerCase();
	if (s = userAgent.match(/chrome\/([\d\.]+)/)) {
		browser.chrome = 'Chrome';
		browser.ver = s[1];
	} else if (s = userAgent.match(/msie ([\d\.]+)/)) {
		browser.ie = 'IE'
		browser.ver = s[1];
	} else if (userAgent.match(/trident/) && (s = userAgent.match(/rv.?([\d\.]+)/))) {
		browser.ie = 'IE';
		browser.ver = s[1];
	} else if (s = userAgent.match(/version\/([\d\.]+).*safari/)) {
		browser.safari = 'Safari';
		browser.ver = s[1];
	} else if (s = userAgent.match(/firefox\/([\d\.]+)/)) {
		browser.firefox = 'Firefox';
		browser.ver = s[1];
	} else if (s = userAgent.match(/opera.([\d\.]+)/)) {
		var s2;
		if (s2 = userAgent.match(/version\/([\d\.]+)/))
			s = s2;
		browser.opera = 'Opera';
		browser.ver = s[1];
	} else if (s = userAgent.match(/opr.([\d\.]+)/)) {
		browser.opera = 'Opera';
		browser.ver = s[1];
	} else {
		browser.unkown = 'unknown';
	}
	return browser;
}