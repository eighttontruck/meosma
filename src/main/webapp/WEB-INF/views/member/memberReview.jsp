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
	function fCheck(){
		myform.submit();
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
	.flex2{
		display:flex;
		justify-content: space-between;
	}
	.orderListImg{
		width:100px;
	}
	.font{
		font-size:10px;
		font-height:10px;
	}
	#sidebar{
		margin-top:50px;
		margin-left:50px;
	}
	 .star {
	    position: relative;
	    font-size: 2rem;
	    color: #ddd;
	  }
	  .star span{
	    width: 0;
	    position: absolute; 
	    left: 0;
	    color: rgb(255,146,58);
	    overflow: hidden;
	    pointer-events: none;
	  }
	  .star input {
	    width: 100%;
	    height: 100%;
	    position: absolute;
	    left: 0;
	    opacity: 0;
	    cursor: pointer;
	  }
	  img{
	  	 width:100px;
	  }
	  #textInput{
	  	width:100%;
	  	height:100px;
	  	outline:none;
	  	border:1px solid lightgray;
	  	padding:10px;
	  }
	  #textInput:focus{
	  	border:1px solid black;
	  }
	  .blackBtn{
		width:100px;
		height:30px;
		border:none;
		background-color:black;
		color:white;
		margin:0 auto;
	}
	.labelText{
		margin:10px;
		font-weight:600;
		font-size:1.2rem;
	}
	input[type=file]::file-selector-button {
	  width: 150px;
	  height: 30px;
	  background: #fff;
	  border: 1px solid rgb(77,77,77);
	  border-radius: 10px;
	  cursor: pointer;
	  &:hover {
	    background-color: rgb(77,77,77);
	    color: #fff;
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
					<%-- <div class="flex"><h1><strong>${vo.name}</strong></h1><a>회원정보변경</a></div>
					<div class="flex">LV.${vo.level}</div> --%>
				</div>
			</div>
			<div class="headerDiv" id="headerRightDiv">
			<%-- 	<div>
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
					<h1><strong>2</strong></h1> --%>
				</div>
			</div>
		</div>
		<div id="memberInfo2">
			<div id="sidebar">
				<div class="sidebar2">
					<h3>나의 쇼핑 활동</h3>
					<a href="${ctp}/member/orderHistory_Detail">주문 내역 조회</a>
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
				<h2>구매후기</h2>
				<hr>
				<ul>
					<li>작성하신 후기는 머스마 및 머스마 글로벌 이용자에게 공개됩니다. 댓글은 머스마에서 확인하지 않습니다.</li>
					<li>일반 후기 작성 시 500원의 적립금을 평일 기준 2일 전후로 지급됩니다.</li>
					<li>후기 내용은 20자 이상 작성합니다. 상품과 관련 없는 내용, 단순 문자 및 기호의 나열/반복 확인 시 적립금 회수 및 지급 혜택이 제한됩니다.</li>
					<li>아래에 해당할 경우 적립금 지급이 보류되며, 이미 지급받으셨더라도 2차 검수를 통해 적립금을 회수할 수 있습니다 ,또한 일부 후기는 조건에 따라 비노출 처리 됩니다.</li>
					<li>문자 및 기호의 단순 나열, 반복된 내용의 후기, 주문하신 상품과 관련 없는 내용의 후기, 개인정보 및 광고, 비속어가 포함된 내용의 후기</li>
					<li>원활한 서비스 이용을 위해 후기 도용 시 적립금 2배 회수, 3개월간 후기 적립금 지급이 중단되며, 일부 머스마 서비스 이용에 제한이 발생될 수 있습니다.</li>
					<li>신체정보(성별, 키, 몸무게)는 수집ㆍ이용 동의 시 후기 서비스 제공 목적으로만 이용되며, 머스마 개인정보 처리방침에 따라 처리됩니다.</li>
				</ul>
				<hr>
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
				<hr>
				<form name="myform" method="post" enctype="multipart/form-data">
					<div class="flex2" style="width:280px;">
						<p style="line-height:45px;">별점을 매겨주세요.</p>
						<span class="star">★★★★★<span>★★★★★</span>
	  						<input type="range" oninput="drawStar(this)" name="score" value="1*2" step="1" min="0" max="10"  onload="drawStar(this)">
						</span>
						<script>
							const drawStar = (target) => {
							  const starSpan = document.querySelector('.star span');
							  starSpan.style.width = target.value * 10 + '%';
							}
						</script>
					</div>
					<div class="labelText">상품사진</div>
					<div><input type="file" name="file" id="file"></div>
					
					<div class="labelText">상품후기</div>
					<div><textarea rows="6" name="content" id="textInput" placeholder="후기를 작성해주세요."></textarea></div>
					<input type="hidden" name="goods_Idx" value="${vo.goods_Idx}">
					<input type="hidden" name="orderHistory_Detail_Idx" value="${orderHistory_Detail_Idx}">
				</form>
				<button type="button" onclick="fCheck()" class="blackBtn">등록</button>
			</div>
		</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>