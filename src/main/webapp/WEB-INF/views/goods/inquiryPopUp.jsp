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
	function exchange(){
		$("#exchangeDiv").css("display","flex");
		$("#refundDiv").css("display","none");
	}
	function refund(){
		$("#exchangeDiv").css("display","none");
		$("#refundDiv").css("display","flex");
	}
	
	$(document).ready(function() {
		$("#exchange").prop('checked', true); 
		exchange();
		
	});
	
	function dd(){
		let cnt = $("#goods_Stock").val();
		$("#exchangeDiv").html("");
		let str="";
		for(let i=0; i<cnt; i++){
			str+='<div class="col-sm-3 mb-2">교환할 사이즈</div>';
			str+='<div class="col-sm-9">';
			str+='<select>';
			str+='<c:forEach var="stock" items="${stockVos}" varStatus="st">';
			str+='<c:if test="${vo.goods_Option eq stock.goods_Option}">';
			str+='<option disabled value="${stock.option_Idx}:${stock.stock}_${stock.goods_Option}">${stock.goods_Option}</option>';
			str+='</c:if>';
			str+='<c:if test="${vo.goods_Option ne stock.goods_Option}">';
			str+='<option value="${stock.option_Idx}:${stock.stock}_${stock.goods_Option}">${stock.goods_Option}</option>';
			str+='</c:if>';
			str+='</c:forEach>';
			str+='</select>';
			str+='</div>';
		}
		$("#exchangeDiv").append(str);
	}
</script>
<style>
	body > div{
		width:600px;
		height:750px;
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
						<img alt="" src="${ctp}/images/${vo.goods_ThumbNail}">
					</div>
					<div id="dd">
						<div class="row">${vo.goods_Brand}</div>
						<div class="row">${vo.goods_Name}</div>
						<div class="row">SIZE : ${vo.goods_Option}</div>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<div class="marginAuto" id="midDiv">
			<div class="row">
				<div class="col-sm-3">파일첨부</div>
				<div class="col-sm-9">
					<input type="file" name="file" id="file" class="form-control-file border">
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">문의유형</div>
				<div class="col-sm-9">
					<input type="radio" name="group1" id="exchange" onclick="exchange()">&nbsp;교환
					<input type="radio" name="group1" onclick="refund()">&nbsp;환불
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">수량</div>
				<div class="col-sm-9">
					<input type="number" id="goods_Stock" onchange="dd()" value="1" max="${vo.goods_Stock}" min=1 onclick="">
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3">사유</div>
				<div class="col-sm-9" ><input type="text"></div>
			</div>
			<div class="row" id="exchangeDiv">
				<div class="col-sm-3">교환할 사이즈</div>
				<div class="col-sm-9">
					<select>
						<option></option>		
					</select>
				</div>
			</div>
			<div class="row" id="refundDiv">
				<div class="col-sm-3">환불금액</div>
				<div class="col-sm-9">${vo.goods_Price}</div>
			</div>
		</div>
		<hr>
		<div class="marginAuto">
			<div class="row" >
				<div class="marginAuto2">
					<button id="whiteBtn">취소</button>
					<button id="blackBtn">신청</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>