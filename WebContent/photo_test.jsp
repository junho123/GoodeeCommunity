<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>

	
	<form action="photoUp" method ="post" enctype="multipart/form-data">
	<input type="text" name="id" value="${sessionScope.id}" hidden/><br/>
	<input type="file" name="photo"/>
	사진의 파일명은 숫자 혹은 영어로만 구성되어 있어야 합니다.
	<br/><br/>
	<input type="submit"/> <button onclick="window.close()"> 닫기 </button>
	</form>
	
	
	<script>
	  var msg = "${msg}";
	  if(msg != ""){
	  	alert(msg);
	  }
	</script>