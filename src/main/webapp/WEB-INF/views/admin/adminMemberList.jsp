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
    </head>
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
			.flex{
				display:flex;
				align-items:center;
				justify-content: space-between;
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
	    		$("#startDate").val("${pageVO.startDate}");
				$("#endDate").val("${pageVO.endDate}");
	    		
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
    </script>
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
                        <h1 class="mt-4"><a href="${ctp}/admin/memberList">회원 리스트</a></h1>
                        <div class="card mb-4">
                            <div class="card-body">
                            	<div>
                            		<form method="get" name="myform"  class="flex">
                            			<div>
			                            	<select id="genderSelect" name="genderSelect" class="searchSelect" onchange="mainCategoryFilter()">
												<option disabled hidden selected value="">성별 선택</option>
												<option>남자</option>
												<option>여자</option>
											</select>
											<select id="levelSelect" name="levelSelect" class="searchSelect" onchange="subCategoryFilter()">
												<option disabled hidden selected value="">회원등급 선택</option>
												<option>브론즈</option>
												<option>실버</option>
												<option>골드</option>
												<option>플레티넘</option>
												<option>다이아</option>
											</select>
										</div>
										<div>
			                            	<select class="searchSelect" name="searchKeyword" id="searchKeyword">
			                            		<option <c:if test="${pageVO.searchKeyword eq 'idx'}">selected</c:if> value="idx">회원번호</option>
			                            		<option <c:if test="${pageVO.searchKeyword eq 'brand'}">selected</c:if> value="brand">이메일(아이디)</option>
			                            		<option <c:if test="${pageVO.searchKeyword eq 'name'}">selected</c:if> value="name">이름</option>
			                            		<option <c:if test="${pageVO.searchKeyword eq 'name'}">selected</c:if> value="name">생일</option>
			                            		<option <c:if test="${pageVO.searchKeyword eq 'name'}">selected</c:if> value="name">최근</option>
			                            		<option <c:if test="${pageVO.searchKeyword eq 'name'}">selected</c:if> value="name">이름</option>
			                            	</select>
			                            	<input type="text" class="searchInput" value="${pageVO.searchString}" id="searchString" name="searchString">
			                            	<button type="button" class="searchBtn" onclick="searchBtn()">검색</button>
		                            	</div>
	                            	</form>
                            	</div>
                                <table id="listTable">
                                	<thead>
                                		<tr>
                                			<th>회원 번호</th>
                                			<th>이메일(아이디)</th>
                                			<th>이름</th>
                                			<th>성별</th>
                                			<th>생일</th>
                                			<th>전화번호</th>
                                			<th>회원등급</th>
                                			<th>가입일</th>
                                			<th>마지막방문일</th>
                                			<th>주문횟수</th>
                                		</tr>
                                	</thead>
                                	<tbody>
                                		<c:forEach var="member" items="${member_Vos}" varStatus="st">
	                                		<tr>
	                                			<td>${member.idx}</td>
	                                			<td>${member.emailId}</td>
	                                			<td>${member.name}</td>
	                                			<td>${member.gender}</td>
	                                			<td>${fn:substring(member.birthday,2,11)}</td>
	                                			<td>${member.telNum}</td>
	                                			<td>${member.level}</td>
	                                			<td>${fn:substring(member.firstJoinDay,2,11)}</td>
	                                			<td>${fn:substring(member.firstJoinDay,2,11)}</td>
	                                			<td><a href="${ctp}/admin/orderHistoryList?member_Idx=${member.idx}">${member.order_Count}</a></td>
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
