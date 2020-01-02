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
//         ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
//         ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
    });                    
   
    $('#calendar').datepicker('setDate', 'today');
    
});
</script>

</head>

<body class="popupWrapper">
	<!--  popupSection -->
	<div class="popupSection">
		<h1>공지사항 
			<c:choose>
				<c:when test="${mode eq 'insert'}">
				글쓰기
				</c:when>
				<c:when test="${mode eq 'update'}">
				<c:if test="${sessionScope.franchiseInfoVo.franchiseeStatus eq '1'}">
				수정
				</c:if>
				</c:when>
			</c:choose>
		</h1>
		<!--  contentBox  -->
		<c:choose>
		<c:when test="${sessionScope.franchiseInfoVo.franchiseeStatus eq '1'}">
		<div class="contentBox">
			<div class="dfTable left">
				<input type="hidden" id="mode" name="mode" value="${mode}" >
				<input type="hidden" id="noticeId" name="noticeId" value="${noticeInfo.NoticeId}" >
				<table class="tl">
					<colgroup>
						<col style="">
					</colgroup>
					<tbody>
						<tr>
							<th>제목</th>
						</tr>
						<tr>
							<td>
								<input type="text" id="title" name="title" style="width: 95%;" value="${noticeInfo.Title}">
							</td>
						</tr>
						<tr>
							<th>내용</th>
						</tr>
						<tr>
							<td>
								<textarea id="textContents" name="textContents" cols="50" rows="10" style="width:95%;">${noticeInfo.Contents}</textarea>
							</td>
						</tr>
						<tr>
							<th>게시일</th>
						</tr>
						<tr style="float: left;">
							<td>
								<input type="text" id="calendar" name="postDate" value="${noticeInfo.PostDate}">
							</td>
						</tr>
						<tr>
							<th>담당자</th>
						</tr>
						<tr>
							<td>
								<input type="text" id="manager" name="manager" style="width: 95%;" value="${noticeInfo.Manager}">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="dfTable bot fr">
				<button class="btn m bgbl" id="noticeWrite">완료</button>
			</div>
		</div>
		</c:when>
		<c:otherwise>
		<div class="contentBox">
			<div class="dfTable left">
				<table class="tl">
					<colgroup>
						<col style="">
					</colgroup>
					<tbody>
						<tr>
							<th>제목</th>
						</tr>
						<tr>
							<td style="text-align: left;">${noticeInfo.Title}</td>
						</tr>
						<tr>
							<th>내용</th>
						</tr>
						<tr>
							<% pageContext.setAttribute("newLineChar", "\n"); %>
							<td style="text-align: left;">${fn:replace(noticeInfo.Contents, newLineChar, "<br/>")}</td>
						</tr>
						<tr>
							<th>게시일</th>
						</tr>
						<tr>
							<td style="text-align: left;">${noticeInfo.PostDate}</td>
						</tr>
						<tr>
							<th>담당자</th>
						</tr>
						<tr>
							<td style="text-align: left;">${noticeInfo.Manager}</td>
						</tr>
					</tbody>
				</table>
			</div>			
		</div>
		</c:otherwise>		
		</c:choose>
	</div>
</body>
</html>