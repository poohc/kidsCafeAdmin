<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
<script type="text/javascript">
$(function(){
	$('#searchBtn').click(function(){
		$('#frm').submit();
	});
});

function createExcel(){
	$('#frm').attr('action','${pageContext.request.contextPath}/sales/excelDownload.do');
	$('#frm').submit();
}

</script>

</head>

<body>
	<div class="wrapper" id="wrapper">
		<!--  headerBox  -->
		<jsp:include page="../common/top.jsp" />

		<!--  contents  -->
		<div id="contents" class="contentBox">
			<!--leftMenu-->
			<c:import url="../common/leftMenu.jsp">
				<c:param name="menuName" value="sales" />
			</c:import>
			<!--//leftMenu-->
			<!--  contentSection  -->
			<div class="contentSection">
				<h2>일별매출</h2>
				<form id="frm" action="${pageContext.request.contextPath}/sales/salesDaily.view" method="post">
				<input type="hidden" id="localName" name="localName" value="${localName}">
				<input type="hidden" id="salesType" name="salesType" value="daily">
				<!--  searchBox -->
				<div class="searchBox">
					<!--menuBox-->
					<c:import url="../common/menuDeatil.jsp">
						<c:param name="menuName" value="salesMenu" />
						<c:param name="menuSelected" value="daily" />
					</c:import>
					<!--//menuBox-->
					<table>
						<colgroup>
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<td>
									<c:choose>
										<c:when test="${sessionScope.franchiseInfoVo.franchiseeStatus eq '1'}">
										<div class="selectBox">
											<select id="selectFranchiseNum" name="selectFranchiseNum">
												<option value="">전지점</option>
												<c:forEach items="${franchiseList}" var="franchiseList">
													<option value="${franchiseList.FranchiseeNum}" <c:if test="${franchiseList.FranchiseeNum eq selectFranchiseNum}">selected="selected"</c:if>>${franchiseList.LocalName}</option>
												</c:forEach>
											</select>
										</div>
										</c:when>
										<c:otherwise>
										<input type="hidden" id="selectFranchiseNum" name="selectFranchiseNum" value="${selectFranchiseNum}">
										</c:otherwise>
									</c:choose>	
									<div class="selectBox">
										<select id="searchYear" name="searchYear">
										<c:forEach begin="${searchYear - 2}" end="${searchYear}" step="1" var="year">
										<option value="${year}" <c:if test="${year eq searchYear}">selected="selected"</c:if>>${year}년</option>
										</c:forEach>										 
										</select>
									</div>
									<div class="selectBox">
										<select id="searchMonth" name="searchMonth">
										<c:forEach begin="1" end="12" step="1" var="month">
											<option value="${month}" <c:if test="${month eq searchMonth}">selected="selected"</c:if>>${month}월</option>
										</c:forEach>
										</select>
									</div> 
									<input type="button" value="검색" class="btn m bggy" id="searchBtn">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				</form>
				<!--  //searchBox -->

				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3>
							<span>${searchYear}년 ${searchMonth}월 ${localName}</span>매출
						</h3>
					</div>
					<table>
						<colgroup>
							<col width="100px">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>지점</th>
								<th>소셜매출</th>
								<th>F&B</th>
								<th>MD상품</th>
								<th>신용카드</th>
								<th>현금</th>
								<th>현금영수증</th>
								<th>입장객 수</th>
								<th>매출합계(소셜매출+신용카드+현금)</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty monthSalesInfo}">
								<c:forEach items="${monthSalesInfo}" var="monthSalesInfo">
								<tr>
									<td>${monthSalesInfo.LOCAL_NAME}</td>
									<td><fmt:formatNumber value="${monthSalesInfo.ENTERENCE_FEE_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesInfo.FANDB_FEE_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesInfo.MD_FEE_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesInfo.CREDIT_CARD_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesInfo.CASH_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesInfo.CASH_RECEIPT_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesInfo.ENTERENCE_COUNT_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesInfo.TOTAL_SUM}" pattern="#,###" /></td>
								</tr>
								</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="9">월 매출 데이터가 없습니다.</td>
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
							<a href="#excel" onclick="createExcel();">
								<i class="ico exl"></i>액셀로 내보내기
							</a>
						</span>
						<span class="btn m lngr">
							<a href="#print" onclick="screenPrint();">
								<i class="ico print"></i>인쇄
							</a>
						</span>
					</div>
				</div>
				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3>
							<span>${searchYear}년 ${searchMonth}월 ${localName} 일별</span>매출
						</h3>
					</div>
					<table>
						<colgroup>
							<col width="120px">
							<col width="100px">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>날짜</th>
								<th>지점</th>
								<th>소셜매출</th>
								<th>F&B</th>
								<th>MD상품</th>
								<th>신용카드</th>
								<th>현금</th>
								<th>현금영수증</th>
								<th>입장객 수</th>
								<th>매출합계(소셜매출+신용카드+현금)</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty monthSalesList}">
								<c:forEach items="${monthSalesList}" var="monthSalesList">
								<tr>
									<td>${monthSalesList.YYYYMMDD}</td>
									<td>${monthSalesList.LOCAL_NAME}</td>
									<td><fmt:formatNumber value="${monthSalesList.ENTERENCE_FEE_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesList.FANDB_FEE_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesList.MD_FEE_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesList.CREDIT_CARD_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesList.CASH_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesList.CASH_RECEIPT_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesList.ENTERENCE_COUNT_SUM}" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${monthSalesList.TOTAL_SUM}" pattern="#,###" /></td>									
								</tr>
								</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="10">일 매출 데이터가 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>				
						</tbody>
					</table>
				</div>
			</div>
			<!--  //contentSection  -->
		</div>
		<!--  //contents-->
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>