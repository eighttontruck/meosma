<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	.header{
		width:100%;
		display:flex;
		justify-content:space-between;
		height:70px;
		line-height:70px;
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
		border-color:lightgray;
		border-width: 0.5px 0px 0.5px 0px;
		background-color:white;
		opacity:0.95;
	}
	
	.navBtn{
		width:100px;
		height:100%;
		margin: 0px 20px;
		background-color:white;
		border:none;
		border-bottom:2px solid white;
	}
	.navBtn:hover{
		border-bottom:2px solid black;
	}
	.borderBottom2{
		border-bottom:2px solid black;
	}
</style>
<body>
	<div class="header">
		<div>
			<a href="${ctp}/goods/drawList">응모</a>
			<a href="#">매장 정보</a>
			<a href="#">에디토리얼</a>
			<a href="${ctp}/admin/adminMain">관리자페이지</a>
		</div>
		<div class="text-center">
			<a href="${ctp}/"><img src="${ctp}/images/musma.png" style="width:200px; margin-top:5px;"></a>
		</div>
		<div class="text-right">
			<a href="#">검색</a>
			<a href="#">관심목록</a>
			<a href="${ctp}/goods/cart">장바구니</a>
			<c:if test="${empty sLevel}">
				<a href="${ctp}/member/memberLogin">로그인</a>
			</c:if>
			<c:if test="${!empty sLevel}">
				<a href="${ctp}/member/memberMyPage">마이페이지</a>
			</c:if>
			<c:if test="${!empty sLevel}">
				<a href="${ctp}/member/memberLogOut">로그아웃</a>
			</c:if>
		</div>
	</div>
	<div id="navbar">
		<div><button type="button" class="navBtn <c:if test="${brand_Idx == 0 and mainCategory_Idx == 1}">borderBottom2</c:if>" onclick="location.href='${ctp}/goods/goodsList?mainCategory_Idx=1'">남성</button></div>
		<div><button type="button" class="navBtn <c:if test="${brand_Idx == 0 and mainCategory_Idx == 2}">borderBottom2</c:if>" onclick="location.href='${ctp}/goods/goodsList?mainCategory_Idx=2'">여성</button></div>
		<div><button type="button" class="navBtn <c:if test="${brand_Idx == 0 and mainCategory_Idx == 3}">borderBottom2</c:if>" onclick="location.href='${ctp}/goods/goodsList?mainCategory_Idx=3'">생활</button></div>
		<div><button type="button" class="navBtn <c:if test="${brand_Idx != 0 and brand_Idx ne null}">borderBottom2</c:if>" onclick="location.href='${ctp}/goods/brandList'">브랜드</button></div>
		<div><button type="button" class="navBtn">세일</button></div>
	</div>
</body>