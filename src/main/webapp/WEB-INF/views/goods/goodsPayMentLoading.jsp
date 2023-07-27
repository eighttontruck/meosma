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
	var IMP = window.IMP; 
	IMP.init("imp18020804");
	IMP.request_pay({
	    /* pg : 'inicis', */ /* version 1.1.0부터 지원. 변경된 방침에서는 pg : 'html5_inicis' 로 고쳐준다. */
	    pg : 'html5_inicis.INIpayTest',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : 'ㅇ',
	    amount : 10, //판매 가격
	    buyer_email : '2ju4885@naver.com',
	    buyer_name : 'ㅇ',
	    buyer_tel : 'ㅇㅇ',
	    buyer_addr : 'ㅇㅇ',
	    buyer_postcode : 'ㅇㅇ'
	}, function(rsp) {
		  var paySw = 'no';
	    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
	        msg += '\n고유ID : ' + rsp.imp_uid;
	        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	        msg += '\n결제 금액 : ' + rsp.paid_amount;
	        msg += '\n카드 승인번호 : ' + rsp.apply_num;
	        paySw = 'ok';
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	    if(paySw == 'no') {
		    alert("다시 주문구매창으로 이동합니다.");
		    myform.submit();
		    /* history.go(-1);
	    	location.href='${ctp}/goods/goodsPayment'; */
	    }
	    else {
				var temp = "";
				temp += '?name=${payMentVO.name}';
				temp += '&amount=${payMentVO.amount}';
				temp += '&buyer_email=${payMentVO.buyer_email}';
				temp += '&buyer_name=${payMentVO.buyer_name}';
				temp += '&buyer_tel=${payMentVO.buyer_tel}';
				temp += '&buyer_addr=${payMentVO.buyer_addr}';
				temp += '&buyer_postcode=${payMentVO.buyer_postcode}';
				temp += '&imp_uid=' + rsp.imp_uid;
				temp += '&merchant_uid=' + rsp.merchant_uid;
				temp += '&paid_amount=' + rsp.paid_amount;
				temp += '&apply_num=' + rsp.apply_num;
				
				temp += '&orderIdx=${orderVO.orderIdx}';
				
 				location.href='${ctp}/dbShop/paymentResult'+temp;
	    }
	});
</script>
<style>
	
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<form name="myform" method="post" action="${ctp}/goods/goodsPayment">
		<c:forEach var="vo" items="${vos2}" varStatus="st">
			<input type="checkBox" name="idxChecked"  value="${vo.idxChecked}" checked/>
			<input type="text" name="order_Option" value="${vo.order_Option}">
			<input type="text" name="order_Stock" value="${vo.order_Stock}">
			<input type="text" name="goods_Idx" value="${vo.goods_Idx}">
			<input type="text" name="option_Idx" value="${vo.option_Idx}">
		</c:forEach>
		<input type="text" name="buyStatus" value="${buyStatus}">
		<input type="text" name="sIdx" value="${sIdx}">
		<input type="text" name="finalPrice" value="${finalPrice}">
	</form>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>