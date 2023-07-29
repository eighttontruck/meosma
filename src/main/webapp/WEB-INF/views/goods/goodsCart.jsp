<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
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
</head>
<script>
	function onTotal(){
	    let total = 0;
	    let minIdx = parseInt(document.getElementById("minIdx").value);
	    let maxIdx = parseInt(document.getElementById("maxIdx").value);
	    for(let i=minIdx;i<=maxIdx;i++){
	      if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){  	// 장바구니에 들어있는 체크된 항목만을 총계를 구한다.
	        total = total + parseInt(document.getElementById("totalPrice"+i).value); 
	      }
	    }
	    document.getElementById("total").innerHTML='₩'+numberWithCommas(total);
	    document.getElementById("totalPriceInput").value=total;
	    
	    if(total>=200000||total==0){
	      document.getElementById("baeSong").innerHTML = '₩0';
	      document.getElementById("baeSongInput").value=0;
	    } else {
	      document.getElementById("baeSong").innerHTML='₩'+numberWithCommas(3000);
	      document.getElementById("baeSongInput").value=3000;
	    }
	    let lastPrice=parseInt(document.getElementById("baeSongInput").value)+total;
	    document.getElementById("lastPrice").innerHTML = '₩'+numberWithCommas(lastPrice);
	    document.getElementById("finalPriceInput").value = lastPrice;
	}

	function onCheck(){
	    let minIdx = parseInt(document.getElementById("minIdx").value);				// 출력되어있는 상품중에서 가장 작은 idx값이 minIdx변수에 저장된다.
	    let maxIdx = parseInt(document.getElementById("maxIdx").value);				// 출력되어있는 상품중에서 가장 큰  idx값이 maxIdx변수에 저장된다.
	    
	    // 상품 주문을 위한 체크박스에 체크가 되어있는것에 대한 처리루틴이다.
	    // 상품주문 체크박스가 체크되어 있지 않은것에 대한 개수를 emptyCnt에 누적처리하고 있다. 즉, emptyCnt가 0이면 모든 상품이 체크되어 있다는 것으로 '전체체크버튼'을 true로 처리해준다.
	    let emptyCnt=0;
	    for(let i=minIdx;i<=maxIdx;i++){
	      if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
	        emptyCnt++;
	        break;
	      }
	    }
	    if(emptyCnt!=0){
	      document.getElementById("allcheck").checked=false;
	    } 
	    else {
	      document.getElementById("allcheck").checked=true;
	    }
	    onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
	}

	function allCheck(){
		let minIdx = parseInt(document.getElementById("minIdx").value);
	  	let maxIdx = parseInt(document.getElementById("maxIdx").value);
	  	if(document.getElementById("allcheck").checked){
	    	for(let i=minIdx;i<=maxIdx;i++){
		      	if($("#idx"+i).length != 0){
		        	document.getElementById("idx"+i).checked=true;
		      	}
	    	}
	  	}
	  	else {
	    	for(let i=minIdx;i<=maxIdx;i++){
		      	if($("#idx"+i).length != 0){
		        	document.getElementById("idx"+i).checked=false;
		      	}
	    	}
	  	}
	  	onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
	}
	
	function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
	
	function deleteCart(){
		let cartArray = [];
		let total = 0;
	    let minIdx = parseInt(document.getElementById("minIdx").value);
	    let maxIdx = parseInt(document.getElementById("maxIdx").value);
	    for(let i=minIdx;i<=maxIdx;i++){
	      if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){  	// 장바구니에 들어있는 체크된 항목만을 총계를 구한다.
	        cartArray.push(i);
	      }
	    }
		if(cartArray.length==0){
			alert("삭제할 상품을 선택해주세요.");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/goods/deleteCartAJAX",
			data : {
				cartArray : cartArray
			},
			success : function(data){
				alert("dd");
				location.reload();
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}
	
	function payMentCheck(){
		myform.submit();
	}
	
	function updateCartStock(cart_Idx, maxStock, str){
		let curStock=$("#cntInput"+cart_Idx).val();
		
		if(maxStock==curStock&&str=='plus'){
			alert("최대 수량은 "+maxStock+"개 입니다.");
			return false;
		}
		
		if(curStock==1&&str=='minus'){
			alert("최소 수량은 1개 입니다.");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/goods/updateCartStockAJAX",
			data : {
				cart_Idx : cart_Idx,
				str : str
			},
			success : function(data){
				alert("수량이 변경되었습니다.");
				location.reload();
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}
</script>
<style>
	html,
      body {
        height: 100%;
        padding: 0px;
        margin: 0px;
      }

      header {
        height: 120px;
      }

      .wrap {
        min-height: calc(100% - 120px);
      }

      footer {
        height: 284px;
      }
	#listTable{
		margin-top:20px;
		width:60%;
		text-align:center;
		margin: 0 auto;
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
	img{
		width:100px;
	}
	.flex{
		display:flex;
		align-items:center;
		justify-content: flex-start;
	}
	.flex2{
		display:flex;
		align-items:center;
		justify-content: space-between;
	}
	.marginAuto{
		margin: 0 auto;
	}
	#priceDiv{
		width:60%;
		border-bottom: 1px solid black;
		margin-top:1rem;
	}
	#priceDiv > dl{
		text-align:right;
		padding:20px;
		width:33.3%;
	}
	#priceDiv dd{
		font-size:30px;
		text-align:right;
	}
	#priceDiv dt{
		font-size:20px;
		text-align:right;
	}
	#btnDiv{
		width:60%;
		margin-top:1rem;
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
</style>
<body>
	<header><jsp:include page="/WEB-INF/views/include/header.jsp" /></header>
	<div class="wrap">
		<div class="text-center mt-4"><h1><strong>CART</strong></h1></div>
		<form method="post" name="myform" action="${ctp}/goods/goodsPayment">
			<table id="listTable">
				<thead>
					<tr>
						<th><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/></th>
						<th>상품/옵션 정보</th>
						<th>수량</th>
						<th>상품금액</th>
						<th>적립예정액</th>
						<th>합계금액</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty vos}">
						<tr>
							<td colspan=6>장바구니에 물건 없음</td>
						</tr>
					</c:if>
					
					<c:forEach var="vo" items="${vos}" varStatus="st">
						<tr>
							<td><input type="checkbox" name="idxChecked" id="idx${vo.idx}" value="${vo.idx}" onClick="onCheck()" /></td>
							<td>
								<div class="flex">
									<div style="margin-right:20px;">
										<img alt="" src="${ctp}/images/${vo.order_ThumbNail}">
									</div>
									<div id="dd">
										<div class="row">${vo.order_Brand}</div>
										<div class="row">${vo.order_Name}</div>
										<div class="row">SIZE : ${vo.order_Option}</div>
									</div>
								</div>
							</td>
							<td style="width:80px;">
								<%-- ${vo.order_Stock} --%>
								<span id="goods_qty">
									<input type="text" id="cntInput${vo.idx}" name="order_Stock" value="${vo.stock}" class="goodsCnt" readonly>
									<span class="stockCntBtn">
										<button type="button" class="upgoods_cnt" onclick="updateCartStock(${vo.idx}, 'plus')" id="upgoods_cnt2"></button>
										<button type="button" class="downgoods_cnt" onclick="updateCartStock(${vo.idx}, 'minus')"></button>
									</span>
								</span>
							</td>
							<td>₩<fmt:formatNumber value="${vo.order_Price}" pattern="#,###"/></td>
							<td>
								<c:set var="accumulatedPoints" value="${vo.order_Price * vo.stock * 0.05}" />
								₩<fmt:formatNumber value="${accumulatedPoints}" pattern="#,###"/>
							</td>
							<td>
								<c:set var="totalPrice" value="${vo.order_Price * vo.stock}" />
								₩<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>
								<input type="hidden" value="${totalPrice}" id="totalPrice${vo.idx}">
							</td>
						</tr>
						<input type="hidden" name="goods_Idx" value="${vo.goods_Idx}">
						<input type="hidden" name="option_Idx" value="${vo.option_Idx}">
						<input type="hidden" name="order_Stock" value="${vo.stock}">
						<input type="hidden" name="order_Option" value="${vo.order_Option}">
						<input type="hidden" name="sIdx" value="${sIdx}">
					</c:forEach>
				</tbody>
			</table>
			<input type="hidden" name="finalPrice" id="totalPriceInput">
			<input type="hidden" name="buyStatus" value="cart">
		</form>
		<c:set var="minIdx" value="${vos[0].idx}"/>						<!-- 구매한 첫번째 상품의 idx -->
		<c:set var="maxSize" value="${fn:length(vos)-1}"/>		
		<c:set var="maxIdx" value="${vos[maxSize].idx}"/>			<!-- 구매한 마지막 상품의 idx -->
		<input type="hidden" id="minIdx" name="minIdx" value="${minIdx}"/>
		<input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
		<c:if test="${empty vos}">

		</c:if>
		<c:if test="${not empty vos}">
			<div>
				<div class="flex2 marginAuto" id="priceDiv">
					<dl>
						<dt>총 1개의 상품금액</dt>
						<dd>
							<strong id="total">₩0</strong>
						</dd>
					</dl>
					<dl>
						<dt>배송비</dt>
						<dd>
							<strong id="baeSong">₩0</strong>
							<input type="hidden" id="baeSongInput">
						</dd>
						
					</dl>
					<dl>
						<dt>합계</dt> 
						<dd>
							<strong id="lastPrice">₩0</strong>
							<input type="hidden" id="finalPriceInput">
						</dd>
					</dl>
				</div>
			</div>
			<div class="flex2 marginAuto" id="btnDiv">
				<div>
					<button type="button" onclick="deleteCart()">선택 삭제</button>
				</div>
				<div class="flex2">
					<button type="button" onclick="payMentCheck()">주문</button>
				</div>
			</div>
		</c:if>
	</div>
	<footer><jsp:include page="/WEB-INF/views/include/footer.jsp"/></footer>
</body>
</html>