<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="utf-8">
<title>:::키즈코리아:::</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script type="text/javascript">
$.fn.serializeObject = function() {
  var result = {}
  var extend = function(i, element) {
    var node = result[element.name]
    if ("undefined" !== typeof node && node !== null) {
      if ($.isArray(node)) {
        node.push(element.value)
      } else {
        result[element.name] = [node, element.value]
      }
    } else {
      result[element.name] = element.value
    }
  }

  $.each(this.serializeArray(), extend)
  return result
}

// $(document).ready(function(){
	
// 	$('.menuClass').click(function(){
		
// 		if($(this).attr('id') != 'goDash'){
// 			if($(this).hasClass('on') == true){
// 				$(this).removeClass('on');	
// 			} else {
// 				$(this).addClass('on');
// 			}	
// 		}
		
// 	});
	
// });

function logout(){
	$.ajax({
		url : "${pageContext.request.contextPath}/login/logoutProcess.json",
		type : "POST",
		data : {},
		success : function(result) {
			if (result.resultCode == '00') {
				location.replace('${pageContext.request.contextPath}/login/login.view');
			} else {
				alert('로그아웃에 실패했습니다. 관리자에게 문의하여 주세요.');
			}
		}
	});
}

function clock() {
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth();
    var day = date.getDate();
    var hour = date.getHours();
    var minute = date.getMinutes();
 	var seconds = date.getSeconds();
    
    day = day < 10 ? '0' + day : day;
    hour = hour < 10 ? '0' + hour : hour;
    minute = minute < 10 ? '0' + minute : minute;
    seconds = seconds < 10 ? '0' + seconds : seconds;
    
    $('#full_date').text(year + '-' + (month+1) + '-' + day + ' ' + hour + ':' + minute + ':' + seconds);
}

setInterval(clock, 1000);
</script>