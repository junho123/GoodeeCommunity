<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="style.css">

<script src="index.js" defer></script>
<script
src="https://kit.fontawesome.com/fbff03f786.js"
crossorigin="anonymous"
></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
   <div id="container">
        <!-- Main Navbar -->
        <nav class="navbar" id="navbar">
            <div class="navbar__logo">
                <a href="main">
                    <img src="image/logo.PNG" alt="로고">
                    <h1>구디 커뮤니티</h1>
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
                    <a href="boardList?mboard_no=1" id="free" >
                        <span>자유 게시판</span>
                    </a>
                </li>
                <li>
                    <a href="boardList?mboard_no=2" id="edu">
                        <span>학습 게시판</span>
                    </a>
                </li>
                <li>
                    <a href="boardList?mboard_no=3" id="secret">
                        <span>익명 게시판</span>
                    </a>
                </li>
                <li>
                    <a href="lunchmenu.jsp" id="lunch">
                        <span>오늘 점심 뭐먹지?</span>
                    </a>
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
        <br/>
        <div id="contents">
            <div class="section-bot">
                <div class="board-swipe">
                    <ul>
                        <li>
                           	<button class="key-color" style="top : -15px">${list[0].boardname}</button>
                        </li>
                    </ul>
                <!-- 게시글 검색바 -->
                
                </div>
		
                <div class="list-box">
                	<c:forEach items="${list }" var="bbs" varStatus="status">
	                	<ul>              	
							<li>
								<a href="boardDetail?board_no=${bbs.board_no}">
									<h3>
										<strong class="key-color" style="color:darkgreen">[${bbs.boardname}]</strong> ${bbs.bo_subject }</h3>
										<i class="icon-new"></i>
										<dl class="writing-info"> 
											<dt class="blind"></dt>
											<c:if test="${bbs.mboard_no eq 3}" >
												<dd class="writer">익명</dd>
											</c:if>
											<c:if test="${bbs.mboard_no ne 3}">
												<dd class="writer">${bbs.nickName }</dd> 
											</c:if>
											<dt class="blind"></dt>
										<dd>
											<span class="date">${bbs.bo_reg_date }</span>
											<span class="count-read">${bbs.bo_bHit }</span>
											<span class="count-likes">${blikeCnt[status.index].blike_cnt }</span>
											<span class="count-comment">${commentCnt[status.index]}</span>
										</dd>
									</dl>
								</a>
							</li>				
	                    </ul>
                    </c:forEach>                         
                </div>

                <div class="list-paging">  
                	<c:if test="${page.curPage ne 1}">
                        <button onClick="fn_paging('${page.prevPage }')">prev</button> 
                    </c:if>             
                     <c:forEach var="pageNum" begin="${page.startPage }" end="${page.endPage }">
	                     <c:choose>
		                        <c:when test="${pageNum eq  page.curPage}">
		                            <button class="on" onClick="fn_paging('${pageNum }')">${pageNum }</button> 
		                        </c:when>
		                        <c:otherwise>
		                            <button onClick="fn_paging('${pageNum }')">${pageNum }</button> 
		                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	                <c:if test="${page.curPage ne page.pageCnt && page.pageCnt > 0}">
                        	<button onClick="fn_paging('${page.nextPage }')">next</button> 
                    </c:if>
                </div>
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
	
	var mboard_no = window.location.search.substring(11);
	
	function fn_paging(curPage) {
		if(mboard_no.length > 2){
			mboard_no = window.location.search.substring(21);
		}
		location.href = "boardList?curPage="+curPage+"&mboard_no="+mboard_no;
	}		
	
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	

	var loginId = "${sessionScope.id}";
	var profile_img = $("#profile_img");
	var loginbtn = $("#login");
	if(loginId==""){
		profile_img.css({"display":"none"});	
	}else{    
	    loginbtn.css({"display":"none"});
	    profile_img.css({"display":"block"});
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