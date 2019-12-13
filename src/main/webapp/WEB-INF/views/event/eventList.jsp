<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
	<jsp:include page="../common/header.jsp" />
</head>

<body id="mobile_wrap">
	<div class="pages">
		<div data-page="blog" class="page no-toolbar no-navbar">
			<div class="page-content">
                <c:import url="../common/top.jsp">
			   		<c:param name="menuName" value="<span>슈퍼윙스</span>키즈카페" />
			    </c:import>
				<div id="pages_maincontent">
					<h2 class="page_title">이벤트안내</h2>
					<div class="page_single layout_fullwidth_padding">
						<div class="posts">
							<div class="post_entry">
								<div class="post_thumb">
									<a href="/event/event1.view">
										<img src="${pageContext.request.contextPath}/resources/images/event/thumb_event1.jpg" alt="" title="" />
									</a>
									<div class="post_thumb_details">
										<a href="" class="open-popup" data-popup=".popup-social">
											<img src="${pageContext.request.contextPath}/resources/images/icons/white/twitter.png" alt="" title="" />
										</a>
									</div>
								</div>
								<div class="post_details">
									<div class="post_category">
										<a href="/event/event1.view" class="bgred">~10.31까지</a>
									</div>
									<h2><a href="/event/event1.view">매일 매일 할로윈데이</a>
									</h2>
									<p>매일 매일 진행되는 할로윈 이벤트에 참여하시고 상품도 받아가세요.</p>
								</div>
							</div>
							<div class="post_entry">
								<div class="post_details">
									<div class="post_category">
										<a href="/event/event2.view" class="bgblue">~11.4까지</a>
									</div>
									<h2><a href="/event/event2.view">할로윈이벤트</a></h2>
									<p>3주간 매일 매일이 할로윈데이</p>
								</div>
								<div class="post_thumb">
									<a href="/event/event2.view">
										<img src="${pageContext.request.contextPath}/resources/images/event/thumb_event2.jpg" alt="" title="" />
									</a>
									<div class="post_thumb_details">
										<a href="" class="open-popup" data-popup=".popup-social">
											<img src="${pageContext.request.contextPath}/resources/images/icons/white/twitter.png" alt="" title="" />
										</a>
									</div>
								</div>
							</div>
							<div class="post_entry">
								<div class="post_thumb">
									<a href="/event/event3.view">
										<img src="${pageContext.request.contextPath}/resources/images/event/thumb_event3.jpg" alt="" title="" />
									</a>
									<div class="post_thumb_details">
										<a href="" class="open-popup" data-popup=".popup-social">
											<img src="${pageContext.request.contextPath}/resources/images/icons/white/twitter.png" alt="" title="" />
										</a>
									</div>
								</div>
								<div class="post_details">
									<div class="post_category">
										<a href="/event/event3.view" class="bgred">~ 계속</a>
									</div>
									<h2><a href="/event/event3.view">[안양점]생일파티 상차림 이벤트</a>
									</h2>
									<p>파티룸 이용시에 생일자 아이들의 생일파티 상차람을 예쁘게 꾸며드려요~^^</p>
								</div>
							</div>
						</div>
						<div id="loadMore">더 보기</div>
						<div id="showLess">마지막</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>