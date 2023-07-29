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
	.productList{
		/* display:flex;
		flex-direction:row;
		flex-wrap:wrap;
		justify-content:space-evenly;
		justify-content: flex-start;
  		align-items: flex-start;
		padding:300px 2% 0 4%; 
		gap:10px; */
		margin-top:20px;
		display:grid;
		grid-template-columns:repeat(4,1fr);
		grid-gap:20px 20px;
		padding:0 20px;
	}
	@media screen and (max-width: 1440px) {
		.productList{
			display:grid;
			grid-template-columns:repeat(3,1fr);
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
		margin-top:140px;
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
	.mainBanner{
		margin-top:120px;
		padding: 20px 20px 0px 20px;
	}
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="mainBanner"><img src="${ctp}/images/mainbanner.jpg"></div>
	<div class="productList">
		<div><img src="${ctp}/images/banner1.jpg"></div>
		<div><img src="${ctp}/images/banner2.jpg"></div>
		<div><img src="${ctp}/images/banner3.jpg"></div>
		<div><img src="${ctp}/images/banner4.jpg"></div>
		<div><img src="${ctp}/images/banner5.jpg"></div>
		<div><img src="${ctp}/images/banner6.jpg"></div>
		<div><img src="${ctp}/images/banner7.jpg"></div>
		<div><img src="${ctp}/images/banner8.jpg"></div>
		<div><img src="${ctp}/images/banner9.jpg"></div>
		<div><img src="${ctp}/images/banner10.jpg"></div>
		<div><img src="${ctp}/images/banner11.jpg"></div>
		<div><img src="${ctp}/images/banner12.jpg"></div>
		<div><img src="${ctp}/images/banner13.jpg"></div>
		<div><img src="${ctp}/images/banner14.jpg"></div>
		<div><img src="${ctp}/images/banner15.jpg"></div>
		<div><img src="${ctp}/images/banner16.jpg"></div>
		<div><img src="${ctp}/images/banner17.jpg"></div>
		<div><img src="${ctp}/images/banner18.jpg"></div>
		<div><img src="${ctp}/images/banner25.jpg"></div>
		<div><img src="${ctp}/images/banner26.JPG"></div>
		<div><img src="${ctp}/images/banner21.jpg"></div>
		<div><img src="${ctp}/images/banner22.jpg"></div>
		<div><img src="${ctp}/images/banner23.jpg"></div>
		<div><img src="${ctp}/images/banner24.jpg"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>