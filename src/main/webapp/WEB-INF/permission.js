/**
 * 开始执行任务。
 * 给引擎的 task 设置回调，在引擎完成函数调用后，将调用该回调。现在挂上的是 writeOpLog 回调。
 * 引擎允许使用传入 jscurrtask.start(obj = {callback : function(obj){}})， 在执行完函数后(或出错时)回调该callback。
 * @param code
 * @param table
 * @param rowid
 * @param desc
 */
D2JS.prototype.actas = function(code, table, rowid, desc){
	if(this.session.user && this.session.user.allowed[code]){
		var task = new org.siphon.d2js.jshttp.Task();
		this.task = task;
		if(this.taskDocker) this.taskDocker.value = task;
		
		task.start({code : code, startTime : new Date(), table : table ? table.toUpperCase() : null, id : rowid, desc : desc, 
				  callback : this.writeOpLog.bind(this)});
	} else {
		throw new Error('permission denied for function ' + code);
	}
}

D2JS.prototype.operationLog = function(code, table, rowid, desc){
		var task = new org.siphon.d2js.jshttp.Task();
		this.task = task;
		if(this.taskDocker) this.taskDocker.value = task;
		
		task.start({code : code, startTime : new Date(), table : table ? table.toUpperCase() : null, id : rowid, desc : desc, 
				  callback : this.writeOpLog.bind(this)});
}


/**
 * 检查用户有无执行操作的权限，如无则抛错
 * 如:
 * 	checkPrivilege('company.query')
 * @param [code] {String} 权限代码，可以为空，为空时检测有无登录
 */
D2JS.prototype.checkPrivilege = function(code){
	if(this.session.user && (!code || this.session.user.allowed[code])){
		
	} else {
		throw new Error('permission denied for function ' + code);
	}
}

/**
 * 
 * @param args {code : '', startTime : new Date(), table : 'tablename', id : 'id', desc : '{name:xx}', exception : err}   
 * 			  
 * @returns
 */
D2JS.prototype.writeOpLog = function(args){
	var addr = this.request.getRemoteHost() + ":" + this.request.getRemotePort();
	
	if(this.executor.isOracle()){
		var sql =
			"insert into uac.operation_log\n" +
			"  (id, person, address, sessionid, start_time, end_time, function_code,\n" + 
			"   apply_table, row_id, op_desc, result, result_desc)\n" + 
			"values\n" + 
			"  (uac.seq_operation_log.nextval, :person, :address, :sessionid, :start_time, :end_time,\n" + 
			"   :function_code, :apply_table, :row_id, :op_desc, :result,\n" + 
			"   :result_desc)";
	} else if(this.executor.isPostgreSQL()){
		var sql =
			"insert into uac.operation_log\n" +
			"  (id, person, address, sessionid, start_time, end_time, function_code,\n" + 
			"   apply_table, row_id, op_desc, result, result_desc)\n" + 
			"values\n" + 
			"  (nextval('uac.seq_operation_log'), :person, :address, :sessionid, :start_time, :end_time,\n" + 
			"   :function_code, :apply_table, :row_id, :op_desc, :result,\n" + 
			"   :result_desc)";
	}
	
	var opResult = 'S', resultDesc = args.resultDesc;
	if(args.exception){
		switch(args.exception.name){
			case 'ValidationError' : opResult = 'F'; break;
			case 'FailedError' : opResult = 'F'; break;
			case 'FatalError' : opResult = 'A'; break;
			case 'Error' : opResult = 'E'; break;
			case 'JavaError' : opResult = 'A'; break;	// java 异常都视为致命错误
		}
		resultDesc = args.exception.message;
		//TODO java error
	}
	if (this.session.user) {
	    var desc = typeof (args.desc) == 'string' ? args.desc : JSON.stringify(args.desc, shortenStr);
	    if (desc.length > 4000) {
	        desc = desc.substr(0, 4000);
	    }
		var rcd = {person : this.session.user.id, address : addr, 
					sessionid : this.session.getId() + '', 
					start_time : args.startTime * 1,
					end_time : new Date() * 1,
					function_code : args.code,
					apply_table : args.table,
					row_id : args.id,
					op_desc : desc,
					result : opResult,
					result_desc : resultDesc
				};
		if(this.transactConnection){
			var another = this.clone();
			another.transactConnection = null;
			another.execute(sql, rcd);
		} else {
			this.execute(sql, rcd);
		}
	}

	function shortenStr(key, value) {
	    if (typeof value == 'string' && value.length > 100) {
	        return value.substr(0, 100) + '...';
	    }
	    return value;
	}    
};