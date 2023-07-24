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
	#navbar button{ /* 앞으로 이렇게 작성하자 */
		width:100px;
		height:100%;
		margin: 0 20;
		background-color:white;
		border:none;
	}
	#navbar button:hover{
  		border-style: solid;
		border-width: 0px 0px 2px 0px ;
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
		margin-top:200px;
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
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="productList">
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<div class="productDiv">
				<div>
					<a href="${ctp}/goods/goodsViews?idx=${vo.idx}&secCate_Idx=${vo.secondCatagory_Idx}">
						<img src="${ctp}/images/${vo.thumbNail}">
					</a>
				</div>
				<div>
					<a href="${ctp}/goods/goodsViews?brand_Idx=${vo.brand_Idx}"><span>${vo.brand_Name}</span></a><br>
					<a href="${ctp}/goods/goodsViews?idx=${vo.idx}&secCate_Idx=${vo.secondCatagory_Idx}"><span>${vo.name}</span></a>
					<p>₩<fmt:formatNumber value="${vo.price}" pattern="#,###"/></p>
				</div>
			</div>
		</c:forEach>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>