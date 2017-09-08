imports("jslib/d2js.js");

imports("../config/website.js");

D2JS.init();

(function initLog4j(){
	var classLoader = java.lang.Thread.currentThread().contextClassLoader;
	var url = classLoader.getResource("log4j.properties");
	if(url){
		org.apache.log4j.PropertyConfigurator.configure(decodeURIComponent(url.file));
	}
	logger.info('log4j inited');
})();

imports("./d2js/node.js");

imports("./permission.js");

defineNodeSql(d2js.executor);

initTypeRelations(d2js.executor);
