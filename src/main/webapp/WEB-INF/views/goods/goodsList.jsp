<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,user-scalable=no, viewport-fit=cover" />
 	<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
 	<link rel="icon" href="${ctp}/resources/images/tabimage.png">
 	<link rel="apple-touch-icon" href="${ctp}/resources/images/tabimage.png">
	<title>머스마(Musma) - 글로벌 멀티 컬쳐 선두주자 나야나</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<style>
	html,
      body {
        height: 100%;
        padding: 0px;
        margin: 0px;
      }

      header {
        height: 120px;
      }

      .wrap {
        min-height: calc(100% - 120px);
      }

      footer {
        height: 284px;
      }
	.header{
		width:100%;
		display:flex;
		justify-content:space-between;
		height:70px;
		line-height:70px;
		position: fixed;
		top: 0;
		background-color:white;
		opacity:0.95;
	}
	.header > div{ /* 자식 선택자는 > 자손 선택자는 띄어쓰기 */
		width:100%;
	}
	.header a{
		margin: 0px 20px;
	}
	#navbar{
		width:100%;
		height:50px;
		display:flex;
		justify-content:center;
		border-style: solid;
		border-width: 0.5px 0px 0px 0px;
		position: fixed;
		top: 70;
		background-color:white;
		opacity:0.95;
	}
	.productList{
		/* display:flex;
		flex-direction:row;
		flex-wrap:wrap;
		justify-content:space-evenly;
		justify-content: flex-start;
  		align-items: flex-start;
		padding:300px 2% 0 4%; 
		gap:10px; */
		margin-top:40px;
		display:grid;
		grid-template-columns:repeat(5,1fr);
		grid-gap:48px 24px;
		padding:0 2%;
	}
	@media screen and (max-width: 1440px) {
		.productList{
			display:grid;
			grid-template-columns:repeat(4,1fr);
			grid-gap:48px 24px;
		}
	}
	@media screen and (max-width: 1200px) { 
		.productList{
			display:grid;
			grid-template-columns:repeat(2,1fr);
			grid-gap:48px 24px;
		}
	}
	.flex{
		display:flex;
		justify-content: center;
	}
	img{
		width:100%;
	}
	.productDiv{
		width:100%; /* 반응협 만들때 19%주면 됨*/ 
		margin-bottom:40px;
	}
	p{
		margin:0;
	}
	#categoryDiv{
		margin:0 auto;
		margin-top:20px;
		border-bottom:1px solid lightgray;
		padding-bottom:20px;
	}
	.categoryBtn{
		border:none;
		background-color:white;
		border-bottom:1px solid white;
		margin-left:10px;
	}
	.categoryBtn:hover{
		border-bottom:1px solid black;
	}
	.borderBottom{
		border-bottom:1px solid black;
	}
</style>
<body>
	<header><jsp:include page="/WEB-INF/views/include/header.jsp" /></header>
	<div class="wrap">
		<div id="categoryDiv">
			<div class="text-center mb-2">
				<c:if test="${mainCategory ne null}">
					<h5>${brandVO.name}</h5>
				</c:if>
				<c:if test="${subCategory ne null}">
					<h5>${subCategory[0].mainCategory_Name}</h5>
				</c:if>
				<c:if test="${secondCategory ne null}">
					<h5>${secondCategory[0].subCategory_Name}</h5>
				</c:if>
			</div>
			<div class="flex">
				<c:if test="${mainCategory ne null}">
					<button type="button" class="categoryBtn <c:if test="${mainCategory_Idx == 0}">borderBottom</c:if>" onclick="location.href='${ctp}/goods/goodsList?brand_Idx=${brandVO.idx}&mainCategory_Idx=${subCategory[0].mainCategory_Idx}'">전체</button>
					<c:forEach var="vo" items="${mainCategory}" varStatus="st">
						<button type="button" class="categoryBtn" onclick="location.href='${ctp}/goods/goodsList?brand_Idx=${brandVO.idx}&mainCategory_Idx=${vo.category_Idx}'">${vo.category_Name}</button>
					</c:forEach>
				</c:if>
				<c:if test="${subCategory ne null}">
					<button type="button" class="categoryBtn <c:if test="${subCategory_Idx == 0}">borderBottom</c:if>" onclick="location.href='${ctp}/goods/goodsList?brand_Idx=${brandVO.idx}&mainCategory_Idx=${subCategory[0].mainCategory_Idx}'">전체</button>
					<c:forEach var="vo" items="${subCategory}" varStatus="st">
						<button type="button" class="categoryBtn" onclick="location.href='${ctp}/goods/goodsList?brand_Idx=${brandVO.idx}&mainCategory_Idx=${vo.mainCategory_Idx}&subCategory_Idx=${vo.subCategory_Idx}'">${vo.subCategory_Name}</button>
					</c:forEach>
				</c:if>
				<c:if test="${secondCategory ne null}">
					<button type="button" class="categoryBtn <c:if test="${secondCategory_Idx == 0}">borderBottom</c:if>" onclick="location.href='${ctp}/goods/goodsList?brand_Idx=${brandVO.idx}&mainCategory_Idx=${secondCategory[0].mainCategory_Idx}&subCategory_Idx=${secondCategory[0].subCategory_Idx}'">전체</button>
					<c:forEach var="vo" items="${secondCategory}" varStatus="st">
						<button type="button" class="categoryBtn <c:if test="${vo.secondCategory_Idx == secondCategory_Idx}">borderBottom</c:if>" onclick="location.href='${ctp}/goods/goodsList?brand_Idx=${brandVO.idx}&mainCategory_Idx=${vo.mainCategory_Idx}&subCategory_Idx=${vo.subCategory_Idx}&secondCategory_Idx=${vo.secondCategory_Idx}'">${vo.secondCategory_Name}</button>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<div class="productList">
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<div class="productDiv">
					<div>
						<a href="${ctp}/goods/goodsViews?idx=${vo.idx}">
							<img src="${ctp}/images/${vo.thumbNail}">
						</a>
					</div>
					<div>
						<a href="${ctp}/goods/goodsList?brand_Idx=${vo.brand_Idx}"><span>${vo.brand_Name}</span></a><br>
						<a href="${ctp}/goods/goodsViews?idx=${vo.idx}"><span>${vo.name}</span></a>
						<p>₩<fmt:formatNumber value="${vo.price}" pattern="#,###"/></p>
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="text-center m-4">
		    <ul class="pagination justify-content-center pagination-sm">
		       <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/goods/goodsList?pageSize=${pageVO.pageSize}&pag=1&brand_Idx=${brand_Idx}&mainCategory_Idx=${mainCategory_Idx}&subCategory_Idx=${subCategory_Idx}&secondCategory_Idx=${secondCategory_Idx}">첫페이지</a></li></c:if>
		       <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/goods/goodsList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&brand_Idx=${brand_Idx}&mainCategory_Idx=${mainCategory_Idx}&subCategory_Idx=${subCategory_Idx}&secondCategory_Idx=${secondCategory_Idx}">이전블록</a></li></c:if>
		       <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	               <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/goods/goodsList?pageSize=${pageVO.pageSize}&pag=${i}&brand_Idx=${brand_Idx}&mainCategory_Idx=${mainCategory_Idx}&subCategory_Idx=${subCategory_Idx}&secondCategory_Idx=${secondCategory_Idx}">${i}</a></li></c:if>
		           <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/goods/goodsList?pageSize=${pageVO.pageSize}&pag=${i}&brand_Idx=${brand_Idx}&mainCategory_Idx=${mainCategory_Idx}&subCategory_Idx=${subCategory_Idx}&secondCategory_Idx=${secondCategory_Idx}">${i}</a></li></c:if>
		       </c:forEach>
		       <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/goods/goodsList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&brand_Idx=${brand_Idx}&mainCategory_Idx=${mainCategory_Idx}&subCategory_Idx=${subCategory_Idx}&secondCategory_Idx=${secondCategory_Idx}">다음블록</a></li></c:if>
		       <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/goods/goodsList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}&brand_Idx=${brand_Idx}&mainCategory_Idx=${mainCategory_Idx}&subCategory_Idx=${subCategory_Idx}&secondCategory_Idx=${secondCategory_Idx}">마지막페이지</a></li></c:if>
		    </ul>
	    </div>
	</div>
	<footer><jsp:include page="/WEB-INF/views/include/footer.jsp" /></footer>
</body>
</html>