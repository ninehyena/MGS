<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt"%>
<%@ include file="includes/header.jsp"%>

<div class="logInOutPage">
	<div class="logInMessage">
		<h1>로그인</h1>
		<img src="/resources/img/mainLogo.png" width="30" height="30" alt="icon">
		<h3>${error}</h3>
		<h3>${logout}</h3>
	</div>
	<div class="logInOutBox">
		<form id="loginBox" method="post" action="/login" style="border: solid 2px #01b4c4; padding: 22px 30px 22px 30px; border-radius: .5rem;">
			<div class="form-group">
				<label>
					아이디
					<span> (ID)</span>
				</label>
				<input type="text" name="username" placeholder="아이디를 입력해주세요." class="form-control">
			</div>
			<br>
			<div class="form-group">
				<label>
					비밀번호
					<span> (PASSWORD)</span>
				</label>
				<input type="password" name="password" placeholder="비밀번호를 입력해주세요." class="form-control">
			</div>
			<br>
			<div class="form-group">
				<input type="checkbox" name="remember-me"> 자동 로그인
			</div>
			<br>
			<span class="forgetIdPw">아이디 혹은 비밀번호를 잊으셨나요?</span>
			<br>
			<span class="findIdPw">
				<a href="/findUserIdPw">&#62;&#62; 아이디 / 비밀번호 찾기</a>
			</span>
			<br>
			<br>
			<div class="form-group">
				<input type="submit" id="loginBtn" value="로그인">
			</div>
			<span class="joinNoNo">아직 회원이 아니신가요?</span>
			<br>
			<span class="joinGoGo">
				<a href="/signup">&#62;&#62; 회원가입 하러 가기</a>
			</span>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" />

		</form>
	</div>
</div>

<%@ include file="includes/footer.jsp"%>