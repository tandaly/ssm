/**
 * juqery ajax session超时处理
 */


/*以下为自己扩展的*/
String.prototype.endWith=function(s){
  if(s==null||s==""||this.length==0||s.length>this.length)
     return false;
  if(this.substring(this.length-s.length)==s)
     return true;
  else
     return false;
  return true;
};

String.prototype.startWith=function(s){
  if(s==null||s==""||this.length==0||s.length>this.length)
	  return false;
  if(this.substr(0,s.length)==s)
     return true;
  else
     return false;
  return true;
};

//ajax session超时处理
$.ajaxSetup({ 
    contentType:"application/x-www-form-urlencoded;charset=utf-8", 
    //timeout:5, 
    cache:false, 
    complete:function(XHR,TS)
    { 
	   var resText=XHR.responseText; 
	   if(resText.startWith("{sessionState:0, root:")){
		   res = eval("("+resText+")");
		   if(top.art != undefined)
		   {
			   top.art.dialog.alert('操作超时,请重新登录！', function(){
				   top.document.location.href=res.root + '/login.do';
			   });
		   }
		   else
		   {
			   top.document.location.href=res.root + '/login.do'; 
		   }
	   } 
    }
}); 