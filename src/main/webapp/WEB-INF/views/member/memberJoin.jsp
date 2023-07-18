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
	let telNum1=$("#telNum1").val()
	let telNum2=$("#telNum2").val()
	let telNum3=$("#telNum3").val()
	
	function telNumAutoFocus(num){
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
					$("#hidP8").css("visibility","hidden");
				}
			}
			
		}
	}
	let birthday1="";
	let birthday2="";
	let birthday3="";
	function ableBirthdayInput(){
		birthday1=$("#birthday1 option:selected").val();
		birthday2=$("#birthday2 option:selected").val();
		birthday3=$("#birthday3 option:selected").val();
		
		if(birthday1!=""){
			$("#birthday1").css("border-color","lightgray");
			$("#birthday2").removeAttr("disabled");
		}
		if(birthday2!=""){
			$("#birthday2").css("border-color","lightgray");
			$("#birthday3").removeAttr("disabled");
		}
		if(birthday3!=""){
			$("#birthday3").css("border-color","lightgray");
			$("#hidP7").css("visibility","hidden")
		}
	}
	
	function genderChange(){
		$("#gender").css("border-color","lightgray");
		$("#gender").css("outline","none");
		$("#hidP6").css("visibility","hidden");
	}
	
	const emailIdRegex=new RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/);
	const pwdRegex=new RegExp(/(?=.*[0-9])(?=.*[a-z])(?=.*\W)(?=\S+$).{8,20}/);
	const nameRegex=new RegExp(/^[가-힣]{2,5}$/);
	
	let emailIdC=false;
	let pwdC=false;
	let pwdDoubleC=false;
	let nameC=false;
	
	let emailCertCheck=false;
	
	function emailIdRegExpCheck(){
		let emailId=$("#emailId").val().replace(/\s/gi,"");
		
		if(!emailIdRegex.test(emailId)){
			$("#hidP1").html("이메일 형식에 맞게 다시 입력해주세요.");
			$("#hidP1").css("visibility","visible");
			$("#emailId").css("border-color","red");
			emailIdC=false;
		} else{
			$("#hidP1").css("visibility","hidden");
			$("#emailId").css("border-color","lightgray");
			emailIdC=true;
		}
	}
	
	let code = "";
	function mailSendAJAX(){
		let emailId=$("#emailId").val().replace(/\s/gi,"");
		
		if(emailId==""){
			$("#hidP1").html("이메일을 입력해주세요.");
			$("#hidP1").css("visibility","visible");
			$("#emailId").css("border-color","red");
			return false;
		}
		
		if(!emailIdC){
			return false;
		}
		
		$("#certNumDiv2").css("display","block");
		$("#hidP1").css("visibility","visible");
		$("#hidP1").html("메일 전송중 ...");
		$("#emailId").css("border-color","lightgray");
		$.ajax({
			type : "post",
			url : "${ctp}/member/mailSendAJAX",
			data : {emailId:emailId},
			success : function(data){
				if(data=="error"){
					$("#hidP1").html("메일이 전송되지 않았습니다.");
				} else{
					$("#hidP1").html("메일이 전송됐습니다. 인증번호를 입력하세요.");
					$("certNum").focus();
					code = data;
					alert(code);
				}
			},
			error : function() {
				alert("전송오류!");
			}
		})
			
	}
	
	function certNumCheck(){
		let inputCode=$("#certNum").val().replace(/\s/gi,"");
		if(inputCode==""){
			$("#hidP2").css("visibility","visible");
			$("#certNum").css("border-color","red");
			return false;
		}
		
		if(inputCode==code){
			$("#certNumDiv2").css("display","none");
			$("#hidP1").css("visibility","hidden");
			$("#emailId").attr("readonly",true);
			$("#emailCheckBtn").attr("disabled", true);
			emailCertCheck = true;
			
		} else{
			$("#hidP2").css("visibility","visible");
			$("#hidP2").html("인증번호가 일치하지 않습니다. 다시 입력해주세요.");
			$("#certNum").css("border-color","red");
			emailCertCheck = false;
		}
	}
	function pwdRegExpCheck(){
		let pwd=$("#pwd").val().replace(/\s/gi,"");
		
		if(!pwdRegex.test(pwd)){
			$("#hidP3").html("8~20 길이의 소문자, 숫자, 특수문자가 와야합니다.");
			$("#hidP3").css("visibility","visible");
			$("#pwd").css("border-color","red");
			pwdC=false;
		} else{
			$("#hidP3").css("visibility","hidden");
			$("#pwd").css("border-color","lightgray");
			pwdC=true;
		}
	}
	
	function pwd2SameCheck(){
		let pwd=$("#pwd").val().replace(/\s/gi,"");
		let pwd2=$("#pwd2").val().replace(/\s/gi,"");
		
		if(pwd!=pwd2){
			$("#hidP4").html("비밀번호가 일치하지 않습니다.");
			$("#hidP4").css("visibility","visible");
			$("#pwd2").css("border-color","red");
			pwdDoubleC=false;
		} else{
			$("#hidP4").css("visibility","hidden");
			$("#pwd2").css("border-color","lightgray");
			pwdDoubleC=true;
		}
	}
	
	function nameRegExpCheck(){
		let name=$("#name").val().replace(/\s/gi,"");
		
		if(!nameRegex.test(name)){
			$("#hidP5").html("이름을 다시 입력해주세요.");
			$("#hidP5").css("visibility","visible");
			$("#name").css("border-color","red");
			nameC=false;
		} else{
			$("#hidP5").css("visibility","hidden");
			$("#name").css("border-color","lightgray");
			nameC=true;
		}
	}
	
	
	function blankCheck(){
		let emailId=$("#emailId").val().replace(/\s/gi,"");
		let pwd=$("#pwd").val().replace(/\s/gi,"");
		let pwd2=$("#pwd2").val().replace(/\s/gi,"");
		let name=$("#name").val().replace(/\s/gi,"");
		let gender=$("#gender option:selected").val().replace(/\s/gi,"");
		let birthday1=$("#birthday1 option:selected").val().replace(/\s/gi,"");
		let birthday2=$("#birthday2 option:selected").val().replace(/\s/gi,"");
		let birthday3=$("#birthday3 option:selected").val().replace(/\s/gi,"");
		let telNum1=$("#telNum1").val().replace(/\s/gi,"");
		let telNum2=$("#telNum2").val().replace(/\s/gi,"");
		let telNum3=$("#telNum3").val().replace(/\s/gi,"");
		
		if(emailId=="") {
			$("#hidP1").css("visibility","visible");
			$("#emailId").css("border-color","red");
		}
		if(pwd=="") {
			$("#hidP3").css("visibility","visible");
			$("#pwd").css("border-color","red");
		}
		if(pwd2=="") {
			$("#hidP4").css("visibility","visible");
			$("#pwd2").css("border-color","red");
		}
		if(name=="") {
			$("#hidP5").css("visibility","visible");
			$("#name").css("border-color","red");
		}
		if(gender=="") {
			$("#hidP6").css("visibility","visible");
			$("#gender").css("border-color","red");
		}
		if(birthday1==""||birthday2==""||birthday3=="") {
			$("#hidP7").css("visibility","visible");
			$("#birthday1").css("border-color","red");
			$("#birthday2").css("border-color","red");
			$("#birthday3").css("border-color","red");
		}
		if(telNum1==""||telNum2==""||telNum3=="") {
			$("#hidP8").css("visibility","visible");
			$("#telNum1").css("border-color","red");
			$("#telNum2").css("border-color","red");
			$("#telNum3").css("border-color","red");
			return false;
		}
		
		if(emailId!=""&&pwd!=""&&pwd2!=""&&name!=""&&gender!=""&&birthday1!=""&&birthday2!=""&&birthday3!=""&&telNum1!=""&&telNum2!=""&&telNum3!=""){
			if(!emailCertCheck){
				$("#emailId").css("border-color","red");
				$("#hidP1").html("이메일 인증해야 회원가입 할 수 있습니다.");
				$("#hidP1").css("visibility","visible");
				return false;
			}
			if(pwdC&&pwdDoubleC&&nameC){
				if(birthday2.length==1){
					birthday2="0"+birthday2;
				}
				if(birthday3.length==1){
					birthday3="0"+birthday3;
				}
				$("#birthday").val(birthday1+birthday2+birthday3);
				$("#telNum").val(telNum1+"-"+telNum2+"-"+telNum3);
				myform.submit();
			}
			
		}
	}
</script>
<style>
	form{
		width:400px;
		margin:0 auto;
		margin-top:20px;
	}
	#loginOption{
		display:flex;
		justify-content:space-between;
		margin:10px 0px;
	}
	#emailSendDiv{
		display:flex;
		justify-content:space-between;
	}
	#certNumDiv{
		display:flex;
		justify-content:space-between;
	}
	#certNumDiv2{
		display:none;
	}
	#joinBtn{
		width:100%;
		height:40px;
		background-color:black;
		color:white;
		border:none;
		margin-bottom:50px;
	}
	#emailCheckBtn{
		width:145px;
		height:40px;
		background-color:white;
		border-style:solid;
		border-color:black;
		border-width:1px;
	}
	#certNumCheckBtn{
		width:145px;
		height:40px;
		background-color:black;
		border:none;
		color:white;
	}
	#birthdayForm{
		display:flex;
		justify-content:space-between;
	}
	#birthdayForm > select{
		width:130px;
	}
	#telNumForm{
		display:flex;
		justify-content:space-between;
	}
	#telNumForm > input{
		width:130px;
	}
	.hiddenText{
		color:red;
		visibility:hidden;
	}
	.emailId{
		width:250px;
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
	.selectForm{
		width:100%;
		border-style:solid;
		border-width:1px;
		border-color:lightgray;
		height:40px;
		padding:0px 16px;
	}
	.selectForm:focus{
		border-color:black;
		outline:none;
	}
	.form div{
		margin-bottom:0px;
	}
	p{
		margin:0;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div>
		<form name="myform" method="post">
			<div>
				<label>아이디(이메일)</label>
				<div id="emailSendDiv">
					<input type="text" id="emailId" name="emailId" oninput="emailIdRegExpCheck()" placeholder="이메일을 입력해주세요" class="emailId">
					<button type="button" id="emailCheckBtn" onclick="mailSendAJAX()">인증번호 발송</button>
				</div>
				<p class="hiddenText" id="hidP1">이메일을 입력해주세요.</p>	
			</div>
			<div id="certNumDiv2">
				<div id="certNumDiv">
					<button type="button" id="certNumCheckBtn" onclick="certNumCheck()">인증번호 확인</button>
					<input type="text" id="certNum" name="certNum" placeholder="인증번호를 입력해주세요." class="emailId">
				</div>
				<p class="hiddenText" id="hidP2">인증번호를 입력해주세요.</p>
			</div>
			<div>
				<label>비밀번호</label>
				<input type="password" id="pwd" name="pwd" oninput="pwdRegExpCheck()" placeholder="비밀번호를 입력해주세요" class="inputForm">
				<p class="hiddenText" id="hidP3">비밀번호를 입력해주세요.</p>
			</div>
			<div>
				<label>비밀번호 확인</label>
				<input type="password" id="pwd2" name="pwd2" oninput="pwd2SameCheck()" placeholder="비밀번호를 한번 더 입력해주세요" class="inputForm">
				<p class="hiddenText" id="hidP4">비밀번호를 한번 더 입력해주세요.</p>
			</div>
			<div>
				<label>이름</label>
				<input type="text" id="name" name="name" oninput="nameRegExpCheck()" placeholder="이름을 입력해주세요" class="inputForm">
				<p class="hiddenText" id="hidP5">이름을 입력해주세요.</p>
			</div>
			<div>
				<label>성별(선택사항)</label>
				<select id="gender" name="gender" class="selectForm" onchange="genderChange()">
					<option value="" disabled hidden selected>성별을 선택해주세요</option>
					<option value="남자">남자</option>
					<option value="여자">여자</option>
					<option value="선택안함">선택안함</option>
				</select>
				<p class="hiddenText" id="hidP6">성별을 선택해주세요.</p>
			</div>
			<div>
				<label>생년월일</label>
				<div id="birthdayForm">
					<select id="birthday1" name="birthday1" class="selectForm" onchange="ableBirthdayInput()">
						<option value="" disabled hidden selected>연도</option>
						<c:forEach var="i" begin="0" end="100">
							<c:set var="yearOption" value="${2023-i}"></c:set>
							<option>${yearOption}</option>
						</c:forEach>
					</select>
					<select id="birthday2" name="birthday2" class="selectForm" onchange="ableBirthdayInput()" disabled>
						<option value="" disabled hidden selected>월</option>
						<c:forEach var="i" begin="1" end="12">
							<option value="${i}">${i}</option>
						</c:forEach>
					</select>
					<select id="birthday3" name="birthday3" class="selectForm" onchange="ableBirthdayInput()" disabled>
						<option value="" disabled hidden selected>일</option>
						<c:forEach var="i" begin="1" end="31">
							<option value="${i}">${i}</option>
						</c:forEach>
					</select>
				</div>
				<p class="hiddenText" id="hidP7">생년월일을 선택해주세요.</p>
				<input type="hidden" id="birthday" name="birthday">
			</div>
			<div>
				<label>핸드폰 번호</label>
				<div id="telNumForm">
					<input type="text" id="telNum1" name="telNum1" oninput="telNumAutoFocus(1)" placeholder="010" maxlength="3" class="inputForm">
					<input type="text" id="telNum2" name="telNum2" oninput="telNumAutoFocus(2)" placeholder="1234" maxlength="4" class="inputForm">
					<input type="text" id="telNum3" name="telNum3" oninput="telNumAutoFocus(3)" placeholder="5678" maxlength="4" class="inputForm">
				</div>
				<p class="hiddenText" id="hidP8">핸드폰 번호를 입력해주세요.</p>
				<input type="hidden" id="telNum" name="telNum">
			</div>
			<div><button type="button" id="joinBtn" onclick="blankCheck()">회원가입</button></div>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>