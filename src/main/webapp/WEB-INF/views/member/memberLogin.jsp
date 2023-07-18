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
<script>
	'use strict';
	function loginCheck(){
		let emailId=$("#emailId").val().replace(/\s/gi,"");
		let pwd=$("#pwd").val().replace(/\s/gi,"");
		if(emailId==""&&pwd==""){
			$("#hidP1").css("display","block");
			$("#emailId").css("border-color","red");
			$("#hidP2").css("display","block");
			$("#pwd").css("border-color","red");
			return false;
		} else if(emailId==""){
			$("#hidP1").css("display","block");
			$("#emailId").css("border-color","red");
			return false;
		} else if(pwd==""){
			$("#hidP2").css("display","block");
			$("#pwd").css("border-color","red");
			return false;
		} 
		myform.submit();
	}
	function emailIdInputCheck(){
		let emailId=$("#emailId").val().replace(/\s/gi,"");
		if(emailId!=""){
			$("#hidP1").css("display","none");
			$("#emailId").css("border-color","lightgray");
		}
	}
	function pwdInputCheck(){
		let pwd=$("#pwd").val().replace(/\s/gi,"");
		if(pwd!=""){
			$("#hidP2").css("display","none");
			$("#pwd").css("border-color","lightgray");
		}
	}
	
</script>
<style>
	form{
		padding-top:0px;
		width:500px;
		margin:0 auto;
		margin-top:10%
	}
	.inputForm{
		width:100%;
		border-style:solid;
		border-width:1px;
		border-color:lightgray;
		height:40px;
		padding:0px 16px;
	}
	.inputForm:focus{
		border-color:black;
		outline:none;
	}
	.hiddenText{
		color:red;
		display:none;
	}
	p{
		margin:0;
	}
	#loginOption{
		display:flex;
		justify-content:space-between;
		margin:10px 0px;
	}
	#loginBtn{
		width:100%;
		height:40px;
		margin-bottom:10px;
		background-color:black;
		color:white;
		border:none;
	}
	#joinBtn{
		width:100%;
		height:40px;
		background-color:white;
		border-style:solid;
		border-width:1px;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div>
		<form name="myform" method="post">
			<div>
				<label>아이디(이메일)</label>
				<input type="text" id="emailId" name="emailId" oninput="emailIdInputCheck()" placeholder="이메일을 입력해주세요" class="inputForm">
				<p class="hiddenText" id="hidP1">이메일을 입력해주세요.</p>
			</div>
			<div class="mt-2">
				<label>비밀번호</label>
				<input type="password" id="pwd" name="pwd" oninput="pwdInputCheck()" placeholder="비밀번호를 입력해주세요" class="inputForm">
				<p class="hiddenText" id="hidP2">비밀번호를 입력해주세요.</p>
			</div>
			<div id="loginOption">
				<div><input type="checkbox" id="idSave" name="idSave">아이디 저장</div>
				<div><a href="${ctp}/member/memberIdFind">아이디 찾기</a> | <a href="${ctp}/member/memberPwdFind">비밀번호 찾기</a></div>
			</div>
			<div><button type="button" id="loginBtn" onclick="loginCheck()">로그인</button></div>
			<div><button type="button" id="joinBtn" onclick="location.href='${ctp}/member/memberJoin'">회원가입</button></div>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>