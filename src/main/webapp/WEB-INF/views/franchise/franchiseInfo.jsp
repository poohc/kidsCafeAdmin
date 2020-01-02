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
				<h2>매장현황</h2>
				
				<!--  searchBox -->
				<div class="searchBox">
					<!--menuBox-->
					<c:import url="../common/menuDeatil.jsp">
						<c:param name="menuName"     value="franchiseMenu" />
						<c:param name="menuSelected" value="franchiseInfo" />
					</c:import>
				</div>
				<!--  //searchBox -->
				
				<!--  dfTable  -->
				<c:forEach items="${franchiseInfoList}" var="franchiseInfoList">
				<div class="dfTable left">
					<div class="tit_info2">
						<h3>가맹점 정보</h3>
					</div>
					
					<table>
						<colgroup>
							<col width="15%">
							<col width="">
							<col width="15%">
							<col width="">
						</colgroup>

						<tbody>
							<tr>
								<th>매장명</th>
								<td class="">${franchiseInfoList.LocalName}</td>
								<th>사업자등록번호</th>
								<td class="">${franchiseInfoList.BusinessNumber}</td>
							</tr>
							<tr>
								<th>주소</th>
								<td colspan="3" class="">${franchiseInfoList.Address}</td>
							</tr>
							<tr>
								<th>점주명</th>
								<td class="">${franchiseInfoList.MasterName}</td>
								<th>매장전화번호</th>
								<td class="">${franchiseInfoList.BusinessNumber}</td>
							</tr>
							<tr>
								<th>오픈일</th>
								<td class="">${franchiseInfoList.JoinDate}</td>
								<th>매장코드번호</th>
								<td class="">${franchiseInfoList.FranchiseeNum}</td>
							</tr>
							<tr>
								<th>계약로얄티</th>
								<td colspan="3" class="">${franchiseInfoList.Royalty}</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--  //dfTable  -->

				<!--  dfTable  -->
				<div class="dfTable left">
					<div class="tit_info2">
						<h3>VAN정보</h3>
					</div>
					<table>
						<colgroup>
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>

						<tbody>
							<tr>
								<th>VAN관리대리점</th>
								<td class="">${franchiseInfoList.VANName}</td>
								<th>VAN관리대리점 연락처</th>
								<td class="">${franchiseInfoList.VANNum}</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<!--  //dfTable  -->
				<div class="dfTable bot">
					<div class="fr">
						<button class="btn m bgbl" onclick="changeFranchisePassword('${franchiseInfoList.FranchiseeNum}')">비밀번호 변경</button>
					</div>
				</div>
				
				</c:forEach>
				<!--  //contentSection  -->
			</div>
			<!--  //contents-->
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>