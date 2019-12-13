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

<body class="popupWrapper">
	<!--  popupSection -->
	<div class="popupSection">
		<h1>요청게시판
			<div class="txt_info tred">
			${localName}
			</div>
		</h1>

		<!--  contentBox  -->
		<div class="contentBox">
			<div class="dfTable left">
				<table class="tl">
					<colgroup>
						<col style="">
					</colgroup>
					<tbody>
						<input type="hidden" id="receptionNo" name="receptionNo" value="${receptionNo}">
						<input type="hidden" id="franchiseNum" name="franchiseNum" value="${franchiseNum}">
						<tr>
							<th>제목</th>
						</tr>
						<tr>
							<td>
								<input type="text" id="title" name="title" style="width: 95%;">
							</td>
						</tr>
						<tr>
							<th>내용</th>
						</tr>
						<tr>
							<td>
								<textarea id="textContents" name="textContents" cols="50" rows="10" style="width:95%;"></textarea>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
						</tr>
						<tr>
							<td>
								<input type="tel" id="telNo" name="telNo" style="width: 95%;">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="dfTable bot fr">
				<button class="btn m bgbl" id="requestReceptionWrite">완료</button>
			</div>
		</div>
		<!--  //contentBox  -->

	</div>
</body>
</html>