//add  by dzr 2013-11-07
	openExtWin = function(option){
//		console.info('refId=============================='+option.refreshWinId)
		if(option.id){
			var win = Ext.getCmp(option.id);
			if(!win){
				var config ={
						animCollapse : true,
						animateTarget : 'exit',
						closeAction : 'hide',
						modal : true,
						visitUrl : option.url
					};
				Ext.apply(config,option)
				win = new ExtWindow(config);
			}
			win.show();
		}else{
			var config ={
					animCollapse : true,
					animateTarget : 'exit',
					closeAction : 'hide',
					modal : true,
					visitUrl : option.url
				};
			Ext.apply(config,option)
			win = new ExtWindow(config);
			win.show();
		}
	}

	//add  by dzr 2013-11-08
	ExtWindow =Ext.extend(Ext.window.Window,{
	 	visitUrl:null,
	 	refreshWinId : '',
	 	constructor:function(config){
//	 		console.info('refId extwindow=============================='+config.refreshWinId)
	 		Ext.apply(this,config);
	 		
	 		if(this.visitUrl.indexOf('?')!=-1){
 				this.visitUrl+='&';
 			}else{
 				this.visitUrl+='?';
 			}
	 		this.callParent([{
				autoScroll:true,
				loadMask : true,
				bodyStyle : 'background-color:#fff',
				html:'<iframe id="'+this.getId()+'_doc_iframe" width="100%" height="100%" scrolling="auto" frameborder="0" src="'+this.visitUrl+'&winId='+this.getId()+'&w_ref_Id='+this.refreshWinId+'"></iframe>'
	 		}]);
	 	},
	 	refresh:function(){
	 		this.body.update('<iframe id="'+this.getId()+'_doc_iframe" width="100%" height="100%" scrolling="auto" frameborder="0" src="'+this.visitUrl+'&winId='+this.getId()+'&w_ref_Id='+this.refreshWinId+'"></iframe>');
	 	}
	 });
	

	
function getIframeWin(){
	var curIframe = $('#tabContents>div.active').find('iframe')[0].contentWindow;
	//var grd = curIframe.viewPort.down('#grdMain');
	return curIframe;
	
}