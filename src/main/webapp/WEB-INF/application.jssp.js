imports("jslib/jssp.js");

imports("../config/website.js");

D2JS.init();

imports("./d2js/node.js");

imports("./permission.js");

defineNodeSql(d2js.executor);

initTypeRelations(d2js.executor);

