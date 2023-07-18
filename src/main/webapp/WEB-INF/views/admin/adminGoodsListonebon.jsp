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
        <script>
	        'use strict'
	    	
	    	function lectureTypeCheck(){
	    		let lectureType=document.getElementById("lectureType").value;
	    		location.href="${ctp}/getMemberList.mem?lectureType="+lectureType;
	    	}
	    	
	    	function searchCheck(){
	    		let searchString = $("#searchString").val();
	    		
	    		if(searchString.trim()==""){
	    			alert("찾고자하는 검색어를 입력하세요!");
	    			searchForm.searchString.focus();
	    		} else{
	    			searchForm.submit();
	    		}
	    	}
	    	
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
        </script>
        <style>
		   img{
		   		width:100px;
		   }
		   #listTable{
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
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand ps-3" href="index.html">관리자페이지</a>
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
                                    <a class="nav-link" href="${ctp}/admin/orderHistoryList">주문 내역</a>
                                    <a class="nav-link" href="layout-sidenav-light.html">분류 관리</a>
                                    <a class="nav-link" href="layout-sidenav-light.html">분류 관리</a>
                                    
                                </nav>
                            </div>
                            
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts2" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                              	브랜드
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts2" aria-labelledby="headingOne22" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="layout-static.html">브랜드 리스트</a>
                                    <a class="nav-link" href="layout-sidenav-light.html">브랜드 등록</a>
                                </nav>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">상품 리스트</h1>
                        <div class="card mb-4">
                            <div class="card-body">
                                <table id="listTable">
									<thead>
										<tr>
											<th>상품 번호</th>
											<th>사진</th>
											<th>브랜드</th>
											<th>상품명</th>
											<th>가격</th>
											<th>좋아요</th>
											<th>카테고리</th>
											<th>수량 현황<th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="goods" items="${goodsVos}" varStatus="st">
											<tr>
												<td class="align-middle">${goods.idx}</td>
												<td class="align-middle"><img alt="" src="${ctp}/images/${goods.thumbNail}"></td>
												<td class="align-middle">${goods.brand_Name}</td>
												<td class="align-middle">${goods.name}</td>
												<td class="align-middle">${goods.price}</td>
												<td class="align-middle">${goods.goods_Like}</td>
												<td class="align-middle">${goods.secondCatagory_Idx}</td>
												<td class="align-middle"><button type="button" id="modalBtn" onclick="getGoodsStockAJAX(${goods.idx})" data-toggle="modal" data-target="#myModal">재고 현황</button></td>
												<td class="align-middle">
													<button type="button" id="updateBtn" onclick="location.href='${ctp}/admin/goodsUpdate?goods_Idx=${goods.idx}'">수정</button>
													<button type="button" id="deleteBtn" onclick="location.href='${ctp}/admin/goodsDelete?goods_Idx=${goods.idx}'">삭제</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
							  	</table>
                            </div>
                        </div>
                    </div>
                </main>   
            </div>
            <div class="modal" id="myModal">
				  <div class="modal-dialog modal-dialog-centered">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header">
				        <h4 class="modal-title">Modal Heading</h4>
				        <button type="button" class="close" data-dismiss="modal">&times;</button>
				      </div>
				
				      <!-- Modal body -->
				      <div class="modal-body">
				        <table class="table table-striped text-center align-middle">
				        	<thead>
				        		<tr>
				        			<th>옵션</th>
				        			<th>수량</th>
				        		</tr>
				        	</thead>
				        	<tbody id="goodsStockAJAX">
				        		
				        	</tbody>
				        </table>
				      </div>
				
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				      </div>
				
				    </div>
				  </div>
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
