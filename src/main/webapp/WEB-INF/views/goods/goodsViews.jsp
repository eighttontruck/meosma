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
	function showPopup(){
		window.open("/product/inquiryPopUp","test","width=400, height=400,left=0, top=0");
	}
	
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
				/* str += '<div class="options" id="option'+idx+'">';
				str += '<div>'+optionSelect+'</div>';
				str += '<div id="div2"><span><input type="text" value="1" class="goodsCnt">';
				str += '<span id="span2"><button class="upgoods_cnt"></button>'
				str += '<button class="downgoods_cnt"></button></span></span></div>'
				str += '<div><button type="button" id="closebtn" onclick=delete('+idx+')><img src="${ctp}/images/closebtn.PNG"></img></button></div>';
				str += '<div></div>';
				str += '<div></div>';
				str += '</div><hr>'; */
				
				str += '<tbody id="goods_Option'+option_Idx+'">';
					str += '<tr>';
						str += '<td class="td">'+option_Name+'</td>';
						str += '<input type="hidden" name="order_ThumbNail" value="${goodsVo.thumbNail}">';
						str += '<input type="hidden" name="order_Name" value="${goodsVo.name}">';
						str += '<input type="hidden" name="order_Option" value="'+option_Name+'">';
						str += '<input type="checkbox" name="idxChecked" value="${goodsVo.idx}">';
						str += '<input type="hidden" name="order_Price" value="${goodsVo.price}">';
						str += '<input type="hidden" name="goods_Idx" value="${goodsVo.idx}">';
						str += '<input type="hidden" name="option_Idx" value="'+option_Idx+'">';
						str += '<td class="td"><span id="goods_qty">';
							str += '<input type="text" id="cntInput'+option_Idx+'" name="order_Stock" value="1" class="goodsCnt" readonly>';
							str += '<span class="stockCntBtn"><button type="button" onclick="stockCntUp('+option_Idx+','+goods_Stock+','+${goodsVo.price}+')" class="upgoods_cnt" id="upgoods_cnt2"></button>';
							str += '<button type="button" class="downgoods_cnt" onclick="stockCntDown('+option_Idx+','+${goodsVo.price}+')"></button></span>';
						str += '</span></td>';
						str += '<td class="td" id="optionPrice'+option_Idx+'" style="text-align:right;">₩'+goods_Price+'</td>';
						str += '<td style="text-align:center;"><button type="button" id="closebtn" onclick=delOption('+option_Idx+')><img src="${ctp}/images/closebtn.PNG"></img></button></td>';
					str += '</tr>';
				str += '</tbody>';
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
	#goodsImage > img{
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
	
	/* #dropdownMenu {
  
  position: absolute;
  background-color: #fff;
  padding: 10px;
  border: 1px solid #ccc;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
} */

/* #dropdownButton:hover + #dropdownMenu,
#dropdownMenu:hover {
  display: block;
} */

/* .submenu {
  display: none;
  position: absolute;
  top: 0;
  left: 100%;
  margin-top: -10px;
  padding: 10px;
  background-color: #fff;
  border: 1px solid #ccc;
} */

/* .dropdown-submenu:hover > .submenu {
  display: block;
} */
	
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="container">
		<div id="goodsImage">
			<img alt="" src="${ctp}/images/${goodsVo.thumbNail}" class="goodsimages">
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
						<input type="hidden" name="totalPrice" id="totalPriceInput">
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
								웍스아웃 (마이페이지 > 주문 내역 > 주문서 상세 페이지 조회 > 교환/환불 신청)
								(자세히 보기)
							</p>
						</div>
					</div>
					<div>
						<div id="dropdownButton4" class="explainDiv">A/S 안내</div>
						<div id="dropdownMenu4" class="hiddenExplainDiv">
							<p>
								(주)웍스아웃 및 정식 판매처를 통하여 구입한 모든 제품은 A/S를 받으실 수 있습니다.
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
								(자세히 보기)
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="productBrand">
		</div>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<div id="reviewDiv">
			<div>
				<div></div>
				<div></div>
				<div></div>
				<div></div>
				<div></div>
				<div></div>
			</div>
				<select name="score">
					<option>5</option>
					<option>4</option>
					<option>3</option>
					<option>2</option>
					<option>1</option>
				</select>
				<input type="text" id="content" name="content" placeholder="댓글을 작성해주세요.">
				<input type="text" id="Product_Idx" name="Product_Idx" value="${goodsVo.idx}">
				<input type="text" id="Member_Idx" name="Member_Idx" value="${sIdx}">
				<button>댓글 작성</button>
			
		</div>
		<div id="inquiryDiv">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>답변여부</th>
						<th>구분</th>
						<th>내용</th>
						<th>작성자</th>
						<th>등록일자</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>
							<div>문의작성자가 문의한 내용이 들어간다.</div>
							<p>머시깽이~</p>
						</td>
					</tr>
					<tr>
						<td>~~~앙 몰라~</td>
					</tr>
				</tbody>
			</table>
			
			<button type="button" class="btn btn-primary" onclick="showPopup()">작성하기</button>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>