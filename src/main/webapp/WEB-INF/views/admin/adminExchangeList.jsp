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
    	
    	function shippingNum(idx){
    		$("#idx").val(idx);
    	}
    	
    	function updateExchangeDelivery(idx){
			let confirmed = confirm("수령 후 검수 완료하셨나요?");
    		
    		if(confirmed){
    			$.ajax({
    				type : "post",
    				url : "${ctp}/admin/updateExchangeDeliveryAJAX",
    				data : {idx:idx},
    				success : function(data){
    					alert("교환 수령완료 처리 성공");
    					location.reload();
    				},
    				error : function() {
    					alert("전송오류");
    				}
    			});
    		}
    	}
    	
    	function getOrderHistory_DetailList(idx){
    		$.ajax({
    			type : "post",
    			url : "${ctp}/admin/exchange_DetailListAJAX",
    			data : {
    				idx : idx,
    			},
    			success : function(data){
    				let str='';
    				str += '<tr class="mt-4 mb-4">';
    				str += '<td>교환 신청한 옵션 : '+data[0].order_Option+'</td>';
    				str += '<td>수량 : '+data[0].total_Stock+'</td>';
    				str += '</tr>';
    				for(let i=0; i<data.length; i++){
    					if(data[i] == null) break;
    					/* <div class="flex">
						<div style="margin-right:20px;">
							<img alt="" src="${ctp}/images/${order.goods_ThumbNail}">
						</div>
						<div id="dd">
							<div class="row">${order.goods_Brand}</div>
							<div class="row">${order.goods_Name}</div>
							<div class="row">SIZE : ${order.goods_Option}</div>
						</div>
						</div> */
    					str += '<tr>';
    					str += '<td>';
    					str	+= '<div class="flex2">';
    					str += '<div style="margin-right:20px;">';
    					str += '<img alt="" src="${ctp}/images/'+data[i].goods_ThumbNail+'">';
    					str += '</div>';
    					str += '<div id="dd">';
    					str += '<div class="row">'+data[i].goods_Brand+'</div>';
    					str += '<div class="row">'+data[i].goods_Name+'</div>';
    					str += '<div class="row">SIZE : '+data[i].goods_Option+'</div>';
    					str += '</div>';
    					str += '</div>';
    					str += '</td>';
    					str += '<td>'+data[i].stock+'</td>';
    					/* str += '<td>ddddddddd</td>';
    					str += '<td>ddddddddd</td>'; */
    					str += '</tr>';
    				}
    				$("#orderHistory_DetailtBody").html(str);
    			},
    			error : function() {
    				alert("전송오류!");
    			}
    		});
    	}
    	
    	function updateExchangeDelivery(idx){
			let confirmed = confirm("수령 후 검수 완료하셨나요?");
    		
    		if(confirmed){
    			$.ajax({
    				type : "post",
    				url : "${ctp}/admin/updateExchangeDeliveryAJAX",
    				data : {idx:idx},
    				success : function(data){
    					alert("교환 수령완료 처리 성공");
    					location.reload();
    				},
    				error : function() {
    					alert("전송오류");
    				}
    			});
    		}
    	}
    	
    	function sortFilter2() {
			let sortFilter=$("#sortFilter").val();
			let searchKeyword = $("#searchKeyword").val();
			let searchString = $("#searchString").val();
			location.href = "${ctp}/admin/exchangeList?sortFilter="+sortFilter+"&searchKeyword="+searchKeyword+"&searchString="+searchString;
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
    	function shippingNumRegister(){
    		let idx=$("#idx").val();
    		let shippingNum = $.trim($("#shippingNum").val());
    		$.ajax({
    			type : "post",
    			url : "${ctp}/admin/exchangeShippingNumRegisterAJAX",
    			data : {
    				idx : idx,
    				shippingNum : shippingNum
    			},
    			success : function(data){
    				alert("운송장 등록완료");
    				location.reload();
    			},
    			error : function() {
    				alert("전송오류!");
    			}
    		});
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
    	#modalTable{
			width:100%;
			text-align:center;
		}
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
		.flex2{
			display:flex;
			align-items:center;
			justify-content: flex-start;
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
		img{
			width:100px;
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
					          			<th>수량</th>
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
                	 <!-- The Modal -->
					  <div class="modal" id="deliveryModal">
					    <div class="modal-dialog modal-dialog-centered">
					      <div class="modal-content">
					      
					        <!-- Modal Header -->
					        <div class="modal-header">
					          <h4 class="modal-title text-center">운송장 등록</h4>
					          <button type="button" class="close" data-dismiss="modal">&times;</button>
					        </div>
					        
					        <!-- Modal body -->
					        <div class="modal-body text-center">
					        	<select>
					        		<option>CJ대한통운</option>
					        		<option>롯데택배</option>
					        		<option>우체국택배</option>
					        		<option>로젠택배</option>
					        		<option>편의점택배</option>
					        	</select>
					        	<input type="text" name="shippingNum" id="shippingNum">
					        	<input type="hidden" name="idx" id="idx">
					        </div>
					        
					        <!-- Modal footer -->
					        <div class="modal-footer">
					          <button type="button" onclick="shippingNumRegister()" class="btn btn-success">등록</button>
					          <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
					        </div>
					        
					      </div>
					    </div>
					  </div>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4"><a href="${ctp}/admin/exchangeList">교환 신청 내역</a></h1>
                        <div class="row">
                            <div class="col">
                                <div class="card mb-4">
                                    <div class="card-body">
                                    	<div>
		                            		<form method="get" name="myform"  class="flex">	
				                            	<div>
				                            		<select onchange="sortFilter2()" class="searchSelect" name="sortFilter" id="sortFilter" >
				                            			<option hidden disabled selected value="">정렬 선택</option>
				                            			<option <c:if test="${pageVO.filter eq '신청접수'}">selected</c:if> value="신청접수">신청접수</option>
				                            			<option <c:if test="${pageVO.filter eq '수령완료'}">selected</c:if> value="수령완료">수령완료</option>
				                            			<option <c:if test="${pageVO.filter eq '배송중'}">selected</c:if> value="배송중">배송중</option>
				                            			<option <c:if test="${pageVO.filter eq '교환완료'}">selected</c:if> value="교환완료">교환완료</option>
				                            		</select>
				                            	</div>
				                            	<div>
					                            	<select class="searchSelect" name="searchKeyword" id="searchKeyword">
					                            		<option <c:if test="${pageVO.searchKeyword eq 'orderhistory_detail_idx'}">selected</c:if> value="orderhistory_detail_idx">주문번호</option>
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
													<th>주문번호</th>
													<th>신청날짜</th>
													<th>사유</th>
													<th>수령인 이름</th>
													<th>수령인 전화번호</th>
													<th>수령인 주소</th>
													<th>상태</th>
													<th>비고</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="vo" items="${vos}" varStatus="st">
													<tr>
														<td><button type="button" id="modalBtn" data-toggle="modal" data-target="#detailModal" onclick="getOrderHistory_DetailList(${vo.idx})">${vo.idx} ></button></td>
														<td>${vo.orderHistory_Detail_Idx}</td>
														<td>${vo.applicationDate}</td>
														<td>${vo.reason}</td>
														<td>${vo.recipient_Name}</td>
														<td>${vo.recipient_TelNum}</td>
														<td>${vo.recipient_Address}</td>
														<td>${vo.status}</td>
														<td>
															<c:if test="${vo.status eq '신청접수'}">
																<button type="button" onclick="updateExchangeDelivery(${vo.idx})">수령완료</button>
															</c:if>
															<c:if test="${vo.status eq '수령완료'}">
																<button type="button" data-toggle="modal" data-target="#deliveryModal" onclick="shippingNum(${vo.idx})">운송장 입력</button>
															</c:if>
														</td>
													</tr>
												</c:forEach>
											</tbody>
									  	</table>
									  	<div class="text-center m-4">
										    <ul class="pagination justify-content-center pagination-sm">
										       <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/exchangeList?pageSize=${pageVO.pageSize}&pag=1&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">첫페이지</a></li></c:if>
										       <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/exchangeList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">이전블록</a></li></c:if>
										       <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
									               <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/exchangeList?pageSize=${pageVO.pageSize}&pag=${i}&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">${i}</a></li></c:if>
										           <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/exchangeList?pageSize=${pageVO.pageSize}&pag=${i}&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">${i}</a></li></c:if>
										       </c:forEach>
										       <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/exchangeList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">다음블록</a></li></c:if>
										       <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/exchangeList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&sortFilter=${pageVO.filter}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}">마지막페이지</a></li></c:if>
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
