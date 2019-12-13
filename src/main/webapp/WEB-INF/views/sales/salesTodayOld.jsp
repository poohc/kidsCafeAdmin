<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
</head>

<body>
	<div class="wrapper" id="wrapper">
		<!--  headerBox  -->
		<jsp:include page="../common/top.jsp" />

		<!--  contents  -->
		<div id="contents" class="contentBox">
			<!--leftMenu-->
			<c:import url="../common/leftMenu.jsp">
				<c:param name="menuName" value="sales" />
			</c:import>
			<!--//leftMenu-->
			<!--  contentSection  -->
			<div class="contentSection">
				<h2>당일매출</h2>
				<!--  searchBox -->
				<div class="searchBox">
					<!--menuBox-->
					<c:import url="../common/menuDeatil.jsp">
						<c:param name="menuName" value="salesMenu" />
						<c:param name="menuSelected" value="today" />
					</c:import>
					<!--//menuBox-->
				</div>
				<!--  //searchBox -->

				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3>
							당일매출 <span>${year}년 ${month}월 ${date}일</span>
							<div class="tred">* 일 결제내역에서 정산을 완료해야 매출액이 합산됩니다.</div>
						</h3>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>매출지점</th>
								<th>신용카드</th>
								<th>현금</th>
								<th>현금영수증</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty salesInfo}">
									<c:forEach items="${salesInfo}" var="salesInfo">
									<tr>
										<td>${salesInfo.LOCAL_NAME}</td>
										<td><fmt:formatNumber value="${salesInfo.CARD}"         pattern="#,###" /></td>
										<td><fmt:formatNumber value="${salesInfo.CASH}"         pattern="#,###" /></td>
										<td><fmt:formatNumber value="${salesInfo.CASH_RECEIPT}" pattern="#,###" /></td>
										<td><fmt:formatNumber value="${salesInfo.TOTAL_PRICE}"  pattern="#,###" /></td>
									</tr>	
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="5">금일 매출이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!--  //dfTable  -->

				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3>당일방문 집계</h3>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>매출지점</th>
								<th>단체입장</th>
								<th>성인</th>
								<th>아동</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty visitInfo}">
									<c:forEach items="${visitInfo}" var="visitInfo">
									<tr>
										<td>${visitInfo.LOCAL_NAME}</td>
										<td><fmt:formatNumber value="${visitInfo.GROUP_SUM}" pattern="#,###" /></td>
										<td><fmt:formatNumber value="${visitInfo.ADULT_SUM}" pattern="#,###" /></td>
										<td><fmt:formatNumber value="${visitInfo.KIDS_SUM}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${visitInfo.TOTAL_SUM}" pattern="#,###" /></td>
									</tr>	
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="5">당일 방문고객이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!--  //dfTable  -->

				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3>당일소셜 집계</h3>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>매출지점</th>
								<th>2시간아동평일</th>
								<th>2시간아동주말</th>
								<th>성인평일</th>
								<th>성인주말</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty snsVisitInfo}">
									<c:forEach items="${snsVisitInfo}" var="snsVisitInfo">
									<tr>
										<td>${snsVisitInfo.LOCAL_NAME}</td>
										<td><fmt:formatNumber value="${snsVisitInfo.WEEKDAY_KIDS_SUM}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${snsVisitInfo.HOLIDAY_KIDS_SUM}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${snsVisitInfo.WEEKDAY_ADULT_SUM}" pattern="#,###" /></td>
										<td><fmt:formatNumber value="${snsVisitInfo.HOLIDAY_ADULT_SUM}" pattern="#,###" /></td>
									</tr>	
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="5">당일 소셜방문 고객이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!--  //dfTable  -->
			</div>
			<!--  //contentSection  -->
			<!--  //contents-->
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>