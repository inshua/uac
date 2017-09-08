var typeDict = { 
		'varchar2' : 'string',
		'char'		: 'string',
		'varchar'	: 'string',
		'nvarchar'	: 'string',
		'nvarchar2'	: 'string',
		integer		: 'int',
		number		: 'float',
		date		: 'date'
	};
function dbTypeToExtFiledType(type){
	return typeDict[type] || 'auto';		
}