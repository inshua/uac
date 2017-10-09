function defineNodeSql(executor){
	if(executor.isOracle()){
		/**
		 * <pre>
		 * 增加节点范围查询的 SQL。
		 * 生成一个 WITH node AS (select ... from node ... connect by .. )，
		 * 在后面的 SQL 中可以使用 nd。用法如：
		 * <pre class="code">
		 * 		sql = nodeSql(params, ['COMPANY']) + sql;
		 * 		sql += "select * from a, nd where a.node = nd.id" 
		 * </pre>
		 * 或，(如果引入了 sqlstring.js)
		 * <pre class="code">
		 * 		sql.node(params, ['COMPANY']);
		 * </pre>
		 * 原计划别名叫表名 node，但 oracle 11g 中，当 WITH 块内访问到的名称和 as 的代号相同时，会认为发生了递归，而不是当表名理解。
		 * </pre>
		 * @param params  params= {q: {node : 起点节点, cut : 剪枝节点 }, nodeProperty : 'node'}, cut 选填， node 如为 null，将修改 params 参数自动填入 session.user.node，可以修改 nodeProperty 设置node参数名。
		 * @param types null | ['类型', ...] | '类型'. 选填。
		 * @param cutCond 附加剪枝函数 function(){} : string。应返回 SQL 片段字符串。选填。
		 * @param orderBy 调整排序因子 function(){} : string。应返回 SQL 的 ORDER SILBLINGS BY 后的内容，即"字段名 ASC|DESC, ..."。选填。
		 * @param reverse 默认 false. 是否从子节点反溯各个父级. 如果反溯, 伪表名取 ndr 而不是 nd.
		 * @returns
		 */
		D2JS.prototype.nodeSql = function (params, types, cutCond, orderBy, reverse){
			var sql = 'with nd as (select id, name, parent_id, type, level lv from uac.node connect by parent_id = prior id ';
			if(reverse){
				sql = 'with ndr as (select id, name, parent_id, type, level lv from uac.node connect by prior parent_id = id ';
			}

			if(params.cut){
				sql += ' and id <> :cut' ;
			}
			
			if(types){
				if(types.push){		// whether is array
					// types.push('ROOT');
				} else {
					types = ['ROOT', types];	// if string
				}
			} else {
				types = [];
			}
			
			if(types.length){
				sql += ' and type in (' + types.map(function(t){return "'" + t.toUpperCase() + "'";}).join(',') + ') ';		
			}
			if(cutCond){
				sql += cutCond();
			}
			
			var nodeProp = params.nodeProperty || 'node';
			if(params[nodeProp] == null) params[nodeProp] = this.session.user.node.id;	
			// if(!params[nodeProp]) params[nodeProp] = 0;

			sql += ' start with id = :' + nodeProp;
			if(orderBy){
				sql += ' order siblings by ' + orderBy(params);
			} else {
				sql += ' order siblings by name';
			}
			sql += ') ';
			return sql;
		};
	} else if(executor.isPostgreSQL()){
		D2JS.prototype.nodeSql = function (params, types, cutCond, orderBy, reverse){
			var nodeProp = params.nodeProperty || 'node';			
			if(params[nodeProp] == null || isNaN(params[nodeProp])) {
				params[nodeProp] = this.session.user.node.id;
				//logger.info('set nodeProp ' + nodeProp + ' got ' + JSON.stringify(params));
			}
			
			if(types){
				if(types.push){		// whether is array
					// types.push('ROOT');
				} else {
					types = ['ROOT', types];	// if string
				}
			} else {
				types = [];
			}
			
			var alias = 'nd';
			var sql = 'with recursive t as (select *, 1 lv, name::varchar(2000) path from uac.node where id = :' + nodeProp 
						 + ' union select d.*, t.lv + 1, (t.path || d.name) :: varchar(2000) from uac.node d, t where d.parent_id = t.id ' 
			if(reverse){
				alias = 'ndr';
				var sql = 'with recursive t as (select *, 1 lv, name::varchar(2000) path from uac.node where id = :' + nodeProp 
				 		 + ' union select d.*, t.lv + 1, (t.path || d.name) :: varchar(2000) from uac.node d, t where d.id = t.parent_id ' 
			}
			
			sql += (params.cut &&  ' and d.id <> :cut' || '')
				+ (cutCond && cutCond() || '')
				+ (types.length && ' and d.type in (' + types.map(function(t){return "'" + t.toUpperCase() + "'";}).join(',') + ') ' || '')
				+ ' ) select id, name, parent_id, type, lv, path from t order by path';
			
			
			if(orderBy && orderBy != 'name'){
				throw new Error('must order by name, ' + JSON.stringify(params) + ' not allowed');
			} 
			
			return 'with ' + alias + ' as (' + sql + ')';
		};
	}
}

if(typeof(Sql) != 'undefined'){
	/**
	 * 增加节点范围查询的 SQL。
	 */
	Sql.prototype.node = function(d2js, params, types){
		this.sql = this.sql ? d2js.nodeSql.call(this, arguments) + this.sql : d2js.nodeSql.call(this, arguments);
		return this;
	};
}

/**
 * 查找所给节点类型可以包含的所有直属子级实体类型（不含孙子级）
 * @param type
 * @returns
 */
function findChildTypes(type){
	return application.allowedChildTypes[type.toUpperCase()];
}

/**
 * 查找可以直接容纳所给实体类型的所有实体及节点类型。
 * @param type
 * @returns
 */
function findParentTypes(type){
	return application.allowedParentTypes[type.toUpperCase()];
}

/**
 * 查找可以容纳所给实体类型的所有实体及节点类型，含直接容纳的及因为能容纳前者而间接容纳的递归父级。
 * @param type
 * @returns
 */
function findAncientTypes(type){
	return application.allowedAncientTypes[type.toUpperCase()];
}

/**
 * 查找可以容纳所给实体类型的所有实体及节点类型，含直接容纳的及因为能容纳前者而间接容纳的递归父级。以及本类型自身。
 * @param type
 * @returns
 */
function findAncientTypesAnd(type){
	var types = application.allowedAncientTypes[type.toUpperCase()];
	return types.indexOf(type) == -1? types.concat(type) : types; 
}


// 从 NODE_ALLOWED_CHILDREN_TYPE 初始化类型间从属关系
function initTypeRelations(){
	var allowedChildTypes = application.allowedChildTypes;		

	if(allowedChildTypes == null){
		application.allowedChildTypes = allowedChildTypes = {};			// 直属子级类型
		var allowedParentTypes = application.allowedParentTypes = {};   // 直属父级类型
		var allowedAncientTypes = application.allowedAncientTypes = {}; // 连带父级 类型
		
		var typeRelations = d2js.executor.query('select * from uac.NODE_ALLOWED_CHILDREN_TYPE',[], true).rows;
		for(var i=0; i<typeRelations.length; i++){
			var r = typeRelations[i];
			if(allowedChildTypes[r.parent_type]){
				allowedChildTypes[r.parent_type].push(r.child_type);
			} else {
				allowedChildTypes[r.parent_type] = [r.child_type];
			}
			
			if(allowedParentTypes[r.child_type]){
				allowedParentTypes[r.child_type].push(r.parent_type);
			} else {
				allowedParentTypes[r.child_type] = [r.parent_type];
			}				
		}
		
		// build ancient types
		for(var type in allowedParentTypes){
			if(allowedParentTypes.hasOwnProperty(type)){
				var arr = [];
				for(var stk = [].concat(allowedParentTypes[type]); stk.length > 0;){
					var pt = stk.pop();
					arr.push(pt);
					
					var types = allowedParentTypes[pt];
					if(types) {
						types = types.filter(function(item){return arr.indexOf(item) == -1 && stk.indexOf(item) == -1;});
						stk = stk.concat(types);
					}
				}				
				
				allowedAncientTypes[type] = arr;
			}
		}
		//application.sample = 'abcd';
		logger.info('allowedChildTypes init : ' + JSON.stringify(application.allowedChildTypes));
		logger.info('allowedParentTypes init : ' + JSON.stringify(application.allowedParentTypes));
		logger.info('allowedAncientTypes init : ' + JSON.stringify(application.allowedAncientTypes));
		
	}
}


/**
 * <pre>
 * 类似 Unique 检查器。检查与传入记录 NODE 相同的兄弟记录看是否唯一。
 * </pre>
 * @param table 表名
 * @param tableField 字段名。如与传入字段名相同可不填。
 * @param primaryDesc
 * @returns 
 */
V.uniqueInNode = function(table, tableField, ignoreCase){	
	return {
		name : 'unique',	
		check : function(v, fld, rcd, d2js){
			if(v==null||v=='') return;
			var pk = 'id';
			fld = tableField || fld;
			
			var nodeFld = 'node';
			if(table != 'uac.node') nodeFld = 'node';
			
			var sql = 'select 1 from ' + table + ' where ' + nodeFld + ' = ? and ' + fld + ' = ?';
			if(ignoreCase){
				if(v != null) v = v.toUpperCase();
				sql = 'select 1 from ' + table + ' where ' + nodeFld + ' = ? and upper(' + fld + ') = ?';
			}
			var args = [rcd[nodeFld], v]
			if(rcd.id != null){
				sql += ' and id <> ?';
				args.push(rcd.id);
			}
			sql += ' limit 1';
			
			var rows = d2js.query(sql, args);
			
			if(rows.length){
				return '发现重复记录';
			}
		}
	};
};