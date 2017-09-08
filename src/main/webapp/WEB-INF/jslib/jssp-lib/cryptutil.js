//importPackage(java.io);
//importPackage(java.math);
//importPackage(java.security);
//importPackage(javax.crypto);
//importPackage(sun.misc);

var importedJavaPackage = new JavaImporter(
	    java.io, 
	    java.math, 
	    java.security,
	    javax.crypto);
function CryptUtil() {
}
/**
 * SHA加密
 * @param data
 * @return    */
CryptUtil.encryptSHA=function(data){
	with(importedJavaPackage){
	    var sha = java.security.MessageDigest.getInstance('SHA-1');
	   // logger.info("javaData:"+javaData);
	    sha.update(data,0,data.length);
	    return sha.digest();
	}
}
CryptUtil.mysqlEncrypt = function (pwd2,random){
	//var pwd2=CryptUtil.encryptSHA(new java.lang.String(pwd).getBytes());
	var arrRandom = new java.lang.String(random).getBytes();
	var concated = Java.from(arrRandom).concat(Java.from(CryptUtil.encryptSHA(pwd2)));
	var b = CryptUtil.encryptSHA(concated);
	var arr=[];
	for(var i=0;i<20;i++){
		var r = pwd2[i] ^ b[i];
		arr.push(r);
	}
	return arr;
}
CryptUtil.intArrayToByteArray= function (intArray){
	var buff = java.nio.ByteBuffer.allocate(intArray.length*4);
	for (var i=0;i<intArray.length ;i++)
		buff.putInt(intArray[i]);
	buff.flip();

	var barr = CryptUtil.newByteArray(buff.limit());
	buff.get(barr, 0, barr.length);
	var result = [];
	for(var i=0;i<buff.limit(); i++) result.push(barr[i]);
	return result;
}
CryptUtil.hexToByteArray= function (pwd){
	var pwdArray=new Array();
	for (var i=0;i<pwd.length;i+=2){
		var temp= parseInt(pwd.substr(i,2),16);
		if(temp > java.lang.Byte.MAX_VALUE){
			temp = temp - 256;
		}
		pwdArray.push(temp);
	}
	return pwdArray;
};

CryptUtil.newByteArray = function(length){
	var s= '';
	for(var i=0;i<length; i++) s+='a';
	var barr = new java.lang.String(s).getBytes();
	return barr;
};

CryptUtil.jsArrayToByteArray = function(arr){
	var barr = CryptUtil.newByteArray(arr.length);
	for(var i=0;i<arr.length;i++) barr[i] = arr[i];
	return barr;
};

/**
 * 将原有系统的加密方式移植过来
 * @param name
 * @param passwd
 * @returns
 */
CryptUtil.encrypt=function(name,passwd)
{
	with(importedJavaPackage){
		if (name.length < 3 ||  passwd.length < 3){
		  return "-1";
		}
	
		if (name.length > 30 || passwd.length > 30){
		  return "-2";
		}
	
		var l_answer,as_name,as_passwd;
		var l_char;
		var sigleCharIntValue;
		var l_shift,l_position,l_offset,l_root;
		//处理name
		//as_name = name.toUpperCase();
		as_name = name;
		
		for (var i = 0;i<as_name.length;i++){
				sigleCharIntValue =as_name.charCodeAt(i);
				if (sigleCharIntValue < 65 || sigleCharIntValue > 90){
					sigleCharIntValue = 65 + (sigleCharIntValue - parseInt(sigleCharIntValue /24) * 24);
				}
			as_name =as_name.substring(0,i)+ String.fromCharCode(sigleCharIntValue)+as_name.substring(i+1);
		}
		//处理password
		//as_passwd = passwd.toUpperCase();
		as_passwd = passwd;
		
		for (var i = 0;i<as_passwd.length;i++){
				sigleCharIntValue =as_passwd.charCodeAt(i);
				if (sigleCharIntValue < 65 || sigleCharIntValue > 90){
					sigleCharIntValue = 65 + (sigleCharIntValue - parseInt(sigleCharIntValue /24) * 24);
				}
			as_passwd = as_passwd.substring(0,i)+String.fromCharCode(sigleCharIntValue)+as_passwd.substring(i+1);
			out.println(as_passwd[i]);
		}
		l_offset = as_name.charCodeAt(1);
		l_root   = as_passwd.charCodeAt(as_passwd.length-1);
		l_shift  = as_name.charCodeAt(as_name.length-1);
		l_shift  = (l_shift - parseInt(l_shift /13) * 13);
		l_answer = as_name + as_passwd;
	
		l_position = 1;
	
		for (var i = 1;i<=30;i++){
		  if (l_answer.length >= 30){
			  break;
		  }
	
		  l_shift = l_shift + l_offset + i;
		  if ( l_shift > 90){
			  l_shift = (l_shift - parseInt(l_shift /24) * 24);
			  l_shift = l_shift + 65;
		  }
	
		  l_char = String.fromCharCode(l_shift);
	
		  if (l_position == 1){
			  l_answer = l_answer + l_char ;
			  l_position = 0;
		  }else{
			  l_answer = l_char + l_answer;
			  l_position = 1;
		  }
		}
		
		for (var i = 0;i<30;i++){
				sigleCharIntValue =l_answer.charCodeAt(i);
				sigleCharIntValue = sigleCharIntValue + l_root + i+1;
				if (sigleCharIntValue > 90){
					sigleCharIntValue = 65 + (sigleCharIntValue - parseInt(sigleCharIntValue /24) * 24);
				}
				l_answer = l_answer.substring(0,i)+String.fromCharCode(sigleCharIntValue)+l_answer.substring(i+1);
		}
	
		return l_answer;
	}
};

/**
 * 将字节数组转成二进制
 * @param byteArray
 * @returns
 */
function byte2hex(byteArray) {
	with(importedJavaPackage){
	    var md5StrBuff = new java.lang.StringBuffer();
	    for (var i = 0; i < byteArray.length; i++) {
	        if (java.lang.Integer.toHexString(0xFF & byteArray[i]).length() == 1) {
	            md5StrBuff.append("0").append(
	                    java.lang.Integer.toHexString(0xFF & byteArray[i]));
	        } else {
	            md5StrBuff.append(java.lang.Integer.toHexString(0xFF & byteArray[i]));
	        }
	    }
	    return md5StrBuff.toString();
	}
}
/**
 * java 版本的加密sha1
 * @param password
 * @returns
 */
function encryptSha1(password){
	with(importedJavaPackage){
		try {
			//password = password.toUpperCase();
			var pw = new java.lang.String(password);
			var data = pw.getBytes();
			var md = java.security.MessageDigest.getInstance("SHA-1");
			md.update(data,0,data.length);
			return byte2hex(md.digest());
		} catch (e) {
			//out.print(e);
		}
	}
}