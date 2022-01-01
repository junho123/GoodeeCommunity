<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구디 커뮤니티</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    	<link rel="stylesheet" href="style.css">
	<script src="index.js" defer></script>
	<script src="https://kit.fontawesome.com/fbff03f786.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<style>
	body {
		background-image: url('./image/backgroundimg2.png');
		background-repeat: no-repeat;
		background-size: cover;
	}


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
	
	.joinbox{
		position: absolute;
		left: 30%;
		top: 30%;
		width: 550px;
		height: 400px;
		border: 3px solid rgb(148, 186, 201);
		font-size: large;
		padding-left: 70px;

		background-color: rgb(224, 220, 213);
	}
	
	table, td,tr {
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
	padding: 5px 10px;
	}	
	
	</style>
</head>
	<body>
         <div class="navbar__logo">
                <a href="main">
                    <img src="image/logo.PNG" alt="로고">
                 </a>
         </div>       
            
         <div class="joinbox">
            <h3> 회원 가입 </h3>
			<table>
				<tr>
					<td> 아이디* </td>
					<td> <input type="text" name="id"/> <input type="button" id="idChck" value="ID중복확인"/></td>
				</tr>
				<tr>
					<td> 비밀번호* </td>
					<td> <input type="password" name="pw"/></td>
				</tr>
				<tr>
					<td> 비밀번호확인* </td>
					<td> <input type="password" name="pwChck"/></td>
				</tr>		
				<tr>
					<td> 닉네임* </td>
					<td> <input type="text" name="nickName"/> <input type="button" id="nickChck" value="중복확인"/></td>
				</tr>		
				<tr>
					<td> 이름* </td>
					<td> <input type="text" name="name"></td>
				</tr>		
				<tr>
					<td> 이메일 </td>
					<td> <input type="email" name="u_email"> <button id="auth">인증 코드 발송</button></td>
				</tr>
				<tr>
					<td colspan="2">인증 코드 입력 : <input type="text" name="auth"> <button id="authChk">인증하기</button> </td>
				</tr>
				<tr>
					<td colspan="2"> <input type = "button" id="join" value="회원가입"> </td>
				</tr>			
			</table>
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
            <input type="text" name="writer" placeholder="   작성자"> 
            <input type="text" name="subject" placeholder="   제목">
            <input type="text" name="c_email" placeholder="   이메일">
            <textarea type="text" name="content" placeholder="     문의 내용"></textarea>
            <br><br>
            <button id="ct_send">보내기</button>
        </div>
    </div>
       	
	</body>

<script>
var overChk = false;
var overChknic = false;
var dice = null;
var emailChk = 0;

$("#auth").click(function(){
	if($("input[name='u_email']").val() == ""){
		alert("이메일을 입력해주세요");
	}else{
		var $email = $("input[name='u_email']");
		var param = {};
		param.email = $email.val();
		
		$.ajax({
			type: "post",
			url: "mail",
			data: param,
			dataType: "JSON",
			success: function(data){
				alert("인증코드가 전송되었습니다. 이메일을 확인해주세요");
				dice = data.dice;
			},
			error: function(error){
				console.log(error);
			}
		});
	}					
});

$("#authChk").click(function(){
	if($("input[name='auth']").val() == dice){
		emailChk = 1;
		alert("인증번호가 확인되었습니다.");
	} else {
		alert("인증번호를 다시 확인해주세요.");
	}
});

$("#idChck").click(function(){
	if($("input[name='id']").val() == ""){
		alert("아이디를 입력해주세요.");
	}else{
		var id = $("input[name='id']").val();
		$.ajax({
			type: "get",
			url: "overlay",
			data: {"id":id},
			dataType: "JSON",
			success: function(data){
				console.log(data);
				if(data.overlay){
					alert("이미 사용중인 ID 입니다.");
					$("input[name='id']").val("");
				}else{
					alert("사용 가능한 ID 입니다");
					overChk = true;
				}
			},
			error: function(e){
				console.log(e);
			}			
		});
	}
});

$("#nickChck").click(function(){
	if($("input[name='nickName']").val() == ""){
		alert("닉네임을 입력해주세요.");
	}else{
		var nickname = $("input[name='nickName']").val(); // id값 가져오기
		console.log(nickname); // 잘 들어오는 지 확인: 1차
		
		$.ajax({
			type: "get",
			url: "overlaynick",
			data: {"nickname":nickname},
			dataType: "JSON",
			success: function(data){		
				if(data.overlay){
					alert("이미 사용중인 닉네임입니다.");
					$("input[name='nickName']").val("");
				}else{
					alert("사용 가능한 닉네임입니다");
					overChknic = true;
				}
			},
			error: function(e){
				console.log(e);
			}			
		});
	}
});


$("#join").click(function(){
	var $id = $("input[name='id']");
	var $pw = $("input[name='pw']");
	var $pwChck = $("input[name='pwChck']");
	var $name = $("input[name='name']");
	var $nickName = $("input[name='nickName']");
	var $email = $("input[name='u_email']");
	var $emailChk =$("input[name='auth']");
	
	console.log($id);
	console.log($pw);
	console.log($name);
	
	if($pw.val()==$pwChck.val()){}else{
		alert("비밀번호가 일치하지 않습니다.")
		$("input[name='pw]").focus();
	};		
	
	
	if(overChk&&overChknic){			
		if($id.val()==""){
			alert("아이디를 확인해주세요");
			$id.focus();
		}else if($pw.val()==""){
			alert("비밀번호를 입력해주세요");
			$pw.focus();
		}else if($pwChck.val()==""){
			alert("비밀번호를 확인해주세요");
			$pwChck.focus();
		}else if($nickName.val()==""){
			alert("닉네임을 입력해주세요");
		}else if($name.val()==""){
			alert("이름을 입력해주세요");
			$name.focus();
		}else if($email.val()==""){
			alert("이메일을 입력해주세요");
			$email.focus();
		}else if(emailChk != 1){
			alert("이메일 인증을 완료해주세요.");
			$('#auth').focus();
		}else{// 모든 항목을 입력했을 경우
			console.log("서버로 전송");
			
			var param = {};
			param.id = $id.val();
			param.pw = $pw.val();
			param.name = $name.val();
			param.nickName = $nickName.val();
			param.email = $email.val();
			param.emailChk = emailChk;
			
			console.log('param:' , param); // 콘솔에 +찍으면 문자열로 바뀜
			
			$.ajax({
				type: "post",
				url: "join",
				data: param,
				dataType: "JSON",
				success: function(data){
					console.log(data.join);
					if(data.join){
						alert("회원가입에 성공하였습니다. ");
						location.href="main";
					}else{
						alert("회원가입에 실패하였습니다.");
						location.href="joinform.jsp";
					}
				},
				error: function(error){
					console.log(error);
				}
			});
		}			
		
	}else{
		alert("중복체크를 확인해 주세요");
		$("input[name='id']").focus();
	}
});

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