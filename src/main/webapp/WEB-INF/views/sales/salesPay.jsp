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
//          ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
//          ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
     });                    
     
    //초기값을 오늘 날짜로 설정
//     $('#calendar').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	
    $('.updatePayChk').click(function() {
		if($(this).find('.chkOn').hasClass('on') == true){
			$(this).find('.chkOn').removeClass('on');
			$(this).find('#selectChk').prop("checked", false);
		} else {
			$(this).find('.chkOn').addClass('on');
			$(this).find('#selectChk').prop("checked", true);
		}
	});
    
    $('.radio').click(function(){
    	$('#radioSearch').val($(this).data('value'));
    	searchPayList();
    });
    
    $('input[name="chkDeletedData"]').click(function(){
    	$(this).find('.chkOn').addClass('on');
    });
    
    $('#franchiseNum').change(function(){
    	searchPayList();
    });    
    
    $('#payCancel').click(function(){
    	if($('input[name="selectChk"]:checked').length == 0){
			alert('취소할 결제내역을 선택하세요.');
			return;
		}
		
		if(confirm('결제내역을 취소 하시겠습니까?')){
			
			$('#cancel').val('1');
			var formData = $('#frm').serializeObject();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/sales/salesPayCancel.json",
				type : "POST",
				contentType: 'application/json',
				data : JSON.stringify(formData),
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
				    	searchPayList();
					} else {
						alert(result.resultMessage);
						return;
					}
				},
				error : function(error){
					alert('결제내역 취소 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
					return;
				}
			});
		}
    });    
    
    $('#abuseCancel').click(function(){
    	if($('input[name="selectChk"]:checked').length == 0){
			alert('직권취소할 결제내역을 선택하세요.');
			return;
		}
		
		if(confirm('결제내역을 직권취소 하시겠습니까?')){
			
			$('#cancel').val('2');
			var formData = $('#frm').serializeObject();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/sales/salesPayCancel.json",
				type : "POST",
				contentType: 'application/json',
				data : JSON.stringify(formData),
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
				    	searchPayList();
					} else {
						alert(result.resultMessage);
						return;
					}
				},
				error : function(error){
					alert('결제내역 직권취소 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
					return;
				}
			});
		}
    });    
});

function searchPayList(){
	$('#localName').val($('#selectFranchiseNum option:checked').text());
	$('#frm').attr('action','${pageContext.request.contextPath}/sales/salesPay.view');
	$('#frm').submit();
}

function chk(obj){
	$(obj).find('.chkOn').addClass('on');
}

</script>

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
				<h2>
					결제내역관리 <span class="tred">(결제내역 데이터관리는 매장에서 로얄티 정산 관계로 삭제해야 할 결제내역 관리를 위한 기능으로, 최종승인자의 승인으로 처리합니다.)</span>
				</h2>
				<!--  searchBox -->
				<form id="frm" action="${pageContext.request.contextPath}/sales/salesPay.view" method="post">
				<input type="hidden" id="localName" name="localName" value="${localName}">
				<input type="hidden" id="radioSearch" name="radioSearch" value="${radioSearch}">
				<div class="searchBox">
					<!--menuBox-->
					<c:import url="../common/menuDeatil.jsp">
						<c:param name="menuName" value="salesMenu" />
						<c:param name="menuSelected" value="pay" />
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
									<div class="selectCal">
										<span> 
											승인번호
											<input type="text" id="approvalNum" name="approvalNum" value="${approvalNum}">
											<input type="text" id="calendar" name="searchDate" value="${searchDate}">
										</span>
									</div>
									<input type="button" value="검색" class="btn m bggy" onclick="searchPayList();">
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<!--  //searchBox -->

				<!--  dfTable  -->
				<div class="dfTable">
					<div class="tit_info2">
						<h3 class="fl">
							<span>${year}년 ${month}월 ${date}일 ${localName}의 결제내역</span>
						</h3>
						<p class="fr">
							<input type="text" placeholder="성함 또는 고객번호" id="searchKeyword" name="searchKeyword" value="${searchKeyword}">
							<input type="button" value="검색" class="btn m bggy" onclick="searchPayList();">
						</p>
					</div>
					<div class="radioBox tit_info3">
						<!-- 클릭 시 클래스 on추가 / 포커스시 클래스 focused추가 -->
						<input type="radio" name="searchRadio">
							<span class="ico radio <c:if test="${radioSearch eq 'confirm'}">on</c:if>" data-value='confirm'></span>
							<label class="lab_radio">정상승인</label>
						<input type="radio" name="searchRadio">
							<span class="ico radio <c:if test="${radioSearch eq 'cancel'}">on</c:if>" data-value='cancel'></span>
							<label class="lab_radio">취소된 내역만 보기</label>
						<input type="radio" name="searchRadio">
							<span class="ico radio <c:if test="${radioSearch eq 'customCancel'}">on</c:if>" data-value='customCancel'></span>
							<label class="lab_radio">직권취소 내역</label>
					</div>
					<table>
						<colgroup>
							<c:if test="${radioSearch eq 'confirm'}">
							<col width="50px;">
							</c:if>
							<col width="130px">
							<col width="80px">
							<col width="130px">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<c:if test="${radioSearch eq 'confirm'}">
								<th>선택</th>
								</c:if>
								<th>날짜</th>
								<th>지점명</th>
								<th>고객번호</th>
								<th>고객명</th>
								<th>금액</th>
								<th>승인여부</th>
								<th>결제수단</th>
								<th>승인번호</th>
								<th>카드사</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${not empty payList}">
							<input type="hidden" id="cancel" name="cancel">
							<c:forEach items="${payList}" var="payList">
							<tr>
								<c:if test="${radioSearch eq 'confirm'}">
								<td>
									<div class="checkBox updatePayChk">
									<input type="checkbox" id="selectChk" name="selectChk" value="${payList.APPROVALNUM}">
										<label class="lab_check"></label>
										<span class="ico check chkOn"></span>
									</div>
								</td>
								</c:if>
								<td>${payList.YYYYMMDD}</td>
								<td>${payList.LOCAL_NAME}</td>
								<td>${payList.MCODE}</td>
								<td>${payList.NAME}</td>
								<td><fmt:formatNumber value="${payList.PRICE}" pattern="#,###" /></td>
								<td>${payList.CONFIRM_TYPE}</td>
								<td>${payList.KINDS_OF_PAY}</td>
								<td>${payList.APPROVALNUM}</td>
								<td>${payList.PG_NAME}</td>
							</tr>
							</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<c:choose>
								<c:when test="${radioSearch eq 'confirm'}">
								<td colspan="10">결제내역 데이터가 없습니다.</td>
								</c:when>
								<c:otherwise>
								<td colspan="9">결제내역 데이터가 없습니다.</td>
								</c:otherwise>
								</c:choose>
							</tr>
							</c:otherwise>
							</c:choose>				
						</tbody>
					</table>
				</div>
				</form>
				<!--  //dfTable  -->
				<div class="dfTable bot">
					<div class="fr">
						<button class="btn m lngy" onclick="searchPayList();">새로고침</button>
						<c:if test="${sessionScope.franchiseInfoVo.franchiseeStatus eq '1'}">
							<c:if test="${radioSearch eq 'confirm'}">
							<button class="btn m bgred" id="payCancel">취소</button>
							<button class="btn m bgred" id="abuseCancel">직권취소</button>
							</c:if>
						</c:if>
					</div>
				</div>
			</div>
			<!--  //contentSection  -->
		</div>
		<!--  //contents-->
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>