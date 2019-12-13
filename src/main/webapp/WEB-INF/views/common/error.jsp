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
		<div data-page="about" class="page no-toolbar no-navbar">
			<div class="page-content">
				<c:import url="../common/top.jsp">
					<c:param name="menuName" value="<span>슈퍼윙스</span>키즈카페" />
				</c:import>

				<div id="pages_maincontent">
					<h2 class="page_title">오류가 발생했습니다.</h2>
					<div class="page_single layout_fullwidth_padding">
						<ul class="features_list">
							<li>
								<a href="/main/intro.view">
									<span>메인페이지로 이동</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>