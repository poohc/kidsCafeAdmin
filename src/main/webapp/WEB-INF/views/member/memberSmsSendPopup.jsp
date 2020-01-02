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
	
	'<c:if test="${not empty memberList}">'
	'<c:forEach items="${memberList}" var="memberList">'
	var memberInfo = {
			  name: '${memberList.Name}',
			  phone: '${memberList.Phone}'
		   };
	if(memberInfo.phone.length == 10 || memberInfo.phone.length == 11){
		memberPhoneList.push(memberInfo);	
	}
	'</c:forEach>';
	'</c:if>'
	
	//글자 byte 수 제한
    $('#textContents').keyup(function(){
		$('#byteText').text(byteCheck($(this)) + 'Byte');
    });
    
    $('#memberSmsSend').click(function(){
		if($('#title').val().length == 0){
			alert('제목을 입력해주세요');
			$('#title').focus();
			return false;
		}
		
		if($('#textContents').val().length == 0){
			alert('문자 내용을 입력해주세요');
			$('#textContents').focus();
			return false;
		}
		
		if(confirm(memberPhoneList.length + ' 명의 회원에게 SMS 가 전송됩니다. 전송하시겠습니까?')){
			
			var sendList = new Array();
			
			for(var i=0; i<memberPhoneList.length; i++){
				sendList.push(memberPhoneList[i]);
				if((i+1)%1000 == 0){
					funcSendSms(sendList);
					sendList = new Array();
				}
			}
			funcSendSms(sendList);
		}
		
    });
    
    function funcSendSms(sendList){
    		
    	$.ajax({
			url: "https://www.apiorange.com/api/group/sms.do",
			type: "POST",
			headers: {
				"Content-Type": "application/json; charset=utf-8",
				"Authorization": "0Aqm9GtEmYnNyk//VY3Ta3cPw6Q+/7YnLJed7v9D61U="
			},
			data: JSON.stringify({
				sender : "01030242890",
				subject : $('#title').val(),
				total_ea : sendList.length,
				msg : $('#textContents').val(),
				data : sendList
			}),
			success : function(data) {
				if (data && data.response_code == 200) {
					alert('문자전송에 성공했습니다.');
				
					var byteLength = $('#byteText').text().replace('Byte','');
					var smsCnt = 0;
					var lmsCnt = 0;
				
					if(parseInt(byteLength) > 90){
						lmsCnt = sendList.length;
					} else {
						smsCnt = sendList.length;
					}
				
					$.ajax({
						url : "${pageContext.request.contextPath}/member/insertSmsSendHistory.json",
						type : "POST",
						data : {
							franchiseNum : $('#franchiseNum').val(),
							smsSendCount : smsCnt,
							lmsSendCount : lmsCnt,
							contents : $('#textContents').val()
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
					alert('문자 발송을 위한 오렌지가 부족합니다. 충전하고 사용하여주세요.');
					window.close();
				} else {
					alert("SMS 전송중 오류가 발생했습니다. 관리자에게 문의하여 주세요");
					window.close();
				}
			},
			error : function(request, status, error) {
				alert("SMS 전송중 오류가 발생했습니다. 관리자에게 문의하여 주세요");
				window.close();
			}
		});
    }
    
});




function byteCheck(el){
    var codeByte = 0;
    for (var idx = 0; idx < el.val().length; idx++) {
        var oneChar = escape(el.val().charAt(idx));
        if ( oneChar.length == 1 ) {
            codeByte ++;
        } else if (oneChar.indexOf("%u") != -1) {
            codeByte += 2;
        } else if (oneChar.indexOf("%") != -1) {
            codeByte ++;
        }
    }
    return codeByte;
}
</script>

</head>

<body class="popupWrapper">
	<!--  popupSection -->
	<div class="popupSection">
		<input type="hidden" id="franchiseNum" value="${sessionScope.franchiseInfoVo.franchiseeNum}">
		<h1>SMS 전송
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
							<th>제목</th>
							<td class="tl" colspan="3">
								<input class="tc" type="text" id="title" name="title" style="text-align: left;">
							</td>
						</tr>
						<tr>
							<th>문자 내용<br/>
								<span style="font-weight: normal;font-size: 8px;">90Byte 초과시 LMS 로 전송됩니다.</span><br/>
								<span style="font-weight: normal;font-size: 8px;">Byte 체크 : <span id="byteText"></span></span>
							</th>
							<td class="tl" colspan="3">
								<textarea id="textContents" name="textContents" cols="50" rows="10" style="width:95%;" limitbyte="80"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="dfTable bot fr">
				<button class="btn m bgbl" id="memberSmsSend">전송</button>
			</div>
		</div>
		<!--  //contentBox  -->

	</div>
</body>
</html>