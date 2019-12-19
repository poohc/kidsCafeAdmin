<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#selectedFranchise').change(function() {
		movePage($('#currentPage').val());
	});
			
	$('#searchBtn').click(function(){
// 		if($('#searchText').val().length == 0){
// 			alert('검색어를 입력해주세요.');
// 			return;
// 		}
		
		if($('#searchText').val().length > 0){
			$('#searchKeyword').val($('#searchText').val());	
		} else {
			$('#searchKeyword').val('');
		}
		movePage($('#currentPage').val());
	});
	
	$('.franchiseDiv').click(function() {
		if($(this).find('.chkOn').hasClass('on') == true){
			$(this).find('.chkOn').removeClass('on');
			$(this).find('#selectedFranchise').prop("checked", false);
		} else {
			$(this).find('.chkOn').addClass('on');
			$(this).find('#selectedFranchise').prop("checked", true);
		}
		
	});
	
// 	$('#lastVisitMonth').change(function(){
// 		movePage($('#currentPage').val());
// 	});
	
	$('#memberInfoUpdate').click(function(){
		if($('#phone').val().length == 0){
			alert('전화번호를 입력해주세요.');
			$('#phone').focus();
			return;
		}
		
		if($('#name').val().length == 0){
			alert('이름을 입력해주세요.');
			$('#name').focus();
			return;
		}
		
		if(confirm('회원정보를 업데이트 하시겠습니까?')){
			
			$.ajax({
				url : "${pageContext.request.contextPath}/member/memberInfoUpdate.json",
				type : "POST",
				data : {
					mCode : $('#mCode').val(),
					phone : $('#phone').val(),
					agreeFlag : $('#agreeFlag').val(),
					termsFlag : $('#termsFlag').val(),
					name : $('#name').val()
				},
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
						opener.parent.memberDetail($('#mCode').val(), $('#phone').val());
						window.close();
					} else {
						alert(result.resultMessage);
						return;
					}
				},
				error : function(error){
					alert('회원정보 업데이트 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
					return;
				}
			});
		}
		
	});
	
	$('input[name="updatePoint"]').keyup(function(e) {
		reg = /[^0-9]/gi;
        v = $(this).val();
        if (reg.test(v)) {
            $(this).val(v.replace(reg, ''));
            $(this).focus();
        }
	});
	
	$('#memberPointUpdate').click(function(){
		
		var flag = 'true';
		
		var type = '적립';
		if($('#addMinus').val() == 0){
			type = '차감';
		}
		
		if($('#updatePoint').val().length == 0){
			alert(type + ' 포인트 정보를 입력해주세요.');
			$('#updatePoint').focus();
			flag = 'false';
			return;
		}
		
		if(type == '차감'){
			//차감할 포인트가 누적 포인트 보다 클 경우
			if(parseInt($('#updatePoint').val()) > parseInt($('#point').val())){
				alert(type + ' 포인트는 누적포인트보다 클 수 없습니다.');
				$('#updatePoint').val('');	
				flag = 'false';
			}
		}
		
		if($('#staff').val().length == 0){
			alert(type + ' 스탭명을 입력해 주세요.');
			$('#staff').focus();
			flag = 'false';
			return;
		}
		
		if($('#comment').val().length == 0){
			alert(type + ' 메모를 입력해주세요.');
			$('#comment').focus();
			flag = 'false';
			return;
		}
		
		if(flag == 'true'){
			if(confirm('포인트 정보를 업데이트 하시겠습니까?')){
				
				$.ajax({
					url : "${pageContext.request.contextPath}/member/pointInfoUpdate.json",
					type : "POST",
					data : {
						mCode : $('#mCode').val(),
						point : $('#updatePoint').val(),
						staff : $('#staff').val(),
						comment : $('#comment').val(),
						addMinus : $('#addMinus').val()
					},
					success : function(result) {
						if (result.resultCode == '00') {
							alert(result.resultMessage);
							opener.parent.memberDetail($('#mCode').val(), $('#phone').val());
							window.close();
						} else {
							alert(result.resultMessage);
							return;
						}
					},
					error : function(error){
						alert('포인트 정보 업데이트 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
						return;
					}
				});
			}	
		}
		
	});
	
	
	
	$('#pointInfoUpdate').click(function(){
		if($('#totalPoint').val().length == 0){
			alert('포인트를 입력해주세요.');
			$('#totalPoint').focus();
			return;
		}
		
		if(confirm('포인트 정보를 업데이트 하시겠습니까?')){
			
			$.ajax({
				url : "${pageContext.request.contextPath}/member/pointInfoUpdate.json",
				type : "POST",
				data : {
					mCode : $('#mCode').val(),
					point : $('#totalPoint').val()
				},
				success : function(result) {
					if (result.resultCode == '00') {
						alert(result.resultMessage);
						memberDetail($('#mCode').val(), $('#phone').val());
					} else {
						alert(result.resultMessage);
						return;
					}
				},
				error : function(error){
					alert('포인트 정보 업데이트 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
					return;
				}
			});
		}
	});
	
	$('#familyInfoUpdate').click(function(){
		
		var validChk = 'true';
		
		$('.newFamily').each( function() {
           if($(this).val().length == 0){
        	   alert('가족 이름을 입력해주세요.');
        	   $(this).focus();
        	   validChk = 'false';
        	   return false;
           } 
        });
		
		if(validChk == 'true'){
			if(confirm('가족정보를 업데이트 하시겠습니까?')){
				
				var formData = $('#familyForm').serializeObject();
				
				$.ajax({
					url : "${pageContext.request.contextPath}/member/familyInfoUpdate.json",
					type : "POST",
					contentType: 'application/json',
					data : JSON.stringify(formData),
					success : function(result) {
						if (result.resultCode == '00') {
							alert(result.resultMessage);
							memberDetail($('#mCode').val(), $('#phone').val());
						} else {
							alert(result.resultMessage);
							return;
						}
					},
					error : function(error){
						alert('가족 정보 업데이트 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
						return;
					}
				});
			}
		}
	});
	
});

function searchExcelDownload(){
	$('#franchiseNum').val($('#selectedFranchise').val());
	$('#searchKeyword').val($('#searchKeyword').val());
	$('#frm').attr('action','${pageContext.request.contextPath}/member/searchExcelDownload.do');
	$('#frm').submit();
}

function groupMemberExcelDownload(){
	$('#franchiseNum').val($('#selectedFranchise').val());
	$('#searchKeyword').val($('#searchKeyword').val());
	$('#frm').attr('action','${pageContext.request.contextPath}/member/groupMemberExcelDownload.do');
	$('#frm').submit();
}

function memberDetail(mCode, phone){
	$('#mCode').val(mCode);
	$('#phone').val(phone);
	$('#frm').attr('action','${pageContext.request.contextPath}/member/memberDetail.view');
	$('#frm').submit();
}

function movePage(currentPage){
	$('#currentPage').val(currentPage);
	
	//관리자 계정일 경우 가맹점 정보 체크박스 넘기기
	if('${sessionScope.franchiseInfoVo.franchiseeStatus}' == '1'){
		
		if($('input[name="selectedFranchise"]:checked').length > 0){
			var franchiseList = '';
			$('input[name="selectedFranchise"]:checked').each(function(){
				franchiseList += $(this).val() + ',';
			});
			franchiseList = franchiseList.substring(0, franchiseList.length - 1);
			$('#franchiseNum').val(franchiseList);	
		} else {
			$('#franchiseNum').val($('#selectedFranchise').val());
		}
		
	} else {
		$('#franchiseNum').val($('#selectedFranchise').val());	
	}
	$('#searchMonth').val($('#lastVisitMonth').val());
	$('#frm').submit();
}

function excelDownload(){
	$('#franchiseNum').val($('#selectedFranchise').val()); 
	$('#frm').attr('action','${pageContext.request.contextPath}/member/excelDownload.do');
	$('#frm').submit();
}

//가족 추가삭제 처리
function familyInsertDelete(state, qrCode){
	
	if(state == 'insert'){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/member/getNewMemberInfo.json",
			type : "POST",
			data : {},
			success : function(result) {
				if (result.resultCode == '00') {
					var insertTr = '';
					insertTr += '<tr class="familyTr" id="familyTr_'+result.qrCode+'">';
					insertTr += '<input type="hidden" name="familyQrCode" value="'+result.qrCode+'">';
					insertTr += '<input type="hidden" name="familyMflag" value="0">';
					insertTr += '<td>'+result.qrCode+'</td>';
					insertTr += '<td><select id="adult" name="familyAdult"><option value="1">성인</option><option value="0">아동</option></select></td>';
					insertTr += '<td><input class="tc newFamily" name="familyName" /></td>';
					insertTr += '<td>'+result.joinDate + '&nbsp;';
					insertTr += '<span class="btn m lngy row">';
					insertTr += '<a href="#familyDelete" onclick="familyInsertDelete(\'delete\', \''+result.qrCode+'\');">';
					insertTr += '<i class="ico minus"></i>';
					insertTr += '</a>';
					insertTr += '</span>';
					insertTr += '</td>';
					insertTr += '</tr>';
					$("#familyTbody").append(insertTr);
				} else {
					alert('추가 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
					return;
				}
			},
			error : function(error){
				alert('추가 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
				return;
			}
		});				
		
		
	} else if(state == 'delete'){
		var deletedQrCode = qrCode;
		$.ajax({
			url : "${pageContext.request.contextPath}/member/deleteMemberAvailable.json",
			type : "POST",
			data : {
				qrCode : deletedQrCode
			},
			success : function(result) {
				if (result.resultCode == '00') {
					$('#familyTr_'+qrCode+'').remove();		
				} else if (result.resultCode == '09'){
					alert('삭제할수 없는 가족입니다.');
					return;
				} else {
					$('#familyTr_'+qrCode+'').remove();
				}
			}
		});		
	}
}

//회원탈퇴 처리
function signOut(){
	if(confirm('해당회원을 탈퇴 처리 하시겠습니까?')){
		$.ajax({
			url : "${pageContext.request.contextPath}/member/memberSignOut.json",
			type : "POST",
			data : {
				phone : $('#phone').val(),
				MCode : $('#mCode').val()
			},
			success : function(result) {
				if (result.resultCode == '00') {
					alert('탈퇴 처리 되었습니다.');
					$('#searchKeyword').val('');
					$('#frm').attr('action', '${pageContext.request.contextPath}/member/memberSearch.view');
					$('#frm').submit();
				} else {
					alert('회원 탈퇴 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
				}
			},
			error : function(error){
				alert('회원 탈퇴 중 오류가 발생했습니다. 관리자에게 문의하여 주세요.');
			}
		});	
	}
}

function openMemberInfoUpdatePopup(mCode, phone){
	var popupTitle = "memberInfoUpdPopup" ;
	window.open('${pageContext.request.contextPath}/member/memberInfoUpdatePopup.view?mCode='+mCode+'&phone='+phone, popupTitle,  'width=765,height=300,toolbar=0,location=0, directories=0, status=0, menubar=0');
}

function openMemberPointUpdatePopup(mCode, phone){
	var popupTitle = "memberPointUpdPopup" ;
	window.open('${pageContext.request.contextPath}/member/memberPointUpdatePopup.view?mCode='+mCode+'&phone='+phone, popupTitle,  'width=765,height=300,toolbar=0,location=0, directories=0, status=0, menubar=0');
}

function openMemberSmsSendPopup(){
	var popupTitle = "memberSmsSendPopup" ;
	window.open('${pageContext.request.contextPath}/member/memberSmsSendPopup.view?franchiseNum='+$('#franchiseNum').val()+'&searchKeyword='+$('#searchKeyword').val()+'&searchMonth='+$('#searchMonth').val()+'&sms=sms', popupTitle, 'width=765,height=450,toolbar=0,location=0, directories=0, status=0, menubar=0');
}

function openMemberNoticeTalkSendPopup(){
	var popupTitle = "memberNoticeTalkSendPopup" ;
	window.open('${pageContext.request.contextPath}/member/memberNoticeTalkSendPopup.view?franchiseNum='+$('#franchiseNum').val()+'&searchKeyword='+$('#searchKeyword').val()+'&searchMonth='+$('#searchMonth').val()+'&sms=sms', popupTitle, 'width=765,height=750,toolbar=0,location=0, directories=0, status=0, menubar=0');
}

</script>