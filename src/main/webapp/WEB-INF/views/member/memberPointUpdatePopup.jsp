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

<body class="popupWrapper">
	<!--  popupSection -->
	<div class="popupSection">
		<h1>누적포인트정보수정
			<div class="txt_info tred"></div>
		</h1>

		<!--  contentBox  -->
		<div class="contentBox">
			<div class="dfTable left">
				<table class="tl">
					<colgroup>
						<col style="width: 80px">
						<col style="width: 80px">
						<col style="width: 80px">
						<col style="width: 80px">
					</colgroup>
					<tbody>
						<input type="hidden" id="mCode" name="mCode" value="${memberInfo.MCode}">
						<input type="hidden" id="point" name="point" value="${memberInfo.Point}">
						<tr>
							<th>누적포인트</th>
							<td class="tl" colspan="3">
								${memberInfo.Point}
							</td>							
						</tr>
						<tr>
							<th>적립/차감 포인트</th>
							<td class="tl" colspan="3">
								<select id="addMinus" name="addMinus">
									<option value="1">적립</option>
									<option value="0">차감</option>
								</select>
								<input type="text" id="updatePoint" name="updatePoint">
							</td>							
						</tr>
						<tr>
							<th>스탭</th>
							<td class="tl" colspan="3">
								<input type="text" id="staff" name="staff">
							</td>							
						</tr>
						<tr>
							<th>코멘트</th>
							<td class="tl" colspan="3">
								<input type="text" id="comment" name="comment">
							</td>							
						</tr>
					</tbody>
				</table>
			</div>
			<div class="dfTable bot fr">
				<button class="btn m bgbl" id="memberPointUpdate">완료</button>
			</div>
		</div>
		<!--  //contentBox  -->

	</div>
</body>
</html>