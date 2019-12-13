<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/boardHeader.jsp" />
</head>

<body>
	<form id="frm" action="${pageContext.request.contextPath}/board/requestBoard.view" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value="${currentPage}">
		<input type="hidden" id="franchiseNum" name="franchiseNum" value="${franchiseNum}">
	</form>
	<div class="wrapper" id="wrapper">
		<!--  headerBox  -->
		<jsp:include page="../common/top.jsp" />

		<!--  contents  -->
		<div id="contents" class="contentBox">
			<!--leftMenu-->
			<c:import url="../common/leftMenu.jsp">
				<c:param name="menuName" value="request" />
			</c:import>
			
			<!--//leftMenu-->
			<!--  contentSection  -->
			<div class="contentSection">
				<h2>요청게시판</h2>
				
				<!--  dfTable  -->
				<div class="dfTable">
					<table>
						<colgroup>
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>선택</th>
								<th>접수일</th>
								<th>접수번호</th>
								<th>지점명</th>
								<th>제목</th>
								<th>내용</th>
								<th>연락처</th>
								<th>처리일</th>
								<th>처리결과</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${not empty requestBoardList}">
							<form id="requestBoardForm">
							<c:forEach items="${requestBoardList}" var="requestBoardList">
							<tr>
								<td>
									<div class="checkBox selectChkDiv requestDiv">
									<!-- 클릭 시 클래스 on추가 / 포커스시 클래스 focused추가 -->
									<input type="checkbox" id="selectChk" name="selectChk" value="${requestBoardList.IndexNo}">
										<label class="lab_check"></label>
										<span class="ico check chkOn"></span>
									</div>
								</td>
								<td class="cur" onClick="openRequestProcessingPopup('${requestBoardList.IndexNo}');">${requestBoardList.ReceptionDate}</td>
								<td class="cur" onClick="openRequestProcessingPopup('${requestBoardList.IndexNo}');">${requestBoardList.ReceptionNo}</td>
								<td class="cur" onClick="openRequestProcessingPopup('${requestBoardList.IndexNo}');">${requestBoardList.fName}</td>
								<td class="cur" onClick="openRequestProcessingPopup('${requestBoardList.IndexNo}');">${requestBoardList.Title}</td>
								<td class="cur" onClick="openRequestProcessingPopup('${requestBoardList.IndexNo}');">${requestBoardList.Contents}</td>
								<td class="cur" onClick="openRequestProcessingPopup('${requestBoardList.IndexNo}');">${requestBoardList.TelNo}</td>
								<td class="cur" onClick="openRequestProcessingPopup('${requestBoardList.IndexNo}');">${requestBoardList.ProcessingDate}</td>
								<td class="cur" onClick="openRequestProcessingPopup('${requestBoardList.IndexNo}');">${requestBoardList.ProcessingResult}</td>
							</tr>
							</c:forEach>
							</form>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="9">요청 게시물이 없습니다.</td>
							</tr>
							</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!--  //dfTable  -->
				<div class="dffooterBox">
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
				
				<div class="dfTable bot">
					<div class="fr">
						<button class="btn m lngy" id="requestReceptionPopup">접수</button>
						<c:if test="${sessionScope.franchiseInfoVo.franchiseeStatus eq '1'}">	
						<button class="btn m bgbk" id="deleteRequest">삭제</button>
						</c:if>
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