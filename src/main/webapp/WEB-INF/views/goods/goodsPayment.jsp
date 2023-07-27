<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js"></script>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<script>
	let point = ${memberVo.point};
	let totalPrice = ${finalPrice};
	
	function fCheck(){
		let address1 = $.trim($("#sample6_postcode").val());
		let address2 = $.trim($("#sample6_address").val());
		let address3 = $.trim($("#sample6_detailAddress").val());
		let address = address2+" "+address3;
		$("#recipient_Address").val(address1+"/"+address2+"/"+address3);
		
		let goods_Name = $("#goodsName").val();
		
		if($('.goodsNames').length!=1){
			goods_Name = goods_Name+" 외 "+parseInt($('.goodsNames').length-1)+"개";
		}
		
		alert(goods_Name);
		var IMP = window.IMP; 
		IMP.init("imp18020804");
		IMP.request_pay({
		    /* pg : 'inicis', */ /* version 1.1.0부터 지원. 변경된 방침에서는 pg : 'html5_inicis' 로 고쳐준다. */
		    pg : 'html5_inicis.INIpayTest',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : goods_Name,
		    amount : 10, //판매 가격
		    buyer_email : '${memberVo.emailId}',
		    buyer_name : '${memberVo.name}',
		    buyer_tel : '${memberVo.telNum}',
		    buyer_addr : address,
		    buyer_postcode : address1
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
	}
	
	function fCheck2(){
		let address1 = $.trim($("#sample6_postcode").val());
		let address2 = $.trim($("#sample6_address").val());
		let address3 = $.trim($("#sample6_detailAddress").val());
		let address = address2+" "+address3;
		$("#recipient_Address").val(address1+"/"+address2+"/"+address3);
		
		myform.submit();
	}
	
	$(document).ready(function() {
		if(point==0){
			$("#pointCheckBox").attr("disabled",true);
		}
		let point2=0;
		let inputArray = $('input[name="expectSavePoint"]').toArray();
		for(let i=0; i< inputArray.length; i++){
			point2 += parseInt(inputArray[i].value);
		}
		
		$("#expectPoint").html("₩"+numberWithCommas(point2));
		$("#savePoint").val(point2);
		if(${finalPrice}>=100000){
			$("#shipFeeText").html(0);
		}
		
	});
	
	$(function(){
		$("#pointCheckBox").change(function(){
			if ($(this).is(":checked")) {
				$("#pointInput").val(${memberVo.point});
				usePoint2();
			} else {
				$("#pointInput").val(0);
				usePoint2();
			}
		});
		
	});
	
	function usePoint2(){
		let memberPoint = ${memberVo.point};
		let usedPoint = $("#pointInput").val().replace(/(^0+)/, "");
		let usedPoint2 = $("#pointInput").val();
		if(usedPoint >= memberPoint){
			$("#pointInput").val(${memberVo.point});
			$("#usedPoint").val(${memberVo.point});
			$("#pointCheckBox").prop("checked", true);
			ontotal2();
			return false;
		} else{
			$("#pointCheckBox").prop("checked", false);
		}
		$("#usedPoint").val(usedPoint2);
		$("#pointInput").val(usedPoint);
		if(usedPoint==""){
			$("#usedPoint").val(0);
		}
		
		ontotal2();
	}
	
	function useCoupon2(couponIdx,name,dcP){
		$("#usedCouponText").html(name+" 할인율 "+dcP+"% 적용됨");
		
		$("#coupon_Idx").val(couponIdx);
		$("#usedCoupon").val(${finalPrice}/100*dcP);
		
		ontotal2();
	}
	
	function ontotal2(){
		let point = $("#usedPoint").val();
		let coupon = $("#usedCoupon").val();
		
		/* alert(point);
		alert(coupon); */
		
		let finalPrice = ${finalPrice};
		let discountPrice = Number(point)+Number(coupon);
		$("#discountPrice").html("₩"+numberWithCommas(discountPrice));
		$("#finalPriceDiv").html("₩"+numberWithCommas(finalPrice-point-coupon));
		$("#finalPriceDiv2").html("₩"+numberWithCommas(finalPrice-point-coupon));
		$("#finalPriceInput").val(finalPrice-point-coupon);
		
	}
	
	function numberWithCommas(x) {
	      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
</script>
<style>
	#couponModal td{
		border-bottom:1px solid lightgray;
		height:50px;
	}
	strong{
		font-size:20px;
	}
	#listTable{
		margin-top:20px;
		width:100%;
		text-align:center;
		margin: 0 auto;
		margin-bottom:40px;
	}
	th{
		border-top:1px solid #ddd;
		border-bottom:1px solid #ddd;
		padding:7px 0;
		background:#f8f8f8;
		height:50px;
		font-size:18px;
	}
	#listTable td{
		border-bottom:1px solid lightgray;
		height:50px;
	}
 	form{
 		width:1000px;
 	}
	#orderList{
		width:1000px;
		margin:0 auto;
		height:auto;
	}
	#orderList > .row{
		text-align:center;
		width:900px;
		margin:0 auto;
	}
	.flex{
		display:flex;
		align-items:center;
		justify-content: flex-start;
	}
	.container{
		display:flex;
		flex-wrap:wrap;
		width:1100px;
		margin:0 auto;
	}
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
		
	}
	.inputText:focus{
		outline:none;
		border-bottom: 1.9px solid black;
	}
	/* .flexDiv > .col :first-child{
		margin:10px;
		font-weight:600;
		font-size:1rem;
	} */
	.labelText{
		margin:10px;
		font-weight:600;
		font-size:1.2rem;
	}
	.flexDiv > .col input:not([type="radio"],[type="checkbox"]) {
		width: 90%;
		margin:10px;
		font-size:1.1rem;
	}
	img{
		width:100px;
	}
	table{
		width:100%;
		text-align:center;
	}
	.orderImage{
		display:inline-block;
	}
	#postCodeBtn{
		width:120px;
		height:40px;
		border-width:1px;
		background-color:white;
	}
	#paymentBtn{
		width:500px;
		height:50px;
		background-color:black;
		color:white;
		border:none;
	}
	#couponBtn{
		width:100px;
		height:40px;
		background-color:white;
		border:1px solid;
	}
	#finalPrice{
		width:500px;
		height:70px;
		border-width:1px;
		border:solid;
		color:red;
		text-align:center;
		line-height:70px;
		margin-bottom:20px;
	}
	#finalPriceDiv2{
		width:500px;
		height:60px;
		border: 2px solid lightgray;
		text-align:center;
		font-size:30px;
		color:red;
		line-height:55px;
		margin: 10px 0;
	}
	input::-webkit-inner-spin-button {
	  appearance: none;
	  -moz-appearance: none;
	  -webkit-appearance: none;
	}
	.whiteBtn{
		width:50px;
		height:30px;
		background-color:white;
		boder:1px solid;
	}
	.whiteBigBtn{
		width:100px;
		height:40px;
		background-color:white;
		boder:1px solid lightgray;
	}
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="container">
		
		<div class="modal" id="myModal">
		    <div class="modal-dialog modal-dialog-centered modal-lg">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title">쿠폰 목록</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body">
		          <table id="couponModal">
		          	<thead>
		          		<tr>
		          			<th>쿠폰번호</th>
		          			<th>쿠폰명</th>
		          			<th>할인율</th>
		          			<th>발행날짜</th>
		          			<th>만료날짜</th>
		          			<th>비고</th>
		          		</tr>
		          	</thead>
		          	<tbody>
		          		<c:forEach var="coupon" items="${couponVos}" varStatus="st">
			          		<tr>
			          			<td>${coupon.idx}</td>
			          			<td>${coupon.name}</td>
			          			<td>${coupon.dcPercentage}%</td>
			          			<td>${fn:substring(coupon.issuedDate,2,11)}</td>
			          			<td>${fn:substring(coupon.usageDate,2,11)}</td>
			          			<td><button type="button" id="useCouponBtn" class="useCouponBtn whiteBtn" onclick="useCoupon2(${coupon.idx},'${coupon.name}' ,${coupon.dcPercentage})" data-dismiss="modal">사용</button></td>
			          		</tr>
			          		<input type="hidden" id="coupon${coupon.idx}" value="${coupon.dcPercentage}" >
		          		</c:forEach>
		          		<c:if test="${empty couponVos}"> <!-- List가 비어있는지 확인 -->
						    <tr>
						      	<td colspan="4"><h4>적용 가능한 쿠폰이 없습니다.</h4></td> <!-- "없음" 메시지를 표시 -->
						    </tr>
						</c:if>
		          	</tbody>
		          </table>
		        </div>
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
		        </div>
		        
		      </div>
		    </div>
  		</div>
  		
  		<!-- The Modal -->
		<div class="modal" id="deliveryModal">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">배송지 목록</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		        <table>
		        	<thead>
		        		<tr>
		        			<th>이름</th>
		        			<th>전화번호</th>
		        			<th>주소</th>
		        			<th>비고</th>
		        		</tr>
		        	</thead>
		        	<tbody>
		        		<c:forEach var="ShipAdd" items="${member_ShipAddVos}" varStatus="st">
							<tr>
								<td>${ShipAdd.ship_Name}</td>
								<td>${ShipAdd.ship_TelNum}</td>
								<td>${ShipAdd.ship_Address}</td>
								<td><button type="button">선택</button></td>
							</tr>		        		
		        		</c:forEach>
		        		<c:if test="${empty member_ShipAddVos}"> <!-- List가 비어있는지 확인 -->
						    <tr>
						      	<td colspan="4"><h4>등록된 주소 없음</h4></td> <!-- "없음" 메시지를 표시 -->
						    </tr>
						</c:if>
		        	</tbody>
		        </table>
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
		      </div>
		
		    </div>
		  </div>
		</div>
  		
  		<form name="myform" method="post" action="${ctp}/goods/goodsPaymentOk" class="container">
			<div id="orderList">
				<div class="ml-2"><h1><strong>ORDER</strong></h1></div>
				<table id="listTable">
					<thead>
						<tr>
							<th>상품/옵션 정보</th>
							<th>수량</th>
							<th>상품금액</th>
							<th>적립예정</th>
							<th>합계금액</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="vo" items="${vos}" varStatus="st">
							<tr>
								<td>
									<div class="flex">
										<div style="margin-right:20px;">
											<img alt="" src="${ctp}/images/${vo.order_ThumbNail}">
										</div>
										<div id="dd">
											<div class="row">${vo.order_Brand}</div>
											<div class="row">${vo.order_Name}</div>
											<div class="row">SIZE : ${vo.order_Option}</div>
											<input type="hidden" value="${vo.order_Name}" class="goodsNames" id="goodsName">
										</div>
									</div>
								</td>
								<td>${vo.order_Stock}</td>
								<td>₩<fmt:formatNumber value="${vo.order_Price}" pattern="#,###"/></td>
								<td>
									<c:set var="accumulatedPoints" value="${vo.order_Price * vo.order_Stock * 0.05}" />
									₩<fmt:formatNumber value="${accumulatedPoints}" pattern="#,###"/>
									<input type="hidden" value="${accumulatedPoints}" name="expectSavePoint">
								</td>
								<td>
									<c:set var="totalPrice2" value="${vo.order_Price * vo.order_Stock}" />
									₩<fmt:formatNumber value="${totalPrice2}" pattern="#,###"/>
									<input type="hidden" value="${totalPrice2}" id="totalPrice${vo.idx}">
								</td>
							</tr>
							<input type="hidden" name="cart_Idx" value="${vo.idx}">
							<input type="hidden" name="goods_Idx" value="${vo.goods_Idx}">
							<input type="hidden" name="order_Option" value="${vo.order_Option}">
							<input type="hidden" name="option_Idx" value="${vo.option_Idx}">
							<input type="hidden" name="order_Stock" value="${vo.order_Stock}">
							<input type="hidden" name="totalPrice" value="${totalPrice2}">
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<div id="memberInfo" class="flexDiv">
				<div class="bigText"><h1><strong>주문자 정보</strong></h1></div>
				<div class="col">
					<div class="labelText">주문자명</div>
					<div><input type="text" class="inputText" name="orderer_Name" value="${memberVo.name}" readonly></div>
				</div>
				<!-- <div class="col">
					<div class="labelText">주소</div>
					<div><input type="text" class="inputText"></div>
				</div>
				<div class="col">
					<div class="labelText">전화번호</div>
					<div><input type="text" class="inputText"></div>
				</div> -->
				<div class="col">
					<div class="labelText">휴대폰 번호</div>
					<div><input type="text" class="inputText" name="orderer_TelNum" value="${memberVo.telNum}" ></div>
				</div>
				<div class="col">
					<div class="labelText">이메일</div>
					<div><input type="text" class="inputText" name="orderer_EmailId" value="${memberVo.emailId}" readonly></div>
				</div>
			</div>
			
			<div id="deliveryInfo" class="flexDiv">
				<div class="bigText"><h1><strong>배송지 정보</strong></h1></div>
				<div class="col">
					<div class="labelText">배송지 확인&nbsp;<button type="button" class="whiteBigBtn" data-toggle="modal" data-target="#deliveryModal">배송지 목록</button></div>
					<div>
						<input type="radio" name="myGroup" class="inputText" checked>&nbsp;직접 입력
						<input type="radio" name="myGroup" class="inputText">&nbsp;최근 이용한 주소 가져오기
					</div>
				</div>
				<div class="col">
					<div class="labelText">수령인</div>
					<div><input type="text" name="recipient_Name" class="inputText"></div>
				</div>
				<div class="col">
					<div class="labelText">주소 결제시 / 기준으로 짤라서 저장하기</div>
					<div>
			        	<input type="text" id="sample6_postcode" style="width:295px;"class="inputText">
			          	<button type="button" onclick="sample6_execDaumPostcode()" id="postCodeBtn">우편번호 찾기</button>
			      		<input type="text" id="sample6_address" size="50" class="inputText">
			        	<input type="text" id="sample6_detailAddress" class="inputText">
			        	<input type="hidden" name="recipient_Address" id="recipient_Address"> <!-- 보내기 전에 합쳐서/ 로 구분해서 보내기 -->
			          	<input type="hidden" id="sample6_extraAddress" class="inputText">
					</div>
					
					<!-- <div><input type="text" id="sample6_address" class="inputText" style="width:70%;"><button>우편번호 검색</button></div>
					<div><input type="text" id="sample6_detailAddress" class="inputText"></div>
					<div><input type="text" id="sample6_extraAddress" class="inputText"></div> -->
				</div>
				<div class="col">
					<div class="labelText">휴대폰 번호</div>
					<div><input type="text" name="recipient_TelNum" class="inputText"></div>
				</div>
				<!-- <div class="col">
					<div class="labelText">전화번호</div>
					<div><input type="text" class="inputText"></div>
				</div> -->
				<div class="col">
					<div class="labelText">배송 요청사항</div>
					<div><input type="text" class="inputText"></div>
				</div>
			</div>
			
			<div id="paymentInfo" class="flexDiv">
				<div class="bigText"><h1><strong>결제 정보</strong></h1></div>
				<div class="col">
					<div class="labelText">상품 합계 금액</div>
					<div class="ml-4"><strong>₩<fmt:formatNumber value="${finalPrice}" pattern="#,###"/></strong></div>
				</div>
				<div class="col">
					<div class="labelText">배송비</div>
					<div><strong class="ml-4">₩<span id="shipFeeText">3,000</span></strong></div>
				</div>
				<div class="col">
					<div>할인 및 적립</div>
					<div>할인 : <strong id="discountPrice">0</strong></div>
					<div>예상적립금 : <strong id="expectPoint"></strong></div>
				</div>
				<div class="col">
					<div class="labelText">적립금 사용</div>
					<div><input type="number" class="inputText" id="pointInput" oninput="usePoint2()" style="width:50%;">원</div>
					<div><input type="checkbox" class="inputText" id="pointCheckBox">&nbsp;전액 사용하기(보유 적립금 <fmt:formatNumber value="${memberVo.point}" pattern="#,###"/>원)</div>
				</div>
				<div class="col">
					<div class="labelText">쿠폰 사용&nbsp;<button type="button" id="couponBtn" data-toggle="modal" data-target="#myModal">쿠폰 목록</button></div>
					<div id="usedCouponText">사용 안함</div>
				</div>
				<div class="col">
					<div class="labelText">최종 결제 금액</div>
					<div><strong class="ml-4" id="finalPriceDiv">${finalPrice}</strong></div>
				</div>
			</div>
			
			<div id="selectPayment" class="flexDiv">
				<div class="bigText"><h1><strong>결제수단 선택</strong></h1></div>
				<div class="col">
					<div class="labelText">
						※ 고객님은 안전거래를 위해 현금으로 결제시 저희 쇼핑몰에서 가입한 구매안전서비스인 KG 이니시스의 구매안전(에스크로)서비스를 이용하실 수 있습니다.
					</div>
				</div>
				<div id="finalPriceDiv2">₩<fmt:formatNumber value="${finalPrice}" pattern="#,###"/></div>
				<input type="hidden" id="usedCoupon">
				<input type="text" value="0" name="usedPoint" id="usedPoint">
				<input type="hidden" id="finalPriceInput" name="finalPrice" value="${finalPrice}" readonly>
				<input type="hidden" value="0" id="coupon_Idx" name="coupon_Idx">
				<input type="hidden" name="buyStatus" value="${buyStatus}">
				<input type="hidden" name="payMentInfo1" id="payMentInfo1">
				<input type="hidden" name="payMentInfo2" id="payMentInfo2">
				<input type="hidden" name="payMentInfo3" id="payMentInfo3">
				<input type="hidden" name="payMentInfo4" id="payMentInfo4">
				<div class="col mb-2">
					<input type="checkbox">&nbsp;(필수) 구매하실 상품의 결제정보를 확인하였으며, 구매진행에 동의합니다. 주문이 폭주하여 실재고보다 많은 주문이 들어올 경우 결제가 취소 될 수 있습니다.
				</div>
				<div>
					<button type="button" id="paymentBtn" onclick="fCheck2()">결제하기</button>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>