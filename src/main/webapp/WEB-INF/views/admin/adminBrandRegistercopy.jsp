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
	function fCheck(){
		let name=$("#name").val().replace(/\s/gi,"");;
		let content = $("#content").val().replace(/\s/gi,"");
		
		if(name==""||content==""){
			alert("양식을 모두 작성해주세요.");
			return false;
		}
		myform.submit();
	}
</script>
<style>

	.flexDiv{
		width:500px;
		height:700px;
		margin:0 auto;
	}
	.bigText{
		margin:2px;
		border-bottom: 1.9px solid #000;
		padding:2px;
	}
	.bigText > h1{
		margin:4px;
	}
	.inputText{
	 	border:none;
		border-bottom: 1.9px solid lightgray;
		width: 90%;
		margin:10px;
		font-size:1.1rem;
		
	}
	.inputText:focus{
		outline:none;
		border-bottom: 1.9px solid black;
	}
	.labelText{
		margin:10px;
		font-weight:600;
		font-size:1.2rem;
	}
	.inputTextArea{
		border:none;
		border-bottom: 1.9px solid lightgray;
		width:90%;
		margin:10px;
		font-size:1.1rem;
		height:200px;
	}
	.inputTextArea:focus{
		outline:none;
		border-bottom: 1.9px solid black;
	}
	button{
		width:500px;
		height:50px;
		background-color:black;
		color:white;
		border:none;
	}
	#btnDiv{
		margin:0 auto;
		width:500px;
		margin-top:30px;
	}
</style>
<body>
	<div>
		<form name="myform" method="post">
			<div id="memberInfo" class="flexDiv">
				<div class="bigText"><h1><strong>브랜드 등록</strong></h1></div>
				<div class="col">
					<div class="labelText">브랜드명</div>
					<div><input type="text" name="name" id="name" class="inputText"></div>
				</div>
				<div class="col">
					<div class="labelText">브랜드 설명</div>
					<div><textarea name="content" id="content" class="inputTextArea"></textarea></div>
				</div>
				<div id="btnDiv">
					<button onclick="fCheck()">등록</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>