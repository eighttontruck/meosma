<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js"></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<script>
	function fCheck(){
		
		myform.submit();
	}
</script>
<style>
	#closebtn{
		width:13px;
		border:none;
		background:none;
	}
	#closebtn > img {
		width:20px;
	}
	body > div{
		width:600px;
		height:750px;
	}
	.size{
		text-align:center;
		line-height:34px;
	}
	.delBtn{
		text-align:left;
		line-height:30px;
	}
	.marginAuto{
		margin:0 auto;
		width:90%
	}
	.marginAuto2{
		margin:0 auto;
		width:50%
	}
	input{
	 	border:none;
		border-bottom: 1.9px solid lightgray;
	}
	input:focus{
		outline:none;
		border-bottom: 1.9px solid black;
	}
	select{
	 	border:none;
		border-bottom: 1.9px solid lightgray;
	}
	select:focus{
		outline:none;
		border-bottom: 1.9px solid black;
	}
	#main > div{
	}
	#midDiv > .row{
		margin:20px 0;
		font-size:18px;
	}
	#blackBtn{
		margin:10px;
		width:100px;
		height:40px;
		border:none;
		background-color:black;
		color:white;
	}
	#whiteBtn{
		margin:10px;
		width:100px;
		height:40px;
		border:1px solid black;
		background-color:white;
		color:black;
	}
	.flex{
		display:flex;
		align-items:center;
		justify-content: flex-start;
	}
	img{
		width:130px;
	}
	.goodsCnt{
		width:50px;
		height:34px;
		border-style:solid;
		border-width:1px;
		border-color:lightgray;
		float:left;
		padding:0 5px;
		text-align:center;
		outline:none;
	}
	.upgoods_cnt{
		background-image: url("${ctp}/images/upbtn.png");
		width:23px;
		height:17px;
		border:none;
		margin: 0 0 0 -1px;
		display:block;
	}
	.downgoods_cnt{
		background-image: url("${ctp}/images/downbtn.png");
		width:23px;
		height:17px;
		border:none;
		margin: 0 0 0 -1px;
		display:block;
	}
	#postCodeBtn{
		width:120px;
		height:35px;
		border-width:1px;
		background-color:white;
	}
	.inputTextArea{
		border: 1.9px solid lightgray;
		width:98%;
		font-size:1.1rem;
		height:200px;
	}
	.inputTextArea:focus{
		outline:none;
		border: 1.9px solid black;
	}
</style>
<body>
	<div id="main">
		<div class="marginAuto">
			<div class="row">
				<h1>상품문의</h1>
			</div>
			<div class="row">
				<div class="flex">
					<div style="margin-right:20px;">
						<img alt="" src="${ctp}/images/${vo.thumbNail}">
					</div>
					<div id="dd">
						<div class="row">${vo.brand_Name}</div>
						<div class="row">${vo.name}</div>
						<div class="row">₩<fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</div>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<form method="post" name="myform" enctype="multipart/form-data">
			<div class="marginAuto" id="midDiv">
				<div class="row">
					<div class="col-sm-3">문의유형</div>
					<div class="col-sm-9">
						<input type="radio" name="category" value="사이즈">&nbsp;사이즈
						<input type="radio" name="category" value="배송">&nbsp;배송
						<input type="radio" name="category" value="재입고">&nbsp;재입고
						<input type="radio" name="category" value="상품상세문의">&nbsp;상품상세문의
					</div>
				</div>
				<div class="row" id="exchangeDiv">
					<div class="col-sm-3">문의 옵션</div>
					<div class="col-sm-9">
						<select class="" id="optionSelect" name="">
						<option disabled hidden selected value="">사이즈 선택</option>
						<c:forEach var="stock" items="${vos}" varStatus="st">
							<option>${stock.goods_Option}</option>
						</c:forEach>		
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3">제목</div>
					<div class="col-sm-9">
						<input type="text" name="title">
						<input type="checkbox" name="" value="상품상세문의">&nbsp;비밀글
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3">문의 내용</div>
					<div class="col-sm-9">
						<textarea class="inputTextArea" name="content"></textarea>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3">이미지 첨부</div>
					<div class="col-sm-9">
						<input type="file" name="file" id="file" class="form-control-file border">
						<input type="hidden" name="goods_Idx" value="${goods_Idx}">
					</div>
				</div>
			</div>
			<hr>
			<div class="marginAuto">
				<div class="row" >
					<div class="marginAuto">
						<button id="whiteBtn" type="button">취소</button>
						<button id="blackBtn" type="button" onclick="fCheck()">신청</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>