<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/masterHeader.jsp" />
</head>

<body class="popupWrapper">
	<!--  popupSection -->
	<div class="popupSection">
		<h1>입장권 추가
			<div class="txt_info tred"></div>
		</h1>

		<!--  contentBox  -->
		<div class="contentBox">
			<form id="ticketForm">
			<div class="dfTable left">
				<table class="tl">
					<colgroup>
						<col style="width: 80px">
						<col style="width: 80px">
						<col style="width: 80px">
						<col style="width: 80px">
					</colgroup>
					<tbody>
						<tr>
							<th>입장권명</th>
							<td class="tl" colspan="3">
								<input type="text" id="ticketName" name="ticketName">
							</td>
						</tr>
						<tr>
							<th>금액</th>
							<td class="tl">
								<input type="number" id="ticketPrice" name="ticketPrice">
							</td>
							<th>이용시간(시간단위)</th>
							<td class="tl">
								<input type="number" id="ticketPlayTime" name="ticketPlayTime">
							</td>
						</tr>
						<tr>
							<th>입장권 속성</th>
							<td class="tl" colspan="3">
								<select id="ticketAttr" name="ticketAttr">
									<option value="O" selected="selected">O</option>
									<option value="X">X</option>	
								</select>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
			<div class="dfTable bot fr">
				<button class="btn m bgbl" id="ticketInsertBtn">완료</button>
			</div>
		</div>
		<!--  //contentBox  -->

	</div>
</body>
</html>