<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport"
    content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/apple-touch-icon.png" />
  <link href="${pageContext.request.contextPath}/resources/images/apple-touch-startup-image-320x460.png" media="(device-width: 320px)"
    rel="apple-touch-startup-image">
  <link href="${pageContext.request.contextPath}/resources/images/apple-touch-startup-image-640x920.png"
    media="(device-width: 320px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image">
  <title>:::큐브관리자:::</title>
  <link rel="stylesheet" href="/resources/css/framework7.css">
  <link rel="stylesheet" href="/resources/css/style.css">
  <link type="text/css" rel="stylesheet" href="/resources/css/swipebox.css" />
  <link type="text/css" rel="stylesheet" href="/resources/css/animations.css" />
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700,800" rel="stylesheet">
</head>

<body id="mobile_wrap">
  <div class="pages">
    <div data-page="success" class="page no-toolbar no-navbar">
      <div class="page-content">
        <div class="navbarpages">
          <div class="navbar_left">
            <div class="logo_text"><a href="main"><span>슈퍼윙스</span>키즈카페</a></div>
          </div>
          <a href="#" data-panel="left" class="open-panel">
            <div class="navbar_right"><img src="${pageContext.request.contextPath}/resources/images/icons/white/menu.png" alt="" title="" /></div>
          </a>
        </div>

        <div id="pages_maincontent">
          <div class="page_single layout_fullwidth_padding">
            <div class="success_message">
              <span>접수완료</span>
              <img src="${pageContext.request.contextPath}/resources/images/icons/black/contact_success.png" />
              <p>고객님의 요청사항이 접수 되었습니다.</p>
              <p>담당자 확인 후 최대한 빨리 연락드리겠습니다.</p>
            </div>
            <a href="main" class="button_full">닫기</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>

</html>