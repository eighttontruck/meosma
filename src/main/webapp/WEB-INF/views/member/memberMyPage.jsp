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
</head>
<script>
function getOrderHistory_DetailList(idx){
	$.ajax({
		type : "post",
		url : "${ctp}/admin/orderHistory_DetailListAJAX",
		data : {
			idx : idx,
		},
		success : function(data){
			let str='';
			for(let i=0; i<data.length; i++){
				if(data[i] == null) break;
				str += '<tr>';
				str += '<td><div class="flex">';
				str += '<div><img class="orderListImg" src="${ctp}/images/'+data[i].goods_ThumbNail+'"></div>';
				str += '<div>'+data[i].goods_Brand+'<br><strong>'+data[i].goods_Name+'</strong><br>'+data[i].goods_Option+'</div>';
				str += '</div></td>';
				str += '<td>'+data[i].idx+'</td>';
				str += '<td>₩'+data[i].totalPrice+'('+data[i].goods_Stock+'개)</td>';
				str += '<td><button>반품&교환&환불 신청</button></td>';
				str += '</tr>';
			}
			$("#orderHistory_DetailtBody").html(str);
		},
		error : function() {
			alert("전송오류!");
		}
	});
}
</script>
<style>
	#memberInfo{
		margin:0 auto;
/* 		text-align:center; */
		display:flex;
		background-color:lightgray;
		width:100%;
		height:300px;
		padding:30px;
	}
	#memberInfo2{
		display:flex;
		margin:0 auto;
		width:100%;
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
		width:100%;
	}
	#listTable{
		margin-top:20px;
		width:100%;
		text-align:center;
	}
	#modalTable{
		width:100%;
		text-align:center;
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
	#modalTable td{
		border-bottom:1px solid lightgray;
	}
	#container{
		width:100%;
	}
	.headerDiv{
		width:50%;
	}
	#headerRightDiv{
		display:flex;
	}
	#headerRightDiv > div{
		width:33%;
		padding:50px;
	}
	#headerLeftDiv{
		padding-left:100px;
	}
	#mainDiv a{
		margin:0 15px;
		font-size:18px;
	}
	.round-image{
		width:100%;
		height:100%;
	}
	.circle-container {
	  width: 150px; /* 원의 지름을 설정 */
	  height: 150px; /* 원의 지름을 설정 */
	  border-radius: 50%; /* 정확한 원 모양을 생성 */
	  overflow: hidden; /* 이미지가 원 밖으로 넘치지 않도록 숨김 처리 */
	  float:left;
	  margin-right:50px;
	}
	.flex{
		display:flex;
		align-items:center;
	}
	.orderListImg{
		width:100px;
	}
	.font{
		font-size:10px;
		font-height:10px;
	}
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div id="container">
		<div id="memberInfo">
			<div class="headerDiv" id="headerLeftDiv">
				<div><h3><strong>My Page</strong></h3></div>
				<div>
					<div class="circle-container">
						<img alt="" class="round-image" src="${ctp}/images/1_1.jpg">
					</div>
					<div class="flex"><h1><strong>${vo.name}</strong></h1><a>회원정보변경</a></div>
					<div class="flex">LV.${vo.level}</div>
				</div>
			</div>
			<div class="headerDiv" id="headerRightDiv">
				<div>
					<img alt="" src="${ctp}/images/coin.png" style="width:50px;">
					<h4>적립금 ></h4>
					<h1><strong>${vo.point}</strong></h1>
				</div>
				<div>
					<img alt="" src="${ctp}/images/coupon.png" style="width:70px;">
					<h4>쿠폰 ></h4>
					<h1><strong>${vo.level}</strong></h1>
				</div>
				<div>
					<img alt="" src="${ctp}/images/review.png" style="width:50px;">
					<h4>후기작성 ></h4>
					<h1><strong>2</strong></h1>
				</div>
			</div>
		</div>
		<!-- The Modal -->
		  <div class="modal" id="detailModal">
		    <div class="modal-dialog modal-dialog-centered modal-xl">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title text-center">주문내역 상세조회</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body">
		          <table id="modalTable">
		          	<thead>
		          		<tr>
		          			<th>상품정보</th>
		          			<th>주문번호</th>
		          			<th>주문금액(수량)</th>
		          			<th>교환&환불</th>
		          		</tr>
		          	</thead>
		          	<tbody id="orderHistory_DetailtBody"></tbody>
		          </table>
		        </div>
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
		        </div>
		        
		      </div>
		    </div>
		  </div>
		<div id="memberInfo2">
			<div id="sidebar">
				<div>
					<h3>나의 쇼핑 활동</h3>
					<a href="${ctp}/member/memberGoodsOrderList?sIdx=${sIdx}">주문 내역 조회</a><br>
					<a>구매후기</a><br>
					<a>래플 응모내역</a>
					<a>상품문의</a>
					<a>1:1문의</a>
					<a>최근 본 상품</a>
					<a>좋아요</a>
					<a>나의 맞춤 정보</a>
					<a>회원 혜택</a>
					<a>래플 응모내역</a>
					<a>래플 응모내역</a>
				</div>
				<div>
					<h3>커뮤니티</h3>
					<a>게시물/스크랩/댓글</a><br>
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
				<h2>주문 내역 조회</h2>
				<div>
					<a>입금/결제</a>
					<a>배송중/픽업대기</a>
					<a>배송완료/픽업완료</a>
					<a>구매확정</a>
					<a>교환</a>
					<a>교환완료</a>
					<a>환불</a>
					<a>환불완료</a>
				</div>
				<table id="listTable">
					<thead>
						<tr>
							<th>주문번호</th>
							<th>회원번호</th>
							<th>주문일자</th>
							<th>주문금액(수량)</th>
							<th>주문상태</th>
							<th>수령인 이름</th>
							<th>수령인 전화번호</th>
							<th>수령인 주소</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order" items="${vos}" varStatus="st">
							<tr>
								<td><button type="button" data-toggle="modal" data-target="#detailModal" onclick="getOrderHistory_DetailList(${order.idx})">${order.idx}</button></td>
								<td>${order.member_Idx}</td>
								<td>${fn:substring(order.orderDate,2,11)}</td>
								<td>₩<fmt:formatNumber value="${order.finalPrice}" pattern="#,###"/></td>
								<td>
									${order.status}
									<c:if test="${order.status eq '결제완료'}"><button type="button" data-toggle="modal" data-target="#deliveryModal" onclick="shippingNum(${order.idx})">운송장 작성</button></c:if>
								</td>
								<td>${order.recipient_Name}</td>
								<td>${order.recipient_TelNum}</td>
								<td>${order.recipient_Address}</td>
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