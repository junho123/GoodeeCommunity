<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title> 구디 커뮤니티</title>
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="style.css" />
		<link rel="stylesheet" type="text/css" href="M05_contact.css" />
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="index.js" defer></script>
		<script src="https://kit.fontawesome.com/fbff03f786.js" crossorigin="anonymous"></script>
		<style>
		table, th, tr, td {
		border-collapse: collapse;}
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
            <div class="section-topp"><h1>문의사항</h1>
                <div id="menu">
                    <table>
                        <tr>
                            <th>No</th>
                            <th>작성자</th>
                            <th>제목</th>
                            <th>내용</th>
                            <th>이메일</th>
                            <th>상태</th>
                        </tr>
                        
                        <!-- 문의사항 리스트 -->
                        <c:forEach var="contact" items="${contact}">
						<tr>
							<td><c:out value="${contact.contact_no}"/></td>
							<td><c:out value="${contact.writer}" /></td>
							<td><c:out value="${contact.subject}" /></td>
							<td><p><c:out value="${contact.content}" /></p></td>
							<td><p><c:out value="${contact.c_email}" /></p></td>
							<c:if test="${contact.c_status eq 0}">
								<td><p> <input type="button" class="status" value="접수" onclick="stateSet(${contact.c_status}, ${contact.contact_no})"></p></td>
							</c:if>
							<c:if test="${contact.c_status eq 1}">
								<td><p> <input type="button" class="status" value="완료" onclick="stateSet(${contact.c_status}, ${contact.contact_no})"></p></td>
							</c:if>
							
						</tr>		
						</c:forEach>
                         
                    </table>
                </div>
        </div>  
    </div>
      
</body>
<script>

var msg = "${msg}";
if(msg != ""){
	alert(msg);
}



//접수&완료 버튼

function stateSet(status, contact_no){
	if(confirm("문의사항을 처리하시겠습니까?") == true){ 
		location.href="contactState?c_status="+status+"&contact_no="+contact_no;
    }
    else {
    	return;
    }
}

</script>
</html>