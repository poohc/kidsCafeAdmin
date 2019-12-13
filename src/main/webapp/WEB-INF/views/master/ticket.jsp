<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/memberHeader.jsp" />
</head>

<body>
	<form id="frm" action="${pageContext.request.contextPath}/member/memberList.view" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value="${currentPage}">
		<input type="hidden" id="franchiseNum" name="franchiseNum">
	</form>
	<div class="wrapper" id="wrapper">
		<!--  headerBox  -->
		<jsp:include page="../common/top.jsp" />

		<!--  contents  -->
		<div id="contents" class="contentBox">
			<!--leftMenu-->
			<jsp:include page="../common/leftMenu.jsp" />
			<!--//leftMenu-->
			 <!--  contentSection  -->
			<div class="contentSection">
				<h2>입장권 설정</h2>
				<!--  searchBox -->
				<div class="searchBox">
					<!--menuBox-->
					<c:import url="../common/menuDeatil.jsp">
						<c:param name="menuName"     value="masterMenu" />
						<c:param name="menuSelected" value="ticket" />
					</c:import>
					<!--//menuBox-->
				</div>

				<!--  //searchBox -->

				<!--  dfTable  -->
				<div class="dfTable">
					<table>

						<colgroup>
							<col width="50px;">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>선택</th>
								<th>입장권명</th>
								<th>이용시간(단위:시간)</th>
								<th>금액</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${not empty ticketList}">
							<c:forEach items="${ticketList}" var="ticketList">
							<tr>
								<td>
									<div class="checkBox">
										<input type="checkbox">
										<label class="lab_check"></label> 
										<span class="ico check"></span>
									</div>
								</td>
								<td>${ticketList.TicketName}</td>
								<td>${ticketList.TicketPlayTime}</td>
								<td>${ticketList.TicketPrice}</td>
							</tr>
							</c:forEach>
							</c:when>
							<c:otherwise>
							</c:otherwise>
							<tr>
								<td colspan="4">입장권 정보가 없습니다.</td>
							</tr>		
							</c:choose>					
						</tbody>
					</table>
				</div>
				<!--  //dfTable  -->
				<div class="dfTable bot">
					<div class="fr">
						<button class="btn m bgbl" id="ticketDeleteBtn">선택삭제</button>
						<button class="btn m lnbl" onclick="openTicketPopup();">추가</button>
					</div>
				</div>

				<!--  //contentSection  -->
			</div>

			<!--  //contents-->
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>