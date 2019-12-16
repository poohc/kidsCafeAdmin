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
var memberPhoneList = new Array();

$(document).ready( function() {
	
    $('#memberKakaoSend').click(function(){
		if($('#kakao_add1').val().length == 0){
			alert('추가정보1 입력해주세요');
			$('#kakao_add1').focus();
			return false;
		}
		
		if($('#kakao_add2').val().length == 0){
			alert('추가정보2 입력해주세요');
			$('#kakao_add2').focus();
			return false;
		}
		
		'<c:if test="${not empty memberList}">'
		'<c:forEach items="${memberList}" var="memberList">'
		var memberInfo = {
				  kakao_name: '${memberList.Name}',
				  kakao_phone: '${memberList.Phone}',
				  kakao_add1: $('#kakao_add1').val(),
				  kakao_add2: $('#kakao_add2').val()
			   };
		if(memberInfo.kakao_phone.length == 10 || memberInfo.kakao_phone.length == 11){
			memberPhoneList.push(memberInfo);	
		}
		'</c:forEach>';
		'</c:if>'
		
		if(confirm(memberPhoneList.length + ' 명의 회원에게 카카오알림톡이 전송됩니다. 전송하시겠습니까?')){
			
			var sendList = new Array();
			
			for(var i=0; i<memberPhoneList.length; i++){
				sendList.push(memberPhoneList[i]);
				if((i+1)%1000 == 0){
					funcSendKakao(sendList);
					sendList = new Array();
				}
			}
			funcSendKakao(sendList);
		}
		
    });
    
    function funcSendKakao(sendList){
    		
    	$.ajax({
			url: "https://www.apiorange.com/api/group/notice.do",
			type: "POST",
			headers: {
				"Content-Type": "application/json; charset=utf-8",
				"Authorization": "0Aqm9GtEmYnNyk//VY3Ta3cPw6Q+/7YnLJed7v9D61U="
			},
			data: JSON.stringify({
				tmp_number : '11608',
				kakao_sender : "01030242890",
				total_ea : sendList.length,
				data : sendList
			}),
			success : function(data) {
				if (data && data.response_code == 200) {
					alert('카카오 알림톡 전송에 성공했습니다.');
					$.ajax({
						url : "${pageContext.request.contextPath}/member/insertSendKakaoHistory.json",
						type : "POST",
						data : {
							franchiseNum : $('#franchiseNum').val(),
							kakaoTalkSendCount : sendList.length,
							type : '카카오알림톡'
						},
						success : function(result) {
							if (result.resultCode == '00') {
								window.close();
							}  else {
								window.close();
							}
						},
						error : function(error){
							window.close();
						}
					});	
				
				} else if (data && data.response_code == 300) {
					alert('카카오 알림톡 발송을 위한 오렌지가 부족합니다. 충전하고 사용하여주세요.');
					window.close();
				} else {
					alert("카카오 알림톡 전송중 오류가 발생했습니다. 관리자에게 문의하여 주세요");
					window.close();
				}
			},
			error : function(request, status, error) {
				alert("카카오 알림톡 전송중 오류가 발생했습니다. 관리자에게 문의하여 주세요");
				window.close();
			}
		});
    }
    
});

</script>

</head>

<body class="popupWrapper">
	<!--  popupSection -->
	<div class="popupSection">
		<input type="hidden" id="franchiseNum" value="${sessionScope.franchiseInfoVo.franchiseeNum}">
		<h1>카카오 알림톡 전송
			<div class="txt_info tred"></div>
		</h1>

		<!--  contentBox  -->
		<div class="contentBox">
			<div class="dfTable left">
				<table class="tl">
					<colgroup>
						<col style="width: 80px">
						<col style="width: 80px">
						<col style="width: 80px">
						<col style="width: 80px">
					</colgroup>
					<tbody>
						<tr>
							<th>템플릿</th>
							<td class="tl" colspan="3">
								<img src="${pageContext.request.contextPath}/resources/images/kakaoTemplate.png" alt="카카오 알림톡 템플릿" />
							</td>
						</tr>
						<tr>
							<th>추가 정보1</th>
							<td class="tl">
								<input type="text" id="kakao_add1">								
							</td>
							<th>추가 정보2</th>
							<td class="tl">
								<input type="text" id="kakao_add2">								
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="dfTable bot fr">
				<button class="btn m bgbl" id="memberKakaoSend">전송</button>
			</div>
		</div>
		<!--  //contentBox  -->

	</div>
</body>
</html>