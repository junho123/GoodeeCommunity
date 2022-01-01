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
            
            <button class="write" onclick="location.href='write.jsp'">
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
        <div id="contents">
            <div class="section-bot">
                <div class="board-swipe">
                    <ul>
                        <li>
                           	<button class="key-color" style="top : -35px">검색 결과</button>
                        </li>
                    </ul>
                <!-- 게시글 검색바 -->
                <div class="board_search-input">
	                <form class="searchbar" action="search" method="get" >
	                    <select>
							<option>제목</option>
						</select>
	                    <input
	                      class="search"
	                      type="text"
	                      name="search"
	                    />
	                    <button style="left : 100px"><i class="fas fa-search"></i></button>
	                </form>
            	</div>
                </div>
		
                <div class="list-box">
                	<c:forEach items="${list }" var="bbs" varStatus="status">
	                	<ul>              	
							<li>
								<a href="boardDetail?board_no=${bbs.board_no}">
									<h3>
										<strong class="key-color">[${bbs.boardname}]</strong> ${bbs.bo_subject }</h3>
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
</body>
<script>

	
	function fn_paging(curPage) {
		location.href = "search?curPage="+curPage+"&search="+"${search}";
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
	
</script>
</html>