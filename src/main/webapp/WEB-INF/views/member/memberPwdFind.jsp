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
	function pwdFineCheck(){
		let name=$("#name").val().replace(/\s/gi,"");
		let telNum1=$("#telNum1").val().replace(/\s/gi,"");
		let telNum2=$("#telNum2").val().replace(/\s/gi,"");
		let telNum3=$("#telNum3").val().replace(/\s/gi,"");
		let emailId=$("#emailId").val().replace(/\s/gi,"");
		
		if(name==""){
			$("#hidP1").css("visibility","visible");
			$("#name").css("border-color","red");
		} if(telNum1==""||telNum1.length!=3){
			$("#hidP2").css("visibility","visible");
			$("#telNum1").css("border-color","red");
		} if(telNum2==""||telNum2.length!=4){
			$("#hidP2").css("visibility","visible");
			$("#telNum2").css("border-color","red");
		} if(telNum3==""||telNum3.length!=4){
			$("#hidP2").css("visibility","visible");
			$("#telNum3").css("border-color","red");
		} if(emailId==""){
			$("#hidP3").css("visibility","visible");
			$("#emailId").css("border-color","red");
		}
		
		if(name!=""&&telNum1!=""&&telNum1.length==3&&telNum2!=""&&telNum2.length==4&&telNum3!=""&&telNum3.length==4&&emailId!=""){
			if(nameC&&emailIdC&&emailCertCheck){
				let name=$("#name").val().replace(/\s/gi,"");
				let telNum=telNum1+"-"+telNum2+"-"+telNum3;
				let emailId=$("#emailId").val().replace(/\s/gi,"");
				
				$.ajax({
					type : "post",
					url : "${ctp}/member/memberPwdFind",
					data : {
						name:name,
						telNum:telNum,
						emailId:emailId
						},
					success : function(data){
						if(data!="0"){
							$("#divForm").css("display","none");
							$("#pwdFindDiv").css("display","block");
						} else{
							$("#hidP3").html("일치하는 회원정보가 없습니다.");
							$("#hidP3").css("visibility","visible");
						}
					},
					error : function() {
						alert("전송 오류!");
					}
				});
			}
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
	
	const emailIdRegex=new RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/);
	let emailIdC=false;
	
	function emailIdRegExpCheck(){
		let emailId=$("#emailId").val().replace(/\s/gi,"");
		
		if(!emailIdRegex.test(emailId)){
			$("#hidP3").html("이메일 형식에 맞게 다시 입력해주세요.");
			$("#hidP3").css("visibility","visible");
			$("#emailId").css("border-color","red");
			emailIdC=false;
		} else{
			$("#hidP3").css("visibility","hidden");
			$("#emailId").css("border-color","lightgray");
			emailIdC=true;
		}
	}
	
	let code = "";
	let emailCertCheck = false; // 이메일 인증 완료 여부를 저장하는 변수
	let timer; // 타이머를 저장하는 변수
	const timeLimit = 10; // 시간 제한 (3분을 초 단위로 표시)
	function mailSendAJAX(){
		let emailId=$("#emailId").val().replace(/\s/gi,"");
		
		if(emailId==""){
			$("#hidP3").html("이메일을 입력해주세요.");
			$("#hidP3").css("visibility","visible");
			$("#emailId").css("border-color","red");
			return false;
		}
		
		if(!emailIdC){
			return false;
		}
		
		$("#certNumDiv2").css("display","block");
		$("#hidP3").css("visibility","visible");
		$("#hidP3").html("메일 전송중 ...");
		$("#emailId").css("border-color","lightgray");
		$.ajax({
			type : "post",
			url : "${ctp}/member/mailSendAJAX",
			data : {emailId:emailId},
			success : function(data){
				if(data=="error"){
					$("#hidP3").html("메일이 전송되지 않았습니다.");
				} else{
					$("#hidP3").html("메일이 전송됐습니다. 인증번호를 입력하세요.");
					$("certNum").focus();
					code = data;
					alert(code);
				}
			},
			error : function() {
				alert("전송오류!");
			}
		});
		clearInterval(timer);
		startTimer();
			
	}
	
	function startTimer() {
	    let timeLeft = timeLimit;
	    timer = setInterval(function() {
	        if (timeLeft <= 0) {
	            // 타이머 종료, 인증 시간 초과
	            clearInterval(timer);
	            handleTimeout();
	        } else {
	            // 남은 시간 표시
	            let minutes = Math.floor(timeLeft / 60);
	            let seconds = timeLeft % 60;
	            $("#timerDisplay").html(minutes+"분 "+seconds+"초 남았습니다.");
	            timeLeft--;
	        }
	    }, 1000); // 1초마다 타이머 갱신
	}

	function handleTimeout() {
	    // 타이머가 종료되었을 때 처리할 작업
	    $("#certNumDiv2").css("display","none");
		$("#hidP3").css("visibility","hidden");
		$("#emailId").removeAttr("readonly");
	    $("#emailCheckBtn").removeAttr("disabled");
	    $("#timerDisplay").html("시간 초과 - 다시 인증해주세요.");
	    emailCertCheck = false;
	}
	
	function certNumCheck(){
		let inputCode=$("#certNum").val().replace(/\s/gi,"");
		if(inputCode==""){
			$("#hidP4").css("visibility","visible");
			$("#certNum").css("border-color","red");
			return false;
		}
		
		if(inputCode==code){
			clearInterval(timer); // 타이머 초기화
			$("#certNumDiv2").css("display","none");
			$("#hidP3").css("visibility","hidden");
			$("#emailId").attr("readonly",true);
			$("#emailCheckBtn").attr("disabled", true);
			$("#timerDisplay").html("");
			emailCertCheck = true;
			
		} else{
			$("#hidP4").css("visibility","visible");
			$("#hidP4").html("인증번호가 일치하지 않습니다. 다시 입력해주세요.");
			$("#certNum").css("border-color","red");
			emailCertCheck = false;
		}
	}
	
	let pwdC=false;
	let pwdDoubleC=false;
	const pwdRegex=new RegExp(/(?=.*[0-9])(?=.*[a-z])(?=.*\W)(?=\S+$).{8,20}/);
	
	function pwdRegExpCheck(){
		let updatePwd=$("#updatePwd").val().replace(/\s/gi,"");
		
		if(!pwdRegex.test(updatePwd)){
			$("#hidP5").html("8~20 길이의 소문자, 숫자, 특수문자가 와야합니다.");
			$("#hidP5").css("visibility","visible");
			$("#updatePwd").css("border-color","red");
			pwdC=false;
		} else{
			$("#hidP5").css("visibility","hidden");
			$("#updatePwd").css("border-color","lightgray");
			pwdC=true;
		}
	}
	
	function pwdDoubleCheck(){
		let updatePwd=$("#updatePwd").val().replace(/\s/gi,"");
		let pwdCheck=$("#pwdCheck").val().replace(/\s/gi,"");
		
		if(updatePwd!=pwdCheck){
			$("#hidP6").html("비밀번호가 일치하지 않습니다.");
			$("#hidP6").css("visibility","visible");
			$("#pwdCheck").css("border-color","red");
			pwdDoubleC=false;
		} else{
			$("#hidP6").css("visibility","hidden");
			$("#pwdCheck").css("border-color","lightgray");
			pwdDoubleC=true;
		}
	}
	
	function pwdUpdateCheck(){
		let updatePwd=$("#updatePwd").val().replace(/\s/gi,"");
		let pwdCheck=$("#pwdCheck").val().replace(/\s/gi,"");
		
		if(updatePwd==""){
			$("#hidP5").css("visibility","visible");
			$("#pwd").css("border-color","red");
		} if(pwdCheck==""){
			$("#hidP6").css("visibility","visible");
			$("#pwdCheck").css("border-color","red");
		}
		
		if(updatePwd!=""&&pwdCheck!=""){
			if(pwdC&&pwdDoubleC){
				$("#emailIdForm").val($("#emailId").val().replace(/\s/gi,""));
				myform.submit();
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
	#pwdFindDiv{
		width:500px;
		margin:0 auto;
		padding-top:150px;
		display:none;
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
	.pwdFindBtn{
		width:100%;
		height:40px;
		margin-bottom:10px;
		background-color:black;
		color:white;
		border:none;
		margin:10px 0px;
	}
	#idFindDiv{
		margin:0 auto;
		display:none;
	}
	.emailId{
		width:350px;
		border-style:solid;
		border-width:1px;
		border-color:lightgray;
		height:40px;
		padding:0px 16px;
	}
	.emailId:focus{
		border-color:black;
		outline:none;
	}
	#emailCheckBtn{
		width:140px;
		height:40px;
		background-color:white;
		border-style:solid;
		border-color:black;
		border-width:1px;
	}
	#certNumDiv{
		display:flex;
		justify-content:space-between;
	}
	#certNumDiv2{
		display:none;
	}
	#certNumCheckBtn{
		width:145px;
		height:40px;
		background-color:black;
		border:none;
		color:white;
	}
	#pwdFindBtn{
		width:100%;
		height:40px;
		margin-bottom:10px;
		background-color:black;
		color:white;
		border:none;
		margin:10px 0px;
	}
	#pwdUpdateBtn{
		width:100%;
		height:40px;
		margin-bottom:10px;
		background-color:white;
		color:black;
		border-style:solid;
		border-width:1px;
		margin:10px 0px;
	}
	.flex{
		display:flex;
		justify-content:space-between;
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
		<div>
			<div class="flex">
				<label>아이디(이메일)</label>
				<div id="timerDisplay"></div>			
			</div>
			<div id="emailSendDiv">
				<input type="text" id="emailId" name="emailId" oninput="emailIdRegExpCheck()" placeholder="이메일을 입력해주세요" class="emailId">
				<button type="button" id="emailCheckBtn" onclick="mailSendAJAX()">인증번호 발송</button>
			</div>
			<p class="hiddenText" id="hidP3">이메일을 입력해주세요.</p>	
		</div>
		<div id="certNumDiv2">
			<div id="certNumDiv">
				<button type="button" id="certNumCheckBtn" onclick="certNumCheck()">인증번호 확인</button>
				<input type="text" id="certNum" name="certNum" placeholder="인증번호를 입력해주세요." class="emailId">
			</div>
			<p class="hiddenText" id="hidP4">인증번호를 입력해주세요.</p>
		</div>
		<div><button type="button" id="pwdFindBtn" onclick="pwdFineCheck()">다음</button></div>
	</div>
	
	<div id="pwdFindDiv">
		<form name="myform" method="post" action="${ctp}/member/memberPwdUpdate">
			<div>
				<label>비밀번호</label>
				<input type="password" id="updatePwd" name="updatePwd" oninput="pwdRegExpCheck()" placeholder="새 비밀번호를 입력해주세요." class="inputForm">
				<p class="hiddenText" id="hidP5">비밀번호를 입력해주세요.</p>
			</div>
			<div>
				<label>비밀번호 확인</label>
				<input type="password" id="pwdCheck" name="pwdCheck" oninput="pwdDoubleCheck()" placeholder="새 비밀번호를 다시 입력해주세요" class="inputForm">
				<p class="hiddenText" id="hidP6">비밀번호를 한번 더 입력해주세요.</p>
			</div>
			<input type="hidden" id="emailIdForm" name="emailIdForm">
			<button type="button" id="pwdUpdateBtn" onclick="pwdUpdateCheck()">변경</button>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>