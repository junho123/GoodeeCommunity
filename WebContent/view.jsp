<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<style></style>
	</head>
	<body>
		<!-- 댓글 작성 -->
<!-- 너비와 정렬방식 설정 -->
<div style="width:700px; text-align:center;">
 
<!-- 세션에 저장되어있는 userid가 null이 아닐때 -->
<!-- 그러니까 로그인을 한 상태이어야만 댓글을 작성 할 수 있다.-->
     <c:if test="${sessionScope.userid != null }">
         <textarea rows="5" cols="80" id="replytext"
             placeholder="댓글을 작성하세요"></textarea>
         <br>
         <!-- 댓글쓰기 버튼을 누르면 id값인 btnReply값이 넘어가서 -->
         <!-- 위쪽에 있는 스크립트 구문이 실행되고 -->
         <!-- 내가 댓글을 작성한 값이 스크립트문을 거쳐서 컨트롤러로 맵핑되게 된다. -->
         <button type="button" id="btnReply">댓글쓰기</button>
      </c:if>
		</div>
		<!-- 댓글 목록 -->
		<!-- 댓글이 등록이 되면 listReply에 댓글이 쌓이게 된다 -->
		<div id="listReply"></div>
         
         
	</body>
	<script>
	//댓글 쓰기 (버튼을 눌러서 id값이 넘어와 실행되는 자바스크립트 구문)
    $("#btnReply").click(function(){
        var replytext=$("#replytext").val(); //댓글 내용
        var bno="${dto.bno}"; //게시물 번호
        var param={ "replytext": replytext, "bno": bno};
        //var param="replytext="+replytext+"&bno="+bno;
        $.ajax({
            type: "post", //데이터를 보낼 방식
            url: "${path}/reply/insert.do", //데이터를 보낼 url
            data: param, //보낼 데이터

            success: function(){ //데이터를 보내는것이 성공했을시 출력되는 메시지
                alert("댓글이 등록되었습니다.");
                listReply2(); //댓글 목록 출력
            }
        });
    });
	
  //댓글 목록 출력 함수
    function listReply(){
        $.ajax({
            type: "get", //get방식으로 자료를 전달한다
            url: "${path}/reply/list.do?bno=${dto.bno}", //컨트롤러에 있는 list.do로 맵핑하고 게시판 번호도 같이 보낸다.
            success: function(result){ //자료를 보내는것이 성  공했을때 출력되는 메시지
                //result : responseText 응답텍스트(html)
                $("#listReply").html(result);
            }
        });
    }

	</script>
</html>