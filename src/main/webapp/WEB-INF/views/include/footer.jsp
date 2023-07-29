<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	.footer_box{
		padding:30px 30px;
		border-top:1px solid #000;
		box-sizing:border-box;
		margin-top:50px;
	}
	.ft_wrap{
		overflow:auto;
	}
	#footer_wrap .sec{
		float:left;
		width:30%;
		margin:0
	}
	#footer_wrap #sec2{
		width:auto;
		float:right;
		min-width:400px;
	}
	.sec{
		margin:150px auto;
		overflow:hidden;
	}
	#footer_wrap #sec3{
		float:left;
		width:100%;
	}
	.footer_bottom{
		padding-top:15px;
		font-size:.8rem;
		border-top:1px solid #ddd;
	}
	.po{
		display:inline-block;
	}
	.mo{
		display:none;
	}
	.btn_licensee_info{
		color:#000;
		border-bottom: 1px solid #000;
	}
	#footer_wrap .footer_box .sec .ft-logo img{
		display:block;
		width:100%;
	}
	.mtm{
		margin-top:16px;
	}
	#footer_wrap #sec2 ul li{
		margin:5px auto;
	}
	#footer_wrap #sec2 ul{
		float:left;
		margin-left:50px;
	}
</style>
<body>
	<div id="footer_wrap">
		<div class="footer_box">
			<div class="ft_wrap">
				<div class="sec" id="sec1">
					<a href="/" class="ft-logo">
						<img src="${ctp}/images/musma.png" style="width:300px;" alt="footerLogo">
					</a>
					<ul class="mtm">
						<li>고객센터 : 02-3443-8144</li>
						<li>운영시간 : 08:30 - 16:30 (Mon-Fri)</li>
						<li>점심시간 : 11:30 - 13:30</li>
					</ul>
				</div>
				<div class="sec" id="sec2">
					<ul>
						<li><a href="#">Company</a></li>
						<li><a href="">Contact</a></li>
						<li><a href="">Store</a></li>
						<li><a href="" target="_blank">Career</a></li>
					</ul>
					<ul>
						<li><a href="">C/S</a></li>
						<li><a href="">Membership</a></li>
						<li><a href="">Privacy</a></li>
						<li><a href="">Terms of Service</a></li>
					</ul>
					<ul>
						<li><a href="" target="_blank">Instagram</a></li>
						<li><a href="" target="_blank">Youtube</a></li>
					</ul>
				</div>
				
				<div id="sec3">
					<div class="footer_bottom mtl">
						(주)머스마 | 대표 : 이주협 <span class="po">|</span><br class="mo"> 사업자등록: 123-45-21265 <a href="#" class="btn_licensee_info" onclick="gd_popup_bizInfo('2118721265'); return false;">확인 </a><br>
						통신판매업신고번호: 평양-05242호 | 개인정보관리자: 한승호 | 단골손님: 백현호 | 마이걸프란: 박성윤<span class="po">|</span><br class="mo"> 전화: 02-1234-8144 | 팩스: 02-1234-8148
						<!-- |  주소: 서울특별시 강남구 언주로164길 13  -->
					</div>
				</div>
			</div>
		</div>
	</div>
</body>