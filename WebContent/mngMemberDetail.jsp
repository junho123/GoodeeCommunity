<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@900&family=Source+Sans+Pro:wght@600&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="style.css">
	<link rel="stylesheet" href="manageDetail.css">
	<script src="https://kit.fontawesome.com/fbff03f786.js" crossorigin="anonymous"></script>
	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
                <form class="searchbar" action="writeView" method="get">
                    <input
                      class="search"
                      type="text"
                      name="search"
                    />
                    <button><i class="fas fa-search"></i></button>
                </form>
            </div>	
            
            <button class="write" location.href="writeViews">
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
                    <a href="mngcomment.jsp" id="mngcomment">
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
            <div class="mtitle"><h1>회원 상세 관리</h1></div> 
                       

            <div class="upmy1">
            <div class="upmy2">
                <div class="upmy3_1">
                
                <div class="upimge">
                    <a href="#"><img class="imge_1" src="image/member.png"/></a>
                    <div class="u">
                    <button class="delete">삭제</button>                    
                    </div>
                </div>
                
                </div>
                
             	  <form action="mngUpdate" method="post">
                
	                <div class="upmy3_2">
	                
	                <div class="u3_2">
	                    <div><b>닉네임 : </b><input type="text" value="${mylist.nickName }" name="nickName"><input type="button" id="nickChck" value="중복확인"/></div></br>
	                </div>
	                <div class="u3_2">
	                    <div><b>아이디 : </b><input type="text" name="id" value="${mylist.id}"  readonly></div><br/>
	                </div>
	                <div class="u3_2">
	                    <div><b>이름 : </b><input type="text" name="name" value="${mylist.name}" ></div><br/>
	                </div>
	                
	                
	                </div>
	                
	                <div class="upfn">
	                	<input type="submit" id="mngUpdate" value="수정" style="width: 100px; height: 50px;"></button>
	                </div>
                 </form>
	                <div class="upcant">
        	              <input type="button" id="mngOut" value="회원 탈퇴" onclick="location.href='mngOut?id=${mylist.id}'" style="width: 100px; height: 50px;" />
	                </div>
                
                
	            </div>
	            <div class="upmy2_1">
	                <ul>
	                    <li>
	                        <a href="">
	                            <div class="screen">
	                                <button class="myWrite">작성한 글</button>
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="">
	                            <div class="screen">
	                                <button>댓글 단 글</button>
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="">
	                            <div class="screen">
	                                <button>좋아요 한 글</button>
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="">
	                            <div class="screen">
	                            <button>작성한 학습사항</button>
	                            </div>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	            <div class="dap">
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
           
            
</body>
<script>

	//메세지
	var msg = "${msg}";
	if(msg!=""){alert(msg);}

	//회원탈퇴 알림
	$("#mngOut").click(function(){
		alert("정말 탈퇴 하시겠습니까?");
	});
	
	//수정 확인
	$("#mngUpdate").click(function(){
		if(confirm("정말 수정하시겠습니까 ?") == true){
	        location.href="mngUpdate";
	    }else{
	        return ;
	    }
	});	
	
	/*닉네임 중복 확인*/
	  $("#nickChck").click(function(){
			if($("input[name='nickName']").val() == ""){
				alert("닉네임을 입력해주세요.");
			}else{
				var nickname = $("input[name='nickName']").val(); // id값 가져오기
				console.log(nickname); // 잘 들어오는 지 확인: 1차
				
				$.ajax({
					type: "get",
					url: "overlaynick",
					data: {"nickname":nickname},
					dataType: "JSON",
					success: function(data){		
						if(data.overlay){
							alert("이미 사용중인 닉네임입니다.");
							$("input[name='nickName']").val("");
						}else{
							alert("사용 가능한 닉네임입니다");
							overChknic = true;
						}
					},
					error: function(e){
						console.log(e);
					}			
				});
			}
		});
	
		function fn_paging(curPage) {
			if(mboard_no.length > 2){
				mboard_no = window.location.search.substring(21);
			}
			location.href = "boardList?curPage="+curPage+"&mboard_no="+mboard_no;
		}	
	  
</script>
</html>