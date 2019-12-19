<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--menuBox-->
<div class="menuBox">
	<c:choose>
	<c:when test="${param.menuName eq 'memberMenu'}">
	<ul>
		<li <c:if test="${param.menuSelected eq 'list'}">class="on"</c:if>>
			<a href="${pageContext.request.contextPath}/member/memberList.view">
				<span>회원리스트</span>
			</a>
		</li>
		<li <c:if test="${param.menuSelected eq 'search'}">class="on"</c:if>>
			<a href="${pageContext.request.contextPath}/member/memberSearch.view">
				<span>회원검색</span>
			</a>
		</li>
		<li <c:if test="${param.menuSelected eq 'group'}">class="on"</c:if>>
			<a href="${pageContext.request.contextPath}/member/groupMemberList.view">
				<span>단체회원리스트</span>
			</a>
		</li>
	</ul>
	</c:when>
	<c:when test="${param.menuName eq 'salesMenu'}">
		<ul>
			<li <c:if test="${param.menuSelected eq 'today'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/sales/salesToday.view">
					<span>당일매출</span>
				</a>
			</li>
			<li <c:if test="${param.menuSelected eq 'daily'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/sales/salesDaily.view">
					<span>일별매출</span>
				</a>
			</li>
			<li <c:if test="${param.menuSelected eq 'monthly'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/sales/salesMonthly.view">
					<span>월별매출</span>
				</a>
			</li>
			<li <c:if test="${param.menuSelected eq 'pay'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/sales/salesPay.view">
					<span>결제내역관리</span>
				</a>
			</li>
		</ul>
	</c:when>
	<c:when test="${param.menuName eq 'masterMenu'}">
		<ul>
			<li <c:if test="${param.menuSelected eq 'ticket'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/master/ticket.view">
					<span>입장권</span>
				</a>
			</li>
			<li <c:if test="${param.menuSelected eq 'saleTicket'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/master/saleTicket.view">
					<span>할인권설정</span>
				</a>
			</li>
			<li <c:if test="${param.menuSelected eq 'savePercent'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/master/savePercent.view">
					<span>적립률</span>
				</a>
			</li>
			<li <c:if test="${param.menuSelected eq 'food'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/master/food.view">
					<span>푸드</span>
				</a>
			</li>
			<li <c:if test="${param.menuSelected eq 'mdProduct'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/master/mdProduct.view">
					<span>MD상품</span>
				</a>
			</li>
			<li <c:if test="${param.menuSelected eq 'multiTicket'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/master/multiTicket.view">
					<span>다회권</span>
				</a>
			</li>
			<li <c:if test="${param.menuSelected eq 'beverage'}">class="on"</c:if>>
				<a href="${pageContext.request.contextPath}/master/beverage.view">
					<span>음료</span>
				</a>
			</li>
		</ul>
	</c:when> 
	<c:otherwise>
	</c:otherwise>
	</c:choose>
</div>
<!--//menuBox-->