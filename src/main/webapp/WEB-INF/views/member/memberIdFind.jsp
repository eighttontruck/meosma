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
	function idFineCheck(){
		let name=$("#name").val().replace(/\s/gi,"");
		let telNum1=$("#telNum1").val().replace(/\s/gi,"");
		let telNum2=$("#telNum2").val().replace(/\s/gi,"");
		let telNum3=$("#telNum3").val().replace(/\s/gi,"");
		if(name==""&&telNum1==""&&telNum1.length!=3&&telNum2==""&&telNum2.length!=4&&telNum3==""&&telNum3.length!=4){
			$("#hidP1").css("visibility","visible");
			$("#name").css("border-color","red");
			$("#hidP2").css("visibility","visible");
			$("#telNum1").css("border-color","red");
			$("#telNum2").css("border-color","red");
			$("#telNum3").css("border-color","red");
			return false;
		} else if(name==""){
			$("#hidP1").css("visibility","visible");
			$("#name").css("border-color","red");
			return false;
		} else if(telNum1==""&&telNum1.length!=3&&telNum2==""&&telNum2.length!=4){
			$("#hidP2").css("visibility","visible");
			$("#telNum1").css("border-color","red");
			$("#telNum2").css("border-color","red");
			return false;
		} else if(telNum2==""&&telNum2.length!=4&&telNum3==""&&telNum3.length!=4){
			$("#hidP2").css("visibility","visible");
			$("#telNum2").css("border-color","red");
			$("#telNum3").css("border-color","red");
			return false;
		} else if(telNum1==""&&telNum1.length!=3&&telNum3==""&&telNum3.length!=4){
			$("#hidP2").css("visibility","visible");
			$("#telNum1").css("border-color","red");
			$("#telNum3").css("border-color","red");
			return false;
		} else if(telNum1==""&&telNum1.length!=3){
			$("#hidP2").css("visibility","visible");
			$("#telNum1").css("border-color","red");
			return false;
		} else if(telNum2==""&&telNum2.length!=4){
			$("#hidP2").css("visibility","visible");
			$("#telNum2").css("border-color","red");
			return false;
		} else if(telNum3==""&&telNum3.length!=4){
			$("#hidP2").css("visibility","visible");
			$("#telNum3").css("border-color","red");
			return false;
		}
		
		if(nameC){
			let name=$("#name").val().replace(/\s/gi,"");
			let telNum=telNum1+"-"+telNum2+"-"+telNum3;
			$("#divForm").css("display","none");
			$("#idFindDiv").css("display","block");
			
			$.ajax({
				type : "post",
				url : "${ctp}/member/memberIdFind",
				data : {
					telNum:telNum,
					name:name
					},
				success : function(data){
					$("#findEmailId").html(data);
				},
				error : function() {
					$("#findEmailId").html("일치하는 회원정보가 없습니다.");
				}
			})
			
		}
	}
	
	const nameRegex=new RegExp(/^[가-힣]{2,5}$/);
	let nameC=false;
	function nameRegExpCheck(){
		let name=$("#name").val().replace(/\s/gi,"");
		
		if(!nameRegex.test(name)){
			$("#hidP1").html("이름을 제대로 입력해주세요.");
			$("#hidP1").css("visibility","visible");
			$("#name").css("border-color","red");
			nameC=false;
		} else{
			$("#hidP1").css("visibility","hidden");
			$("#name").css("border-color","lightgray");
			nameC=true;
		}
	}

	function phoneNumAutoFocus(num){
		if(num==1){
			if($("#telNum1").val().length==3){
				$("#telNum1").css("border-color","lightgray");
				$("#telNum2").focus();
			}
		} else if(num==2){
			if($("#telNum2").val().length==4){
				$("#telNum2").css("border-color","lightgray");
				$("#telNum3").focus();
			}
		} else if(num==3){
			if($("#telNum3").val().length==4){
				$("#telNum3").css("border-color","lightgray");
				if($("#telNum1").val().length==3&&$("#telNum2").val().length==4&&$("#telNum3").val().length==4){
					$("#hidP2").css("visibility","hidden");
				}
			}
			
		}
	}
	
</script>
<style>
	#divForm{
		padding-top:0px;
		width:500px;
		margin:0 auto;
		margin-top:100px;
	}
	#idFindDiv{
		width:500px;
		margin:0 auto;
		padding-top:150px;
		display:none;
	}
	#idFindDiv > div{
		background-color:lightgray;
		height:150px;
		margin-bottom:30px;
	}
	#idFindDiv h3{
		line-height:150px;
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
		visibility:hidden;
	}
	p{
		margin:0;
	}
	#phoneNumForm{
		display:flex;
		justify-content:space-between;
	}
	#phoneNumForm > input{
		width:160px;
	}
	#loginOption{
		display:flex;
		justify-content:space-between;
		margin:10px 0px;
	}
	.idFindBtn{
		width:100%;
		height:40px;
		margin-bottom:10px;
		background-color:black;
		color:white;
		border:none;
		margin:10px 0px;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div id="divForm">
		<div>
			<label>이름</label>
			<input type="text" id="name" name="name" oninput="nameRegExpCheck()" placeholder="이름을 입력해주세요" class="inputForm">
			<p class="hiddenText" id="hidP1">이름을 입력해주세요.</p>
		</div>
		<div>
			<label>핸드폰 번호</label>
			<div id="phoneNumForm">
				<input type="text" id="telNum1" name="telNum1" oninput="phoneNumAutoFocus(1)" placeholder="010" maxlength="3" class="inputForm">
				<input type="text" id="telNum2" name="telNum2" oninput="phoneNumAutoFocus(2)" placeholder="1234" maxlength="4" class="inputForm">
				<input type="text" id="telNum3" name="telNum3" oninput="phoneNumAutoFocus(3)" placeholder="5678" maxlength="4" class="inputForm">
			</div>
			<p class="hiddenText" id="hidP2">핸드폰 번호를 입력해주세요.</p>
			<input type="hidden" id="telNum" name="telNum">
		</div>
		
		<div><button type="button" class="idFindBtn" onclick="idFineCheck()">다음</button></div>
	</div>
	<div id="idFindDiv">
		<h1 class="text-center">회원정보 검색결과</h1>
		<div>
			<h3 class="text-center"><span id="findEmailId"></span></h3>
		</div>
		<button type="button" class="idFindBtn" onclick="location.href='${ctp}/member/memberLogin'">로그인 하러가기</button>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>