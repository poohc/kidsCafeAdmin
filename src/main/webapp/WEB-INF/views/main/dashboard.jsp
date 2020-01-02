<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/boardHeader.jsp" />

<script type="text/javascript">
var salesInfoList = new Array();
var visitInfoList = new Array();
var salesMonthArray = new Array;
var visitMonthArray = new Array;

'<c:if test="${not empty salesInfoByMonth}">'
'<c:forEach items="${salesInfoByMonth}" var="salesInfoByMonth">'
var salesInfo = {
		  totalSum: '${salesInfoByMonth.TOTAL_SUM}'
	   };
	salesInfoList.push('${salesInfoByMonth.TOTAL_SUM}');
	salesMonthArray.push('${salesInfoByMonth.YYYYMM}');
'</c:forEach>';
'</c:if>'

'<c:if test="${not empty visitInfoByMonth}">'
'<c:forEach items="${visitInfoByMonth}" var="visitInfoByMonth">'
var visitInfo = {
		  yyyyMM: '${visitInfoByMonth.YYYYMM}',
		  totalSum: '${visitInfoByMonth.TOTAL_SUM}'
	   };
	visitInfoList.push('${visitInfoByMonth.TOTAL_SUM}');
	visitMonthArray.push('${visitInfoByMonth.YYYYMM}');
'</c:forEach>';
'</c:if>'

var salesConfig = {
	type: 'line',
	data: {
		labels: salesMonthArray,
		datasets: [{
			label: '매출액',
			backgroundColor: window.chartColors.red,
			borderColor: window.chartColors.red,
			data: salesInfoList,
			fill: false,
		}]
	},
	options: {
		responsive: true,
		title: {
			display: true,
			text: '월별 매출 변화'
		},
		tooltips: {
			mode: 'index',
			intersect: false,
		},
		hover: {
			mode: 'nearest',
			intersect: true
		},
		scales: {
			xAxes: [{
				display: true,
				scaleLabel: {
					display: true,
					labelString: '월'
				}
			}],
			yAxes: [{
				display: true,
				scaleLabel: {
					display: true,
					labelString: '매출액'
				}
			}]
		}
	}
};

var visitConfig = {
		type: 'line',
		data: {
			labels: visitMonthArray,
			datasets: [{
				label: '방문객수',
				backgroundColor: window.chartColors.blue,
				borderColor: window.chartColors.blue,
				data: visitInfoList,
				fill: false,
			}]
		},
		options: {
			responsive: true,
			title: {
				display: true,
				text: '월별 방문객 변화'
			},
			tooltips: {
				mode: 'index',
				intersect: false,
			},
			hover: {
				mode: 'nearest',
				intersect: true
			},
			scales: {
				xAxes: [{
					display: true,
					scaleLabel: {
						display: true,
						labelString: '월'
					}
				}],
				yAxes: [{
					display: true,
					scaleLabel: {
						display: true,
						labelString: '방문객수'
					}
				}]
			}
		}
	};


window.onload = function() {
	var salesCtx = document.getElementById('salesCanvas').getContext('2d');
	var visitCtx = document.getElementById('visitCanvas').getContext('2d');
	window.myLine = new Chart(salesCtx, salesConfig);
	window.myLine = new Chart(visitCtx, visitConfig);
};
</script>
</head>

<body>
	<div class="wrapper" id="wrapper">
		<!--  headerBox  -->
		<div class="headerBox">
			<div class="headerWrap">
				<h1>
					<a id="home" style="cursor: pointer">
						<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="키즈코리아" />
					</a>
				</h1>
				<div class="fr">
<!-- 					<ul class="alramBox"> -->
<%-- 						<li><img src="${pageContext.request.contextPath}/resources/images/ico_head_01.png" alt="공지알림"> --%>
<!-- 							<p>1</p></li> -->
<%-- 						<li><img src="${pageContext.request.contextPath}/resources/images/ico_head_02.png" alt="고객의 소리 접수"> --%>
<!-- 							<p>10</p></li> -->
<%-- 						<li><img src="${pageContext.request.contextPath}/resources/images/ico_head_03.png" alt="요청게시판 접수"> --%>
<!-- 							<p>100</p></li> -->
<!-- 					</ul> -->
					<ul>
						<li>
							<span class="date" id="full_date">2019-10-17 14:46:54</span>
						</li>
						<li><b class="tbl">${sessionScope.franchiseInfoVo.localName}</b></li>
						<li class="btn m bgwh">
							<a id="#logout" onclick="logout();">로그아웃</a>
						</li>
					</ul>
				</div>
			</div>
			<!--  //headerBox  -->
		</div>

		<!--  contents  -->
		<div id="contents" class="contentBox">
			<!--leftMenu-->
			<c:import url="../common/leftMenu.jsp">
				<c:param name="menuName" value="dashboard" />
			</c:import>
			<!--//leftMenu-->
			<!--  contentSection  -->
			<div class="contentSection">
				<!--현황-->
				<div class="statusBox">
					<table>
						<colgroup>
							<col width="25%">
							<col width="25%">
							<col width="25%">
							<col width="25%">
							<col width="25%">
						</colgroup>
						<tbody>
							<tr>
								<td>
									<dl>
										<dt>TODAY 방문회원</dt>
										<dd id="memerEntCnt">
											<fmt:formatNumber value="${dashBoardViewInfo.ENT_MEMBER}" pattern="#,###" />
										</dd>
									</dl>
								</td>
								<td>
									<dl>
										<dt>현재매출액</dt>
										<dd>
											<fmt:formatNumber value="${dashBoardViewInfo.TOTAL_PRICE}" pattern="#,###" />
										</dd>
									</dl>
								</td>
								<td>
									<dl>
										<dt>TODAY 회원</dt>
										<dd id="TodayMemberCnt">
											<fmt:formatNumber value="${dashBoardViewInfo.TODAY_JOIN_MEMBER}" pattern="#,###" />
										</dd>
									</dl>
								</td>
								<td>
									<dl>
										<dt>소셜입장</dt>
										<dd id="FranchiseeInfoCnt">
											<fmt:formatNumber value="${dashBoardViewInfo.SNS_COUNT}" pattern="#,###" />
										</dd>
									</dl>
								</td>
								<td>
									<dl>
										<dt>A/S요청</dt>
										<dd>0건</dd>
									</dl>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--//현황-->
				
				<!--inBox-->
				<div class="inSection twostage">
					<!--inBox 왼쪽영역-->
					<div class="inBox left">
						<div class="dfTable">
							<div class="tit_info2">
								<h3>A/S요청</h3>
							</div>
							<table>
								<colgroup>
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
										<th>접수일</th>
										<th>접수번호</th>
										<th>지점명</th>
										<th>제목</th>
										<th>내용</th>
										<th>연락처</th>
										<th>처리일</th>
										<th>처리결과</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
									<c:when test="${not empty requestList}">
									<c:forEach items="${requestList}" var="requestList">
										<tr>
											<td class="cur" onClick="openRequestProcessingPopup('${requestList.IndexNo}');">${requestList.ReceptionDate}</td>
											<td class="cur" onClick="openRequestProcessingPopup('${requestList.IndexNo}');">${requestList.ReceptionNo}</td>
											<td class="cur" onClick="openRequestProcessingPopup('${requestList.IndexNo}');">${requestList.fName}</td>
											<td class="cur" onClick="openRequestProcessingPopup('${requestList.IndexNo}');">${requestList.Title}</td>
											<td class="cur" onClick="openRequestProcessingPopup('${requestList.IndexNo}');">${requestList.Contents}</td>
											<td class="cur" onClick="openRequestProcessingPopup('${requestList.IndexNo}');">${requestList.TelNo}</td>
											<td class="cur" onClick="openRequestProcessingPopup('${requestList.IndexNo}');">${requestList.ProcessingDate}</td>
											<td class="cur" onClick="openRequestProcessingPopup('${requestList.IndexNo}');">${requestList.ProcessingResult}</td>
										</tr>
									</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="8">A/S 접수 데이터가 없습니다.</td>
										</tr>
									</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					<!--//inBox 왼쪽영역-->
					<!--inBox 오른쪽영역-->
					<div class="inBox right">
						<div class="dfTable">
							<div class="tit_info2">
								<h3>공지사항</h3>
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
										<th>게시일</th>
										<th>공지번호</th>
										<th>제목</th>
										<th>담당자</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
									<c:when test="${not empty noticeList}">
									<c:forEach items="${noticeList}" var="noticeList">
									<tr>
										<td class="cur" onClick="openNoticeUpdatePopup('${noticeList.NoticeId}');">${noticeList.PostDate}</td>
										<td class="cur" onClick="openNoticeUpdatePopup('${noticeList.NoticeId}');">${noticeList.NoticeId}</td>
										<td class="cur" onClick="openNoticeUpdatePopup('${noticeList.NoticeId}');">${noticeList.Title}</td>
										<td class="cur" onClick="openNoticeUpdatePopup('${noticeList.NoticeId}');">${noticeList.Manager}</td>
									</tr>
									</c:forEach>
									</c:when>
									<c:otherwise>
									<tr>
										<td colspan="4">공지사항이 없습니다.</td>
									</tr>
									</c:otherwise>
									</c:choose>							
								</tbody>
							</table>
						</div>
					</div>
					<!--//inBox 오른쪽영역-->
				</div>
				
				<div class="inSection twostage" style="width: 75%;height: 30%">
					<canvas id="salesCanvas"></canvas>
				</div>
				<div class="inSection twostage" style="width: 75%;height: 30%">
					<canvas id="visitCanvas"></canvas>
				</div>
				
				<!--inBox-->
				<!--  //contentSection  -->
			</div>
			<!--  //contents-->
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>

</body>
</html>