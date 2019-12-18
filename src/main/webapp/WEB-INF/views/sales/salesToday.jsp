<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
<script type="text/javascript">
$(document).ready(function(){
	$('.radio').click(function() {
		
		if($(this).hasClass('on') == false){
			$('.radio').removeClass('on');
			$(this).addClass('on');
			if($(this).data('value') == 'snack'){
				$('#snackBody').show();
				$('#foodBody').hide();
				$('#beverageBody').hide();
				$('#mdBody').hide();
			}
			if($(this).data('value') == 'food'){
				$('#snackBody').hide();
				$('#foodBody').show();
				$('#beverageBody').hide();
				$('#mdBody').hide();
			}
			if($(this).data('value') == 'beverage'){
				$('#snackBody').hide();
				$('#foodBody').hide();
				$('#beverageBody').show();
				$('#mdBody').hide();
			}
			if($(this).data('value') == 'md'){
				$('#snackBody').hide();
				$('#foodBody').hide();
				$('#beverageBody').hide();
				$('#mdBody').show();
			}
		} 
		
	});
	
	$('#calendar').change(function(){
		$('#frm').submit();
	});
	
	$("#calendar").datepicker({
        dateFormat: 'yy-mm-dd' //Input Display Format 변경
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
        ,changeYear: true //콤보박스에서 년 선택 가능
        ,changeMonth: true //콤보박스에서 월 선택 가능                
        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
        ,buttonImage: "${pageContext.request.contextPath}/resources/images/ico_cal.png" //버튼 이미지 경로
        ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
        ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
        ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
//         ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
//         ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
    });                    
    
	
	
   //초기값을 오늘 날짜로 설정
//    $('#calendar').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
   
   if('${searchDate}' != ''){
	   $('#calendar').datepicker('setDate', '${searchDate}');
   } else {
	   $('#calendar').datepicker('setDate', 'today');
   }
   
});
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
				<h2>당일매출</h2>
				<!--  searchBox -->
				<div class="searchBox">
					<!--menuBox-->
					<c:import url="../common/menuDeatil.jsp">
						<c:param name="menuName" value="salesMenu" />
						<c:param name="menuSelected" value="today" />
					</c:import>
					<!--//menuBox-->
				</div>
				<!--  //searchBox -->

				<div class="dfTable">
					<div class="tit_info2">
						<form id="frm" action="${pageContext.request.contextPath}/sales/salesToday.view" method="post">
						<h2>
							당일매출 <span>${year}년 ${month}월 ${date}일</span>
							<div class="tred">* 일 결제내역에서 정산을 완료해야 매출액이 합산됩니다.</div>
							<input type="text" id="calendar" name="searchDate" value="${searchDate}">
						</h2>
						</form>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>매출지점</th>
								<th>신용카드</th>
								<th>현금</th>
								<th>현금영수증</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="salesInfoSum" value="0" />
							<c:choose>
								<c:when test="${not empty salesInfo}">
									<c:forEach items="${salesInfo}" var="salesInfo">
									<tr>
										<td>${salesInfo.LOCAL_NAME}</td>
										<td><fmt:formatNumber value="${salesInfo.CARD}"         pattern="#,###" /></td>
										<td><fmt:formatNumber value="${salesInfo.CASH}"         pattern="#,###" /></td>
										<td><fmt:formatNumber value="${salesInfo.CASH_RECEIPT}" pattern="#,###" /></td>
										<td><fmt:formatNumber value="${salesInfo.TOTAL_PRICE}"  pattern="#,###" /></td>
										<c:set var="salesInfoSum" value="${salesInfoSum + salesInfo.TOTAL_PRICE}" />
									</tr>	
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="5">금일 매출이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>시제금정산</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>POS 종류</th>
								<th>시제금액</th>
								<th>마감금액</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty pettyCashList}">
									<c:forEach items="${pettyCashList}" var="pettyCashList">
									<tr>
										<td>${pettyCashList.POSNAME}</td>
										<td><fmt:formatNumber value="${pettyCashList.OPENPRICE}"   pattern="#,###" /></td>
										<td><fmt:formatNumber value="${pettyCashList.CLOSEPRICE}"  pattern="#,###" /></td>
									</tr>	
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="3">금일 시제금정산 내역이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>직권할인</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>고객명</th>
								<th>전화번호</th>
								<th>할인금액</th>
								<th>할인종류</th>
								<th>메모</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty exOffcioSaleList}">
									<c:forEach items="${exOffcioSaleList}" var="exOffcioSaleList">
									<tr>
										<td>${exOffcioSaleList.NAME}</td>
										<td>${exOffcioSaleList.PHONE}</td>
										<td><fmt:formatNumber value="${exOffcioSaleList.PRICE}"   pattern="#,###" /></td>
										<td>${exOffcioSaleList.GOODSNAME}</td>
										<td>${exOffcioSaleList.MEMO}</td>
									</tr>	
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="5">금일 직권할인 내역이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>당일방문 집계</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>매출지점</th>
								<th>단체입장</th>
								<th>성인</th>
								<th>아동</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty visitInfo}">
									<c:forEach items="${visitInfo}" var="visitInfo">
									<tr>
										<td>${visitInfo.LOCAL_NAME}</td>
										<td><fmt:formatNumber value="${visitInfo.GROUP_SUM}" pattern="#,###" /></td>
										<td><fmt:formatNumber value="${visitInfo.ADULT_SUM}" pattern="#,###" /></td>
										<td><fmt:formatNumber value="${visitInfo.KIDS_SUM}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${visitInfo.TOTAL_SUM}" pattern="#,###" /></td>
									</tr>	
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="5">당일 방문고객이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				<!--  //dfTable  -->

				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h2>소셜매출액</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>티켓</th>
								<th>판매가</th>
								<th>입장수량</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty snsVisitInfo}">
									<c:set value="0" var="snsTotalSum" />
									<c:forEach items="${snsVisitInfo}" var="snsVisitInfo">
									<tr>
										<td>${snsVisitInfo.GOODSNAME}</td>
										<td><fmt:formatNumber value="${snsVisitInfo.TICKET_PRICE}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${snsVisitInfo.CNT}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${snsVisitInfo.SNS_PRICE_SUM}" pattern="#,###" /></td>
										<c:set value="${snsTotalSum + snsVisitInfo.SNS_PRICE_SUM}" var="snsTotalSum" />
									</tr>	
									</c:forEach>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>합계</td>
										<td><fmt:formatNumber value="${snsTotalSum}" pattern="#,###" /></td>
									</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="4">당일 소셜방문 고객이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>다회권 판매</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>다회권명</th>
								<th>단가</th>
								<th>수량</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty multiTicketSalesInfo}">
									<c:forEach items="${multiTicketSalesInfo}" var="multiTicketSalesInfo">
									<tr>
										<td>${multiTicketSalesInfo.NAME}</td>
										<td><fmt:formatNumber value="${multiTicketSalesInfo.PRICE}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${multiTicketSalesInfo.CNT}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${multiTicketSalesInfo.TOTAL_SUM}" pattern="#,###" /></td>
									</tr>	
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="4">당일 다회권 판매내역이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>매출합계</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>매장 현금+신용카드</th>
								<th>소셜티켓</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<c:set value="${salesInfoSum + snsTotalSum}" var="totalSum" />
							<c:choose>
								<c:when test="${salesInfoSum > 0 or snsTotalSum > 0}">
									<tr>
										<td><fmt:formatNumber value="${salesInfoSum}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${snsTotalSum}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${totalSum}"  pattern="#,###" /></td>
									</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="3">당일 매출이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				<!--  //dfTable  -->				
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>신용카드사 별 정산(승인)</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>카드사</th>
								<th>승인금액</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty casdSalesConfirmInfo}">
									<c:forEach items="${casdSalesConfirmInfo}" var="casdSalesConfirmInfo">
									<tr>
										<td>${casdSalesConfirmInfo.PGNAME}</td>
										<td><fmt:formatNumber value="${casdSalesConfirmInfo.PRICE}"  pattern="#,###" /></td>
									</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="2">당일 카드 승인 매출이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>신용카드사 별 정산(취소)</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>카드사</th>
								<th>취소승인금액</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty casdSalesCancelInfo}">
									<c:forEach items="${casdSalesCancelInfo}" var="casdSalesCancelInfo">
									<tr>
										<td>${casdSalesCancelInfo.PGNAME}</td>
										<td><fmt:formatNumber value="${casdSalesCancelInfo.PRICE}"  pattern="#,###" /></td>
									</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="2">당일 카드 취소 매출이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>일반상품 매출</h2>
					</div>
					<div class="radioBox" style="margin-left: 15px;">
						<input type="radio" class="productRadio" name="productRadio">
							<span class="ico radio on" data-value='snack'></span>
							<label class="lab_radio">스낵</label>
						<input type="radio" class="productRadio" name="productRadio">
							<span class="ico radio" data-value='food'></span>
							<label class="lab_radio">푸드</label>
						<input type="radio" class="productRadio" name="productRadio">
							<span class="ico radio" data-value='beverage'></span>
							<label class="lab_radio">음료</label>
						<input type="radio" class="productRadio" name="productRadio">
							<span class="ico radio" data-value='md'></span>
							<label class="lab_radio">MD</label>
					</div>
					<br/><br/>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>상품명</th>
								<th>수량</th>
								<th>단가</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody id="snackBody">
							<c:set value="0" var="snackTotalSum" />
							<c:choose>
								<c:when test="${not empty snackSalesList}">
									<c:forEach items="${snackSalesList}" var="snackSalesList">
									<tr>
										<td>${snackSalesList.GOODSNAME}</td>
										<td><fmt:formatNumber value="${snackSalesList.CNT}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${snackSalesList.DANGA}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${snackSalesList.TOTAL_SUM}"  pattern="#,###" /></td>
										<c:set value="${snackTotalSum + snackSalesList.TOTAL_SUM}" var="snackTotalSum" />
									</tr>
									</c:forEach>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>합계</td>
										<td><fmt:formatNumber value="${snackTotalSum}"  pattern="#,###" /></td>
									</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="4">당일 스낵 매출이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
						<tbody id="foodBody" style="display: none;">
							<c:set value="0" var="foodTotalSum" />
							<c:choose>
								<c:when test="${not empty foodSalesList}">
									<c:forEach items="${foodSalesList}" var="foodSalesList">
									<tr>
										<td>${foodSalesList.GOODSNAME}</td>
										<td><fmt:formatNumber value="${foodSalesList.CNT}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${foodSalesList.DANGA}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${foodSalesList.TOTAL_SUM}"  pattern="#,###" /></td>
										<c:set value="${foodTotalSum + foodSalesList.TOTAL_SUM}" var="foodTotalSum" />
									</tr>
									</c:forEach>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>합계</td>
										<td><fmt:formatNumber value="${foodTotalSum}"  pattern="#,###" /></td>
									</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="4">당일 푸드 매출이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
						<tbody id="beverageBody" style="display: none;">
							<c:set value="0" var="beverageTotalSum" />
							<c:choose>
								<c:when test="${not empty beverageSalesList}">
									<c:forEach items="${beverageSalesList}" var="beverageSalesList">
									<tr>
										<td>${beverageSalesList.GOODSNAME}</td>
										<td><fmt:formatNumber value="${beverageSalesList.CNT}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${beverageSalesList.DANGA}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${beverageSalesList.TOTAL_SUM}"  pattern="#,###" /></td>
										<c:set value="${beverageTotalSum + beverageSalesList.TOTAL_SUM}" var="beverageTotalSum" />
									</tr>
									</c:forEach>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>합계</td>
										<td><fmt:formatNumber value="${beverageTotalSum}"  pattern="#,###" /></td>
									</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="4">당일 음료 매출이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
						<tbody id="mdBody" style="display: none;">
							<c:set value="0" var="mdTotalSum" />
							<c:choose>
								<c:when test="${not empty mdSalesList}">
									<c:forEach items="${mdSalesList}" var="mdSalesList">
									<tr>
										<td>${mdSalesList.GOODSNAME}</td>
										<td><fmt:formatNumber value="${mdSalesList.CNT}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${mdSalesList.DANGA}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${mdSalesList.TOTAL_SUM}"  pattern="#,###" /></td>
										<c:set value="${mdTotalSum + mdSalesList.TOTAL_SUM}" var="mdTotalSum" />
									</tr>
									</c:forEach>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>합계</td>
										<td><fmt:formatNumber value="${mdTotalSum}"  pattern="#,###" /></td>
									</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="4">당일 MD 상품 매출이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>퇴장추가요금</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>구분</th>
								<th>추가이용요금</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty exitSalesInfo}">
									<c:forEach items="${exitSalesInfo}" var="exitSalesInfo">
									<tr>
										<td>${exitSalesInfo.GOODSNAME}</td>
										<td><fmt:formatNumber value="${exitSalesInfo.TOTAL_SUM}"  pattern="#,###" /></td>
									</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="2">당일 퇴장추가요금 내역이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>할인</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>구분</th>
								<th>상품명</th>
								<th>수량</th>
								<th>합계</th>
							</tr>
						</thead>
						<tbody>
							<c:set value="0" var="discountTotalSum" />
							<c:choose>
								<c:when test="${not empty discountSalesInfo}">
									<c:forEach items="${discountSalesInfo}" var="discountSalesInfo">
									<tr>
										<td>${discountSalesInfo.DISCOUNT_TYPE}</td>
										<td>${discountSalesInfo.GOODSNAME}</td>
										<td><fmt:formatNumber value="${discountSalesInfo.CNT}"  pattern="#,###" /></td>
										<td><fmt:formatNumber value="${discountSalesInfo.TOTAL_SUM}"  pattern="#,###" /></td>
										<c:set value="${discountTotalSum + discountSalesInfo.TOTAL_SUM}" var="discountTotalSum" />
									</tr>
									</c:forEach>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>할인합계</td>
										<td><fmt:formatNumber value="${discountTotalSum}"  pattern="#,###" /></td>
									</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="4">당일 할인 내역이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>다회권 입장 수</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>구분</th>
								<th>입장수</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty multiTicketUseInfo}">
									<c:forEach items="${multiTicketUseInfo}" var="multiTicketUseInfo">
									<tr>
										<td>${multiTicketUseInfo.GOODSNAME}</td>
										<td><fmt:formatNumber value="${multiTicketUseInfo.CNT}"  pattern="#,###" /></td>
									</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="2">당일 다회권 입장 내역이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>단체(아동미등록)</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>구분</th>
								<th>단체명</th>
								<th>금액</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty notMembergroupEnterInfo}">
									<c:forEach items="${notMembergroupEnterInfo}" var="notMembergroupEnterInfo">
									<tr>
										<td>${notMembergroupEnterInfo.GOODSNAME}</td>
										<td>${notMembergroupEnterInfo.NAME}</td>
										<td><fmt:formatNumber value="${notMembergroupEnterInfo.SUM_PRICE}"  pattern="#,###" /></td>
									</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="3">당일 아동미등록 단체 입장 내역이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<br/><br/>
				
				<div class="dfTable">
					<div class="tit_info2">
						<h2>단체(아동등록)</h2>
					</div>
					<table>
						<colgroup>
							<col width="150px;">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th>구분</th>
								<th>입장수</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty groupEnterInfo}">
									<c:forEach items="${groupEnterInfo}" var="groupEnterInfo">
									<tr>
										<td>${groupEnterInfo.GOODSNAME}</td>
										<td><fmt:formatNumber value="${groupEnterInfo.CNT}"  pattern="#,###" /></td>
									</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
								<tr>
									<td colspan="2">당일 아동등록 단체 입장 내역이 없습니다.</td>
								</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				
			</div>
			<!--  //contentSection  -->
			<!--  //contents-->
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>