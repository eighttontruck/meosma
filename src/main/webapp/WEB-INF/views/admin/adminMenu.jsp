<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1">
 	<link rel="icon" href="${ctp}/resources/images/tabimage.png">
 	<link rel="apple-touch-icon" href="${ctp}/resources/images/tabimage.png">
	<title>머스마(Musma) - 글로벌 멀티 컬쳐 선두주자 나야나</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<script>
	
</script>
<style>
	div{
		height:500px;
	}
</style>
<body>
	<div class="text-center">
	  <h5>관리자메뉴</h5>
	  <hr/>
	  <p><a href="" target="">홈으로</a></p>
	  <hr/>
	  <p><a href="" target="">회원 리스트</a></p>
	  <hr/>
	  <p><a href="" target="">음식점 리스트</a></p>
	  <hr/>
	  <p><a href="" target="">후기 리스트</a></p>
	  <hr/>
	</div>
</body>
</html>