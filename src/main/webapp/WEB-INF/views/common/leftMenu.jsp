<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="leftMenu">
	<ul>
		<!-- 클릭 시 클래스 on추가-->
		
		<li <c:if test="${param.menuName eq 'dashboard'}">class="on"</c:if> id="goDash" style="cursor: pointer">
			<a href="${pageContext.request.contextPath}/main/dashboard.view">
				현황판
				<c:choose>
					<c:when test="${param.menuName eq 'dashboard'}">
					<i class="ico right">on</i>
					</c:when>
					<c:otherwise>
					<i class="ico right">off</i>
					</c:otherwise>
				</c:choose>
			</a>
		</li>
		<li <c:if test="${param.menuName eq 'member'}">class="on"</c:if> id="goMem" style="cursor: pointer">
			<a href="${pageContext.request.contextPath}/member/memberList.view">
				회원관리
				<c:choose>
					<c:when test="${param.menuName eq 'member'}">
					<i class="ico right">on</i>
					</c:when>
					<c:otherwise>
					<i class="ico right">off</i>
					</c:otherwise>
				</c:choose>
			</a>
		</li>
		<li <c:if test="${param.menuName eq 'sales'}">class="on"</c:if> id="goSale" style="cursor: pointer">
			<a href="${pageContext.request.contextPath}/sales/salesToday.view">
				매출관리
				<c:choose>
					<c:when test="${param.menuName eq 'sales'}">
					<i class="ico right">on</i>
					</c:when>
					<c:otherwise>
					<i class="ico right">off</i>
					</c:otherwise>
				</c:choose>
			</a>
		</li>
<!-- 		<li id="goMaster" style="cursor: pointer"> -->
<%-- 			<a href="${pageContext.request.contextPath}/master/ticket.view"> --%>
<!-- 				마스터관리<i class="ico right">off</i> -->
<!-- 			</a> -->
<!-- 		</li> -->
<!-- 		<li id="goMulti" style="cursor: pointer"> -->
<!-- 			<a> -->
<!-- 				다회권관리<i class="ico right">off</i> -->
<!-- 			</a> -->
<!-- 		</li> -->
<!-- 		<li id="goFran" style="cursor: pointer"> -->
<!-- 			<a> -->
<!-- 				가맹점관리<i class="ico right">off</i> -->
<!-- 			</a> -->
<!-- 		</li> -->
		<li <c:if test="${param.menuName eq 'request'}">class="on"</c:if> id="goAs" style="cursor: pointer">
			<a href="${pageContext.request.contextPath}/board/requestBoard.view">
				요청게시판
				<c:choose>
					<c:when test="${param.menuName eq 'request'}">
					<i class="ico right">on</i>
					</c:when>
					<c:otherwise>
					<i class="ico right">off</i>
					</c:otherwise>
				</c:choose>
			</a>
		</li>
		<li <c:if test="${param.menuName eq 'notice'}">class="on"</c:if> id="goNotice" style="cursor: pointer">
			<a href="${pageContext.request.contextPath}/board/noticeBoard.view">
				공지알림
				<c:choose>
					<c:when test="${param.menuName eq 'notice'}">
					<i class="ico right">on</i>
					</c:when>
					<c:otherwise>
					<i class="ico right">off</i>
					</c:otherwise>
				</c:choose>
			</a>
		</li>
		<li <c:if test="${param.menuName eq 'franchise'}">class="on"</c:if> id="goFranchise" style="cursor: pointer">
			<a href="${pageContext.request.contextPath}/franchise/franchiseInfo.view">
				매장현황
				<c:choose>
					<c:when test="${param.menuName eq 'franchise'}">
					<i class="ico right">on</i>
					</c:when>
					<c:otherwise>
					<i class="ico right">off</i>
					</c:otherwise>
				</c:choose>
			</a>
		</li>
<!-- 		<li id="goVoc" style="cursor: pointer"> -->
<!-- 			<a> -->
<!-- 				고객의소리<i class="ico right">off</i> -->
<!-- 			</a> -->
<!-- 		</li> -->
	</ul>
</div>