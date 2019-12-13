<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/header.jsp" />
<script type="text/javascript">
	function loginProcess() {
		if ($('#fid').val().length == 0) {
			alert('아이디를 입력하세요');
			$('#fid').focus();
			return;
		}

		if ($('#password').val().length == 0) {
			alert('비밀번호를 입력하세요.');
			$('#password').focus();
			return;
		}

		$.ajax({
			url : "${pageContext.request.contextPath}/login/loginProcess.json",
			type : "POST",
			data : {
				fid : $('#fid').val(),
				password : $('#password').val()
			},
			success : function(result) {
				if (result.resultCode == '00') {
					location.replace('${pageContext.request.contextPath}/main/dashboard.view');
				} else {
					alert(result.resultMessage);
				}
			}
		});
	}
</script>
</head>

<body>
	<div class="wrapper" id="wrapper">
		<div class="loginBox">
			<div class="loginWrap">
				<h1>
					<img src="${pageContext.request.contextPath}/resources/images/logo_login.png" alt="wcms 관리시스템">
				</h1>
				<div class="inputSection">
					<div class="fl">
						<input type="text" id="fid" name="fid" placeholder="아이디">
						<input type="password" id="password" name="password" placeholder="비밀번호">
					</div>
					<span class="btn bgbl fr">
						<a href="#login" onclick="loginProcess();">로그인</a>
					</span>
				</div>
				<div class="txtinfoBox">
					<i class="ico exmk"></i>
					<p class="txt_info">
						발급받은 가맹점코드가 아이디입니다. <br />이용 불편 시, 아래로 연락 주시기 바랍니다. <br />
						<span class="tbl">Mail : snlgu@kids-korea.com</span>
					</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>