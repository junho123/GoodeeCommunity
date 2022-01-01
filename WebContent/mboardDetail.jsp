<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="D110_style.css">
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
            <!--게시글 상세보기-->
            <div class="section_top">
                <div class="title_box">
                    <input type="button" id="boarddel" value="삭제" onclick="location.href='del?board_no=${boardDetail.board_no}&mboard_no=${boardDetail.mboard_no }'"/>
                    <input type="button" id="boardupdate"  value="수정" onclick="location.href='updateForm?board_no=${boardDetail.board_no}'"/>
                    <h2><a href="#" class="key_color">${boardDetail.boardname }</a></h2>
                    <h3>${boardDetail.bo_subject }</h3>
                    <dl class="writing_info">
                        <dd class="writer">${boardDetail.nickName }</dd>
                        <span class="date">${boardDetail.bo_reg_date }</span>
                        <img src="./image/조회수.PNG" alt class="read">
                        <span class="count">${boardDetail.bo_bHit }</span>
                    </dl>
                </div>
            </div>
            
            <div class="section-bot">
                <div class="view-box">
                    <div class="txt note-editor">
                        ${boardDetail.bo_content }
                    </div>
                    <div class="share">
                        <button type="button" class="btn-like thread-likes">
                            <span class="like-count">1</span>
                        </button>
                    </div>
                </div>

                <div class="reply-box">
                    <div class="reply-area">
                        <p class="total">
                            <span class="message">댓글</span>
                            <span class="key-color">${commentCnt }</span>
                        </p>
                        <div class="reply-input">
                            <div class="reply-div">
                                <form action="reply?board_no=${boardDetail.board_no}" method="post">
										<input type="hidden" name="no" id="no" value="${ content.board_no }"> 
										<input type="hidden" name="id" id="id" value="${ id }">
										<c:choose>
                                        	<c:when test="${sessionScope.id eq null}">
	                            				<input type="text" name="co_content" id="reply_content" class="nologin-disabled" placeholder="로그인 후 댓글을 작성하실 수 있습니다." disabled>
	                        				</c:when>
	                        				<c:otherwise>
	                           					<input type="text" name="co_content" id="reply_content" class="nologin-disabled" >
	                        				</c:otherwise>
                        				</c:choose>
                        				<c:choose>
                                        	<c:when test="${sessionScope.id eq null}">
	                            				<input type="submit" class="btn-reply" id="reply_btn" value="댓글 등록" disabled>
	                        				</c:when>
	                        				<c:otherwise>
	                           					<input type="submit" class="btn-reply" id="reply_btn" value="댓글 등록">
	                        				</c:otherwise>
                        				</c:choose>
										
								</form>									
                            </div>
                        </div>
                    </div>

                    <div class="reply-list">
                        <ul>
                        	<c:forEach items="${commentList }"  var="comment">                       
	                            <li data-commentid="1027890">
	                                <div class="reply">
	                                    <div class="profile-img"></div>
	                                    <div class="txt-area">
	                                        <dl class="writing-info">
	                                        	<c:choose>
		                                        	<c:when test="${boardDetail.mboard_no eq 3}">
			                            				<dd class="writer">익명</dd>
			                        				</c:when>
			                        				<c:otherwise>
			                           					<dd class="writer">${comment.nickName }</dd>
			                        				</c:otherwise>
		                        				</c:choose>
	                                            <dd>
	                                                <span class="date">${comment.co_reg_date }</span>
	                                            </dd>
	                                        </dl>
	                                        <div class="txt.box1">
	                                            <p>${comment.co_content }</p>

	                                            <div>
		                                            <form action = "recomment?comment_no=${comment.comment_no }&board_no=${boardDetail.board_no}" method="post">
		    	                                        <input type="text" value="" name="recomment" class = "reply-inputbox" style="width : 750px">
		        	                                  	<button type="submit" class="btn-rereply">답글쓰기</button>
   	                                        		</form>
	                                        	</div>
	                                        </div>
	                                        
	                                    </div>
	                                </div>
	                            </li>              
								<c:forEach items="${recommentList }"  var="recommentList">
									<c:if test="${recommentList.comment_no eq  comment.comment_no}">
			                            <li data-commentid="102789">
			                                <div class="reply">
			                                    <div class="profile-img2"></div>
			                                    <div class="txt-area2">
			                                        <dl class="writing-info">
			                                        	<c:choose>
				                                        	<c:when test="${boardDetail.mboard_no eq 3}">
					                            				<dd class="writer">익명</dd>
					                        				</c:when>
					                        				<c:otherwise>
					                           					<dd class="writer">${recommentList.id}</dd>
					                        				</c:otherwise>
				                        				</c:choose>
			                                            <dd>
			                                                <span class="date">${recommentList.reco_reg_date}</span>
			                                            </dd>
			                                        </dl>
			                                        <div class="txt.box1">
			                                            <p>${recommentList.reco_content }</p>
			                                            <c:if test="${recommentList.id } eq ${sessionScope.id }">
			                                            	<button class="btn-coment-reply" onclick="recommentDel(${recommentList.recomment_no})">삭제</button>
			                                            </c:if>
			                                        </div>
			                                    </div>
			                                </div>
			                            </li>
		                            </c:if>
	                            </c:forEach>
                            </c:forEach>                        
                        </ul>                        
                    </div>                                      
                </div><!-- section-bot 끝 -->
                
                <button class="btn-list" onclick='location.href="mngboard.jsp"'>목록으로</button> <!-- 이 부분을 해결해야할 거 같네욥... 어디로 이동해야하지 -->
            </div>
        </div>
     </div>   
            
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}

	function likeCall(){
		$.ajax({
	        type: "post",
	        url: "detailLikeCnt",
	        data: {"board_no":${boardDetail.board_no}},
	        dataType: "JSON",
	        success: function(data){
	        	console.log(data);
	        	$('.like-count').html(data.detailLikeCnt);
	        	if(data.likeStatus){
	        		$('#like-img').attr("src","./image/icon_heart_red.gif");
	        	} else{
	        		$('#like-img').attr("src","./image/icon_heart_empty.gif");
	        	}
	        },
	        error: function(error){
	           console.log(error);
	        }
	     });
	}

	likeCall();

	$('.btn-like').click(function(){
		
		if("${sessionScope.id}"==""){
			alert("로그인 후 이용 가능합니다.");
		} else {
			$.ajax({
		        type: "post",
		        url: "like",
		        data: {"board_no":${boardDetail.board_no}},
		        dataType: "JSON",
		        success: function(data){
		        	if(data.result){
		        		console.log(data);
		        		likeCall();
		        	}
		        },
		        error: function(error){
		           console.log(error);
		        }
		     });
		}

	});

	
</script>
</html>
