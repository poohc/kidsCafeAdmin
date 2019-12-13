<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="headerBox">
	<div class="headerWrap">
		<h1>
			<a href="${pageContext.request.contextPath}/main/dashboard.view">
				<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="키즈카페" />
			</a>
		</h1>
		<span class="date" id="full_date">2019-10-17 14:46:54</span>
		<div class="fr">
			<ul>
				<li>
					<b class="tbl">${sessionScope.franchiseInfoVo.localName}</b>
				</li>
				<li class="btn m bgwh">
					<a id="#logout" onclick="logout();">로그아웃</a>
				</li>
			</ul>
		</div>
	</div>
</div>