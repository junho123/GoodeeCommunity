<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<style>
	table{
			width : 500px;
		}
		table, th, td{
			border : 1px solid black;
			border-collapse : collapse;
			padding : 5px  10px;
		}
		td{
			text-align : center;
		}
		
	</style>
</head>
<!-- bbs가 정상적으로 나오는지 일단 확인 -> bbs-->
<body>

	<%-- ${bbs.idx}	/	${bbs.user_name}	/	${bbs.subject}	/	${bbs.content}
	/${bbs.reg_date}	/	${bbs.bHit} --%>
	<table>
		<tr>
			<th>게시글 번호</th>
			<td>${board.board_no}</td>
		</tr>
		<tr>
			<th>게시판 코드</th>
			<td>${board.mboard_no}</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${board.id}</td>
		</tr>
		<tr>
			<th>게시글 제목</th>
			<td>${board.bo_subject}</td>
		</tr>
		<tr>
			<th>게시글 내용</th>
			<td>${board.bo_content}</td>
		</tr>
		<tr>
			<th>등록일자</th>
			<td>${board.bo_reg_date}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${board.bo_bHit}</td>
		</tr>
		<tr><!-- 파라미터(?) 옆에는 공백 없애라 -->
			<td colspan="2">
				<input type="button" value="삭제" onclick="location.href='del?board_no=${board.board_no}'"/>
				<%-- <input type="button" value="수정" onclick="location.href='updateForm?idx=${bbs.idx}'"/> --%>
			</td>
		</tr>
	</table>
</body>
<script>
/* var msg = "${msg}";
if(msg != ""){
	alert(msg);
} */
</script>
</html>