<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="write&update.css">
<script src="index.js" defer></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/fbff03f786.js" crossorigin="anonymous"></script>
<title>구디 커뮤니티</title>
</head>
<body>
	<div id="container">
        <!-- Main Navbar -->
        <nav class="navbar" id="navbar">
            <div class="navbar__logo">
                <a href="index.jsp">
                    <img src="image/logo.PNG" alt="로고">
                     <c:choose>
	                   	<c:when test="${sessionScope.id eq 'admin'}">
	        				<h1>관리자 페이지</h1>
	                    </c:when>
	    				<c:otherwise>
	       					 <h1>구디 커뮤니티</h1>
	    				</c:otherwise>
	   				</c:choose>
                   
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
                <c:choose>
                   	<c:when test="${sessionScope.id eq 'admin'}">
        				<a href="mngboard.jsp" id="mngboard">
                        <span>게시글 관리</span>
                    	</a>
                    </c:when>
    				<c:otherwise>
       					<a href="boardList?mboard_no=1" id="free">
                        <span>자유 게시판</span>
                    	</a>
    				</c:otherwise>
   				</c:choose>

                </li>
                
                <li>
                    <c:choose>
                   	<c:when test="${sessionScope.id eq 'admin'}">
        				<a href="mngcomment" id="mngcomment">
                        <span>댓글 관리</span>
                    	</a>
                    </c:when>
    				<c:otherwise>
       					<a href="boardList?mboard_no=2" id="edu">
                        <span>학습 게시판</span>
                    	</a>
    				</c:otherwise>
   				</c:choose>
   
                </li>
                <li>
                    <c:choose>
                   	<c:when test="${sessionScope.id eq 'admin'}">
        				<a href="membermanagement.jsp" id="mngmember">
                        <span>댓글 관리</span>
                    	</a>
                    </c:when>
    				<c:otherwise>
       					<a href="boardList?mboard_no=3" id="secret">
                        <span>익명 게시판</span>
                    	</a>
    				</c:otherwise>
   				</c:choose>
   				
                   
                </li>
                <li>
                <c:choose>
                   	<c:when test="${sessionScope.id eq 'admin'}">
        				<a href="contact" id="ask">
                        <span>문의사항 내역</span>
                    </c:when>
    				<c:otherwise>
       					<a href="lunchmenu.jsp" id="lunch">
                        <span>오늘 점심 뭐먹지?</span>
                    	</a>
    				</c:otherwise>
   				</c:choose>
   				
              </li>
            </ul>
            
           <div class="top-util">
            	<div id="profile_img" class="boxx">
                    <jsp:include page="upmy1.jsp"/>
		        </div>
                <div class="inner">                    
                    <button id="login" class="login" onclick="location.href='login.jsp'">로그인</button>
                </div>
            </div>
        </nav>
        
        <!-- Main Contents -->
        <div id="contents">
            <!--게시글 상세보기-->
            <div class="section_top">
	            <h1>글 수정하기</h1>	
	            <div class="select-box">          
	           		<form class="searchbar" action="update?board_no=${boardDetail.board_no }" method="post">              
	                   <select style="width: 300px" name="mboard_no">
	                  		<option selected> 카테고리를 선택해주세요 </option>
	                        <option value="1">자유게시판</option>
	                        <option value="2">학습게시판</option>
	                        <option value="3">익명게시판</option>
	                   <c:choose>
	                   	<c:when test="${sessionScope.id eq 'admin'}">
	        				<option value="4">공지</option>
	                    </c:when>
	    				</c:choose>
	                    </select>
	                                <input type="text" name="subject" class="tit-input" value="${boardDetail.bo_subject }" maxlength="50" >			
					                <div class="note-editing-area">
					                       <textarea name="content" class="textarea">${boardDetail.bo_content}</textarea>
					                </div>  
					                <div class="btn-box">					
						                <button class="register">수정</button>	           							                  
						                <input type="button" class="cancle" onclick="cancle()" value="취소">             		
	            					</div> 
	            				</form>                                                     
                    </div>         
            </div>            
      </div>
    </div>
	<div id="contactsection">
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
    </div>
</body>

<script>
	var loginId = "${sessionScope.id}";
	var profile_img = $("#profile_img");
	var loginbtn = $("#login");
	if(loginId==""){
		profile_img.css({"display":"none"});	
	}else{    
	    loginbtn.css({"display":"none"});
	    profile_img.css({"display":"block"});
	}

	function cancle(){
		if(confirm("글 수정을 취소하시겠습니까 ?") == true){
			window.history.back();
		} else{
			return;
		}
	}
	
	if(loginId=="admin"){
		$("#contactsection").css({"display":"none"});
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