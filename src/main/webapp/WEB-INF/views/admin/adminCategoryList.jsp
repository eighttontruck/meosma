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
        <style>
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
			.orderListImg{
				width:100px;
			}
			
			.flex{
				display:flex;
				align-items:center;
				justify-content: space-between;
			}
			#modalBtn{
				width:100px;
				height:30px;
				background-color:white;
				border:none;
			}
			.searchSelect{
				border:none;
				border-bottom: 1.9px solid lightgray;
				width: 150px;
				padding:5px 10px;
				font-size:1.1rem;
				text-align:center;
			}
			.searchSelect:focus{
				outline:none;
			}
			.searchInput{
				border:none;
				border-bottom: 1.9px solid lightgray;
				width: 200px;
				padding:5px 10px;
				font-size:1.1rem;
			}
			.searchInput:focus{
				outline:none;
				border-bottom: 1.9px solid black;
			}
			.searchBtn{
				width:100px;
				height:30px;
				background-color:black;
				color:white;
				border:none;
			}
			.dateSelect{
				border:none;
				border-bottom: 1.9px solid lightgray;
				width: 100px;
				padding:5px 10px;
				font-size:1.1rem;
				text-align:center;
			}
			.dateSelect:focus{
				outline:none;
			}
			img{
				width:100px;
			}
			#updateBtn{
				width:50px;
				background-color:black;
				color:white;
				border:1px solid black;
			}
			#deleteBtn{
				width:50px;
				background-color:white;	
				border:1px solid black;
			}
        </style>
        <script>
	        $(document).ready(function() {
				$("#mainCategory").val(${mainCategory});
				let mainCategory = $("#mainCategory").val();
				if(mainCategory != 0){
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
			    				    /* if (subCategory == String(res[i].subCategory_Idx)) {
			    				    	str += 'selected';
			    				    } */
		    				    str += ' value="' + res[i].subCategory_Idx + '">' + res[i].subCategory_Name + '</option>';
		    				}
		    				$("#subCategory").html(str);
		    				
		    				$("#subCategory").val(${subCategory});
		    				let subCategory=$("#subCategory").val();
		    				/* if(subCategory != null){
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
			    						$("#secondCategory").val(${pageVO.secondCategory});
			    					},
			    					error:function() {
			    						alert("전송오류!");
			    					}
			    				});
		    				} */
		    			},
		    			error:function() {
		    				alert("전송오류!");
		    			}
		    		});
				}
				
	        });
	        
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
	    		
	    		/* $("#subCategory").change(function(){
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
	    		}); */
	        });
	        
			function getGoodsStockAJAX(goods_Idx){
	    		$.ajax({
	    			type : "post",
	    			url : "${ctp}/goods/goodsStockAJAX",
	    			data : {
	    				goods_Idx : goods_Idx
	    			},
	    			success : function(data){
	    				let str='';
	    				for(let i=0; i<data.length; i++){
	    					if(data[i] == null) break;
	    					str += '<tr><td>'+data[i].goods_Option+'</td>';
	    					str += '<td>'+data[i].stock+'</td></tr>';
	    				}
	    				$("#goodsStockAJAX").html(str);
	    			},
	    			error : function() {
	    				alert("전송오류!");
	    			}
	    		});
	    	}
	        
	        function searchBtn(){
	        	let startPrice = $("#startPrice").val();
	        	let endPrice = $("#endPrice").val();
	        	
	        	if(startPrice>endPrice){
	        		alert("필터를 다시 설정해주세요.");
	        		return false;
	        	}
				myform.submit();
	        	
	        }
	        
	        function mainCategoryFilter(){
	        	let mainCategory = $("#mainCategory").val();
				let searchKeyword = $("#searchKeyword").val();
				let searchString = $("#searchString").val();
				alert(mainCategory);
	      		location.href="${ctp}/admin/categoryList?mainCategory="+mainCategory+"&searchKeyword="+searchKeyword+"&searchString="+searchString;
	        }
	        
	        function subCategoryFilter(){
	        	let mainCategory = $("#mainCategory").val();
	        	let subCategory = $("#subCategory").val();
				let searchKeyword = $("#searchKeyword").val();
				let searchString = $("#searchString").val();
	        	location.href="${ctp}/admin/categoryList?mainCategory="+mainCategory+"&subCategory="+subCategory+"&searchKeyword="+searchKeyword+"&searchString="+searchString;
	        }
	        
	        function secondCategoryFilter(){
	        	let mainCategory = $("#mainCategory").val();
	        	let subCategory = $("#subCategory").val();
	        	let secondCategory = $("#secondCategory").val();
				let searchKeyword = $("#searchKeyword").val();
				let searchString = $("#searchString").val();
	        	location.href="${ctp}/admin/categoryList?mainCategory="+mainCategory+"&subCategory="+subCategory+"&secondCategory="+secondCategory+"&searchKeyword="+searchKeyword+"&searchString="+searchString;
	        }
        </script>
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
		                            <a class="nav-link" href="${ctp}/admin/categoryList">분류 관리</a>
		                            <a class="nav-link" href="${ctp}/admin/categoryRegister">분류 등록</a>
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
                                    <a class="nav-link" href="${ctp}/admin/ReviewList">후기 리스트</a>
                                    <a class="nav-link" href="${ctp}/admin/exchangeList">교환 신청 내역</a>
                                    <a class="nav-link" href="${ctp}/admin/refundList">환불 신청 내역</a>
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
                    <div class="container-fluid px-4">
                        <h1 class="mt-4"><a href="${ctp}/admin/goodsList">상품 조회</a></h1>
                        <div class="card mb-4">
                            <div class="card-body">
                            	<div>
                            		<form method="get" name="myform"  class="flex">	
	                            		<div>
			                            	<select id="mainCategory" name="mainCategory" class="searchSelect" onchange="mainCategoryFilter()">
												<option value="0">대분류 전체보기</option>
												<c:forEach var="vo" items="${mainCategory_vos}" varStatus="st">
													<option value="${vo.category_Idx}">${vo.category_Name}</option>
												</c:forEach>
											</select>
											<select id="subCategory" name="subCategory" class="searchSelect" onchange="subCategoryFilter()"></select>
			                            </div>
		                            	<div>
			                            	<select class="searchSelect" name="searchKeyword" id="searchKeyword">
			                            		<option <c:if test="${pageVO.searchKeyword eq 'idx'}">selected</c:if> value="idx">상품번호</option>
			                            		<option <c:if test="${pageVO.searchKeyword eq 'brand'}">selected</c:if> value="brand">브랜드</option>
			                            		<option <c:if test="${pageVO.searchKeyword eq 'name'}">selected</c:if> value="name">상품명</option>
			                            	</select>
			                            	<input type="text" class="searchInput" value="${pageVO.searchString}" id="searchString" name="searchString">
			                            	<button type="button" class="searchBtn" onclick="searchBtn()">검색</button>
		                            	</div>
	                            	</form>
                            	</div>
                            	
                                <table id="listTable">
									<thead>
										<tr>
											<th>번호</th>
											<th>분류이름</th>
											<th>상위 분류</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${subCategory_vos eq null and secondCategory_vos eq null}">
											<c:forEach var="vo" items="${mainCategory_vos}" varStatus="st">
												<tr>
													<td>${vo.category_Idx}</td>
													<td>${vo.category_Name}</td>
													<td></td>
													<td>
														<button type="button" id="updateBtn" onclick="location.href='${ctp}/admin/brandUpdate?brand_Idx=${brand.idx}'">수정</button>
														<button type="button" id="deleteBtn" onclick="deleteCheck(${brand.idx})">삭제</button>
													</td>
												</tr>
											</c:forEach>
										</c:if>
										<c:forEach var="vo" items="${subCategory_vos}" varStatus="st">
											<tr>
												<td>${vo.subCategory_Idx}</td>
												<td>${vo.subCategory_Name}</td>
												<td>${vo.mainCategory_Name}</td>
												<td>
													<button type="button" id="updateBtn" onclick="location.href='${ctp}/admin/brandUpdate?brand_Idx=${brand.idx}'">수정</button>
													<button type="button" id="deleteBtn" onclick="deleteCheck(${brand.idx})">삭제</button>
												</td>
											</tr>
										</c:forEach>
										<c:forEach var="vo" items="${secondCategory_vos}" varStatus="st">
											<tr>
												<td>${vo.secondCategory_Idx}</td>
												<td>${vo.secondCategory_Name}</td>
												<td>${vo.mainCategory_Name} > ${vo.subCategory_Name}</td>
												<td>
													<button type="button" id="updateBtn" onclick="location.href='${ctp}/admin/brandUpdate?brand_Idx=${brand.idx}'">수정</button>
													<button type="button" id="deleteBtn" onclick="deleteCheck(${brand.idx})">삭제</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
							  	</table>
								<div class="text-center m-4">
								    <ul class="pagination justify-content-center pagination-sm">
								      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/goodsList?pageSize=${pageVO.pageSize}&pag=1&mainCategory=${pageVO.mainCategory}&subCategory=${pageVO.subCategory}&secondCategory=${pageVO.secondCategory}&searchKeyword=${pageVO.searchKeyword}&search=${pageVO.searchString}&startFilter=${pageVO.startFilter}&endFilter=${pageVO.endFilter}">첫페이지</a></li></c:if>
								      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/goodsList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&mainCategory=${pageVO.mainCategory}&subCategory=${pageVO.subCategory}&secondCategory=${pageVO.secondCategory}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startFilter=${pageVO.startFilter}&endFilter=${pageVO.endFilter}">이전블록</a></li></c:if>
								      <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
							              <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/goodsList?pageSize=${pageVO.pageSize}&pag=${i}&mainCategory=${pageVO.mainCategory}&subCategory=${pageVO.subCategory}&secondCategory=${pageVO.secondCategory}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startFilter=${pageVO.startFilter}&endFilter=${pageVO.endFilter}">${i}</a></li></c:if>
								       	  <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/goodsList?pageSize=${pageVO.pageSize}&pag=${i}&mainCategory=${pageVO.mainCategory}&subCategory=${pageVO.subCategory}&secondCategory=${pageVO.secondCategory}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startFilter=${pageVO.startFilter}&endFilter=${pageVO.endFilter}">${i}</a></li></c:if>
								      </c:forEach>
								      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/goodsList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&mainCategory=${pageVO.mainCategory}&subCategory=${pageVO.subCategory}&secondCategory=${pageVO.secondCategory}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startFilter=${pageVO.startFilter}&endFilter=${pageVO.endFilter}">다음블록</a></li></c:if>
								      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/goodsList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&mainCategory=${pageVO.mainCategory}&subCategory=${pageVO.subCategory}&secondCategory=${pageVO.secondCategory}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startFilter=${pageVO.startFilter}&endFilter=${pageVO.endFilter}">마지막페이지</a></li></c:if>
								   </ul>
							   </div>
                            </div>
                        </div>
                    </div>
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
