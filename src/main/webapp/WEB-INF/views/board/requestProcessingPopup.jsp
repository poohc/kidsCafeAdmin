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
		<h1>A/S업무
			<div class="txt_info tred"></div>
		</h1>

		<!--  contentBox  -->
		<c:choose>
		<c:when test="${sessionScope.franchiseInfoVo.franchiseeStatus eq '1'}">
		<div class="contentBox">
			<div class="dfTable left">
				<table class="tl">
					<colgroup>
						<col style="width: 160px">
						<col style="width: 160px">
					</colgroup>
					<tbody>
						<input type="hidden" id="franchiseeNum" name="franchiseeNum" value="${FranchiseeNum}">
						<input type="hidden" id="indexNo" name="indexNo" value="${requestBoardInfo.IndexNo}">
						<tr>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">접수번호</th>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">연락처(-없이 입력해주세요)</th>
						</tr>
						<tr>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">${requestBoardInfo.ReceptionNo}</td>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">${requestBoardInfo.TelNo}</td>
						</tr>
						<tr>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">지점명</th>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">제목</th>
						</tr>
						<tr>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">${requestBoardInfo.fName}</td>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">${requestBoardInfo.Title}</td>
						</tr>
						<tr>
							<th colspan="2" style="border-right: groove;border-bottom-style: groove;text-align: left;">내용</th>
						</tr>
						<tr>
							<td colspan="2" style="border-right: groove;border-bottom-style: groove;text-align: left;">${requestBoardInfo.Contents}</td>
						</tr>
						<tr>
							<th colspan="2" style="border-right: groove;border-bottom-style: groove;text-align: left;">처리결과</th>
						</tr>
						<tr>
							<td colspan="2" style="border-right: groove;border-bottom-style: groove;text-align: left;">
								<select id="processingResult" name="processingResult">
									<option value="접수" <c:if test="${requestBoardInfo.ProcessingResult eq '접수'}">selected="selected"</c:if>>접수</option>
									<option value="조치불가" <c:if test="${requestBoardInfo.ProcessingResult eq '조치불가'}">selected="selected"</c:if>>조치불가</option>
									<option value="A/S완료(유상)" <c:if test="${requestBoardInfo.ProcessingResult eq 'A/S완료(유상)'}">selected="selected"</c:if>>A/S완료(유상)</option>
									<option value="A/S완료(무상)" <c:if test="${requestBoardInfo.ProcessingResult eq 'A/S완료(무상)'}">selected="selected"</c:if>>A/S완료(무상)</option>
									<option value="기타" <c:if test="${requestBoardInfo.ProcessingResult eq '기타'}">selected="selected"</c:if>>기타</option>
								</select>
							</td>
						</tr>
						<tr class="etcProcess">
							<th colspan="2" style="border-right: groove;border-bottom-style: groove;text-align: left;">기타입력</th>
						</tr>
						<tr class="etcProcess">
							<td colspan="2" style="border-right: groove;border-bottom-style: groove;text-align: left;">
								<input type="text" id="etcProcess" name="etcProcess" value="${requestBoardInfo.Etc}" style="width: 98%">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="dfTable bot fr">
				<button class="btn m bgbl" id="processingComplete">완료</button>
			</div>
		</div>
		</c:when>
		<c:otherwise>
		<div class="contentBox">
			<div class="dfTable left">
				<table class="tl">
					<colgroup>
						<col style="width: 160px">
						<col style="width: 160px">
					</colgroup>
					<tbody>
						<tr>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">접수번호</th>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">연락처</th>
						</tr>
						<tr>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">${requestBoardInfo.ReceptionNo}</td>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">${requestBoardInfo.TelNo}</td>
						</tr>
						<tr>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">지점명</th>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">제목</th>
						</tr>
						<tr>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">${requestBoardInfo.fName}</td>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">${requestBoardInfo.Title}</td>
						</tr>
						<tr>
							<th colspan="2" style="border-right: groove;border-bottom-style: groove;text-align: left;">내용</th>
						</tr>
						<tr>
							<td colspan="2" style="border-right: groove;border-bottom-style: groove;text-align: left;">${requestBoardInfo.Contents}</td>
						</tr>
						<tr>
							<th colspan="2" style="border-right: groove;border-bottom-style: groove;text-align: left;">처리결과</th>
						</tr>
						<tr>
							<td colspan="2" style="border-right: groove;border-bottom-style: groove;text-align: left;">
								${requestBoardInfo.ProcessingResult}
							</td>
						</tr>
					</tbody>
				</table>
			</div>			
		</div>
		</c:otherwise>
		</c:choose>		
		<!--  //contentBox  -->

	</div>
</body>
</html>