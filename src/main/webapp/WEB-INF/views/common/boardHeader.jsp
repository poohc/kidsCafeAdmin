<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/Chart.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/utils.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Chart.min.css" />
<script type="text/javascript">
$(document).ready(function(){
	
	$('#requestReceptionPopup').click(function(){
		var popupTitle = "requestReceptionPopup" ;
		window.open('${pageContext.request.contextPath}/board/requestReceptionPopup.view', popupTitle,  'width=600,height=500,toolbar=0,location=0, directories=0, status=0, menubar=0');		
	});
	
	$('#noticeWritePopup').click(function(){
		var popupTitle = "noticeWritePopup" ;
		window.open('${pageContext.request.contextPath}/board/noticeWritePopup.view', popupTitle,  'width=420,height=600,toolbar=0,location=0, directories=0, status=0, menubar=0');		
	});
	
	$('input[name="telNo"]').keyup(function(e) {
		reg = /[^0-9]/gi;
        v = $(this).val();
        if (reg.test(v)) {
            $(this).val(v.replace(reg, ''));
            $(this).focus();
        }
	});
	
	$('.requestDiv').click(function() {
		
		if($(this).find('.chkOn').hasClass('on') == true){
			$(this).find('.chkOn').removeClass('on');
			$(this).find('#selectChk').prop("checked", false);
		} else {
			$(this).find('.chkOn').addClass('on');
			$(this).find('#selectChk').prop("checked", true);
		}
		
	});
	
	$('.noticeDiv').click(function() {
		
		if($(this).find('.chkOn').hasClass('on') == true){
			$(this).find('.chkOn').removeClass('on');
			$(this).find('#selectChk').prop("checked", false);
		} else {
			$(this).find('.chkOn').addClass('on');
			$(this).find('#selectChk').prop("checked", true);
		}
		
	});
	
	$('#requestReceptionWrite').click(function(){
		
		if($('#title').val().length == 0){
			alert('제목을 입력해주세요.');
			$('#title').focus();
			return;
		}
		
		if($('#textContents').val().length == 0){
			alert('내용을 입력해주세요.');
			$('#textContents').focus();
			return;
		}
		
		if($('#telNo').val().length == 0){
			alert('연락처를 입력해주세요.');
			$('#telNo').focus();
			return;
		}
		
		if($('#telNo').val().length < 10 || $('#telNo').val().length > 11) {
			alert('연락처는 10자리 혹은 11자리입니다.');
			$('#telNo').focus();
			return;
		}
		
		if(confirm('요청게시판에 접수 하시겠습니까?')){
			
			$.ajax({
				url : "${pageContext.request.contextPath}/board/requestReceptionWrite.json",
				type : "POST",
				data : {
					FranchiseeNum : $('#franchiseNum').val(),
					Title : $('#title').val(),
					Contents : $('#textContents').val(),
					TelNo : $('#telNo').val(),
					ReceptionNo : $('#receptionNo').val()
				},
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
						opener.parent.movePage(1);
						window.close();
					} else {
						alert(result.resultMessage);
						return;
					}
				}
			});
		}
		
	});
	
// 	$('#processingResult').change(function(){
// 		if($('#processingResult').val() == '기타'){
// 			$('.etcProcess').show();
// 		} else {
// 			$('.etcProcess').hide();
// 		}
// 	});
	
	$('#processingComplete').click(function(){
		
		if(confirm('A/S 를 처리하시겠습니까?')){
			
			$.ajax({
				url : "${pageContext.request.contextPath}/board/requestProcessing.json",
				type : "POST",
				data : {
					indexNo : $('#indexNo').val(),
					processingResult : $('#processingResult').val(),
					etc : $('#etcProcess').val()
				},
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
						opener.parent.movePage(1);
						window.close();
					} else {
						alert(result.resultMessage);
						return;
					}
				}
			});
		}
		
	});
	
	
	$('#deleteRequest').click(function(){
		
		if($('input[name="selectChk"]:checked').length == 0){
			alert('삭제할 A/S 를 선택하세요.');
			return;
		}
		
		if(confirm('A/S 를 삭제 하시겠습니까?')){
			
			var formData = $('#requestBoardForm').serializeObject();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/board/requestReceptionDelete.json",
				type : "POST",
				contentType: 'application/json',
				data : JSON.stringify(formData),
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
						movePage(1);
					} else {
						alert(result.resultMessage);
						return;
					}
				},
				error : function(error){
					alert('A/S 삭제 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
					return;
				}
			});
		}
	});
	
	$('#noticeWrite').click(function(){
		
		if($('#title').val().length == 0){
			alert('제목을 입력해주세요.');
			$('#title').focus();
			return;
		}
		
		if($('#textContents').val().length == 0){
			alert('내용을 입력해주세요.');
			$('#textContents').focus();
			return;
		}
		
		if($('#manager').val().length == 0){
			alert('담당자를 입력해주세요.');
			$('#manager').focus();
			return;
		}
		
		var confirmText = '공지사항을 등록 하시겠습니까?';
		var url = '${pageContext.request.contextPath}/board/noticeWrite.json';
		if($('#mode').val() == 'update'){
			confirmText = '공지사항을 수정 하시겠습니까?';
			url = '${pageContext.request.contextPath}/board/noticeUpdate.json';
		}
		
		if(confirm(confirmText)){
			
			$.ajax({
				url : url,
				type : "POST",
				data : {
					title : $('#title').val(),
					contents : $('#textContents').val(),
					manager : $('#manager').val(),
					postDate : $('#calendar').val().replace(/[^0-9]/g,""),
					noticeId : $('#noticeId').val()
				},
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
						opener.parent.movePage(1);
						window.close();
					} else {
						alert(result.resultMessage);
						return;
					}
				},
				error : function(error){
					alert('오류가 발생했습니다. 관리자에게 문의하여 주세요.');
					return;
				}
			});
		}
		
	});
	
	$('#deleteNotice').click(function(){
		
		if($('input[name="selectChk"]:checked').length == 0){
			alert('삭제할 공지사항을 선택하세요.');
			return;
		}
		
		if(confirm('공지사항을 삭제 하시겠습니까?')){
			
			var formData = $('#noticeForm').serializeObject();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/board/noticeDelete.json",
				type : "POST",
				contentType: 'application/json',
				data : JSON.stringify(formData),
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
						movePage(1);
					} else {
						alert(result.resultMessage);
						return;
					}
				},
				error : function(error){
					alert('공지사항 삭제 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
					return;
				}
			});
		}
	});
	
});

function movePage(currentPage){
	$('#currentPage').val(currentPage); 
	$('#frm').submit();
}

function openRequestProcessingPopup(indexNo){
	var popupTitle = "requestProcessingPopup" ;
	window.open('${pageContext.request.contextPath}/board/requestProcessingPopup.view?indexNo='+indexNo, popupTitle,  'width=550,height=500,toolbar=0,location=0, directories=0, status=0, menubar=0');
}

function openNoticeUpdatePopup(noticeId){
	var popupTitle = "noticeUpdatePopup" ;
	window.open('${pageContext.request.contextPath}/board/noticeUpdatePopup.view?noticeId='+noticeId, popupTitle,  'width=420,height=600,toolbar=0,location=0, directories=0, status=0, menubar=0');
}

</script>