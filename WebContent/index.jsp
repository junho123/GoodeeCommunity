<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html id="html">
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="style.css" />
<script src="index.js" defer></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/fbff03f786.js" crossorigin="anonymous"></script>
<title>구디 커뮤니티</title>
<style>
textarea{
	resize: none;
    width: 229px;
    height: 297px;
}

div #comalert{
background-color: red;
}
* {box-sizing: border-box}
body {font-family: Verdana, sans-serif; margin:0}
.mySlides {display: none}
img {
	vertical-align: middle;
	height: 281px;
}

/* Slideshow container */
.slideshow-container {
  max-width: 1000px;
  height: 275px;
  position: relative;
  margin: auto;
}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  padding: 16px;
  margin-top: -22px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 15px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  cursor: pointer;
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active, .dot:hover {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
  .prev, .next,.text {font-size: 11px}
}

</style>

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
            	<div id="comalert"></div>
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
            <div class="section-top">
                <div class="img-swipe">
					<div class="slideshow-container">

						<div class="mySlides fade">
						  <div class="numbertext">1 / 3</div>
						  <img src="./image/lunch_04.jpg" style="width:100%">
						  <div class="text">8월20일</div>
						</div>
						
						<div class="mySlides fade">
						  <div class="numbertext">2 / 3</div>
						  <img src="./image/lunch_03.jpg" style="width:100%">
						  <div class="text">8월19일</div>
						</div>
						
						<div class="mySlides fade">
						  <div class="numbertext">3 / 3</div>
						  <img src="./image/lunch_02.jpg" style="width:100%">
						  <div class="text">8월 18일</div>
						</div>
						
						<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
						<a class="next" onclick="plusSlides(1)">&#10095;</a>
						
						</div>
						<br>
						
						<div style="text-align:center">
						  <span class="dot" onclick="currentSlide(1)"></span> 
						  <span class="dot" onclick="currentSlide(2)"></span> 
						  <span class="dot" onclick="currentSlide(3)"></span> 
						</div>
                </div>
                <div class="today-memo">
                	<form action="memoWrite" method="post">
	                	 <input type="text" name="subject" class="tit-input" placeholder="제목" maxlength="50" required>			
								<div class="note-editing-area">
				                	<textarea name="content" class="mtextarea" required></textarea>
				                </div>  
				                <div class="btn-box">					
					                <button id="memo_register" class="register">등록</button>     		
            					</div> 
					</form>
                </div>
            </div>

            <div class="section-bot">
                <div class="board-swipe">
                    <ul>
						<li>
						<button class="key-color" onclick="location.href='main'" style="border-color: darkgreen;">전체 게시판</button>
						</li>
						<li>
							<button id=notice onclick="location.href='boardList?mboard_no=4'" style="border-color: darkgreen;">공지사항</button>
						</li>
                    </ul>                   
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
											<span class="count-comment">${commentCnt[status.index] }</span>
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
            <input type="text" id="writer1" placeholder="   작성자" required> 
            <input type="text" id="subject1" placeholder="   제목" required>
            <input type="text" id="c_email1" placeholder="   이메일" required>
            <textarea type="text" id="content1" placeholder="     문의 내용" required></textarea>
            <br><br>
            <button id="ct_send">보내기</button>
        </div>
    </div>
</body>

<script>

var writeMsg = "${writeMsg}";
if(writeMsg != ""){
	alert(writeMsg);
	location.href = "login.jsp";
}

// 아이디가 있는지 체크
var loginId = "${sessionScope.id}";

console.log(loginId);
//관리자 로그인시 관리자 페이지로! // 메인 불러오는 것+문의 불러오기 그 다음에 이동하기
if(loginId!="admin"){}else{location.href="contactmain";}

//세션에 저장된 경우 로그인버튼을 비활성화하기
var profile_img = $("#profile_img");
var loginbtn = $("#login");

if(loginId==""){
	loginbtn.css({"display":"block"});
	profile_img.css({"display":"none"});
}else{
    loginbtn.css({"display":"none"});
    profile_img.css({"display":"block"});
}

//문의사항 보내기
$("#ct_send").click(function(){
		var param = {};		
		param.writer = $("#writer1").val();
		console.log(param.writer);
		param.subject = $("#subject1").val();
		console.log(param.subject);
		param.c_email = $("#c_email1").val();
		console.log(param.c_email);
		param.content = $("#content1").val();
		console.log(param.content);
		
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
	     });
	});

	function fn_paging(curPage) {
		location.href = "main?curPage="+curPage;
	}		
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
/*
 실시간 댓글 알림: 5초마다
	var comalert = $("#comalert");
		
	window.setInterval("refreshDiv()", 5000);
	function refreshDiv(){
		 $("#comalert").load(window.location.href + "#comalert"); // 특정영역 다시 부르기
		
		$.ajax({
	        type: "post",
	        url: "commentalert",
	        dataType: "JSON",
	        success: function(data){
	        	console.log(data.contactmsg);
	        	alert("msg");
	        	comalert.css({"background-color":"red","color":"white"});
	        	comalert.hthl("N");
	        },
	        error: function(error){
	           console.log(error);
	        }
	     });	 
	}

	*/
	/*슬라이드 쇼*/
	var slideIndex = 1;
	showSlides(slideIndex);

	function plusSlides(n) {
	showSlides(slideIndex += n);
	}

	function currentSlide(n) {
	showSlides(slideIndex = n);
	}

	function showSlides(n) {
	var i;
	var slides = document.getElementsByClassName("mySlides");
	var dots = document.getElementsByClassName("dot");
	if (n > slides.length) {slideIndex = 1}    
	if (n < 1) {slideIndex = slides.length}
	for (i = 0; i < slides.length; i++) {
		slides[i].style.display = "none";  
	}
	for (i = 0; i < dots.length; i++) {
		dots[i].className = dots[i].className.replace(" active", "");
	}
	slides[slideIndex-1].style.display = "block";  
	dots[slideIndex-1].className += " active";
	}
	

</script>
</html>