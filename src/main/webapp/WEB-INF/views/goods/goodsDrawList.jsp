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
</style>
<body>
	<header><jsp:include page="/WEB-INF/views/include/header.jsp" /></header>
	<div class="wrap">
		
		
		
	</div>
	<footer><jsp:include page="/WEB-INF/views/include/footer.jsp" /></footer>
</body>
</html>