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
		<h1>기초정보수정
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
						<tr>
							<th>전화번호</th>
							<td class="tl" colspan="3">
								<input type="number" value="${memberInfo.Phone}" id="phone" name="phone">
							</td>
						</tr>
						<tr>
							<th>약관동의</th>
							<td class="tl">
								<select id="termsFlag" name="termsFlag">
									<option value="1" <c:if test="${memberInfo.TermsFlag eq '1'}">selected="selected"</c:if>>동의</option>
									<option value="0" <c:if test="${memberInfo.TermsFlag eq '0'}">selected="selected"</c:if>>미동의</option>
								</select>
							</td>
							<th>아동만 입장 동의</th>
							<td class="tl">
								<select id="agreeFlag" name="agreeFlag">
									<option value="1" <c:if test="${memberInfo.AgreeFlag eq '1'}">selected="selected"</c:if>>동의</option>
									<option value="0" <c:if test="${memberInfo.AgreeFlag eq '0'}">selected="selected"</c:if>>미동의</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>마스터 성함</th>
							<td class="tl" colspan="3">
								<input type="text" value="${memberInfo.Name}" id="name" name="name">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="dfTable bot fr">
				<button class="btn m bgbl" id="memberInfoUpdate">완료</button>
			</div>
		</div>
		<!--  //contentBox  -->

	</div>
</body>
</html>