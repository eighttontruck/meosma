 <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
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
	$(document).ready(function() {
	    // 이동하고자 하는 스크롤 위치를 지정합니다. (단위: 픽셀)
	    
	    if(${pageVO.pag}!=1){
	    	var targetScrollPosition = 1100;
	    	
		    // 스크롤 위치를 이동합니다.
		    $('html, body').animate({
		      scrollTop: targetScrollPosition
		    }, 100); // 1000은 애니메이션 속도를 밀리초(ms) 단위로 지정합니다.
	    }
  	});
	
	
	let option_IdxArray = new Array();
	$(function(){
		$("#optionSelect").change(function(){
			let optionSelect=$(this).val();
			let option_Idx = optionSelect.substring(0,optionSelect.indexOf(":"));
			let goods_Stock = optionSelect.substring(optionSelect.indexOf(":")+1,optionSelect.indexOf("_"));
			let option_Name = optionSelect.substring(optionSelect.indexOf("_")+1);
			let goods_Price = numberWithCommas(${goodsVo.price});
			if($("#goods_Option"+option_Idx).length == 0){
				let str='';
				option_IdxArray[option_Idx]=option_Idx;

				str += '<tbody id="goods_Option'+option_Idx+'">'
					str += '<tr>'
						str += '<td class="td">'+option_Name+'<input type="checkbox" name="idxChecked" value="${goodsVo.idx}" checked style="display:none;"/></td>'
						str += '<input type="hidden" name="order_ThumbNail" value="${goodsVo.thumbNail}">'
						str += '<input type="hidden" name="order_Name" value="${goodsVo.name}">'
						str += '<input type="hidden" name="order_Option" value="'+option_Name+'">'
						str += '<input type="hidden" name="order_Price" value="${goodsVo.price}">'
						str += '<input type="hidden" name="goods_Idx" value="${goodsVo.idx}">'
						str += '<input type="hidden" name="option_Idx" value="'+option_Idx+'">'
						str += '<td class="td"><span id="goods_qty">';
							str += '<input type="text" id="cntInput'+option_Idx+'" name="order_Stock" value="1" class="goodsCnt" readonly>'
							str += '<span class="stockCntBtn"><button type="button" onclick="stockCntUp('+option_Idx+','+goods_Stock+','+${goodsVo.price}+')" class="upgoods_cnt" id="upgoods_cnt2"></button>'
							str += '<button type="button" class="downgoods_cnt" onclick="stockCntDown('+option_Idx+','+${goodsVo.price}+')"></button></span>'
						str += '</span></td>';
						str += '<td class="td" id="optionPrice'+option_Idx+'" style="text-align:right;">₩'+goods_Price+'</td>'
						str += '<td style="text-align:center;"><button type="button" id="closebtn" onclick=delOption('+option_Idx+')><img src="${ctp}/images/closebtn.PNG"></img></button></td>'
					str += '</tr>'
				str += '</tbody>'
				$("#selectedOption").append(str);
				onTotal();
				
			} else{
				alert("이미 선택된 옵션 입니다.");
			}
		
		});		
	});
	function onTotal(){
		let totalPrice = 0;
		option_IdxArray.forEach(function(number){
			//alert(number);
			if(number!=0){
				let stock = $("#cntInput"+number).val();
				totalPrice+=${goodsVo.price}*stock;
			}
		});
		$("#totalPrice").html("₩"+numberWithCommas(totalPrice));
		$("#totalPriceInput").val(totalPrice);
	}
	
	
	function stockCntUp(option_Idx,goods_Stock,goods_Price){
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
	
	function delOption(option_Idx){
		//option_IdxArray.splice(option_Idx,1);
		option_IdxArray[option_Idx]=0;
		$("#goods_Option"+option_Idx).remove();
		onTotal();
	}
	
	function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
	
	function optionCheck(){
		myform.submit();
	}
	
	$(document).ready(function() {
		$("#dropdownMenu1").slideToggle(200);
		
		$("#dropdownButton1").click(function() {
		  $("#dropdownMenu1").slideToggle(200);
		});
		$("#dropdownButton2").click(function() {
		  $("#dropdownMenu2").slideToggle(200);
		});
		$("#dropdownButton3").click(function() {
		  $("#dropdownMenu3").slideToggle(200);
		});
		$("#dropdownButton4").click(function() {
		  $("#dropdownMenu4").slideToggle(200);
		});
		$("#dropdownButton5").click(function() {
		  $("#dropdownMenu5").slideToggle(200);
		});
		
		$(document).on('click', '.review-contents', function() {
            if ($(this).hasClass('review-contents--active')) {
            	$(this).removeClass('review-contents--active');
            } else {
                // 클릭한 div에 'review-contents--active' 클래스를 추가합니다.
                $(this).addClass('review-contents--active');
            }
        });
	});
	
	function insertCart() {
	  let goods_Idx = $('input[name="goods_Idx"]').map(function() {return this.value;}).get();
	  let option_Idx = $('input[name="option_Idx"]').map(function() {return this.value;}).get();
	  let stock = $('input[name="order_Stock"]').map(function() {return this.value;}).get();
	  let member_Idx = $("#sIdx").val();
	  
	  alert(goods_Idx);
	  $.ajax({
	    type: "POST",
	    url: "${ctp}/goods/insertCartAJAX",
	    data: { 
	    	goods_Idx: goods_Idx,
	    	option_Idx : option_Idx,
	    	stock : stock,
	    	member_Idx : member_Idx
	    	},
	    success: function(response) {
	      alert("장바구니 추가 완료");
	    },
	    error: function(error) {
	      alert("장바구니 추가 실패");
	    }
	  });
	}
	
</script>
<style>
	table{
		width:400px;
		margin:10px auto;
	}
	tr{
		height:45px;
	}
	.td{
		width:30%;
	}
	.flex{
		display:flex;
		align-items:center;
		justify-content: space-between;
	}
	.flex2{
		display:flex;
	}
	#goods_qty{
		vertical-align:middle;
	}
	.item-detail_list dt{
		width:300px;
	}
	#priceDiv{
		display:flex;
		justify-content: space-between;
	}
	#closebtn{
		width:13px;
		border:none;
		background:none;
	}
	#closebtn > img {
		width:20px;
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
	#span2{
		height:100px;
		float:left;
	}
	.container{
		display:flex;
		flex-wrap:wrap;
	}
	.options{
		display:flex;
		
	}
	#optionSelect{
		width:400px;
		height:50px;
		padding:10px;
		border-style:solid;
		border-width:1px;
		border-color:lightgray;
	}
	#optionSelect:focus{
		outline:none;
		border-color:black;
	}
	#goodsImage{
		width:600px;
	}
	#goodsImage img{
		width:600px;
	}
	#goodsDetail{
		width:480px;
		padding:40px;
	}
	#sizeSelect{
		width:400px;
		height:50px;
		padding:10px;
	}
	#buyBtn{
		width:400px;
		height:50px;
		background-color:black;
		color:white;
		border:none;
	}
	
	hr{
		border-color:black;
		width:400px;
		margin:0;
	}
	.item-detail_list{
		margin: 5px auto;
	}
	.item-detail_list dt{
		display: inline-block;
		width:130px;
	}
	.item-detail_list dd{
		display: inline-block;
	}
	
	.explainDiv{
		width:400px;
		height: 50px;
		text-align:center;
		line-height:50px;
		cursor:pointer;
	}
	.hiddenExplainDiv{
		display: none;
		width:400px;
		height:auto;
		border:solid;
		border-width:1px 0px 0px 0px;
		
		line-height:50px;
	}
	.hiddenExplainDiv > p{
		display: inline-block;
		line-height:20px;
		font-size:12px;
		padding:10px 10px;
	}
	.halfBtn{
		width:50%;
		height:50px;
		margin-top:20px;
		margin-bottom:20px;
		border:none;
	}
	#reviewDiv{
		border:1px solid lightgray;
		width:1000px;
		padding:20px;
		margin:0 auto;
	}
	#reviewDetailDiv{
		border:1px solid lightgray;
		width:960px;
		margin:0 auto;
		padding-top: 20px;
	}
	.review-profile__date {
	    margin-left: auto;
	    padding-top: 2px;
	    font-size: 12px;
	    color: #aaa;
	}
	.review-profile__text-wrap {
	    box-sizing: border-box;
	    width: calc(100% - 32px);
	    padding-left: 8px
	}
	.review-profile {
	    display: flex;
	    padding: 0 15px 10px 13px;
	    font-size: 14px;
	    font-family: "Apple SD Gothic Neo","Noto Sans KR",sans-serif;
	    line-height: 1.5;
	    align-items: center
	}
	p{
		margin:0;
	}
	.review-profile__image {
	    position: absolute;
	    top: 50%;
	    left: 0;
	    width: 100%;
	    transform: translateY(-50%)
	}
	.review-profile__link {
    display: block;
    overflow: hidden;
    position: relative;
    width: 32px;
    height: 32px;
    margin-top: 2px;
    border-radius: 100%
}
.review-goods-information {
    display: flex;
    max-height: 54px;
    padding: 0 15px 16px 53px;
    align-items: center
}
.review-goods-information__item {
    width: calc(100% - 51px);
    margin-left: 10px;
    padding-top: 1px;
    font-size: 12px
}
.review-goods-information__image {
    position: absolute;
    top: 50%;
    left: 50%;
    height: 100%;
    transform: translate(-50%,-50%);
    -o-object-fit: contain;
    object-fit: contain
}
.review-goods-information__link {
    display: block;
    height: 100%;
}
.review-goods-information__thumbnail {
    overflow: hidden;
    position: relative;
    width: 45px;
    height: 54px;
    border-radius: 4px
}
		.star {
			    position: relative;
			    font-size: 2rem;
			    color: #ddd;
			    margin-left:60px;
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
	  .review-content-photo {
    margin: 16px 0 0;
    padding-left: 53px
}

.review-list--mypage .review-content-photo {
    padding-left: 21px
}

.review-content-photo__wrap {
    position: relative;
    padding: 144px 15px 0 0
}

.review-contents--active .review-content-photo__wrap {
    padding-top: 0
}

.review-list--mypage .review-contents--active .review-content-photo__wrap {
    padding-right: 21px
}

.review-content-photo__list {
    display: flex;
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0
}

.review-contents--active .review-content-photo__list {
    display: block;
    overflow: initial;
    position: static;
    height: auto
}

.review-content-photo__item {
    overflow: hidden;
    position: relative;
    width: 144px;
    height: 144px;
    border-radius: 4px;
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    align-items: center;
    justify-content: center
}

.review-content-photo__item+.review-content-photo__item {
    margin-left: 5px
}

.review-content-photo__item>img {
    display: none
}

.review-contents--active .review-content-photo__item>img {
    display: block;
    width: 100%
}

.review-content-photo__item.review-content-photo--more {
    display: flex
}

.review-contents--active .review-content-photo__item {
    display: block;
    width: 307px;
    height: auto;
    background-image: none!important
}

.review-contents--active .review-content-photo__item+.review-content-photo__item {
    margin: 10px 0 0 0
}

.review-content-photo__dim {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background-color: rgba(0,0,0,.3)
}

.review-contents--active .review-content-photo__dim {
    display: none
}

.review-content-photo__count {
    position: relative;
    z-index: 1;
    font-size: 28px;
    color: #fff
}

.review-contents--active .review-content-photo__count {
    display: none
}
.review-contents__text {
    overflow: hidden;
    position: relative;
    max-height: 93px;
    padding: 0 15px 0 53px;
    font-size: 15px;
    -webkit-text-size-adjust: none;
    line-height: 23px;
    word-break: break-all;
    -moz-text-size-adjust: none;
    text-size-adjust: none;
}
.review-content-photo {
    margin: 16px 0 0;
}


.review-content-photo__wrap {
    position: relative;
    padding: 144px 15px 0 0
}

.review-content-photo__list {
    display: flex;
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0
}

.review-content-photo__item {
    overflow: hidden;
    position: relative;
    width: 144px;
    height: 144px;
    border-radius: 4px;
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    align-items: center;
    justify-content: center
}

.review-content-photo__item+.review-content-photo__item {
    margin-left: 5px
}

.review-content-photo__item>img {
    display: none
}

.review-contents--active .review-content-photo__item>img {
    display: block;
    width: 100%
}

.review-content-photo__item.review-content-photo--more {
    display: flex
}

.review-contents--active .review-content-photo__item {
    display: block;
    width: 307px;
    height: auto;
    background-image: none!important
}

.review-contents--active .review-content-photo__item+.review-content-photo__item {
    margin: 10px 0 0 0
}

.review-content-photo__dim {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background-color: rgba(0,0,0,.3)
}

.review-contents--active .review-content-photo__dim {
    display: none
}

.review-content-photo__count {
    position: relative;
    z-index: 1;
    font-size: 28px;
    color: #fff
}

.review-contents--active .review-content-photo__count {
    display: none
}

.reviewDetailDiv{
	padding-bottom: 30px;
    margin-bottom: 30px;
    border-bottom: 1px solid lightgray;
}
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div>
	<div class="container">
		<div id="goodsImage">
			<div id="demo" class="carousel slide" data-ride="carousel">
			  <!-- Indicators -->
			  <ul class="carousel-indicators">
			    <li data-target="#demo" data-slide-to="0" class="active"></li>
			    <c:forEach var="image" items="${imageVos}" varStatus="st">
			    	<li data-target="#demo" data-slide-to="${st.count}"></li>
			    </c:forEach>
			  </ul>
			  <!-- The slideshow -->
			  <div class="carousel-inner">
			    <div class="carousel-item active">
			      <img src="${ctp}/images/${goodsVo.thumbNail}" alt="Los Angeles">
			    </div>
			    <c:forEach var="image" items="${imageVos}" varStatus="st">
				    <div class="carousel-item">
				      <img src="${ctp}/data/ckeditor/${image.FName}" alt="Chicago">
				    </div>
			    </c:forEach>
			  </div>
			  <!-- Left and right controls -->
			  <a class="carousel-control-prev" href="#demo" data-slide="prev">
			    <span class="carousel-control-prev-icon"></span>
			  </a>
			  <a class="carousel-control-next" href="#demo" data-slide="next">
			    <span class="carousel-control-next-icon"></span>
			  </a>
			</div>
			<%-- <img alt="" src="${ctp}/images/${goodsVo.thumbNail}" class="goodsimages"> --%>
		</div>
		<div id="goodsDetail">
			<div>
				<h3><a href="#">${goodsVo.brand_Name}</a></h3>
				<h1>${goodsVo.name}</h1>
			</div>
			<div class="item-detail_list">
				<dl>
					<dt>CATEGORY.</dt>
					<dt style="width:200px;"><a href="#">${categoryVo.category_Name}</a> > <a href="#">${categoryVo.subCategory_Name}</a> > <a href="#">${categoryVo.secondCategory_Name}</a></dt>
				</dl>
				<dl>
					<dt>PRICE.</dt>
					<dt>₩<fmt:formatNumber value="${goodsVo.price}" pattern="#,###"/></dt>
				</dl>
			</div>
			<div>
				<p>SIZE</p>
				<select id="optionSelect">
					<option disabled hidden selected>사이즈 선택</option>
					<c:forEach var="stock" items="${stockVos}" varStatus="st">
						<c:if test="${stock.stock == 0}">
							<option disabled >${stock.goods_Option}(품절)</option>
						</c:if>
						<c:if test="${stock.stock != 0}">
							<option value="${stock.option_Idx}:${stock.stock}_${stock.goods_Option}">${stock.goods_Option}</option>
						</c:if>
					</c:forEach>
				</select>
				<div>
					<form name="myform" method="POST" action=${ctp}/goods/goodsPayment>
						<table id="selectedOption"></table>
						<input type="hidden" id="sIdx" name="sIdx" value="${sIdx}">
						<input type="hidden" name="finalPrice" id="totalPriceInput">
						<input type="hidden" name="buyStatus" value="direct">
					</form>
					<hr>
				</div>
				<div id="priceDiv">
					<h4>총 합계금액</h4>
					<h4 id="totalPrice"></h4>
				</div>
				<div>
					<c:if test="${empty sIdx}"><button id="buyBtn" disabled>로그인 후 구매 가능합니다.</button></c:if>
					<c:if test="${!empty sIdx}">
						<button id="buyBtn" onclick="optionCheck()">BUY</button>
					<div class="flex">
						<button class="halfBtn" onclick="insertCart()">CART</button>
						<button class="halfBtn">LIKE</button>
					</div>						
					</c:if>
				</div>
				<c:forEach var="stock" items="${stockVos}" varStatus="st">
					<input type="hidden" id="${stock.goods_Option}" value="${stock.stock}">
				</c:forEach>
			</div>
			<div>
				<div>
					<div>
						<div id="dropdownButton1" class="explainDiv">상세정보</div>
						<div id="dropdownMenu1" class="hiddenExplainDiv">
							<p>
								${brandVo.content}
							</p>
						</div>
					</div>
					<div>
						<div id="dropdownButton2" class="explainDiv">배송 안내</div>
						<div id="dropdownMenu2" class="hiddenExplainDiv">
							<p>
								CJ대한통운 (1588-1255)
								배송 지역 : 전국 (일부 지역 제외)
								배송비 : 10만원 이상 구매 시 무료 배송
								배송 기간 : 평일 오후 2시 이전 결제 완료 된 주문건은 당일 출고되며 배송은 1~3일 정도 소요됩니다.
								(자세히 보기)
							</p>
						</div>
					</div>
					<div>
						<div id="dropdownButton3" class="explainDiv">반품 안내</div>
						<div id="dropdownMenu3" class="hiddenExplainDiv">
							<p>
								반품 신청은 상품 수령 후 7일 이내 신청하시면 기사님께서 빠른 시일 내에 수거하실 예정입니다.
								단순 변심으로 인한 교환/반품 신청 시 택배비용은 고객님 부담이오니 이점 양해 바랍니다.
								머스마 (마이페이지 > 주문 내역 > 주문서 상세 페이지 조회 > 교환/환불 신청)
								(자세히 보기)
							</p>
						</div>
					</div>
					<div>
						<div id="dropdownButton4" class="explainDiv">A/S 안내</div>
						<div id="dropdownMenu4" class="hiddenExplainDiv">
							<p>
								(주)머스마 및 정식 판매처를 통하여 구입한 모든 제품은 A/S를 받으실 수 있습니다.
								(자세히 보기)
							</p>
						</div>
					</div>
					<div>
						<div id="dropdownButton5" class="explainDiv">세탁 및 취급 시 주의사항</div>
						<div id="dropdownMenu5" class="hiddenExplainDiv">
							<p>
								제품 혼용율에 따라 세탁 및 취급 유의 사항이 변경될 수 있습니다.
								반드시 부착되어 있는 케어라벨 내용을 확인하신 후 세탁하시기 바랍니다.
								따라서 세탁시에는 반드시 세탁 및 취급 시 주의사항 페이지를 참고 부탁 드립니다.
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="productBrand">
	</div>
	<div id="reviewDiv">
		<c:if test="${!empty reviewVos}">
		<h3 class="mb-4">구매후기(${reviewVos[0].review_Cnt})</h3>
		<div id="reviewDetailDiv">
			<c:forEach var="review" items="${reviewVos}" varStatus="st">
				<div class="reviewDetailDiv">
					<div class="review-profile">
						<a class="review-profile__link"><img src="//image.msscdn.net/mfile_s01/_simbols/_basic/b.png" alt="프로필 이미지" class="review-profile__image"></a>
						<div class="review-profile__text-wrap">
							<div class="flex2">
								<p>LV.${sLevel} ${review.member_Name}</p>
								<p class="review-profile__date">${review.WDate}</p>
							</div>
							<div>
								<div>남자 164cm ~~ dd</div>
							</div>
						</div>
					</div>
					<div class="review-goods-information">
						<div class="review-goods-information__thumbnail">
		                    <a href="https://www.musinsa.com/app/goods/2991552/0" class="review-goods-information__link">
		                        <img src="//image.msscdn.net/images/goods_img/20221221/2991552/2991552_16741013612256_100.jpg" class="review-goods-information__image">
		                    </a>
		                </div>
						<div class="review-goods-information__item">
							<div>${review.brand_Name}</div>
							<div>${review.goods_Name}</div>
							<div>${review.option_Name}</div>
						</div>
					</div>
					<div>
						<span class="star">★★★★★<span>★★★★★</span>
							<input type="range" oninput="drawStar(this)" value="1*2" step="1" min="0" max="10"  onload="drawStar(this)">
						</span>
						<script>
							const drawStar = (target) => {
							  const starSpan = document.querySelector('.star span');
							  starSpan.style.width = target.value * 10 + '%';
							}
						</script>
					</div>
					<div class="review-contents" review_type="goods_estimate" data-review-no="46057695" data-goods-no="2991552">
		                <div class="review-contents__text">${review.content}</div>
		                <div class="review-content-photo">
		                    <div class="review-content-photo__wrap">
		                        <ul class="review-content-photo__list" style="padding-left: 0px;">
		                            <li class="review-content-photo__item" data-img-index="0" style="background-image:url('${ctp}/images/${review.FSname}');">
		                                <img src="${ctp}/images/${review.FSname}">
		                            </li>
		                        </ul>
		                    </div>
		                </div>
		            </div>
		        </div>
	        </c:forEach>
	        <div class="text-center m-4">
			    <ul class="pagination justify-content-center pagination-sm">
			       <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/goods/goodsViews?pageSize=${pageVO.pageSize}&pag=1&idx=${goodsVo.idx}">첫페이지</a></li></c:if>
			       <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/goods/goodsViews?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&idx=${goodsVo.idx}">이전블록</a></li></c:if>
			       <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
		               <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/goods/goodsViews?pageSize=${pageVO.pageSize}&pag=${i}&idx=${goodsVo.idx}">${i}</a></li></c:if>
			           <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/goods/goodsViews?pageSize=${pageVO.pageSize}&pag=${i}&idx=${goodsVo.idx}">${i}</a></li></c:if>
			       </c:forEach>
			       <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/goods/goodsViews?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&idx=${goodsVo.idx}">다음블록</a></li></c:if>
			       <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/goods/goodsViews?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&idx=${goodsVo.idx}">마지막페이지</a></li></c:if>
			    </ul>
		    </div>
	    </div>
    </c:if>
    </div>
    </div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>