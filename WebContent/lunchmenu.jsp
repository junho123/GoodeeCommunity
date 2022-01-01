<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="D130_style.css">
<script src="index.js" defer></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
src="https://kit.fontawesome.com/fbff03f786.js"
crossorigin="anonymous"
></script>
<title>구디 커뮤니티</title>
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
                    <a href="boardList?mboard_no=1">
                        <span>자유 게시판</span>
                    </a>
                </li>
                <li>
                    <a href="boardList?mboard_no=2">
                        <span>학습 게시판</span>
                    </a>
                </li>
                <li>
                    <a href="boardList?mboard_no=3">
                        <span>익명 게시판</span>
                    </a>
                </li>
                <li>
                    <a href="lunchmenu.jsp">
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
            <!--오늘 점심 뭐먹지-->
            	<div class="board-name"><h3>오늘 점심 뭐먹지?</h3></div>
            <button class="menutype-select">한식</button>
            <button class="menutype">중식</button>
            <button class="menutype">일식</button>
            <button class="menutype">양식</button>
            <button class="menutype">분식</button>
            <button class="menutype">배달맛집</button>

            <!--메인-->
            <div class="menu-board">
                <div class="menu1" style="cursor: pointer;" onclick="location.href='https:store.naver.com/restaurants/detail?id=38675031';">
                    <div class="menu-image1">
                        <span class="koreamenu-name1">동남부대찌개</span>
                        <img src="./image/전화아이콘.PNG" class="telimg1">
                        <span class="koreamenu-tel1">02-867-0849</span>
                        <img src="./image/지도아이콘.PNG" class="mapimg1">
                        <div class="koreamenu-map1">서울 금천구 가산디지털2로 142-3</div>
                        <div class="moresee1">더보기 ></div>
                    </div>
                </div>
            
            
                <div class="menu2" style="cursor: pointer;" onclick="location.href='https:store.naver.com/restaurants/detail?id=1029449605';">
                    <div class="menu-image2">
                        <span class="koreamenu-name2">육전국밥</span>
                        <img src="./image/전화아이콘.PNG" class="telimg2">
                        <span class="koreamenu-tel2">02-854-8222</span>
                        <img src="./image/지도아이콘.PNG" class="mapimg2">
                        <div class="koreamenu-map2">서울 금천구 가산디지털2로 136</div>
                        <div class="moresee2">더보기 ></div>
                    </div>
                </div>

                <div class="menu3" style="cursor: pointer;" onclick="location.href='http:store.naver.com/restaurants/detail?id=1001630614&query=%EB%AA%A8%EB%91%90%EA%B5%AD%EB%B0%A5';">
                    <div class="menu-image3">
                        <span class="koreamenu-name3">모두국밥</span>
                        <img src="./image/전화아이콘.PNG" class="telimg3">
                        <span class="koreamenu-tel3">02-2025-4123</span>
                        <img src="./image/지도아이콘.PNG" class="mapimg3">
                        <div class="koreamenu-map3">서울 금천구 가산디지털2로 123</div>
                        <div class="moresee3">더보기 ></div>
                    </div>
                </div>

                <div class="menu4" style="cursor: pointer;" onclick="location.href='https:store.naver.com/restaurants/detail?id=21369601';">
                    <div class="menu-image4">
                        <span class="koreamenu-name4">돈보따리</span>
                        <img src="./image/전화아이콘.PNG" class="telimg4">
                        <span class="koreamenu-tel4">02-855-5550</span>
                        <img src="./image/지도아이콘.PNG" class="mapimg4">
                        <div class="koreamenu-map4">서울 금천구 가산디지털2로 142-9</div>
                        <div class="moresee4">더보기 ></div>
                    </div>
                </div>

                <div class="menu5" style="cursor: pointer;" onclick="location.href='https:store.naver.com/restaurants/detail?id=34034063&tab=main';">
                    <div class="menu-image5">
                        <span class="koreamenu-name5">토마토김밥</span>
                        <img src="./image/전화아이콘.PNG" class="telimg5">
                        <span class="koreamenu-tel5">02-861-8484</span>
                        <img src="./image/지도아이콘.PNG" class="mapimg5">
                        <div class="koreamenu-map5">서울 금천구 서부샛길 606</div>
                        <div class="moresee5">더보기 ></div>
                    </div>
                </div>

                <div class="list-box">   
                    <div class="list-paging">
                    <button id="1" class="on">1</button>
                    <button id="2">2</button>
                    <button id="3">3</button>
                    <button id="4">4</button>
                    <button id="5">5</button>
                    <button id="next">next</button>
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