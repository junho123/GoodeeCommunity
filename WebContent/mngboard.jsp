<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
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
	select {
	width: 150px;
	height: 40px;
	margin: 30px;
	}
	#mngboardlist{
	display: none;}

	#content{
	left: 150px;
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
            <div class="mtitle"><h1>게시글 관리</h1></div>   
            
            <div id="content">
	    	<div class="selectbox">
		        <select name="mngboard" onchange="listCall()">
		        	<option selected value="0"> ----------- </option>
					<option value="1">자유게시판</option>
					<option value="2">학습게시판</option>
					<option value="3">익명게시판</option>
					<option value="4">공지</option>
				</select>
			</div>
			
	        <div id="mngboardlist" style="left: 262px; position: relative;">       
	            <table id="listsection">
    			    <thead>
    			    <tr style="background-color: rgb(138, 190, 59)">
						<th>no.</th> 
						<th>제목</th> 
						<th>작성자</th> 
						<th>조회수</th> 
						<th>등록일</th>
						<th>삭제</th>
				     </tr> 
				     </thead>
					     <tbody>
					     </tbody>
				     </table>
	        </div>
             
         </div>
        </div>
	</body>
	
	<script>

	function listCall(){		
		var val = $("select[name='mngboard']").val();
		console.log(val);

		if (val!=0){
		$.ajax({
	        type: "post",
	        url: "mngboard",
	        data: {"mBoard_no": val},
	        dataType: "JSON",
	        success: function(data) {
	            console.log(data.list);
	            drawTable(data.list);
	        },
		    error: function() {
		        console.log(data);
		    }
	    });
		}else{
			$("#mngboardlist").css({"display": "none"});
			}
	}
	
	function drawTable(list){
		$("#mngboardlist").css({"display": "block"});
		var content = "";
		   $("tbody").empty();   
		   list.forEach(function(item,num){
		      console.log(num,item);
		      content = "<tr><td>"+item.board_no+"</td>"
		         +"<td><a href='mngboardDetail?board_no="+item.board_no+"'>" // 위치 조정 필요...
		        +item.bo_subject+"</td></a><td>"+item.id+"</td><td>"
		         +item.bo_bHit +"</td><td>"+item.bo_reg_date
		         +"</td><td><a href='del?board_no="+item.board_no+"'> 삭제 </a></td></tr>";
		         $("tbody").append(content);
		   });
	}
	
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
		
</script>
</html>