<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	    <meta charset="UTF-8">
	    	<link rel="stylesheet" type="text/css" href="style.css"/>
        	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<style>
	#layer{
	width: 40px;
	height: 40px;
	}
	#layer .pf{
	width: 40px;
	height: 40px;
	}
	</style>
</head>
<body>
	<div id="layer">
	    <div class="pic">
	        <a class="pic_1" href="#"><img class="pf" id="userphoto" src="image/member.png"  ></a>
	    </div>
	</div>
	<div id="btn">
	    <div class="imge">
	        <a href="#"><img class="imge_1" id="userphotoin" src="image/member.png"/></a>
	        <div class="nic">${sessionScope.id} 님 반가워요.</div>
	    </div>
	    <div>		    
		    
		    <div class="dmy">
		        <a href="myPageList">내정보</a>
		        <a href="logout">로그아웃</a>
		    </div>
		    
	    </div>
	</div>
</body>
<script>

var loginId = "${sessionScope.id}";

  $(document).ready(function(){
      btn = $('#layer'); 
      layer = $('#btn');
      btn.click(function(){
         layer.toggle(
           function(){layer.addClass('show')},
           function(){layer.addClass('hide')} 
         );
       });
     
      if(loginId==null){}
      else{
      $.ajax({
  	    type: "post",
        url: "userphoto",
        dataType: "JSON",
        success: function(data){
        	console.log(data.userphoto);
        	//var userphoto = "http://localhost:8080/GoodeecommunityService/memberimg/"+data.userphoto; 
			var userphoto = "image/member/"+data.userphoto;  
			console.log(userphoto);
        	$("#userphoto").attr('src',userphoto);
        	$("#userphotoin").attr('src',userphoto);        	
        },
        error: function(error){
           console.log(error);
        }
  	  	});
      }
});
</script>
</html>
