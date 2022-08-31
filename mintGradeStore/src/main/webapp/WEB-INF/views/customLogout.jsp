<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt"%>
<%@ include file="includes/header.jsp"%>

<div class="logInOutPage">
	<div class="logOutMessage">
		<h1>로그아웃</h1>
		<img src="/resources/img/mainLogo.png" width="30" height="30" alt="icon">
		<h3>${error}</h3>
		<h3>${logout}</h3>
	</div>
	<div class="logInOutBox">
		<form role="form" name="logLogOut" method="post" action="/customLogout" style="border: solid 2px #01b4c4; padding: 22px 30px 22px 30px; border-radius: .5rem;">
			<fieldset style="border: none;">
				<!-- fieldset: 관련 요소를 묶는 역할. -->
				<h3>로그아웃 하시겠어요?</h3>
				<br>
				<a href="index.html" id="logoutBtn" style="text-decoration: none;">네</a>
				<!-- <a href="#" id="logoutCancelBtn" style="text-decoration: none;">아니</a> -->
			</fieldset>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" />
		</form>
		<!-- GET 방식으로 로그아웃 페이지에 접근하고 로그아웃 버튼을 누르면 포스트 방식으로 처리. -->
	</div>
</div>

<script>
	$("#logoutBtn").on("click", function(e) {
		e.preventDefault();

		$("form").submit();
	});
</script>

<c:if test="${param.logout != null}">
	<script>
		$(document).ready(function() {

			alert("로그아웃 되었습니다.");
		});
	</script>
	<!-- 로그아웃 파라미터 값이 있다면 로그아웃 안내 창 표시. -->
</c:if>

<%@ include file="includes/footer.jsp"%>