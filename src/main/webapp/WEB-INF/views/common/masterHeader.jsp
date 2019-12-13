<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#ticketInsertBtn').click(function(){
		if($('#ticketName').val().length == 0){
			alert('입장권명을 입력해주세요.');
			$('#ticketName').focus();
			return;
		}
		
		if($('#ticketPrice').val().length == 0){
			alert('금액을 입력해주세요.');
			$('#ticketPrice').focus();
			return;
		}
		
		if($('#ticketPlayTime').val().length == 0){
			alert('이용시간을 입력해주세요.');
			$('#ticketPlayTime').focus();
			return;
		}
		
		var formData = $('#ticketForm').serializeObject();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/master/ticketInsert.json",
			type : "POST",
			contentType: 'application/json',
			data : JSON.stringify(formData),
			success : function(result) {
				if (result.resultCode == '00') {
					alert(result.resultMessage);
					location.replace('${pageContext.request.contextPath}/master/ticket.view');
				} else {
					alert(result.resultMessage);
					return;
				}
			},
			error : function(error){
				alert('입장권 정보 추가 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
				return;
			}
		});
		
	});
	
	$('#ticketDeleteBtn').click(function(){
		
		var formData = $('#ticketForm').serializeObject();
		
		if(confirm('선택한 입장권을 삭제 하시겠습니까?')){
			$.ajax({
				url : "${pageContext.request.contextPath}/master/ticketDelete.json",
				type : "POST",
				contentType: 'application/json',
				data : JSON.stringify(formData),
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
						location.replace('${pageContext.request.contextPath}/master/ticket.view');
					} else {
						alert(result.resultMessage);
						return;
					}
				},
				error : function(error){
					alert('입장권 정보 삭제 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
					return;
				}
			});	
		}
		
	});
	
});
	
</script>