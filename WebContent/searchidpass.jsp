<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>구디 커뮤니티</title>
	<script src = "https://code.jquery.com/jquery-3.5.1.min.js"> </script>
	<link rel="stylesheet" href="style.css">
	<script src="index.js" defer></script>
	<script src="https://kit.fontawesome.com/fbff03f786.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<style>
	.navbar__logo {
		position: absolute;
		left: 363px;
		top: 50px;
	}
	
	.navbar__logo img {
	    width: 150px;
		height: 150px;
		border-radius: 50%;
	}
	
	.searchbox{
		position: absolute;
		left: 30%;
		top: 30%;
		border: 3px solid rgb(148, 186, 201);
		font-size: large;
		background-color: rgb(224, 220, 213);
		width: 735px;
		height: 365px;
		
	}

	.searchboxx{
		position: relative;
		left: 50px;
		top: 20px;
	}
	
	table, tr, td{
		text-align:center;
		}
	
	body {
		background-image: url('./image/backgroundimg3.png');
		background-repeat: no-repeat;
		background-size: cover;
	}
	</style>
</head>

<body>
    <div class="navbar__logo">
            <a href="main">
                <img src="image/logo.PNG" alt="로고">
             </a>
    </div>           

	<div class= "searchbox">
		<div class="searchboxx">
			<h2> ID 찾기</h2>		
				<div>
					이메일을 입력해주세요
					<input type="email" id="email"> <button id="findid" onclick="findid()">ID 찾기</button>			
				</div>
			<h2> 비밀번호 찾기</h2>
				<div>
					<p>이메일을 입력해주세요. 입력하신 이메일로 임시 비밀번호를 발송해드립니다.</p>						
					<p><td>이메일 : <input type="email" name="u_email"> <button id="auth">임시비밀번호 발송</button></td></p>				
				</div>			
		</div>
	</div>

    <div class="helpIcon">
        <i class="far fa-comment-dots"></i>   
    </div>  
    <div class="helpIcon__content">
        <div class="helpIcon__title">
            <br><br>
            <p>무엇을 도와드릴까요?</p>
            <p>문의 주신 내용은 확인 후 답변 드리겠습니다.</p>
        </div>
        <div class="helpIcon__input">
            <br><br>
            <input type="text" placeholder="   작성자"> 
            <input type="text" placeholder="   제목">
            <input type="text" placeholder="   이메일">
            <textarea type="text" placeholder="     문의 내용"></textarea>
            <br><br>
            <button>보내기</button>
        </div>
    </div>


</body>	

<script>
	$("#auth").click(function(){
		if($("input[name='u_email']").val() == ""){
			alert("이메일을 입력해주세요");
		}else{
			var $u_email = $("input[name='u_email']");
			var param = {};
			param.email = $u_email.val();
			
			$.ajax({
				type: "post",
				url: "findpw",
				data: param,
				dataType: "JSON",
				success: function(data){
					alert(data.msg);
				},
				error: function(error){
					console.log(error);
				}
			});
		}					
	});

	function findid(){
		var email = $("#email").val();
		console.log(email); // 잘 들어오는 지 확인: 1차
		
		$.ajax({
			type: "get",
			url: "findid",
			data: {"email":email},
			dataType: "JSON",
			success: function(data){
				console.log(data.searchedid);
				var id = data.searchedid;
				console.log(id);
				if(id!==""){alert("회원님의 아이디는: "+id+"입니다.");}
				else{alert("입력하신 이메일로 가입된 정보가 없습니다.");}				
			},
			error: function(e){
				console.log(e);
			}			
		});		
	}
	
	//문의사항 보내기
	$("#ct_send").click(function(){

		var param = {};
		
		param.writer = $("input[name='writer']").val();
		param.subject = $("input[name='subject']").val();
		param.c_email = $("input[name='c_email']").val();
		param.content = $("textarea[name='content']").val();
		
		$.ajax({
	        type: "post",
	        url: "contactWrite",
	        data: param,
	        dataType: "JSON",
	        success: function(data){
	        	alert(data.contactmsg);
	        	$(".helpIcon__content").fadeOut();
	        },
	        error: function(error){
	        	alert(data.contactmsg);
	        }
	     }); // 쓰기는 되는데 왜 원래 화면으로 안돌아오는 걸까?

	});
</script>
</html>