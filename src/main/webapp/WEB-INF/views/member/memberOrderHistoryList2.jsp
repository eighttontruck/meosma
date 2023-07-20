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
	const detailButtons = document.querySelectorAll('.detail-btn');
	
	detailButtons.forEach(button => {
	  button.addEventListener('click', function() {
	    const row = this.closest('tr');
	    const existingDetailsTable = row.nextElementSibling;
	
	    if (existingDetailsTable && existingDetailsTable.classList.contains('details-table')) {
	      existingDetailsTable.classList.remove('show');
	      setTimeout(() => {
	        existingDetailsTable.remove();
	      }, 300); // transition 시간과 동일한 시간을 설정합니다.
	      return;
	    }
	
	    const detailsTable = document.createElement('table');
	    detailsTable.classList.add('details-table');
	    detailsTable.innerHTML = '
	      <tr>
	        <th>상품명</th>
	        <th>가격</th>
	      </tr>
	      <tr>
	        <td>상품 1</td>
	        <td>10000</td>
	      </tr>
	      <tr>
	        <td>상품 2</td>
	        <td>20000</td>
	      </tr>
	    ';
	
	    row.insertAdjacentElement('afterend', detailsTable);
	
	    setTimeout(() => {
	      detailsTable.classList.add('show');
	    }, 0);
	  });
	});
</script>
<style>
	#memberInfo{
		margin:0 auto;
/* 		text-align:center; */
		display:flex;
		background-color:lightgray;
		width:1200px;
		height:150px;
		margin-top:50px;
		padding:30px;
	}
	#memberInfo > div{
		width:380px;
	}
	#memberInfo2{
		display:flex;
		margin:0 auto;
		width:1200px;
	}
	#sidebar{
		width:300px;
		padding:50px;
	}
	#sidebar div{
		text-align:center;
	}
	#mainDiv{
		padding:50px;
		width:900px;
	}
	table{
		width:100%;
		text-align:center;
	}
	th{
		border-top:1px solid #ddd;
		border-bottom:1px solid #ddd;
		padding:7px 0;
		background:#f8f8f8;
	}
	td{
		padding:20px 0;
		border-bottom:1px solid #ddd;
	}
	
	
	.details-container {
	  overflow: hidden;
	}
	
	.details-table {
	  opacity: 0;
	  max-height: 0;
	  transition: max-height 0.3s ease, opacity 0.3s ease;
	}
	
	.details-table.show {
	  opacity: 1;
	  max-height: 1000px; /* 적절한 높이로 설정 */
	}
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div>
		<div id="memberInfo">
			<div>
				<p>회원이름</p>
				<h3>${vo.emailId}</h3>
			</div>
			<div>
				<p>회원 등급</p>
				<h3>${vo.level}</h3>
			</div>
			<div>
				<p>보유 포인트</p>
				<h3>${vo.point}</h3>
			</div>
			<div>
				<p>보유 쿠폰</p>
				<h3></h3>
			</div>
		</div>
		
		<div id="memberInfo2">
			<div id="sidebar">
				<div>
					<h3>나의 주문</h3>
					<a href="${ctp}/member/memberGoodsOrderList?sIdx=${sIdx}">전체 주문 내역</a><br>
					<a>결제 취소 내역</a><br>
					<a>교환 반품 내역</a>
				</div>
				<div>
					<h3>나의 정보</h3>
					<a>내 정보 수정</a><br>
					<a>포인트 & 쿠폰</a><br>
					<a>라플(응모내역)</a>
				</div>
				<div>
					<a>고객센터</a><br>
					<a>자주 묻는 질문</a><br>
					<a>로그아웃</a>
				</div>
			</div>
			<div id="mainDiv">
				<table>
					<thead>
						<tr>
							<th>주문 번호</th>
							<th>주문 날짜</th>
							<th>최종 결제 금액</th>
							<th>결제 상태</th>
							<th>배송 상태</th>
							<th>상세 정보</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="ordhi" items="${ohVos}" varStatus="st">
							<tr>
								<td>${ordhi.idx}</td>
								<td>${ordhi.orderDate}</td>
								<td>${ordhi.finalPrice}</td>
								<td>${ordhi.pay_Status}</td>
								<td>${ordhi.shipping_Status}</td>
								<td>
									<button class="detail-btn">구매확정</button>
									<button class="detail-btn">상</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>