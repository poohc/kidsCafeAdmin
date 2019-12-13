<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/memberHeader.jsp" />
<script type="text/javascript">
$(document).ready(function(){
	'<c:if test="${not empty franchiseNumList}">'
	
	var franchiseNumList = new Array();
	
	'<c:forEach items="${franchiseNumList}" var="franchiseNumList">';
	franchiseNumList.push('${franchiseNumList}');
	'</c:forEach>';
	
	$('.franchiseDiv').each(function() {
		if(franchiseNumList.includes($(this).find('#selectedFranchise').val())){
			$(this).find('.chkOn').addClass('on');
			$(this).find('#selectedFranchise').prop("checked", true);
		} else {
			$(this).find('.chkOn').removeClass('on');
			$(this).find('#selectedFranchise').prop("checked", false);
		} 
	});
	
	'</c:if>'	
});
</script>
</head>

<body>
	<form id="frm" action="${pageContext.request.contextPath}/member/memberSearch.view" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value="${currentPage}">
		<input type="hidden" id="franchiseNum" name="franchiseNum">
		<input type="hidden" id="searchKeyword" name="searchKeyword" value="${searchKeyword}">
		<input type="hidden" id="searchMonth" name="searchMonth" value="${searchMonth}">
		<input type="hidden" id="mCode" name="mCode">
		<input type="hidden" id="phone" name="phone">
	</form>
	<div class="wrapper" id="wrapper">
		<!--  headerBox  -->
		<jsp:include page="../common/top.jsp" />

		<!--  contents  -->
		<div id="contents" class="contentBox">
			<!--leftMenu-->
			<c:import url="../common/leftMenu.jsp">
				<c:param name="menuName" value="member" />
			</c:import>
			<!--//leftMenu-->
			<!--  contentSection  -->
			<div class="contentSection">
				<h2>회원검색</h2>
				<!--  searchBox -->
				<div class="searchBox">
					<!--menuBox-->
					<c:import url="../common/menuDeatil.jsp">
						<c:param name="menuName"     value="memberMenu" />
						<c:param name="menuSelected" value="search" />
					</c:import>
					<!--//menuBox-->
					
					<c:choose>
					<c:when test="${sessionScope.franchiseInfoVo.franchiseeStatus eq '1'}">
					<table>
						<colgroup>
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<td>
									<input type="text" placeholder="성함 또는 전화번호" id="searchText" value="${searchKeyword}">
<!-- 									AND -->
<!-- 									<div class="selectBox"> -->
<!-- 										<select id="selectedFranchise"> -->
<!-- 											<option value="" selected="">가입매장</option> -->
<%-- 											<c:forEach items="${franchiseList}" var="franchiseList"> --%>
<%-- 												<option value="${franchiseList.FranchiseeNum}">${franchiseList.LocalName}</option> --%>
<%-- 											</c:forEach> --%>
<!-- 										</select> -->
<!-- 									</div> -->
									&nbsp;&nbsp;&nbsp;
									최근방문일
									<select id="lastVisitMonth" name="lastVisitMonth">
										<option value="">선택하세요</option>
										<option value="3m"  <c:if test="${searchMonth eq '3m'}">selected="selected"</c:if>>3개월</option>
										<option value="6m"  <c:if test="${searchMonth eq '6m'}">selected="selected"</c:if>>6개월</option>
										<option value="12m" <c:if test="${searchMonth eq '12m'}">selected="selected"</c:if>>12개월</option>
									</select>
									<input type="button" value="검색" class="btn m bggy" id="searchBtn">
								</td>
							</tr>
							<c:if test="${not empty franchiseList}">
							<tr>
								<td>
									<c:forEach items="${franchiseList}" var="franchiseList" varStatus="loop">
									<div class="checkBox selectChkDiv franchiseDiv">
									<input type="checkbox" id="selectedFranchise" name="selectedFranchise" value="${franchiseList.FranchiseeNum}" checked="checked">
										<label class="lab_check"></label>
										<span class="ico check chkOn on"></span>${franchiseList.LocalName}
									</div>
									</c:forEach>
								</td>
							</tr>
							</c:if>
						</tbody>
					</table>
					</c:when>
					<c:otherwise>
					<table>
						<colgroup>
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<td>
									<input type="text" placeholder="성함 또는 전화번호" id="searchText" value="${searchKeyword}">
									<input type="hidden" id="selectedFranchise" name="selectedFranchise" value="${sessionScope.franchiseInfoVo.franchiseeNum}">
									&nbsp;&nbsp;&nbsp;
									최근방문일
									<select id="lastVisitMonth" name="lastVisitMonth">
									    <option value="">선택하세요</option>
										<option value="3m"  <c:if test="${searchMonth eq '3m'}">selected="selected"</c:if>>3개월</option>
										<option value="6m"  <c:if test="${searchMonth eq '6m'}">selected="selected"</c:if>>6개월</option>
										<option value="12m" <c:if test="${searchMonth eq '12m'}">selected="selected"</c:if>>12개월</option>
									</select>
									<input type="button" value="검색" class="btn m bggy" id="searchBtn">
								</td>
							</tr>
						</tbody>
					</table>
					</c:otherwise>
					</c:choose>
				</div>

				<!--  //searchBox -->

				<!--  dfTable  -->
				<div class="dfTable">
					<table>
						<colgroup>
							<col width="">
<%-- 							<col width=""> --%>
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
								<th>회원명</th>
<!-- 								<th>고객번호 ‘19자리’</th> -->
								<th>가입일</th>
								<th>전화번호</th>
								<th>가족수</th>
								<th>가입매장</th>
								<th>최근방문일</th>
								<th>최근방문매장</th>
								<th>현재입장여부</th>
								<th>아동위탁동의</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${not empty memberList}">
							<c:forEach items="${memberList}" var="memberList">
							<tr class="cur" onClick="memberDetail('${memberList.MCode}','${memberList.Phone}');">
								<td class="">${memberList.Name}</td>
<%-- 								<td class="">${memberList.MCode}</td> --%>
								<td class="">${memberList.JoinDate}</td>
								<td class="">${memberList.Phone}</td>
								<td class="">${memberList.Num}</td>
								<td class="">${memberList.fName}</td>
								<td class="">${memberList.LastVisit}</td>
								<td class="">${memberList.lastVisitFname}</td>
								<td class="">
									<c:choose>
										<c:when test="${memberList.EntFlag eq '1'}">
										<i class="ico ok"></i>
										</c:when>
										<c:otherwise>
										<i class="ico no"></i>
										</c:otherwise>
									</c:choose>
								</td>
								<td class="">
									<c:choose>
										<c:when test="${memberList.AgreeFlag eq '1'}">
										<i class="ico ok"></i>
										</c:when>
										<c:otherwise>
										<i class="ico no"></i>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="9">검색된 회원 정보가 없습니다.</td>
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
							<a href="#excelDownload" onclick="searchExcelDownload();">
								<i class="ico exl"></i>액셀로 내보내기
							</a>
						</span>
					</div>
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

				<!--  //contentSection  -->
			</div>
			<!--  //contents-->
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>