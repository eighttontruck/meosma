<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	
</style>
<body>
	<div class="table">
		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th>브랜드 번호</th>
					<th>브랜드명</th>
					<th>브랜드 설명</th>
					<th>좋아요 수</th>
					<th>비고</th> <!-- 수정은 내용만 바꿀 수 있으니 모달창으로 보내면 될듯 -->
				</tr>
			</thead>
			<tbody>
				<c:forEach var="brand" items="${brandVos}" varStatus="st">
					<tr>
						<th>${brand.idx}</th>
						<th>${brand.name}</th>
						<th>${brand.content}</th>
						<th>${brand.brand_like}<th>
						<th>
							<input type="button" class="btn btn-sm btn-warning" onclick="updateReply(${Review.idx})" data-toggle="modal" data-target="#myModal" value="수정">
							<a class="btn btn-sm btn-danger" href="javascript:deleteReply('${Review.idx}')">삭제</a>
						</th>
					</tr>
				</c:forEach>
			</tbody>
	  	</table>
  	</div>
	
</body>
</html>