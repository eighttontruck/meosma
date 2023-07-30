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
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<script>

</script>
<style>
	#listTable{
		margin-top:20px;
		width:100%;
		text-align:center;
		margin: 0 auto;
		margin-bottom:20px;
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
	#container{
		width:60%;
		margin:0 auto;
		margin-top:100px;
	}
	#container > div{
		width:60%;
		margin:0 auto;
		text-align:center;
	}
	.blackBtn{
		width:250px;
		height:60px;
		background-color:black;
		color:white;
		border:none;
	}
	.whiteBtn{
		width:250px;
		height:60px;
		background-color:white;
		color:black;
		border:1px solid;
	}
	img{
		width:100px;
	}
	.flex{
		display:flex;
		align-items:center;
		justify-content: flex-start;
	}
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div id="container">
		<h1 class="text-center">결제가 완료됐습니다.</h1>
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
		<p>결제정보</p>
		<p>고유ID : ${payMentInfo1}</p>
		<p>상점 거래ID : ${payMentInfo2}</p>
		<p>결제 금액 : ${payMentInfo3}</p>
		<p>카드 승인번호 : ${payMentInfo4}</p>
		<div>
			<button type="button" class="blackBtn" onclick="location.href='${ctp}/'">홈으로 가기</button>
			<button type="button" class="whiteBtn" onclick="location.href='${ctp}/member/memberMyPage'">마이페이지</button>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>