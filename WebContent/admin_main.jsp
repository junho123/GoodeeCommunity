<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="style.css" />
	
	<script
	src="https://kit.fontawesome.com/fbff03f786.js" crossorigin="anonymous"></script>
		<title>구디아카데미</title>	
		<style>
		table, th, tr, td {
		border: 1px solid darkolivegreen;
		border-collapse: collapse;
		text-align: center;}
		
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
       <div id="contents">
            <div class="section-top">
            <div><h3> 최근 접수된 문의 사항</h3></div>
                <div class="helplist">
                		<div id="menu">
                    <table>
                        <tr >
                            <th width="30px">No</th>
                            <th width="100px">작성자</th>
                            <th width="150px">제목</th>
                            <th width="400px">내용</th>
                            <th width="100px">이메일</th>                            
                        </tr>
                        
                        <!-- 문의사항 리스트 -->
                        <c:forEach var="contact" items="${contact}">
						<tr>
							<td><p><c:out value="${contact.contact_no}"/></p></td>
							<td><p><c:out value="${contact.writer}" /></p></td>
							<td><p><c:out value="${contact.subject}" /></p></td>
							<td><p><c:out value="${contact.content}" /></p></td>
							<td><p><c:out value="${contact.c_email}" /></p></td>
												
						</tr>		
						</c:forEach>
                         
                    </table>
                </div>
                </div>
            </div>          
                
            </div>
            </div>

	</body>
	
	<script>

	</script>
</html>