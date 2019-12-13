<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
  <jsp:include page="../common/header.jsp" />
</head>

<body id="mobile_wrap">
<div class="pages">
  <div data-page="contact" class="page no-toolbar no-navbar">
    <div class="page-content">

      <c:import url="../common/top.jsp">
	    <c:param name="menuName" value="<span>슈퍼윙스</span>키즈카페" />
	  </c:import>

      <div id="pages_maincontent">

        <h2 class="page_title">불편사항 접수</h2>
        <div class="page_single layout_fullwidth_padding">
          <img src="${pageContext.request.contextPath}/resources/images/contact.png"/><br>
          <blockquote><center>
            항상 슈퍼윙스키즈카페를 이용해 주시는<br>
            고객님께 진심으로 감사드립니다.<br>
            매장이용중 불편사항에 대하여 글 남겨주시면<br>
            더 좋은 서비스를 위해 개선하도록 하겠습니다.</center>
          </blockquote>
          <h2 id="Note"></h2>
          <div class="contactform">
            <form class="cmxform" id="ContactForm" method="post" action="">
              <label>고객명</label>
              <input type="text" name="ContactName" id="ContactName" value="" class="form_input required" />
              <label>전화번호</label>
              <input type="number" minlength="11" inputmode="numberic" pattern="[0-9]*" name="UserPhone value="" class=" form_input required" placeholder="휴대폰번호" />
              <label>대상지점명</label>
              <input type="text" name="ContactEmail" id="ContactEmail" value="" class="form_input required email" />
              <label>내용:</label>
              <textarea name="ContactComment" id="ContactComment" class="form_textarea textarea required" rows="" cols=""></textarea>
              <a href="contact_successs" class="button_full">접수하기</a>
              <label id="loader" style="display:none;"><img src="${pageContext.request.contextPath}/resources/images/loader.gif" alt="Loading..." id="LoadingGraphic" /></label>
            </form>
          </div>
          <div class="clear"></div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>