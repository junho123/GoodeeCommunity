<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="manage.css">
<script
src="https://kit.fontawesome.com/fbff03f786.js" crossorigin="anonymous">
</script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>구디 커뮤니티</title>
<style>
#delbutton{
	position : fixed;
	right : 15%;
	bottom : 10%; 
}


</style>

</head>
<body>
		<div id="container">
        <!-- Main Navbar -->
        <nav class="navbar" id="navbar">
            <div class="navbar__logo">
                <a href="index.jsp">
                    <img src="image/logo.PNG" alt="로고">
                    <h1>관리자 페이지</h1>
                </a>
            </div>
            <div class="search-input">
                <form class="searchbar" action="search" method="get">
                    <input
                      class="search"
                      type="text"
                      name="search"
                    />
                    <button><i class="fas fa-search"></i></button>
                </form>
            </div>	
            
            <button class="write" onclick="location.href='writeView'">
                글쓰기
            </button>
    
            <ul class="navbar__menu">
                <h2>전체 게시판</h2>
                <li>
                    <a href="mngboard.jsp" id="mngboard">
                        <span>게시글 관리</span>
                    </a>
                </li>
                <li>
                    <a href="mngcomment" id="mngcomment">
                        <span>댓글 관리</span>
                    </a>
                </li>
                <li>
                    <a href="membermanagement.jsp" id="mngmember">
                        <span>회원 관리</span>
                    </a>
                </li>
                <li>
                    <a href="contact" id="ask">
                        <span>문의사항 내역</span>
                    </a>
                </li>
            </ul>
            
            <div class="top-util">
            	<div class="inner">
               		<button onclick="location.href='logout'"> 로그아웃 </button>
                  <button type="button" class="profile">
                      <div class="profile-img"></div> </button>
                </div>
            </div>
        </nav>
        
        <!-- Main Contents -->
        <div id="contents">
            <div class="mtitle"><h1>회원 관리</h1></div>            
            <div class="section-top2">
                    <table class="member_manage">
                    	<thead>
	                        <tr style="background-color: rgb(138, 190, 59)">
	                            <th>회원ID</th>
	                            <th>이름</th>
	                            <th class="nickName">닉네임</th>
	                            <th>이메일</th>
	                            <th>선택</th>
	                        </tr>
                        </thead>
						<tbody>
              			</tbody>              			
                    </table>
                  
            </div>                    
 				  <button id="delbutton" class="delete" onclick="del()">삭제</button>
        </div>    
	</div>   
            
</body>
<script>



function listCall(){
	$.ajax({
		type:"post",
		url:"m_memberlist",
		data:{},
		dataType:"JSON",
		success:function(data){
			console.log(data);
			if(!data.login){
				alert("로그인이 필요한 서비스 입니다.");
				location.href="login.jsp";
			}else{
				console.log("데이터 불러와졌나요?"+data);
				drawTalbe(data.list);
			}
		},
		error:function(e){
			console.log(e);
		}
	});
}

function drawTalbe(list){
	var content = "";
	$("tbody").empty();
	list.forEach(function(item,num){
		console.log(num,item);
		content = "<tr><td><a href='mngdetail?id="+item.id+"'>"+item.id+"</a></td>"
		+"<td>"+item.name+"</td>"
		+"<td>"+item.nickName+"</td>"
		+"<td>"+item.u_email+"</td>"
		+"<td><input type='checkbox' value='"+item.id+"'/></td></tr>";
		$("tbody").append(content);
	});	
}

function del(){
	var checkArr = [];
	$("input[type='checkbox']:checked").each(function(id,item){
		//console.log(idx,$(this).val());
		checkArr.push($(this).val())
	});
	console.log(checkArr);
	
	$.ajax({
		type:"get",
		url:"memberDel",
		data:{"delList":checkArr},
		dataType:"JSON",
		success:function(result){
			if(result.del){
				alert("회원 삭제에 성공 했습니다.");
			}
			listCall();
		},
		error:function(e){
			console.log(e);
		}
	});
}

listCall();
</script>
</html>