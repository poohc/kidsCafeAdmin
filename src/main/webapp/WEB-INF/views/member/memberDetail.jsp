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

<body>
	<form id="frm" action="/member/memberSearch.view" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value="1">
		<input type="hidden" id="franchiseNum" name="franchiseNum">
		<input type="hidden" id="searchKeyword" name="searchKeyword" value="${searchKeyword}">
		<input type="hidden" id="mCode" name="mCode" value="${memberInfo.MCode}">
		<input type="hidden" id="phone" name="phone" value="${memberInfo.Phone}">
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

<!-- 					<table> -->
<%-- 						<colgroup> --%>
<%-- 							<col width=""> --%>
<%-- 						</colgroup> --%>
<!-- 						<tbody> -->
<!-- 							<tr> -->
<!-- 								<td> -->
<%-- 									<input type="text" placeholder="성함 또는 전화번호" id="searchText" value="${searchKeyword}"> AND --%>
<!-- 									<div class="selectBox"> -->
<!-- 										<select id="selectedFranchise"> -->
<!-- 											<option value="" selected="">가입매장</option> -->
<%-- 											<c:forEach items="${franchiseList}" var="franchiseList"> --%>
<%-- 												<option value="${franchiseList.FranchiseeNum}">${franchiseList.LocalName}</option> --%>
<%-- 											</c:forEach> --%>
<!-- 										</select> -->
<!-- 									</div>  -->
<!-- 									<input type="button" value="검색" class="btn m bggy" id="searchBtn"> -->
<!-- 								</td> -->
<!-- 							</tr> -->
<!-- 						</tbody> -->
<!-- 					</table> -->
				</div>
				<!--  //searchBox -->
				
				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3 class="fl">
							<span>${memberInfo.Name} 회원</span> ${memberInfo.MCode} 가입점 : ${memberInfo.fName}
						</h3>
						<input class="btn m bgbl fr" type="button" value="수정" onclick="openMemberInfoUpdatePopup('${memberInfo.MCode}','${memberInfo.Phone}');">
					</div>
					<table>
						<colgroup>
							<col width="110px">
							<col width="">
							<col width="70px">
							<col width="200px;">
							<col width="120px">
							<col width="120px;">
							<col width="110px;">
							<col width="110px;">
							<col width="90px;">
							<col width="120px;">
						</colgroup>
						<thead>
							<tr>
								<th>가입일</th>
								<th>전화번호</th>
								<th>가족수</th>
								<th>가입매장</th>
								<th>최근방문일</th>
								<th>최근방문매장</th>
								<th>현재입장여부</th>
								<th>약관동의일</th>
								<th>약관동의</th>
								<th>아동만입장동의</th>
							</tr>
						</thead>
						<tbody>
							<tr class="cur">
								<td>${memberInfo.JoinDate}</td>
								<td>${memberInfo.Phone}</td>
								<td>${memberInfo.Num}</td>
								<td>${memberInfo.fName}</td>
								<td>${memberInfo.LastVisit}</td>
								<td>${memberInfo.lastVisitFname}</td>
								<td>
									<c:choose>
										<c:when test="${memberInfo.EntFlag eq '1'}">
										<i class="ico ok"></i>
										</c:when>
										<c:otherwise>
										<i class="ico no"></i>
										</c:otherwise>
									</c:choose>
								</td>
								<td>${memberInfo.AgreeDate}</td>
								<td>
									<c:choose>
										<c:when test="${memberInfo.TermsFlag eq '1'}">
										<i class="ico ok"></i>
										</c:when>
										<c:otherwise>
										<i class="ico no"></i>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${memberInfo.AgreeFlag eq '1'}">
										<i class="ico ok"></i>
										</c:when>
										<c:otherwise>
										<i class="ico no"></i>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<br/><br/>
				<!--  //dfTable  -->
				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3 class="fl">포인트정보</h3>
						<input class="btn m bgbl fr" type="button" value="수정" onclick="openMemberPointUpdatePopup('${memberInfo.MCode}','${memberInfo.Phone}');">
					</div>
					<table>
						<colgroup>
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>누적포인트</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									${memberInfo.Point}
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<br/><br/>
				<!--  //dfTable  -->
				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3 class="fl">가족정보</h3>
						<input class="btn m bgbl fr" type="button" value="업데이트" id="familyInfoUpdate">
					</div>
					<form id="familyForm">
					<input type="hidden" id="familyMcode" name="familyMcode" value="${memberInfo.MCode}">
					<input type="hidden" id="familyPhone" name="familyPhone" value="${memberInfo.Phone}">
					<input type="hidden" id="familyPw" name="familyPw" value="${memberInfo.Password}">
					<table>
						<colgroup>
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>QR코드 (18자리)</th>
								<th>성인/아동</th>
								<th>성함</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody id="familyTbody">
							<c:choose>
								<c:when test="${not empty familyInfo}">
								<c:forEach items="${familyInfo}" var="familyInfo" varStatus="loop">
								<tr class="familyTr" id="familyTr_${familyInfo.QRCode}">
									<input type="hidden" name="familyQrCode" value="${familyInfo.QRCode}">
									<input type="hidden" name="familyName" value="${familyInfo.Name}">
									<input type="hidden" name="familyAdult" value="${familyInfo.Adult}">
									<input type="hidden" name="familyMflag" value="${familyInfo.MFlag}">
									
									<td>${familyInfo.QRCode}</td>
									<td>
										<c:choose>
										<c:when test="${familyInfo.Adult eq '1'}">
										성인
										</c:when>
										<c:otherwise>
										아동
										</c:otherwise>
										</c:choose>
									</td>
									<td>${familyInfo.Name}</td>
									<td>
										${familyInfo.JoinDate}
										<span class="btn m lngy row">
											<a href="#familyDelete" onclick="familyInsertDelete('delete', '${familyInfo.QRCode}');">
												<i class="ico minus"></i>
											</a>
										</span>
									</td>
								</tr>
								</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="4">가족정보가 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>							
						</tbody>						
					</table>
					</form>
				</div>
				<div class="dfTable bot">
					<div class="fr">
<!-- 						<span class="btn m lngy row"> -->
<!-- 							<a href="#familyDelete" onclick="familyInsertDelete('delete');"> -->
<!-- 								<i class="ico minus"></i> -->
<!-- 							</a> -->
<!-- 						</span> -->
						<span class="btn m lngy row">
							<a href="#familyInsert" onclick="familyInsertDelete('insert');">
								<i class="ico plus"></i>
							</a>
						</span>
					</div>
				</div>
				<br/><br/>
				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3 class="fl">방문이력 (최근 3건만 노출)</h3>
					</div>
					<table>
						<colgroup>
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>날짜</th>
								<th>방문매장</th>
								<th>이용금액</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty visitInfo}">
								<c:forEach items="${visitInfo}" var="visitInfo">
								<tr>
									<td>${visitInfo.cIndate}</td>
									<td>${visitInfo.fName}</td>
									<td>${visitInfo.cPrice}</td>
								</tr>
								</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="3">방문 이력이 없습니다.</td>
								</tr
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				<div class="dfTable">
					<div class="tit_info2">
						<h3 class="fl">매장이용정보 (소셜입장 시 요금은 각 소셜 커머스 업체 관리자로 확인)</h3>
					</div>
					<table>
						<colgroup>
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>날짜</th>
								<th>매출지점</th>
								<th>결제구분</th>
								<th>금액</th>
								<th>결제방법</th>
								<th>승인여부</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty storeUseInfo}">
								<c:forEach items="${storeUseInfo}" var="storeUseInfo">
								<tr>
									<td>${storeUseInfo.INDATE}</td>
									<td>${storeUseInfo.LOCAL_NAME}</td>
									<td>${storeUseInfo.KINDS_OF_SALES}</td>
									<td>${storeUseInfo.CPRICE}</td>
									<td>${storeUseInfo.KINDS_OF_PAY}</td>
									<td>${storeUseInfo.CONFIRM_TYPE}</td>
								</tr>
								</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="6">매장이용정보 내역이 없습니다.</td>
								</tr
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				<div class="dfTable">
					<div class="tit_info2">
						<h3 class="fl">다회권 보유정보 [10+1]이용권 ${fn:length(multiTicketList)}장</h3>
					</div>
					<table>
						<colgroup>
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>날짜</th>
								<th>다회권명</th>
								<th>구입매장</th>
								<th>사용</th>
								<th>잔여수량</th>
								<th>메모</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty multiTicketList}">
								<c:forEach items="${multiTicketList}" var="multiTicketList">
								<tr>
									<td>${multiTicketList.INDATE}</td>
									<td>${multiTicketList.NAME}</td>
									<td>${multiTicketList.LOCAL_NAME}</td>
									<td>${multiTicketList.BUYUSE}</td>
									<td>${multiTicketList.NUM}</td>
									<td>${multiTicketList.RESERVED1}</td>
								</tr>
								</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="6">다회권 보유정보가 없습니다.</td>
								</tr
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				<!--  //dfTable  -->
				<div class="dfTable bot">
					<div class="fr">
<!-- 						<button class="btn m lngy">SMS전송</button> -->
<!-- 						<button class="btn m lngy">알림톡전송</button> -->
						<button class="btn m bgbk" onclick="signOut();">회원탈퇴</button>
					</div>
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