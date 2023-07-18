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
	function fCheck(){
		
		alert(fName);
		/* myform.submit(); */
	}
	
	function deleteOption(id) {
	  $('#' + id).empty();
	}
	
	$(document).ready(function() {
		
		let mainCategory=$("#mainCategory").val();
		let subCategory_Name= "${categoryVo.subCategory_Name}";
		$.ajax({
			type : "post",
			url : "${ctp}/goods/subCategoryList",
			data : {mainCategory : mainCategory},
			success:function(res){
				let str='';
				str += '<option disabled hidden selected value="">중분류 선택</option>';
				for (let i = 0; i < res.length; i++) {
				    if (res[i] == null) break;
				    str += '<option ';
				    if (subCategory_Name == String(res[i].subCategory_Name)) {
				    	str += 'selected';
				    }
				    str += ' value="' + res[i].subCategory_Idx + '">' + res[i].subCategory_Name + '</option>';
				}
				$("#subCategory").html(str);
				
				let subCategory=$("#subCategory").val();
				let secondCategory_Name= "${categoryVo.secondCategory_Name}";
				$.ajax({
					type : "post",
					url : "${ctp}/goods/secondCategoryList",
					data : {subCategory : subCategory},
					success:function(res){
						let str='';
						str += '<option disabled hidden selected value="">소분류 선택</option>';
						for (let i = 0; i < res.length; i++) {
						    if (res[i] == null) break;
						    str += '<option ';
						    if (secondCategory_Name == String(res[i].secondCategory_Name)) {
						    	str += 'selected';
						    }
						    str += ' value="' + res[i].secondCategory_Idx + '">' + res[i].secondCategory_Name + '</option>';
						}
						$("#secondCategory").html(str);
					},
					error:function() {
						alert("전송오류!");
					}
				});
			},
			error:function() {
				alert("전송오류!");
			}
		});
		
		/* let subCategory=$("#subCategory").val();
		alert(subCategory);
		let secondCategory_Name= "${categoryVo.secondCategory_Name}";
		alert(secondCategory_Name);
		$.ajax({
			type : "post",
			url : "${ctp}/goods/secondCategoryList",
			data : {subCategory : subCategory},
			success:function(res){
				let str='';
				str += '<option disabled hidden selected value="">소분류 선택</option>';
				for (let i = 0; i < res.length; i++) {
				    if (res[i] == null) break;
				    str += '<option ';
				    if (secondCategory_Name == String(res[i].secondCategory_Name)) {
				    	str += 'selected';
				    }
				    str += ' value="' + res[i].secondCategory_Idx + '">' + res[i].secondCategory_Name + '</option>';
				}
				$("#secondCategory").html(str);
			},
			error:function() {
				alert("전송오류!");
			}
		}); */
	});
	
	$(function(){
		$("#mainCategory").change(function(){
			let mainCategory=$(this).val();
			if(mainCategory == ""){
				alert("중분류를 선택하세요.");
				return false;
			}
			alert(mainCategory);
			 
			$.ajax({
				type : "post",
				url : "${ctp}/goods/subCategoryList",
				data : {mainCategory : mainCategory},
				success:function(res){
					let str='';
					str += '<option disabled hidden selected value="">중분류 선택</option>';
					for(let i=0; i<res.length; i++) {
						if(res[i] == null) break;
						str += '<option value='+res[i].subCategory_Idx+'>'+res[i].subCategory_Name+'</option>';
						
					}
					$("#subCategory").html(str);
				},
				error:function() {
					alert("전송오류!");
				}
			});
		});
		
		
		$("#subCategory").change(function(){
			let subCategory=$(this).val();
			if(subCategory == ""){
				alert("소분류를 선택하세요.");
				return false;
			}
			 
			$.ajax({
				type : "post",
				url : "${ctp}/goods/secondCategoryList",
				data : {subCategory : subCategory},
				success:function(res){
					let str='';
					str += '<option disabled hidden selected value="">소분류 선택</option>';
					for(let i=0; i<res.length; i++) {
						if(res[i] == null) break;
						str += '<option value='+res[i].secondCategory_Idx+'>'+res[i].secondCategory_Name+'</option>';
					}
					$("#secondCategory").html(str);
				},
				error:function() {
					alert("전송오류!");
				}
			});
		});
		
		$("#optionType").change(function(){
			let optionType=$(this).val();
			if(optionType == ""){
				alert("소분류를 선택하세요.");
				return false;
			}
			$("#sizeOption").empty();
			
			let str='';
			if(optionType=="상의"){
				str+='<div class="row" id="top1">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="XS" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("top1")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="top2">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="S" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("top2")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="top3">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="M" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("top3")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="top4">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="L" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("top4")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="top5">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="XL" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("top5")>삭제</button></div>';
				str+='</div>';
			} else if(optionType=="하의"){
				str+='<div class="row" id="bottom1">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="26" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("bottom1")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="bottom2">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="28" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("bottom2")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="bottom3">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="30" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("bottom3")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="bottom4">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="32" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("bottom4")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="bottom5">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="34" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("bottom5")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="bottom6">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="36" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("bottom6")>삭제</button></div>';
				str+='</div>';
			} else if(optionType=="신발"){
				str+='<div class="row" id="shoe1">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="220" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("shoe1")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="shoe2">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="230" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("shoe2")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="shoe3">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="240" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("shoe3")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="shoe4">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="250" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("shoe4")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="shoe5">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="260" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("shoe5")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="shoe6">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="270" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("shoe6")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="shoe7">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="280" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("shoe7")>삭제</button></div>';
				str+='</div>';
				
				str+='<div class="row" id="shoe8">';
				str+='<div class="col">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="290" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("shoe8")>삭제</button></div>';
				str+='</div>';
			} else if(optionType=="기타"){
				str+='<div class="row" id="free">';
				str+='<div class="col ">사이즈</div>';
				str+='<div class="col"><input type="text" name="goodsSize" class="optionInput" value="FREE" readonly></div>';
				str+='<div class="col">수량</div>';
				str+='<div class="col"><input type="number" name="goodsStock" class="stockInput" min=1 max=100></div>';
				str+='<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("free")>삭제</button></div>';
				str+='</div>';
			}
			$("#sizeOption").append(str);
		});
	});
</script>
<style>
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
		width: 90%;
		margin:10px;
		font-size:1.1rem;
	}
	.inputText:focus{
		outline:none;
		border-bottom: 1.9px solid black;
	}
	.labelText{
		margin:10px;
		font-weight:600;
		font-size:1.2rem;
	}
	.inputTextArea{
		border:none;
		border-bottom: 1.9px solid lightgray;
		width:90%;
		margin:10px;
		font-size:1.1rem;
		height:200px;
	}
	.inputTextArea:focus{
		outline:none;
		border-bottom: 1.9px solid black;
	}
	#registerBtn{
		width:500px;
		height:50px;
		background-color:black;
		color:white;
		border:none;
	}
	#btnDiv{
		margin:0 auto;
		width:500px;
		margin-top:30px;
	}
	.optionInput{
		border:none;
		border-bottom: 1.9px solid lightgray;
		width:70px;
		margin:10px;
		font-size:1.1rem;
		text-align:center;
	}
	.optionInput:focus{
		outline:none;
		border-bottom: 1.9px solid black;
	}
	.stockInput{
		border:none;
		border-bottom: 1.9px solid lightgray;
		width:70px;
		margin:10px;
		font-size:1.1rem;
		text-align:center;
	}
	.stockInput:focus{
		outline:none;
		border-bottom: 1.9px solid black;
	}
	#sizeOption .col:nth-child(odd):not(:nth-child(5)) {
  		/* 홀수 번째 자식에 대한 스타일을 적용 */
  		text-align: center;
  		line-height:50px;
	}
	body > div{
		width:700px;
		margin:0 auto;
		margin-top:100px;
	}
	.optionDelBtn{
		width:50px;
		height:30px;
		background-color:white;
		color:black;
		border:solid 1px;
		margin:10px;
	}
	img{
		width:100px;
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
}
</style>
<body>
	<div>
		<form name="myform" method="post" enctype="multipart/form-data">
			<div id="memberInfo" class="flexDiv">
				<div class="bigText"><h1><strong>상품 수정</strong></h1></div>
				<div class="col">
					<div class="labelText">상품사진</div>
					<div><img src="${ctp}/images/${goodsVo.thumbNail}"></div>
					<div><input type="file" name="file" id="file" class="form-control-file"></div>
				</div>
				<div class="col">
					<div class="labelText">브랜드 선택</div>
					<div>
						<select name="brand_Idx" class="inputText">
							<option disabled hidden selected value="" name="brand_idx">브랜드 선택</option>
							<c:forEach var="brand" items="${brandVos}" varStatus="st">
								<option <c:if test="${goodsVo.brand_Idx eq brand.idx}">selected</c:if> value="${brand.idx}">${brand.name}</option>
							</c:forEach>
						</select>
						
					</div>
				</div>
				<div class="col">
					<div class="labelText">제품명</div>
					<div><input type="text" name="name" id="name" value="${goodsVo.name}" class="inputText"></div>
				</div>
				<div class="col">
					<div class="labelText">제품가격</div>
					<div><input type="text" name="price" id="price" value="${goodsVo.price}" class="inputText"></div>
				</div>
				<div class="col">
					<div class="labelText">대분류 선택</div>
					<div>
						<select id="mainCategory" name="mainCategory" class="inputText">
						<option disabled hidden selected value="">대분류 선택</option>
						<c:forEach var="vo" items="${mainCategory_vos}" varStatus="st">
							<option <c:if test="${categoryVo.category_Name eq vo.category_Name}">selected</c:if> value="${vo.category_Idx}">${vo.category_Name}</option>
						</c:forEach>
					</select>
					</div>
				</div>
				<div class="col">
					<div class="labelText">중분류 선택${categoryVo.subCategory_Name}</div>
					<div><select id="subCategory" name="subCategory" class="inputText"></select></div>
				</div>
				<div class="col">
					<div class="labelText">소분류 선택</div>
					<div><select id="secondCategory" name="secondCatagory_Idx" class="inputText"></select></div>
				</div>
				<div class="col">
					<div class="labelText">옵션 선택</div>
					<div>
						<select id="optionType" class="inputText">
						<option disabled hidden selected value="">종류 선택</option>
						<option>상의</option>
						<option>하의</option>
						<option>신발</option>
						<option>기타</option>
					</select>
					</div>
				</div>
				<div class="col">
					<div class="labelText">수량 설정</div>
					<div id="sizeOption">
						<c:forEach var="stock" items="${stockVos}" varStatus="st">
							<div class="row" id="top1">
								<div class="col">옵션</div>
								<div class="col"><input type="text" name="goodsSize" class="optionInput" value="${stock.goods_Option}" readonly></div>
								<div class="col">수량</div>
								<div class="col"><input type="number" name="goodsStock" class="stockInput" value="${stock.stock}" min=1 max=100></div>
								<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption(top1)>삭제</button></div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div id="btnDiv">
					<button onclick="fCheck()" id="registerBtn">등록</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>