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
	
	$('#changePw').click(function(){
		if($('#currentPw').val().length == 0){
			alert('현재 비밀번호를 입력하세요.')
			$('#currentPw').focus();
			return;
		}
		
		if($('#changePw1').val().length == 0){
			alert('변경할 비밀번호를 입력하세요.')
			$('#changePw1').focus();
			return;
		}
		
		if($('#changePw2').val().length == 0){
			alert('변경할 비밀번호를 재입력하세요.')
			$('#changePw2').focus();
			return;
		}
		
		if($('#changePw1').val() != $('#changePw2').val()){
			alert('변경할 비밀번호가 일치하지 않습니다.');
			return;
		}
		
		if(confirm('비밀번호를 변경하시겠습니까?')){
			$.ajax({
				url : "${pageContext.request.contextPath}/franchise/changeFranchisePw.json",
				type : "POST",
				data : {
					franchiseNum : $('#franchiseNum').val(),
					currentPw : $('#currentPw').val(),
					changePw : $('#changePw1').val()
				},
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
						window.close();
					} else {
						alert(result.resultMessage);
						return;
					}
				}
			});
		}
		
	});
	
});
</script>
</head>

<body class="popupWrapper">
	<!--  popupSection -->
	<div class="popupSection">
		<h1>비밀번호 변경</h1>

		<div class="contentBox">
			<div class="dfTable left">
				<table class="tl">
					<colgroup>
						<col style="width: 200px">
					</colgroup>
					<tbody>
						<input type="hidden" id="franchiseNum" name="franchiseNum" value="${franchiseNum}">
						<tr>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">현재비밀번호</th>
						</tr>
						<tr>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">
								<input type="password" id="currentPw" name="currentPw">
							</td>
						</tr>
						<tr>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">변경 할 비밀번호</th>
						</tr>
						<tr>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">
								<input type="password" id="changePw1" name="changePw1">
							</td>
						</tr>
						<tr>
							<th style="border-right: groove;border-bottom-style: groove;text-align: left;">비밀번호 재입력</th>
						</tr>
						<tr>
							<td style="border-right: groove;border-bottom-style: groove;text-align: left;">
								<input type="password" id="changePw2" name="changePw2">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="dfTable bot fr">
				<button class="btn m bgbl" id="changePw">확인</button>
			</div>
		</div>

	</div>
</body>
</html>