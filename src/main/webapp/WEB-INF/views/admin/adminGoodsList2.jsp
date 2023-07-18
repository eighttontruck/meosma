<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	body{
    	font-family: 'SBAggroB';
   		background-color:white;
    }
    #lectureType{
    	width:270px;
    	margin-left:40px;
    }
    .title{
    	margin-top:30px;
    }
    .table{
    	width:99%;
    	margin:0 auto;
    	margin-top:20px;
    	
    }
    td {
    	vertical-align: middle;
    }
    #searchForm > #search{
    	float:right;
    	width:150px;
    }
    #searchForm > #searchString{
    	float:right;
    	width:300px;
    	margin-left:10px;
    }
    #searchForm > #searchBtn{
    	float:right;
    	margin-left:10px;
    	margin-right:50px;
   }
   img{
   		width:100px;
   }
</style>
<body>
	<div class="title">
		<h2 class="text-center">상 품 리 스 트</h2>
	</div>
	<div class="table">
		<table class="table table-striped text-center align-middle">
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
						<td class="align-middle"><button type="button" onclick="getGoodsStockAJAX(${goods.idx})" data-toggle="modal" data-target="#myModal">재고 현황</button></td>
						<td class="align-middle">
							<button type="button" onclick="location.href='${ctp}/goods/goodsUpdate?goods_Idx=${goods.idx}'">수정</button>
							<button type="button" onclick="location.href='${ctp}/goods/goodsDelete?goods_Idx=${goods.idx}'">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
	  	</table>
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
  	<div class="text-center m-4" id="page">
		  	<ul class="pagination justify-content-center pagination-sm">
			    <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/getMemberList.mem?pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}&lectureType=${lectureType}">이전</a></li></c:if>
			    <c:forEach var="i" begin="${curBlock*blockSize + 1 }" end="${curBlock*blockSize + blockSize}" varStatus="st">
			    	<c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/getMemberList.mem?pageSize=${pageSize}&pag=${i}&lectureType=${lectureType}">${i}</a></li></c:if>
			    	<c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/getMemberList.mem?pageSize=${pageSize}&pag=${i}&lectureType=${lectureType}">${i}</a></li></c:if>
			    </c:forEach>
			    <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/getMemberList.mem?pageSize=${pageSize}&pag=${(curBlock+1)*blockSize + 1}&lectureType=${lectureType}">다음</a></li></c:if>
	  		</ul>
  	</div>
</body>
</html>