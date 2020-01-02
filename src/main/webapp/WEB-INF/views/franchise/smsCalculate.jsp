<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
<script type="text/javascript">
	function changeFranchisePassword(franchiseNum){
		var popupTitle = "franchisePwChangePopup" ;
		window.open('${pageContext.request.contextPath}/franchise/franchisePwChangePopup.view?franchiseNum='+franchiseNum, popupTitle,  'width=550,height=500,toolbar=0,location=0, directories=0, status=0, menubar=0');
		
	}
</script>
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
				<c:param name="menuName" value="franchise" />
			</c:import>
			
			<!--//leftMenu-->
			<!--  contentSection  -->
			<div class="contentSection">
				<h2>문자발송 정산</h2>
				
				<!--  searchBox -->
				<div class="searchBox">
					<!--menuBox-->
					<c:import url="../common/menuDeatil.jsp">
						<c:param name="menuName"     value="franchiseMenu" />
						<c:param name="menuSelected" value="smsCalc" />
					</c:import>
				</div>
				<div class="tit_info3">
					<p class="tred">* 문자발송 서비스는 통신사에 선결제로 구입하여 이용하는 관계로 매월25일 문자발송비 정산해야 합니다.</p>
					<p>
						<b>[현재날짜 기준 단가]</b> SMS : 12.5원 LMD : 44.8원
					</p>
					<p>발송한 시점으로 요금을 사용처리하므로 잘 못 전송되는 일이 없도록 신중하게 사용해 주세요.</p>
				</div>
				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3>
							${year}년 ${month}월 현재 사용량<span>
							청구금액 : 
							<c:set var="sendPaySum" value="0" />
							<c:choose>
							<c:when test="${not empty smsSendStatByMonth}">
								<c:forEach items="${smsSendStatByMonth}" var="smsSendStatByMonth">
									<c:set var="sendPaySum" value="${sendPaySum + smsSendStatByMonth.SEND_PAY}" />
								</c:forEach>
								<fmt:formatNumber value="${sendPaySum}" pattern="#,###" />
							</c:when>
							<c:otherwise>
								0
							</c:otherwise>
							</c:choose>
							원 ( VAT별도 )
							</span>
						</h3>
					</div>
					<table>
						<colgroup>
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>월</th>
								<th>구분</th>
								<th>건수</th>
								<th>비용</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${not empty smsSendStatByMonth}">
							<c:forEach items="${smsSendStatByMonth}" var="smsSendStatByMonth">
							<tr>
								<td>${smsSendStatByMonth.YYYYMM}</td>
								<td>${smsSendStatByMonth.SEND_TYPE}</td>
								<td><fmt:formatNumber value="${smsSendStatByMonth.SEND_COUNT}" pattern="#,###" /></td>
								<td><fmt:formatNumber value="${smsSendStatByMonth.SEND_PAY}" pattern="#,###" /></td>
							</tr>
							</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="4">문자 발송 내역이 없습니다.</td>
							</tr>
							</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!--  //searchBox -->
				
				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3>발송리스트 (최근20건)</h3>
					</div>
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
								<th>날짜</th>
								<th>구분</th>
								<th>내용</th>
								<th>건수</th>
								<th>비용</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${not empty smsSendList}">
							<c:forEach items="${smsSendList}" var="smsSendList">
							<tr>
								<td>${smsSendList.YYYYMM}</td>
								<td>${smsSendList.SEND_TYPE}</td>
								<td>${smsSendList.CONTENTS}</td>
								<td><fmt:formatNumber value="${smsSendList.SEND_COUNT}" pattern="#,###" /></td>
								<td><fmt:formatNumber value="${smsSendList.SEND_PAY}" pattern="#,###" /></td>
							</tr>
							</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="5">문자 발송 내역이 없습니다.</td>
							</tr>
							</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!--  //dfTable  -->
				
				<!--  //contentSection  -->
			</div>
			<!--  //contents-->
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>