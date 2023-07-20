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
				width: 300px;
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
        </style>
        <script>
	        $(document).ready(function() {
	        	let today = new Date(); 
	        	
				let year = today.getFullYear(); // 년도
				let month = today.getMonth() + 1; // 월
				let date = today.getDate();  // 날짜
				let day = today.getDay(); 
				
				$("#endYearSelect").val(year);
				$("#startYearSelect").val(year-1);
				
				$("#endMonthSelect").val(month);
				$("#startMonthSelect").val(month);
				
				let monthSelect = document.getElementById("endMonthSelect");
				let endDateSelect = document.getElementById("endDateSelect");
				let startDateSelect = document.getElementById("startDateSelect");
				let selectedMonth = monthSelect.value;
				
				while (endDateSelect.options.length > 1) {
					todaystartDateSelectDateSelect.remove(1);
				}
				while (startDateSelect.options.length > 1) {
					startDateSelect.remove(1);
				}
				var maxDays = getMaxDays(selectedMonth);
				for (var i = 1; i <= maxDays; i++) {
				  var option = document.createElement("option");
				  option.value = i;
				  option.text = i;
				  endDateSelect.add(option);
				}
				for (var i = 1; i <= maxDays; i++) {
				  var option = document.createElement("option");
					  option.value = i;
					  option.text = i;
					  startDateSelect.add(option);
					}
				$("#endDateSelect").val(date);
				$("#startDateSelect").val(date);
				
				let startYear = document.getElementById("startYearSelect").value;
	        	let endYear = document.getElementById("endYearSelect").value;
				
	        	let startMonth = document.getElementById("startMonthSelect").value;
	        	let endMonth = document.getElementById("endMonthSelect").value;
	        	
	        	let startDate = document.getElementById("startDateSelect").value;
	        	let endDate = document.getElementById("endDateSelect").value;
				
	        	
	        	let sdate = $("#sdateCheck").val();
	        	let edate = $("#edateCheck").val();
	        	
	        	$("#startDate").val(startYear+"-"+startMonth+"-"+startDate);
				$("#endDate").val(endYear+"-"+endMonth+"-"+endDate);
	        	
	        	if(sdate!="" && edate!=""){
	        		$("#startDate").val("${pageVO.startFilter}");
					$("#endDate").val("${pageVO.endFilter}");
	        		
		        	let sdateParts = sdate.split("-");
		        	let syear = sdateParts[0];
		        	let smonth = sdateParts[1];
		        	if(smonth.startsWith('0')){
		        		smonth = smonth.slice(1);
		        	}
		        	let sday = sdateParts[2];
		        	if(sday.startsWith('0')){
		        		sday = sday.slice(1);
		        	}
		        	
		        	let edateParts = edate.split("-");
		        	let eyear = edateParts[0];
		        	let emonth = edateParts[1];
		        	if(emonth.startsWith('0')){
		        		emonth = emonth.slice(1);
		        	}
		        	let eday = edateParts[2];
		        	if(eday.startsWith('0')){
		        		eday = eday.slice(1);
		        	}
		        	
		        	$("#endYearSelect").val(eyear);
					$("#startYearSelect").val(syear);
					
					$("#endMonthSelect").val(emonth);
					$("#startMonthSelect").val(smonth);
		        	
					$("#endDateSelect").val(eday);
					$("#startDateSelect").val(sday);
	        	}
	        	
			
				
	        });
	        
	        function searchBtn(){
	        	let startYear = document.getElementById("startYearSelect").value;
	        	let endYear = document.getElementById("endYearSelect").value;
				
	        	let startMonth = document.getElementById("startMonthSelect").value;
	        	let endMonth = document.getElementById("endMonthSelect").value;
	        	
	        	let startDate = document.getElementById("startDateSelect").value;
	        	let endDate = document.getElementById("endDateSelect").value;
	        	
	        	if(startDate==""||endDate==""){
	        		alert("날짜 양식을 모두 입력해주세요.");
	        		return false;
	        	}
	        	if(startMonth.length == 1){
	        		startMonth = "0" + startMonth;
	        	} if(endMonth.length == 1){
	        		endMonth = "0" + endMonth;
	        	} if(startDate.length == 1){
	        		startDate = "0" + startDate;
	        	} if(endDate.length == 1){
	        		endDate = "0" + endDate;
	        	}
				
				$("#startDate").val(startYear+"-"+startMonth+"-"+startDate);
				$("#endDate").val(endYear+"-"+endMonth+"-"+endDate);
				myform.submit();
	        	
	        }
	        function pastDateOptions() {
	        	  var monthSelect = document.getElementById("startMonthSelect");
	        	  var daySelect = document.getElementById("startDateSelect");
	        	  var selectedMonth = monthSelect.value;
	        	  
	        	  // 기존의 일자 옵션을 모두 제거
	        	  while (daySelect.options.length > 1) {
	        	    daySelect.remove(1);
	        	  }
	        	  
	        	  var maxDays = getMaxDays(selectedMonth);
	        	  for (var i = 1; i <= maxDays; i++) {
	        	    var option = document.createElement("option");
	        	    option.value = i;
	        	    option.text = i;
	        	    daySelect.add(option);
	        	  }
	        	  $("#startDateSelect").val("");
	        }
	        
	        function todayDateOptions() {
	        	  var monthSelect = document.getElementById("endMonthSelect");
	        	  var daySelect = document.getElementById("endDateSelect");
	        	  var selectedMonth = monthSelect.value;
	        	  
	        	  // 기존의 일자 옵션을 모두 제거
	        	  while (daySelect.options.length > 1) {
	        	    daySelect.remove(1);
	        	  }
	        	  
	        	  var maxDays = getMaxDays(selectedMonth);
	        	  for (var i = 1; i <= maxDays; i++) {
	        	    var option = document.createElement("option");
	        	    option.value = i;
	        	    option.text = i;
	        	    daySelect.add(option);
	        	  }
	        	  $("#endDateSelect").val("");
	        }
	        
	        function getMaxDays(month) {
			  if (month === "2") {
			    var currentYear = new Date().getFullYear();
			    return isLeapYear(currentYear) ? 29 : 28;
			  } else if (month === "4" || month === "6" || month === "9" || month === "11") {
			    return 30;
			  } else {
			    return 31;
			  }
			}

			function isLeapYear(year) {
			  return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
			}
        	
	        function shippingNum(idx){
	    		$("#orderHistoryIdx").val(idx);
	    	}
	
	        function status_Filter(){
	        	let status = $("#delivery_Status").val();
	        	let startDate = $("#startDate").val();
				let endDate = $("#endDate").val();
				let searchKeyword = $("#searchKeyword").val();
				let searchString = $("#searchString").val();
	      		location.href="${ctp}/admin/orderHistoryList?delivery_Status="+status+"&startDate="+startDate+"&endDate="+endDate+"&searchKeyword="+searchKeyword+"&searchString="+searchString;
	        }
	    	function shippingNumRegister(){
	    		let orderHistoryIdx=$("#orderHistoryIdx").val();
	    		let shippingNum = $.trim($("#shippingNum").val());
	    		$.ajax({
	    			type : "post",
	    			url : "${ctp}/admin/orderShippingNumRegister",
	    			data : {
	    				orderHistoryIdx : orderHistoryIdx,
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
	    	
	    	function getOrderHistory_DetailList(idx){
	    		$.ajax({
	    			type : "post",
	    			url : "${ctp}/admin/orderHistory_DetailListAJAX",
	    			data : {
	    				idx : idx,
	    			},
	    			success : function(data){
	    				let str='';
	    				for(let i=0; i<data.length; i++){
	    					if(data[i] == null) break;
	    					str += '<tr>';
	    					str += '<td><div class="flex">';
	    					str += '<div><img class="orderListImg" src="${ctp}/images/'+data[i].goods_ThumbNail+'"></div>';
	    					str += '<div>'+data[i].goods_Brand+'<br><strong>'+data[i].goods_Name+'</strong><br>'+data[i].goods_Option+'</div>';
	    					str += '</div></td>';
	    					str += '<td>'+data[i].idx+'</td>';
	    					str += '<td>₩'+data[i].totalPrice+'('+data[i].goods_Stock+'개)</td>';
	    					str += '<td>'+data[i].returns_status+'</td>';
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
					          			<th>교환&환불 요청</th>
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
					        	<input type="hidden" name="orderHistoryIdx" id="orderHistoryIdx">
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
                        <h1 class="mt-4"><a href="${ctp}/admin/orderHistoryList">주문내역</a></h1>
                        <div class="card mb-4">
                            <div class="card-body">
                            	<div class="flex">	
                            		<div>
                            			
	                            		<select class="searchSelect" onchange="status_Filter()" id="delivery_Status">
	                            			<option disabled hidden selected>배송상태 선택</option>
		                            		<option <c:if test="${delivery_Status eq '결제완료'}">selected</c:if>>결제완료</option>
		                            		<option <c:if test="${delivery_Status eq '배송중'}">selected</c:if>>배송중</option>
		                            		<option <c:if test="${delivery_Status eq '구매확정'}">selected</c:if>>구매확정</option>
		                            	</select>
		                            </div>
		                            <div>
		                            	<select id="startYearSelect" class="dateSelect">
		                            		<option value="" disabled hidden selected>연도</option>
		                            		<c:forEach var="i" begin="0" end="100">
												<c:set var="yearOption" value="${2023-i}"></c:set>
												<option>${yearOption}</option>
											</c:forEach>
		                            	</select>
		                            	<select id="startMonthSelect" onchange="pastDateOptions()" class="dateSelect">
		                            		<option value="" disabled hidden selected>월</option>
											<c:forEach var="i" begin="1" end="12">
												<option value="${i}">${i}</option>
											</c:forEach>
		                            	</select>
		                            	<select id="startDateSelect" class="dateSelect">
		                            		<option value="" disabled hidden selected>일</option>
		                            	</select>
		                            	-
		                            	<select id="endYearSelect" class="dateSelect">
		                            		<option value="" disabled hidden selected>연도</option>
		                            		<c:forEach var="i" begin="0" end="100">
												<c:set var="yearOption" value="${2023-i}"></c:set>
												<option>${yearOption}</option>
											</c:forEach>
		                            	</select>
		                            	<select id="endMonthSelect" onchange="todayDateOptions()" class="dateSelect">
		                            		<option value="" disabled hidden selected>월</option>
											<c:forEach var="i" begin="1" end="12">
												<option value="${i}">${i}</option>
											</c:forEach>
		                            	</select>
		                            	<select id="endDateSelect" class="dateSelect">
		                            		<option value="" disabled hidden selected>일</option>
		                            	</select>
	                            	</div>
	                            	<div>
	                            	<input type="hidden" value="${pageVO.startFilter}" id="sdateCheck">
	                            	<input type="hidden" value="${pageVO.endFilter}" id="edateCheck">
	                            	<form method="get" name="myform">
		                            	<select class="searchSelect" name="searchKeyword" id="searchKeyword">
		                            		<option <c:if test="${pageVO.searchKeyword eq 'idx'}">selected</c:if> value="idx">주문번호</option>
		                            		<option <c:if test="${pageVO.searchKeyword eq 'member_Idx'}">selected</c:if> value="member_Idx">회원번호</option>
		                            		<option <c:if test="${pageVO.searchKeyword eq 'recipient_Name'}">selected</c:if> value="recipient_Name">수령인 이름</option>
		                            		<option <c:if test="${pageVO.searchKeyword eq 'recipient_TelNum'}">selected</c:if> value="recipient_TelNum">수령인 전화번호</option>
		                            		<option <c:if test="${pageVO.searchKeyword eq 'recipient_Address'}">selected</c:if> value="recipient_Address">수령인 주소</option>
		                            	</select>
		                            	<input type="text" class="searchInput" value="${pageVO.searchString}" id="searchString" name="searchString">
		                            	<input type="hidden" value="${delivery_Status}" name="delivery_Status">
		                            	<input type="hidden" value="" name="startDate" id="startDate">
		                            	<input type="hidden" value="" name="endDate" id="endDate">
		                            	<button type="button" class="searchBtn" onclick="searchBtn()">검색</button>
	                            	</form>
	                            	</div>
                            	</div>
                            	
                                <table id="listTable">
									<thead>
										<tr>
											<th>주문번호</th>
											<th>회원번호</th>
											<th>주문일자</th>
											<th>주문금액(수량)</th>
											<th>주문상태</th>
											<th>수령인 이름</th>
											<th>수령인 전화번호</th>
											<th>수령인 주소</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="order" items="${vos}" varStatus="st">
											<tr>
												<td><button type="button" id="modalBtn" data-toggle="modal" data-target="#detailModal" onclick="getOrderHistory_DetailList(${order.idx})">${order.idx} ></button></td>
												<td>${order.member_Idx}</td>
												<td>${fn:substring(order.orderDate,2,11)}</td>
												<td>₩<fmt:formatNumber value="${order.finalPrice}" pattern="#,###"/></td>
												<td>
													${order.status}
													<c:if test="${order.status eq '결제완료'}"><button type="button" data-toggle="modal" data-target="#deliveryModal" onclick="shippingNum(${order.idx})">운송장 작성</button></c:if>
												</td>
												<td>${order.recipient_Name}</td>
												<td>${order.recipient_TelNum}</td>
												<td>${order.recipient_Address}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div class="text-center m-4">
								    <ul class="pagination justify-content-center pagination-sm">
								      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/orderHistoryList?pageSize=${pageVO.pageSize}&pag=1&delivery_Status=${delivery_Status}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startDate=${pageVO.startFilter}&endDate=${pageVO.endFilter}">첫페이지</a></li></c:if>
								      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/orderHistoryList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&delivery_Status=${delivery_Status}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startDate=${pageVO.startFilter}&endDate=${pageVO.endFilter}">이전블록</a></li></c:if>
								      <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
							              <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/admin/orderHistoryList?pageSize=${pageVO.pageSize}&pag=${i}&delivery_Status=${delivery_Status}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startDate=${pageVO.startFilter}&endDate=${pageVO.endFilter}">${i}</a></li></c:if>
								       	  <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/orderHistoryList?pageSize=${pageVO.pageSize}&pag=${i}&delivery_Status=${delivery_Status}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startDate=${pageVO.startFilter}&endDate=${pageVO.endFilter}">${i}</a></li></c:if>
								      </c:forEach>
								      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/orderHistoryList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&delivery_Status=${delivery_Status}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startDate=${pageVO.startFilter}&endDate=${pageVO.endFilter}">다음블록</a></li></c:if>
								      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/orderHistoryList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&delivery_Status=${delivery_Status}&searchKeyword=${pageVO.searchKeyword}&searchString=${pageVO.searchString}&startDate=${pageVO.startFilter}&endDate=${pageVO.endFilter}">마지막페이지</a></li></c:if>
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
