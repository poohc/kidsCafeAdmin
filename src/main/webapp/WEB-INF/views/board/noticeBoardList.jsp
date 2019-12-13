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
	<form id="frm" action="${pageContext.request.contextPath}/board/noticeBoard.view" method="post">
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
				<c:param name="menuName" value="notice" />
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
						</colgroup>
						<thead>
							<tr>
								<th>선택</th>
								<th>게시일</th>
								<th>공지번호</th>
								<th>제목</th>
								<th>담당자</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${not empty noticeBoardList}">
							<form id="noticeForm">
							<c:forEach items="${noticeBoardList}" var="noticeBoardList">
							<tr>
								<td>
									<div class="checkBox selectChkDiv noticeDiv">
									<!-- 클릭 시 클래스 on추가 / 포커스시 클래스 focused추가 -->
									<input type="checkbox" id="selectChk" name="selectChk" value="${noticeBoardList.NoticeId}">
										<label class="lab_check"></label>
										<span class="ico check chkOn"></span>
									</div>
								</td>
								<td class="cur" onClick="openNoticeUpdatePopup('${noticeBoardList.NoticeId}');">${noticeBoardList.PostDate}</td>
								<td class="cur" onClick="openNoticeUpdatePopup('${noticeBoardList.NoticeId}');">${noticeBoardList.NoticeId}</td>
								<td class="cur" onClick="openNoticeUpdatePopup('${noticeBoardList.NoticeId}');">${noticeBoardList.Title}</td>
								<td class="cur" onClick="openNoticeUpdatePopup('${noticeBoardList.NoticeId}');">${noticeBoardList.Manager}</td>
							</tr>
							</c:forEach>
							</form>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="5">공지사항이 없습니다.</td>
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
				<c:if test="${sessionScope.franchiseInfoVo.franchiseeStatus eq '1'}">
				<div class="dfTable bot">
					<div class="fr">
						<button class="btn m lngy" id="noticeWritePopup">글쓰기</button>
						<button class="btn m bgbk" id="deleteNotice">삭제</button>
					</div>
				</div>
				</c:if>
				<!--  //contentSection  -->
			</div>
			<!--  //contents-->
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>