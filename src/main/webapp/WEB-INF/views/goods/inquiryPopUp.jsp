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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js"></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<script>
	
	function exchange2(){
		$("#exchangeDiv").css("display","flex");
		$("#exchangeFee").css("display","flex");
		$("#refundDiv").css("display","none");
		$("#nameDiv").css("display","flex");
		$("#telNumDiv").css("display","flex");
		$("#addressDiv").css("display","flex");
		$("#refundStockDiv").html("");
	}
	function refund(){
		$("#exchangeFee").css("display","none");
		$("#exchangeDiv").css("display","none");
		$("#nameDiv").css("display","none");
		$("#telNumDiv").css("display","none");
		$("#addressDiv").css("display","none");
		$("#refundDiv").css("display","flex");
		
		$("#refundStockDiv").html("");
		let str = "";
		str += '<div class="col-sm-3">환불할 수량<input type="checkbox" name="idxChecked" value="${goodsVo.idx}" checked style="display:none;"/></div>';
		str += '<input type="hidden" name="option_Idx" value="${vo.option_Idx}">';
		str += '<div class="col-sm-9"><span id="goods_qty">';
		str += '<input type="text" id="cntInput" name="order_Stock" value="1" class="goodsCnt" readonly>';
		str += '<span class="stockCntBtn"><button type="button" onclick="stockCntUp2()" class="upgoods_cnt" id="upgoods_cnt2"></button>';
		str += '<button type="button" class="downgoods_cnt" onclick="stockCntDown2()"></button></span>';
		str += '</span></div>';
		$("#refundStockDiv").append(str);
		
		$("#refundPrice").html("");
		let cnt=$("#cntInput").val();
		let totalPrice = 0;
	 	totalPrice = ${vo.goods_Price} * cnt;
		alert(totalPrice);
		let refundPrice = totalPrice - 3000;
		$("#refundPrice").html("₩"+numberWithCommas(totalPrice)+" - ₩"+numberWithCommas(3000)+" = ₩"+numberWithCommas(refundPrice));
		
		$("#selectedOption").html("");
		
		$("#refundPriceInput").val(refundPrice);
	}
	
	$(document).ready(function() {
		$("#exchange").prop('checked', true); 
		exchange2();
		
	});
	
	let option_IdxArray = new Array();
	$(function(){
		$("#optionSelect").change(function(){
			let optionSelect=$(this).val();
			let option_Idx = optionSelect.substring(0,optionSelect.indexOf(":"));
			let goods_Stock = optionSelect.substring(optionSelect.indexOf(":")+1,optionSelect.indexOf("_"));
			let option_Name = optionSelect.substring(optionSelect.indexOf("_")+1);
			let goods_Price = numberWithCommas(${vo.goods_Price});
			if($("#goods_Option"+option_Idx).length == 0){
				let str='';
				option_IdxArray[option_Idx]=option_Idx;
				valuesArray = $('input[name="order_Stock"]').map(function() {
			        return this.value;
			    }).get();
				let maxStock=${vo.goods_Stock};
				let returnTotalStock=0;
				//alert(valuesArray);
				for(let i=0; i<valuesArray.length; i++){
					returnTotalStock += parseInt(valuesArray[i]);
					if(maxStock<=returnTotalStock){
						alert("주문하신 수량이상으로 교환할 수 없습니다.");
						alert(returnTotalStock);
						return false;
					}
				}
				
				//str += '<tbody id="goods_Option'+option_Idx+'">'
					str += '<div class="row mb-2" id="goods_Option'+option_Idx+'">'
						str += '<div class="col-sm-3 size">'+option_Name+'<input type="checkbox" name="idxChecked" value="${goodsVo.idx}" checked style="display:none;"/></div>'
						str += '<input type="hidden" name="exchangeOption_Idx" value="'+option_Idx+'">'
						str += '<div class="col-sm-3" style="padding:0 34px;"><span id="goods_qty">';
							str += '<input type="text" id="cntInput'+option_Idx+'" name="order_Stock" value="1" class="goodsCnt" readonly>'
							str += '<span class="stockCntBtn"><button type="button" onclick="stockCntUp('+option_Idx+','+goods_Stock+','+${vo.goods_Price}+')" class="upgoods_cnt" id="upgoods_cnt2"></button>'
							str += '<button type="button" class="downgoods_cnt" onclick="stockCntDown('+option_Idx+','+${vo.goods_Price}+')"></button></span>'
						str += '</span></div>';
						//str += '<div class="col" id="optionPrice'+option_Idx+'" style="text-align:right;">₩'+goods_Price+'</div>'
						str += '<div class="col-sm-6 delBtn"><button type="button" id="closebtn" onclick=delOption('+option_Idx+')><img src="${ctp}/images/closebtn.PNG"></img></button></div>'
					str += '</div>'
				//str += '</tbody>'
				
				$("#selectedOption").append(str);
				onTotal();
				
			} else{
				alert("이미 선택된 옵션 입니다.");
			}
		
		});
		
		$("#sameAddress").on("change", function() {
			if ($(this).prop("checked")) {
				let address = "${vo.recipient_Address}";
				let cutAddress=address.split("/");
				$("#recipient_Name").val("${vo.recipient_Name}");
				$("#recipient_telNum").val("${vo.recipient_telNum}");
			  	$("#sample6_postcode").val(cutAddress[0]);
			  	$("#sample6_address").val(cutAddress[1]);
			  	$("#sample6_detailAddress").val(cutAddress[2]);
			  	$("#recipient_Name").attr("readonly",true);
				$("#recipient_telNum").attr("readonly",true);
			  	$("#sample6_postcode").attr("readonly",true);
			  	$("#sample6_address").attr("readonly",true);
			  	$("#sample6_detailAddress").attr("readonly",true);
			  
			} else {
				$("#recipient_Name").val("");
				$("#recipient_telNum").val("");
				$("#sample6_postcode").val("");
			  	$("#sample6_address").val("");
			  	$("#sample6_detailAddress").val("");
			  	$("#recipient_Name").attr("readonly",false);
				$("#recipient_telNum").attr("readonly",false);
			  	$("#sample6_postcode").attr("readonly",false);
			  	$("#sample6_address").attr("readonly",false);
			  	$("#sample6_detailAddress").attr("readonly",false);
			}
	    });
	});
	
	function fCheck(){
		let address = $("#sample6_postcode").val()+"/"+$("#sample6_address").val()+"/"+$("#sample6_detailAddress").val();
		$("#recipient_Address").val(address);
		
		let exchangeRadio = $("#exchange");
		if(exchange.checked){
			var IMP = window.IMP; 
			IMP.init("imp18020804");
			IMP.request_pay({
			    /* pg : 'inicis', */ /* version 1.1.0부터 지원. 변경된 방침에서는 pg : 'html5_inicis' 로 고쳐준다. */
			    pg : 'html5_inicis.INIpayTest',
			    pay_method : 'card',
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : '${vo.goods_Name}',
			    amount : 6000, //판매 가격
			    buyer_email : '${memberVo.emailId}',
			    buyer_name : '${memberVo.name}',
			    buyer_tel : '${memberVo.telNum}',
			    buyer_addr : $("#sample6_address").val()+" "+$("#sample6_detailAddress").val(),
			    buyer_postcode : $("#sample6_postcode").val()
			}, function(rsp) {
				  var paySw = 'no';
			    if ( rsp.success ) {
			        paySw = 'ok';
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;
			    }
			    alert(msg);
			    if(paySw == 'no') {
				    alert("결제를 취소하셨습니다.");
			    }
			    else {
			    	myform.submit();
			    }
			});
		} else{
			myform.submit();
		}
		
		//myform.submit();		
	}
	
	function fCheck2(){
		let address = $("#sample6_postcode").val()+"/"+$("#sample6_address").val()+"/"+$("#sample6_detailAddress").val();
		$("#recipient_Address").val(address);
		myform.submit();
	}
	
	function delOption(option_Idx){
		//option_IdxArray.splice(option_Idx,1);
		option_IdxArray[option_Idx]=0;
		$("#goods_Option"+option_Idx).remove();
		onTotal();
	}
	
	function stockCntUp(option_Idx,goods_Stock,goods_Price){
		let valuesArray = $('input[name="order_Stock"]').map(function() {
	        return this.value;
	    }).get();
		alert(valuesArray[0]);
		let maxStock=${vo.goods_Stock};
		let returnTotalStock=0;
		for(let i=0; i<valuesArray.length; i++){
			returnTotalStock += parseInt(valuesArray[i]);
			if(maxStock<=returnTotalStock){
				alert("주문하신 수량이상으로 교환할 수 없습니다.");
				alert(returnTotalStock);
				return false;
			}
		}
		
		let cnt=$("#cntInput"+option_Idx).val();
		if(cnt>=goods_Stock){
			alert("최대 수량은 "+goods_Stock+"개 입니다.");
			$("#cntInput"+option_Idx).val(goods_Stock);
			return false;
		}
		cnt++;
		$("#cntInput"+option_Idx).val(cnt);
		$("#optionPrice"+option_Idx).html("₩"+numberWithCommas(goods_Price*cnt));
		onTotal();
	}
	
	function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
	
	function onTotal(){
		let totalPrice = 0;
		option_IdxArray.forEach(function(number){
			//alert(number);
			if(number!=0){
				let stock = $("#cntInput"+number).val();
				totalPrice+=${vo.goods_Price} * stock;
			}
		});
		$("#totalPrice").html("₩"+numberWithCommas(totalPrice));
		$("#totalPriceInput").val(totalPrice);
	}
	
	function stockCntDown(option_Idx,goods_Price){
		let cnt=$("#cntInput"+option_Idx).val();
		if(cnt<=1){
			alert("최소 수량은 1개 입니다.");
			$("#cntInput"+option_Idx).val(1);
			return false;
		}
		cnt--;
		$("#cntInput"+option_Idx).val(cnt);
		$("#optionPrice"+option_Idx).html("₩"+numberWithCommas(goods_Price*cnt));
		onTotal();
	}
	
	function stockCntUp2(){
		
		let cnt=$("#cntInput").val();
		let maxStock = ${vo.goods_Stock};
		if(cnt>=maxStock){
			alert("주문하신 수량 이상은 환불할 수 없습니다.");
			return false;
		}
		cnt++;
		$("#cntInput").val(cnt);
		//$("#optionPrice"+option_Idx).html("₩"+numberWithCommas(goods_Price*cnt));
		onTotal2();
	}
	
	function stockCntDown2(){
		let cnt=$("#cntInput").val();
		if(cnt<=1){
			alert("최소 수량은 1개 입니다.");
			return false;
		}
		cnt--;
		$("#cntInput").val(cnt);
		//$("#optionPrice"+option_Idx).html("₩"+numberWithCommas(goods_Price*cnt));
		onTotal2();
	}
	
	function onTotal2(){
		$("#refundPrice").html("");
		let cnt=$("#cntInput").val();
		let totalPrice = 0;
	 	totalPrice = ${vo.goods_Price} * cnt;
		alert(totalPrice);
		let refundPrice = totalPrice - 3000;
		$("#refundPrice").html("₩"+numberWithCommas(totalPrice)+" - ₩"+numberWithCommas(3000)+" = ₩"+numberWithCommas(refundPrice));
		//$("#totalPriceInput").val(totalPrice);
		$("#refundPriceInput").val(refundPrice);
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
						<div class="row">STOCK : ${vo.goods_Stock}개</div>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<form method="post" name="myform">
		<input type="hidden" name="idx" value="${vo.idx}">
		<input type="hidden" name="orderHistory_Idx" value="${vo.idx}">
		<input type="hidden" name="refundPrice" id="refundPriceInput" value="0">
		<input type="hidden" name="goods_Idx" value="${goods_Idx}">
		<input type="hidden" name="refundOption_Idx" value="${vo.option_Idx}">
		<input type="hidden" name="order_Option" value="${vo.goods_Option}">
		<div class="marginAuto" id="midDiv">
			<div class="row">
				<div class="col-sm-3">문의유형</div>
				<div class="col-sm-9">
					<input type="radio" name="category" value="exchange" id="exchange" onclick="exchange2()">&nbsp;교환
					<input type="radio" name="category" value="refund" onclick="refund()">&nbsp;환불
				</div>
			</div>
			<%-- <div class="row">
				<div class="col-sm-3">수량</div>
				<div class="col-sm-9">
					<input type="number" id="goods_Stock" onchange="dd()" value="1" max="${vo.goods_Stock}" min=1>
				</div>
			</div> --%>
			<div class="row">
				<div class="col-sm-3">사유</div>
				<div class="col-sm-9"><input type="text" name="reason"></div>
			</div>
			<div class="row" id="exchangeDiv">
				<div class="col-sm-3">교환할 사이즈</div>
				<div class="col-sm-9">
					<select class="" id="optionSelect">
					<option disabled hidden selected value="">사이즈 선택</option>
					<c:forEach var="stock" items="${stockVos}" varStatus="st">
						<c:if test="${vo.goods_Option eq stock.goods_Option}">
							<option disabled value="${stock.option_Idx}:${stock.stock}_${stock.goods_Option}">${stock.goods_Option}</option>
						</c:if>
						<c:if test="${vo.goods_Option ne stock.goods_Option}">
							<option value="${stock.option_Idx}:${stock.stock}_${stock.goods_Option}">${stock.goods_Option}</option>
						</c:if>
					</c:forEach>		
					</select>
				</div>
			</div>
			<div id="selectedOption"></div>
			<div class="row" id="exchangeFee">
				<div class="col-sm-3">결제할 금액</div>
				<div class="col-sm-9">₩6,000(왕복 배송비)</div>
			</div>
			<div class="row" id="refundStockDiv"></div>
			<div class="row" id="refundDiv">
				<div class="col-sm-3">환불금액</div>
				<div class="col-sm-9" id="refundPrice">${vo.goods_Price}</div>
			</div>
			<div class="row" id="nameDiv">
				<div class="col-sm-3">이름</div>
				<div class="col-sm-9"><input type="text" name="recipient_Name" id="recipient_Name"></div>
			</div>
			<div class="row" id="telNumDiv">
				<div class="col-sm-3">휴대폰 번호</div>
				<div class="col-sm-9"><input type="text" name="recipient_TelNum" id="recipient_telNum"></div>
			</div>
			<div class="row" id="addressDiv">
				<div class="col-sm-3">주소</div>
				<div class="col-sm-9">
					<input type="text" id="sample6_postcode" style="width:200px;"class="inputText">
		          	<button type="button" onclick="sample6_execDaumPostcode()" id="postCodeBtn">우편번호 찾기</button>
		      		<input type="text" id="sample6_address" size="29" class="inputText">
		        	<input type="text" id="sample6_detailAddress" size="29" class="inputText">
		        	<input type="hidden" name="recipient_Address" id="recipient_Address">
		          	<input type="hidden" id="sample6_extraAddress" class="inputText">
		          	<br><input type="checkBox" id="sameAddress">&nbsp;동일한 주소로 보내기
				</div>
			</div>
		</div>
		<hr>
		<div class="marginAuto">
			<div class="row" >
				<div class="marginAuto2">
					<button id="whiteBtn">취소</button>
					<button id="blackBtn" type="button" onclick="fCheck2()">신청</button>
				</div>
			</div>
		</div>
		</form>
	</div>
</body>
</html>