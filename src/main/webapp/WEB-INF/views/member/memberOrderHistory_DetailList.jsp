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
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function popUp(idx, goods_Idx, orderHistory_Idx){
		window.open("${ctp}/goods/inquiryPopUp?idx="+idx+"&goods_Idx="+goods_Idx+"&orderHistory_Idx="+orderHistory_Idx,"test","width=600, height=800,left=650px, top=200px");
	}
	
	function goodsConfirm(orderHistory_Detail_Idx){
		let goodsConfirm = confirm("상품을 수령하셨나요? 구매확정 후에는 교환, 환불이 불가능합니다.");
		
		if(goodsConfirm){
			$.ajax({
				type : "post",
				url : "${ctp}/member/goodsConfirmAJAX",
				data : {
					orderHistory_Detail_Idx : orderHistory_Detail_Idx
				},
				success : function(data){
					location.reload();
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
		
	}
	
	function getOrderHistory_DetailList(idx){
		$.ajax({
			type : "post",
			url : "${ctp}/admin/orderHistory_DetailListAJAX",
			data : {
				idx : idx
			},
			success : function(data){
				let str='';
				for(let i=0; i<data.length; i++){
					if(data[i] == null) break;
					str += '<tr>';
					str += '<td><div class="flex">';
					str += '<div style="margin-right:20px;"><img class="orderListImg" src="${ctp}/images/'+data[i].goods_ThumbNail+'"></div>';
					/* str += '<div>'+data[i].goods_Brand+'<br><strong>'+data[i].goods_Name+'</strong><br>'+data[i].goods_Option+'</div>'; */
					str += '<div><div class="row">'+data[i].goods_Brand+'</div>';
					str += '<div class="row">'+data[i].goods_Name+'</div>';
					str += '<div class="row">SIZE : '+data[i].goods_Option+'</div></div';
					str += '</div></td>';
					str += '<td>'+data[i].idx+'</td>';
					str += '<td>₩'+numberWithCommas(data[i].totalPrice)+'('+data[i].goods_Stock+'개)</td>';
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
		height:320px;
		padding:30px;
	}
	#memberInfo2{
		display:flex;
		margin:0 auto;
		width:100%;
	}
	#sidebar{
		margin-top:50px;
		margin-left:50px;
	}
	#mainDiv{
		padding:50px;
		width:100%;
	}
	.sidebar2{
		display:flex;
		flex-direction:column;
		padding-bottom:15px;
		width:150px;
	}
	.sidebar2 > a{
		display: flex; 
		margin-top: 2px;
		font-size: 16px; 
		line-height: 40px;
		color:rgb(110,110,110);

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
		padding: 80px 50px 50px 120px;
	}
	#headerLeftDiv{
		padding-left:50px;
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
	  width: 180px; /* 원의 지름을 설정 */
	  height: 180px; /* 원의 지름을 설정 */
	  border-radius: 50%; /* 정확한 원 모양을 생성 */
	  overflow: hidden; /* 이미지가 원 밖으로 넘치지 않도록 숨김 처리 */
	  float:left;
	  margin-right:50px;
	}
	img{
		width:100px;
	}
	.flex{
		display:flex;
		align-items:center;
		justify-content: flex-start;
	}
	.orderListImg{
		width:100px;
	}
	.font{
		font-size:10px;
		font-height:10px;
	}
	.blackBtn{
		width:100px;
		height:30px;
		border:none;
		background-color:black;
		color:white;
	}
	.whiteBtn{
		width:130px;
		height:30px;
		border:1px solid black;
		background-color:white;
		color:black;
	}
	.borderBtn{
		border-bottom:1px solid black;
	}
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div id="container">
		<div id="memberInfo">
			<div class="headerDiv" id="headerLeftDiv">
				<div><h3><strong>My Page</strong></h3></div>
				<div style="margin-left: 50px;">
					<div class="circle-container">
					
						<img alt="" class="round-image" src="${ctp}/images/${vo.FSname}">
					</div>
					<div class="flex"><h1><strong>${vo.name}</strong></h1><a>회원정보변경</a></div>
					<div class="flex" style="font-size: 25px;">LV.${vo.level}&nbsp;${strLevel}</div>
				</div>
			</div>
			<div class="headerDiv" id="headerRightDiv">
				<div>
					<img alt="" src="${ctp}/images/coin.png" style="width:50px;">
					<h4>적립금 ></h4>
					<h1><fmt:formatNumber value="${vo.point}" pattern="#,###"/></h1>
				</div>
				<div>
					<img alt="" src="${ctp}/images/coupon.png" style="width:70px;">
					<h4>쿠폰 ></h4>
					<h1>${vo.coupon_Count}</h1>
				</div>
				<div>
					<img alt="" src="${ctp}/images/review.png" style="width:50px;">
					<h4>후기작성 ></h4>
					<h1>${vo.review_Count}</h1>
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
				<div class="sidebar2">
					<h3>나의 쇼핑 활동</h3>
					<a href="${ctp}/member/orderHistory_Detail">주문내역 상세 조회</a>
					<a href="#">구매후기</a>
					<a href="#">래플 응모내역</a>
					<a href="#">상품문의</a>
					<a href="#">1:1문의</a>
					<a href="#">최근 본 상품</a>
					<a href="#">좋아요</a>
					<a href="#">나의 맞춤 정보</a>
					<a href="#">회원 혜택</a>
				</div>
			</div>
			<div id="mainDiv">
				<h2>주문내역 상세 조회</h2>
				<div>
					<a class="<c:if test="${pageVO.filter eq 'pay'}">borderBtn</c:if>" href="${ctp}/member/orderHistory_Detail?filter=pay">입금/결제</a>
					<a class="<c:if test="${pageVO.filter eq 'delivery'}">borderBtn</c:if>" href="${ctp}/member/orderHistory_Detail?filter=delivery">배송중/픽업대기</a>
					<a class="<c:if test="${pageVO.filter eq 'confirm'}">borderBtn</c:if>" href="${ctp}/member/orderHistory_Detail?filter=confirm">구매확정</a>
					<a class="<c:if test="${pageVO.filter eq 'exchange'}">borderBtn</c:if>" href="${ctp}/member/orderHistory_Detail?filter=exchange">교환</a>
					<a class="<c:if test="${pageVO.filter eq 'refund'}">borderBtn</c:if>" href="${ctp}/member/orderHistory_Detail?filter=refund">환불</a>
				</div>
				<table id="listTable">
					<thead>
						<tr>
							<th>상품정보</th>
							<th>주문일자</th>
							<th>주문상세번호(주문번호)</th>
							<th>주문금액(수량)</th>
							<th>주문상태</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty ohVos}"><tr><td colspan="6">주문 내역 없음</td></tr></c:if>
						<c:forEach var="order" items="${ohVos}" varStatus="st">
							<tr>
								<td>
									<div class="flex">
										<div style="margin-right:20px;">
											<img alt="" src="${ctp}/images/${order.goods_ThumbNail}">
										</div>
										<div id="dd">
											<div class="row">${order.goods_Brand}</div>
											<div class="row">${order.goods_Name}</div>
											<div class="row">SIZE : ${order.goods_Option}</div>
										</div>
									</div>
								</td>
								<td>${fn:substring(order.orderDate,2,11)}</td>
								<td>${order.idx}(${order.orderHistory_Idx})</td>
								<c:set var="totalPrice" value="${order.goods_Price * order.goods_Stock}" />
								<td>
									₩<fmt:formatNumber value="${totalPrice}" pattern="#,###"/>(${order.goods_Stock}개)
									<c:if test="${order.complainStatus ne null}">
										<div>
											(${order.complainStatus})
										</div>
									</c:if>
								</td>
								<td>
									<div>
										${order.status}<br>
										<c:if test="${order.review_Status eq '작성완료'}">(후기 ${order.review_Status})</c:if>
									</div>
									
									<c:if test="${order.status eq '배송중'}">
										<div>
											<a href="https://trace.cjlogistics.com/web/detail.jsp?slipno=${order.shipping_Num}" target='_blank'>배송조회</a>
										</div>
									</c:if>
									
								</td>
								<td>
									<c:if test="${order.status eq '배송중'}">
										<button onclick="goodsConfirm(${order.idx})" class="blackBtn">구매확정</button>
										<button onclick="popUp(${order.idx},${order.goods_Idx},${order.orderHistory_Idx})" class="whiteBtn">교환 및 환불 요청</button>
									</c:if>
									<c:if test="${order.status eq '구매확정' and order.review_Status ne '작성완료'}">
										<button type="button" onclick="location.href='${ctp}/member/review?orderHistory_Detail_Idx=${order.idx}'" class="blackBtn">후기 작성</button>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="text-center m-4">
		    <ul class="pagination justify-content-center pagination-sm">
		       <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/orderHistory_Detail?pageSize=${pageVO.pageSize}&pag=1&filter=${pageVO.filter}">첫페이지</a></li></c:if>
		       <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/orderHistory_Detail?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&filter=${pageVO.filter}">이전블록</a></li></c:if>
		       <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	               <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/member/orderHistory_Detail?pageSize=${pageVO.pageSize}&pag=${i}&filter=${pageVO.filter}">${i}</a></li></c:if>
		           <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/orderHistory_Detail?pageSize=${pageVO.pageSize}&pag=${i}&filter=${pageVO.filter}">${i}</a></li></c:if>
		       </c:forEach>
		       <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/orderHistory_Detail?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&filter=${pageVO.filter}">다음블록</a></li></c:if>
		       <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/orderHistory_Detail?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&filter=${pageVO.filter}">마지막페이지</a></li></c:if>
		    </ul>
	    </div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>