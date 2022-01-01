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
	<script src="index.js" defer></script>
	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>구디 커뮤니티</title>
<style>

#commentlist{
	display: none;
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
     <div class="mtitle"><h1> 마이페이지</h1></div> 
            
    <div class="upmy1">    
      <div class="upmy2">      
        <div class="upmy3_1">          
          <div class="upimge">
           <c:choose>
	                   	<c:when test="${sessionScope.userphoto ne null}">
	        				<img width="255px" height="255px" class="imge_1" id="userphoto" src="image/member/${sessionScope.userphoto}"/>
	        			 </c:when>
	    				<c:otherwise>
	       					 <img class="imge_1" id="userphoto" src="image/member.png"/>
	    				</c:otherwise>
	   				</c:choose>
         
            <div class="u">
              <button onclick="openwindow()">등록</button>
              <a href="photoDel"><button>삭제</button></a>
            </div>
          </div>          
        </div>
        
        <form action="myUpdate" method="post">
	        <div class="upmy3_2">         
	          <div class="u3_2">
	            <div><b>닉네임 : </b><input type="text" value="${mylist.nickName }" name="nickName"><input type="button" id="nickChck" value="중복확인"/></div></br>
	          </div>
	          <div class="u3_2">
	            <div><b>이름 : </b><input type="text" name="name" value="${mylist.name}" ></div><br/>
	          </div>
	          <div class="u3_2">
	            <div><b>비밀번호 : </b><input type="password" name="pw" id="myUserPw"/></div><br/>
	          </div>
	          <div class="u3_2">
	            <div><b>비밀번호 확인 : </b><input type="password" id="myUserPwChk"/></div><br/>
	            <font id="chkNotice" size="2"></font>            
	          </div>        
	        </div>
	        
	        <div class="upfn">
	          <button id="memUpdate" value="수정" style="width: 100px; height: 50px;">수정</button>
	        </div>
        </form>
        
        <div class="out">
         <input type="button" id="memOut" value="회원 탈퇴" onclick="location.href='memberout'" style="width: 100px; height: 50px;"/>
        </div>
      
      </div>
      <div class="upmy2_1">
          <ul>
              <li>
                  <a href="">
                      <div class="screen">
                        <button>작성한 글</button>
                      </div>
                  </a>
              </li>
              <li>
                        <div class="screen">
                        <button onclick="listCall()" style="position: absolute; top: 1px; width: 150px;">댓글 단 글</button>
                      </div>
                  </a>
              </li>              
          </ul>
      </div>
      <div class="dap">
      		<div id="boardlist">
			<!-- 내가쓴 것들의 목록 -->
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
  
      				<div id="commentlist">       
			            <table id="listsection">
		    			    <thead>
		    			    <tr style="background-color: rgb(138, 190, 59)">
								<th>no.</th> 
								<th width="300px">내용</th> 
								<th width="100px">작성일</th> 
								<th>삭제</th>
						     </tr> 
						     </thead>
							     <tbody>
							     </tbody>
						     </table>
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
  
  var msg = "${msg}";
  if(msg != ""){
  	alert(msg);
  }
  var loginId = "${sessionScope.id}";

  console.log(loginId);


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
		
		
		//회원탈퇴 알림
		$("#memOut").click(function(){
			alert("정말 탈퇴 하시겠습니까?");
		});
		
		
		//비밀번호 확인
		$(function(){
			$("#myUserPw").keyup(function(){
				$('#chkNotice').innerhtml("")
      	});
      
	      $('#myUserPwChk').keyup(function(){
	
	        if($("#myUserPw").val() != $("#myUserPwChk").val()){
	          $("#chkNotice").html("비밀번호가 일치하지 않습니다.<br>");
	          $("#chkNotice").attr("color","red");
	        }else{
	          $("#chkNotice").html("비밀번호가 일치합니다.<br>");
	          $("#chkNotice").attr("color","green");
	        }

             });
		});
		
		//수정 확인
		
		function memUpdate(){
			if(confirm("정말 수정하시겠습니까 ?") == true){
		        location.href="myUpdate";
		    }else{
		        return ;
		    }
		}
				
		//댓 불러오기
		function listCall(){
			$.ajax({
		        type: "post",
		        url: "mycomment",
		        dataType: "JSON",
		        success: function(data) {
		            console.log(data.list);
		          	$("#boardlist").css({"display":"none"});
		          	$("#commentlist").css({"display":"block"});    	
		            drawTable(data.list);
		        },
			    error: function() {
			        console.log(data);
			    }
		    });
		}
		
		function drawTable(list){
			var content = "";
			var i = 1;
			   $("tbody").empty();   
			   list.forEach(function(item,num){
			      console.log(num,item);
			      content = "<tr><td>"+ i++ +"</td>"
			         +"<td><a href='boardDetail?board_no="+item.board_no+"'>" // 위치 조정 필요...
			        +item.co_content+"</td></a><td>"+item.co_reg_date+"</td>"+
			        "<td><a href='deletecom?board_no="+item.board_no+"'> 삭제 </a></td></tr>";
			         $("tbody").append(content);
			   });
		}

			
		function fn_paging(curPage) {
			location.href = "myboard?curPage="+curPage;
		}

		//사진 업로드 팝업		
	       var openWin;
			function openwindow(){
	            // window.name = "부모창 이름"; 
	            window.name = "mypagedetail";
	            // window.open("open할 window", "자식창 이름", "팝업창 옵션");

	            openWin = window.open("photo_test.jsp",
	                    "photoupload", "width=450, height=150, resizable = no, scrollbars = no");
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

//사용자이미지
	var photo = "${sessionScope.userphoto}";
	console.log(photo);
 	$(document).ready(function(){
		if(photo!=""){
	 		var userphoto = "image/member/"+photo;  
			console.log(userphoto);
       		$("#userphoto").attr('src',userphoto);
		}
	});
			
		  
  </script>
</html>
