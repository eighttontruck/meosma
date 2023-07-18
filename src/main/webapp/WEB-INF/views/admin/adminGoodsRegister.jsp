<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Dashboard - SB Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${ctp}/resources/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
        <script src="${ctp}/ckeditor/ckeditor.js"></script>
        <script>   	
    	function deleteOption(id) {
    	  $('#' + id).empty();
    	}
    	
    	$(function(){
    		$("#mainCategory").change(function(){
    			let mainCategory=$(this).val();
    			if(mainCategory == ""){
    				alert("중분류를 선택하세요.");
    				return false;
    			}
    			 
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
    			const optionData = {
				  "상의": ["XS", "S", "M", "L", "XL"],
				  "하의": ["26", "28", "30", "32", "34", "36"],
				  "신발": ["220", "230", "240", "250", "260", "270", "280", "290"],
				  "기타": ["FREE"]
    			};
    			
    			$("#sizeOption").empty();
    			
    			let str = '';
    			const sizes = optionData[optionType];
    			if (sizes) {
    			  sizes.forEach((size, index) => {
    			    const rowId = index + 1;
    			   
    			     str += '<div class="row" id="'+rowId+'">';
    			     str += '<div class="col divInnerText">사이즈</div>'
    			     str += '<div class="col"><input type="text" name="goodsSize" class="optionInput" value="'+size+'" readonly></div>';
    			     str += '<div class="col divInnerText">수량</div>';
    			     str += '<div class="col"><input type="number" name="goodsStock" class="stockInput" oninput="this.value = this.value.replace(/[^0-9.]/g, "").replace(/(\..*)\./g, "$1");"></div>';
    			     str += '<div class="col"><button type="button" class="optionDelBtn" onclick=deleteOption("'+rowId+'")>삭제</button></div>'
    			     str += '</div>'; 
    			  });
    			}
    		
    			
    			$("#sizeOption").append(str);
    		});
    	});
        </script>
        <style>
        	.bigText{
				margin:2px;
				border-bottom: 1.9px solid #000;
				padding:2px;
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
			.divInnerText{
				text-align:center;
				line-height:47.75px;
			}
			.optionDelBtn{
				width:50px;
				height:30px;
				background-color:white;
				color:black;
				border:solid 1px;
				margin:10px;
			}
			.mainBtn{
				width:100%;
				height:50px;
				background-color:black;
				color:white;
				border:none;
				margin-bottom:40px;
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
</head>
<body class="sb-nav-fixed">
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <a class="navbar-brand ps-3" href="${ctp}/admin/adminMain">관리자페이지</a>
    <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
</nav>
<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">
                    <div class="sb-sidenav-menu-heading">Interface</div>
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts1" aria-expanded="false" aria-controls="collapseLayouts">
                        <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                        상품
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne22" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="${ctp}/admin/goodsList">상품 리스트</a>
                            <a class="nav-link" href="${ctp}/admin/goodsRegister">상품 등록</a>
                      <a class="nav-link" href="layout-sidenav-light.html">분류 관리</a>
                        </nav>
                    </div>
                    
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts2" aria-expanded="false" aria-controls="collapseLayouts">
                        <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                        주문
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseLayouts2" aria-labelledby="headingOne22" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="${ctp}/admin/orderHistoryList">주문 내역</a>
                            <a class="nav-link" href="${ctp}/admin/orderHistoryList">댓글 리스트</a>
                            <a class="nav-link" href="${ctp}/admin/orderHistoryList">문의 리스트</a>
                        </nav>
                    </div>
                    
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts3" aria-expanded="false" aria-controls="collapseLayouts">
                        <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                      	브랜드
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseLayouts3" aria-labelledby="headingOne22" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="${ctp}/admin/brandList">브랜드 리스트</a>
                            <a class="nav-link" href="${ctp}/admin/brandRegister">브랜드 등록</a>
                        </nav>
                    </div>
                    
                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts4" aria-expanded="false" aria-controls="collapseLayouts">
                        <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                      	회원
                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                    </a>
                    <div class="collapse" id="collapseLayouts4" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="${ctp}/admin/memberList">회원 리스트</a>
                            <a class="nav-link" href="layout-sidenav-light.html">ㅇㅇ</a>
                        </nav>
                    </div>
                </div>
            </div>
        </nav>
    </div>
    <div id="layoutSidenav_content">
        <main>
        	<form name="myform" method="post" enctype="multipart/form-data">
            <div class="container-fluid px-4">
                <h1 class="mt-4">상품 등록</h1>
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card mb-4">
                            <div class="card-body">
								<div class="col">
									<div class="labelText">상품사진</div>
									<div><input type="file" name="file" id="file" class="form-control-file border"></div>
								</div>
								<div class="col">
									<div class="labelText">브랜드 선택</div>
									<div>
										<select name="brand_Idx" class="inputText">
											<option disabled hidden selected value="" name="brand_idx">브랜드 선택</option>
											<c:forEach var="vo" items="${brand_vos}" varStatus="st">
												<option value="${vo.idx}">${vo.name}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col">
									<div class="labelText">제품명</div>
									<div><input type="text" name="name" id="name" class="inputText"></div>
								</div>
								<div class="col">
									<div class="labelText">제품가격</div>
									<div><input type="text" name="price" id="price" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="inputText"></div>
								</div>
								<div class="col">
									<div class="labelText">대분류 선택</div>
									<div>
										<select id="mainCategory" name="mainCategory" class="inputText">
											<option disabled hidden selected value="">대분류 선택</option>
											<c:forEach var="vo" items="${mainCategory_vos}" varStatus="st">
												<option value="${vo.category_Idx}">${vo.category_Name}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col">
									<div class="labelText">중분류 선택</div>
									<div><select id="subCategory" name="subCategory" class="inputText"></select></div>
								</div>
								<div class="col">
									<div class="labelText">소분류 선택</div>
									<div><select id="secondCategory" name="secondCatagory_Idx" class="inputText"></select></div>
								</div>
                             </div>
                        </div>
                   </div>
            </div>
            <div class="row">
                     <div class="col-xl-6">
                         <div class="card mb-4">
                             <div class="card-body">
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
									<div id="sizeOption"></div>
								</div>
								</div>
                        	</div>
                    	</div>
                    	<div class="col-xl-6">
                    		<div class="card mb-4">
                       		<div class="card-body">
                       			<div class="labelText">사진 등록</div>
                           		<textarea rows="6" name="content" id="CKEDITOR" class="form-control"></textarea>
	                            <script>
	                           		CKEDITOR.replace("content",{
										filebrowserUploadUrl:"${ctp}/images"                        		
	                           		});
	                            </script>
                       		</div>
                  			</div>
                   		</div>
           		   </div>
           		   <div class="row">
           		       <div class="col">
           		           <button class="mainBtn">등록</button>
           		       </div>
           		   </div>
            	</div>
           	</form>
        </main>   
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${ctp}/resources/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="${ctp}/resources/assets/demo/chart-area-demo.js"></script>
<script src="${ctp}/resources/assets/demo/chart-bar-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="${ctp}/resources/js/datatables-simple-demo.js"></script>
</body>
</html>
