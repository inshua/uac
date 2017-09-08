var importedJavaPackage = new JavaImporter(
    java.util, 
    javax.servlet.http);

//importPackage(java.util);
//importPackage(javax.servlet.http);

function Cookie() {}
	
Cookie.add =function(name, value, maxAge) {        
    var cookie = new javax.servlet.http.Cookie(name, value);
    //cookie.setPath(website);
    if (maxAge>=0) cookie.setMaxAge(maxAge);
    response.addCookie(cookie);
};

Cookie.getCookie=function(name) {
	with(importedJavaPackage){
		var  cookieMap = Cookie.read(request);
	    var cookie = cookieMap[name];    
		if(cookie){
	        return cookie.getValue();
	    }else{
	        return null;
	    }
	}
};

Cookie.read=function() {
    var cookieMap = {};
    var cookies = request.getCookies();
    if (null != cookies) {
        for (var i = 0; i < cookies.length; i++) {
            cookieMap[cookies[i].name + ''] = cookies[i];
        }
    }
    return cookieMap;
}
