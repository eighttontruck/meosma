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
        <title>머스마(Musma) - 글로벌 멀티 컬쳐 선두주자 나야나</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${ctp}/resources/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
    </head>
    <script>
    	function viewContent(content){
    		$("#modal-body").html(content);
    		
    	}
    	
    	function sortFilter2() {
			let sortFilter=$("#sortFilter").val();
			let searchKeyword = $("#searchKeyword").val();
			let searchString = $("#searchString").val();
			location.href = "${ctp}/admin/brandList?sortFilter="+sortFilter+"&searchKeyword="+searchKeyword+"&searchString="+searchString;
    	}
    	
    	function searchBtn(){
        	/* let startPrice = $("#startPrice").val();
        	let endPrice = $("#endPrice").val();
        	
        	if(startPrice>endPrice){
        		alert("필터를 다시 설정해주세요.");
        		return false;
        	} */
			myform.submit();
        	
        }
    	function deleteCheck(brand_Idx){
    		let confirmed = confirm("정말 삭제하시겠습니까?");
    		
    		if(confirmed){
    			$.ajax({
    				type : "post",
    				url : "${ctp}/admin/brandDeleteAJAX",
    				data : {brand_Idx:brand_Idx},
    				success : function(data){
    					alert("해당 브랜드 삭제 완료");
    					location.reload();
    				},
    				error : function() {
    					alert("전송오류");
    				}
    			});
    		}
    	}
    </script>
    <style>
    	#listTable{
    		margin-top:20px;
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
		#modalBtn{
			width:100px;
			height:30px;
			background-color:white;
			border:none;
			
		}
		.flex{
			display:flex;
			align-items:center;
			justify-content: space-between;
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
    </style>
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
                    <div class="container-fluid px-4">
                        <h1 class="mt-4"><a href="${ctp}/admin/brandList">브랜드 리스트</a></h1>
                        <div class="row">
                            <div class="col">
                                <div class="card mb-4">
                                    <div class="card-body">
                                    	<div>
		                            		<form method="get" name="myform"  class="flex">	
				                            	<div>
				                            		<select onchange="sortFilter2()" class="searchSelect" name="sortFilter" id="sortFilter" >
				                            			<option hidden disabled selected value="">정렬 선택</option>
				                            			<option <c:if test="${pageVO.filter eq 'goodsCountDown'}">selected</c:if> value="goodsCountDown">등록된 상품 많은순</option>
				                            			<option <c:if test="${pageVO.filter eq 'goodsCountUp'}">selected</c:if> value="goodsCountUp">등록된 상품 적은순</option>
				                            			<option <c:if test="${pageVO.filter eq 'brandNameUp'}">selected</c:if> value="brandNameUp">알파벳 순</option>
				                            			<option <c:if test="${pageVO.filter eq 'brandNameDown'}">selected</c:if> value="brandNameDown">알파벳 역순</option>
				                            		</select>
				                            	</div>
				                            	<div>
					                            	<select class="searchSelect" name="searchKeyword" id="searchKeyword">
					                            		<option <c:if test="${pageVO.searchKeyword eq 'idx'}">selected</c:if> value="idx">브랜드 번호</option>
					                            		<option <c:if test="${pageVO.searchKeyword eq 'name'}">selected</c:if> value="name">브랜드 이름</option>
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
													<th>브랜드명</th>
													<th>브랜드 설명</th>
													<th>상품 수</th>
													<th>좋아요</th>
													<th>비고</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="brand" items="${brandVos}" varStatus="st">
													<tr>
														<td>${brand.idx}</td>
														<td>${brand.name}</td>
														<td><button type="button" id="modalBtn" data-toggle="modal" data-target="#myModal" onclick="viewContent('${brand.content}')">내용 보기</button></td>
														<td><a href="${ctp}/admin/goodsList?searchKeyword=brand&searchString=${brand.name}">${brand.goods_Count} ></a></td>
														<td>${brand.brand_like}</td>
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
										       <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/brandList?pageSize=${pageVO.pageSize}&pag=1&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">첫페이지</a></li></c:if>
										       <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/brandList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">이전블록</a></li></c:if>
										       <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
									               <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/brandList?pageSize=${pageVO.pageSize}&pag=${i}&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">${i}</a></li></c:if>
										           <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/brandList?pageSize=${pageVO.pageSize}&pag=${i}&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">${i}</a></li></c:if>
										       </c:forEach>
										       <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/brandList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">다음블록</a></li></c:if>
										       <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/brandList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">마지막페이지</a></li></c:if>
										    </ul>
									    </div>
                                    </div>
                                </div> 
                            </div>
                        </div>
                    </div>
                    <!-- The Modal -->
					<div class="modal" id="myModal">
					  <div class="modal-dialog modal-dialog-centered">
					    <div class="modal-content">
					
					      <!-- Modal Header -->
					      <div class="modal-header">
					        <h4 class="modal-title">브랜드 설명</h4>
					        <button type="button" class="close" data-dismiss="modal">&times;</button>
					      </div>
					
					      <!-- Modal body -->
					      <div class="modal-body" id="modal-body">
					        
					      </div>
					
					      <!-- Modal footer -->
					      <div class="modal-footer">
					        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
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
