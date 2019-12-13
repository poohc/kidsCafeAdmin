<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<jsp:include page="../common/header.jsp" />
</head>

<body id="mobile_wrap">
	<div class="pages">
		<div data-page="blogsingle" class="page no-toolbar no-navbar">
			<div class="page-content">
				<c:import url="../common/top.jsp">
					<c:param name="menuName" value="<span>슈퍼윙스</span>키즈카페" />
				</c:import>
				<div id="pages_maincontent">
					<a href="/event/list.view" class="backto">
					<img src="${pageContext.request.contextPath}/resources/images/icons/black/back.png" alt="" title="" /></a>
					<h2 class="blog_title">[안양점]생일파티 상차림 이벤트</h2>
					<!-- Slider -->
					<div class="swiper-container-pages swiper-init" data-effect="slide" data-pagination=".swiper-pagination">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<img src="${pageContext.request.contextPath}/resources/images/event/event3.jpg" alt="" title="" />
							</div>
						</div>
						<div class="swiper-pagination"></div>
					</div>
					<div class="page_single layout_fullwidth_padding">
						<div class="post_single">
							<p>★꽃바구니 장식</p>
							<p>★호기와 아리 클레이 케익</p>
							<p>★생일축하 현수막</p>
							<p>★생일자 및 축하객 아트풍선 제공</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>