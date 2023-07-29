<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
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
	
</script>
<style>
	html, body, th, td, input, select, textarea, button {
	    font-family: 'Pretendard', -apple-system, system-ui, sans-serif;
	    color: var(--text);
	    font-size: 1rem;
	    font-weight: normal;
	    line-height: 1.7;
	}
	*, body, div, dl, dt, dd, ul, ol, li, pre, code, blockquote, th, td, h1, h2, h3, h4, h5, h6, legend, textarea, p, form, fieldset, input, select, button :not(.header){
	    margin: 0;
	    padding: 0;
	    word-break: keep-all;
	    letter-spacing: -.2px;
	    outline: none;
	    box-sizing: border-box;
	}
	.myPageTlt, .pageTlt {
	    margin: 25px auto;
	}
	.pageTlt h2 {
	    font-size: 2.5rem;
	    text-transform: uppercase;
	}
	.brandWrap .brandList h3.tlt {
		padding-top:10px;
	    font-size: 2.7rem;
	    font-weight: bold;
	    border-top: 1px solid #ddd;
	}
	.brandWrap .brandList h3.tltTop {
	    border: 0;
	} 
	.brandWrap {
	    width: 100%;
	    margin: 50px auto;
	    font-size: 0;
	    overflow: hidden;
	}
	.brandWrap .brandList {
	    display: inline-block;
	    width: 20%;
	    height: auto;
	    margin-bottom: 50px;
	    vertical-align: top;
	    overflow: hidden;
	} 
	.brandWrap * {
	    text-transform: uppercase;
	} 
	.brandWrap .brandList:last-child {
	    display: none;
	}
	.pageTlt h2 {
	    font-size: 2.5rem;
	    text-transform: uppercase;
	}
	.sideBlank {
	    padding: 0 48px;
	}
	.brandWrap .brandList .brandLink li {
	    margin-bottom: 3px;
	    font-size: 1rem;
	}
</style>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div id="container">
	    <div id="contents">
	        <div class="sub_content">
				<div class="content_box sideBlank">
				    <div class="pageTlt">
				        <h2>BRAND LIST</h2>
				    </div>
				
				    <ul class="brandWrap">
				        <li class="brandList">
				            <h3 class="tlt tltTop">A</h3>
				            <ul class="brandLink">
				            	<c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('A') or brand.name.startsWith('a')}">
					            		<li class="b128"><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt tltTop">B</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('B') or brand.name.startsWith('b')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt tltTop notTop">C</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('C') or brand.name.startsWith('c')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt tltTop notTop">D</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('D') or brand.name.startsWith('d')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt tltTop notTop">E</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('E') or brand.name.startsWith('e')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">F</h3>
				            <ul class="brandLink">
				            	<c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('F') or brand.name.startsWith('f')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">G</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('G') or brand.name.startsWith('g')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">H</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('H') or brand.name.startsWith('h')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">I</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('I') or brand.name.startsWith('i')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">J</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('J') or brand.name.startsWith('j')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">K</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('K') or brand.name.startsWith('k')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">L</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('L') or brand.name.startsWith('l')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">M</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('M') or brand.name.startsWith('m')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">N</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('N') or brand.name.startsWith('n')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">O</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('O') or brand.name.startsWith('o')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">P</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('P') or brand.name.startsWith('p')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">Q</h3>
				            <ul class="brandLink">
				            	<c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('Q') or brand.name.startsWith('q')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">R</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('R') or brand.name.startsWith('r')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">S</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('S') or brand.name.startsWith('s')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">T</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('T') or brand.name.startsWith('t')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">U</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('U') or brand.name.startsWith('u')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">V</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('V') or brand.name.startsWith('v')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">W</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('W') or brand.name.startsWith('w')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">Y</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('Y') or brand.name.startsWith('y')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList">
				            <h3 class="tlt">Z</h3>
				            <ul class="brandLink">
				                <c:forEach var="brand" items="${vos}" varStatus="st">
				            		<c:if test="${brand.name.startsWith('Z') or brand.name.startsWith('z')}">
					            		<li ><a href="${ctp}/goods/goodsList?brand_Idx=${brand.idx}">${brand.name}</a></li>
				            		</c:if>
				            	</c:forEach>
				            </ul>
				        </li>
				
				        <li class="brandList mo">
				            <h3 class="tlt"></h3>
				            <ul><li></li></ul>
				        </li>
				
				    </ul>
	
				</div>
	
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>