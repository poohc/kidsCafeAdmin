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
			<c:import url="../common/leftMenu.jsp">
				<c:param name="menuName" value="member" />
			</c:import>
			
			<!--//leftMenu-->
			<!--  contentSection  -->
			<div class="contentSection">
				<h2>회원리스트</h2>
				<!--  searchBox -->
				<div class="searchBox">
					<!--menuBox-->
					<c:import url="../common/menuDeatil.jsp">
						<c:param name="menuName"     value="memberMenu" />
						<c:param name="menuSelected" value="list" />
					</c:import>
					<!--//menuBox-->
					<c:choose>
					<c:when test="${sessionScope.franchiseInfoVo.franchiseeStatus eq '1'}">
					<table>
						<colgroup>
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<td>
									<div class="selectBox">
										<select id="selectedFranchise">
											<option value="" selected="selected">가맹점 리스트</option>
											<c:forEach items="${franchiseList}" var="franchiseList">
												<option value="${franchiseList.FranchiseeNum}" <c:if test="${franchiseList.FranchiseeNum eq selectedFrachiseNum}">selected="selected"</c:if>>${franchiseList.LocalName}</option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					</c:when>
					<c:otherwise>
						<input type="hidden" id="selectedFranchise" name="selectedFranchise" value="${sessionScope.franchiseInfoVo.franchiseeNum}">
					</c:otherwise>
					</c:choose>
				</div>
				<!--  //searchBox -->
				
				<div style="font-weight: bold;margin-left: 10px;">회원 수 : <fmt:formatNumber value="${totalCount}" pattern="#,###" /></div><br/>
				
				<!--  dfTable  -->
				<div class="dfTable">
					<table>
						<colgroup>
							<col width="">
<%-- 							<col width=""> --%>
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>회원명</th>
<!-- 								<th>고객번호 ‘19자리’</th> -->
								<th>가입일</th>
								<th>전화번호</th>
								<th>가족수</th>
								<th>가입매장</th>
								<th>최근방문일</th>
								<th>최근방문매장</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${not empty memberList}">
							<c:forEach items="${memberList}" var="memberList">
							<tr>
								<td class="">${memberList.Name}</td>
<%-- 								<td class="">${memberList.MCode}</td> --%>
								<td class="">${memberList.JoinDate}</td>
								<td class="">${memberList.Phone}</td>
								<td class="">${memberList.Num}</td>
								<td class="">${memberList.fName}</td>
								<td class="">${memberList.LastVisit}</td>
								<td class="">${memberList.lastVisitFname}</td>
							</tr>
							</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="7">검색된 회원 정보가 없습니다.</td>
							</tr>
							</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!--  //dfTable  -->
				<div class="dffooterBox">
					<div class="fl">
						<span class="btn m lngr">
							<a href="javascript:excelDownload();">
								<i class="ico exl"></i>액셀로 내보내기
							</a>
						</span>
					</div>
					<!-- pagingBox -->
					<div class="pagingBox fr">
						<c:choose>
						<c:when test="${not empty pagingTag}">
							${pagingTag}
						</c:when>
						<c:otherwise>
							
						</c:otherwise>
						</c:choose>
					</div>
					<!-- //pagingBox -->

				</div>

				<!--  //contentSection  -->
			</div>
			<!--  //contents-->
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>