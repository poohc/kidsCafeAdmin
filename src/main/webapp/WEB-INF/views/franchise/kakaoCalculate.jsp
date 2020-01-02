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
				<h2>알림톡 정산</h2>
				
				<!--  searchBox -->
				<div class="searchBox">
					<!--menuBox-->
					<c:import url="../common/menuDeatil.jsp">
						<c:param name="menuName"     value="franchiseMenu" />
						<c:param name="menuSelected" value="kakaoCalc" />
					</c:import>
				</div>
				<div class="tit_info3">
					<p class="tred">* 알림톡의 발송단가는 건당 11원으로 고객에게 안내해 주는 사항에 대하여 알림톡을 전송합니다.</p>
		  			<p >필요한 알림톡 템플릿은 본사에 문의해 주세요</p>
				</div>
				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3>
							${year}년 ${month}월 현재 사용량<span>
							청구금액 : 
							<c:choose>
							<c:when test="${not empty kakaoSendStatByMonth}">
								<fmt:formatNumber value="${kakaoSendStatByMonth.SEND_PAY}" pattern="#,###" />
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
							<c:when test="${not empty kakaoSendStatByMonth}">
							<tr>
								<td>${kakaoSendStatByMonth.YYYYMM}</td>
								<td>${kakaoSendStatByMonth.SEND_TYPE}</td>
								<td><fmt:formatNumber value="${kakaoSendStatByMonth.SEND_COUNT}" pattern="#,###" /></td>
								<td><fmt:formatNumber value="${kakaoSendStatByMonth.SEND_PAY}" pattern="#,###" /></td>
							</tr>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="4">카카오 알림톡 발송 내역이 없습니다.</td>
							</tr>
							</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<!--  //searchBox -->
				
				<!--  //contentSection  -->
			</div>
			<!--  //contents-->
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>