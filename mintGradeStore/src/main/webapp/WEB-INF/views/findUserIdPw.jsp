<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt"%>
<%@ include file="includes/header.jsp"%>

<div class="logInOutPage">
	<div class="logInMessage">
		<h1>아이디 / 비밀번호 찾기</h1>
		<img src="/resources/img/mainLogo.png" width="30" height="30" alt="icon">
		<h3>${error}</h3>
		<h3>${logout}</h3>
	</div>
	<div class="findBox">
		<form id="findBox" method="post" action="/findUserIdPw" style="border: solid 2px #01b4c4; padding: 22px 30px 22px 30px; border-radius: .5rem;">
			<div class="findChoice" align="center">
				<table>
					<tr>
						<td id="findId" class="find-id">아이디를 찾을래요</td>
						<td>|</td>
						<td id="findPw" class="find-pw">비밀번호를 찾을래요</td>
					</tr>
				</table>
			</div>
			<br>
			<div class="form-group">
				<div class="findIdBox">
					<label>
						아이디 찾기
						<span> (FIND ID)</span>
					</label>
					<input type="text" name="userMail" id="userMail" placeholder="이메일 주소를 입력해주세요." class="form-control">
					<div id="checkInfo">찾으시는 아이디의 이메일 주소를 입력해주세요.</div>
					<br>
				</div>
			</div>
			<div class="form-group">
				<div class="findPwBox">
					<label>
						비밀번호 찾기
						<span> (FIND PASSWORD)</span>
					</label>
					<input type="text" name="userId" id="userId" placeholder="아이디를 입력해주세요." class="form-control"> <input type="text" name="userMail" id="userPwMail" placeholder="이메일 주소를 입력해주세요."
						class="form-control"
					>
					<div id="checkInfo">비밀번호를 찾으시는 아이디, 이메일 주소를 입력해주세요.</div>
					<br>
				</div>
			</div>
			<span class="joinNoNo">아직 회원이 아니신가요?</span>
			<br>
			<span class="joinGoGo">
				<a href="/signup">&#62;&#62; 회원가입 하러 가기</a>
			</span>
			<br>
			<br>
			<span class="findYes">아이디 / 비밀번호를 찾으셨나요?</span>
			<br>
			<span class="loginGoGo">
				<a href="/customLogin">&#62;&#62; 로그인 하러 가기</a>
			</span>
			<div class="findBtnBrother">
				<input type="submit" value="아이디 찾기" id="idFindBtn" style="display: none;"> <input type="submit" value="비밀번호 찾기" id="pwFindBtn" style="display: none;">
			</div>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" />
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {

		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";

		$(document).ajaxSend(function(e, xhr, options) {

			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});

		// 아이디 찾기, 비밀번호 찾기 박스
		$("#findId").on("click", function(e) {

			$("#findId").css("font-weight", "bold");
			$(".findIdBox").css("display", "block");
			$("#idFindBtn").css("display", "block");
			$("#findPw").css("font-weight", "normal");
			$(".findPwBox").css("display", "none");
			$("#pwFindBtn").css("display", "none");
		});

		$("#findPw").on("click", function(e) {

			$("#findPw").css("font-weight", "bold");
			$(".findPwBox").css("display", "block");
			$("#pwFindBtn").css("display", "block");
			$("#findId").css("font-weight", "normal");
			$(".findIdBox").css("display", "none");
			$("#idFindBtn").css("display", "none");
		});

		// 아이디 찾기 클릭.
		var mailReg = /^[a-zA-Z0-9]([-_\.]?[a-zA-Z0-9])*@[a-z0-9]([-_\.]?[a-z0-9])*\.[a-z]{2,3}$/;

		$("#idFindBtn").on("click", function(e) {
			e.preventDefault();

			console.log("아이디 찾기 버튼 클릭");

			var userMail = $("#userMail").val();
			var data = {
				userMail : userMail
			};

			if (userMail == '') {
				alert("이메일을 입력해주세요.");
				return false;
			}

			if (!mailReg.test(userMail)) {
				alert("이메일을 양식에 맞게 입력해주세요.");
				return false;
			}

			$.ajax({
				type : "POST",
				url : "/findUserIdPw/id",
				data : data,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(result) {
					if (result != 'not found') {
						alert("찾으시는 아이디는 [" + result + "] 예요.");
					} else {
						alert("해당 이메일로 가입한 아이디가 존재하지 않아요.");
						return false;
					}
				}
			});
		});

		// 비밀번호 찾기.
		$("#pwFindBtn").on("click", function(e) {
			e.preventDefault();

			console.log("비밀번호 찾기 버튼 클릭");

			var userId = $("#userId").val();
			var userPwMail = $("#userPwMail").val();

			if (userId == '') {
				alert("아이디를 입력해주세요.");
				return false;
			}

			if (userPwMail == '') {
				alert("이메일을 입력해주세요.");
				return false;
			}

			if (!mailReg.test(userPwMail)) {
				alert("이메일을 양식에 맞게 입력해주세요.");
				return false;
			}

			var promise = $.ajax({
				type : "POST",
				url : "/findUserIdPw/pw",
				data : {
					userId : userId,
					userPwMail : userPwMail
				},
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				}
			});

			promise.then(successFunction);
			function successFunction(result) {
				if (result == 'found') {
					if (confirm("입력하신 이메일로 임시 비밀번호를 발급 받으시겠어요?") == true) {
						$.ajax({
							url : "/findUserIdPw/pwMail",
							type : "POST",
							data : {
								userId : userId,
								userPwMail : userPwMail
							},
							beforeSend : function(xhr) {
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},
							success : function(result) {
								if (result == 'success') {
									alert("이메일로 임시 비밀번호를 발급해드렸으니 확인해주세요.");
								} else if (result == 'fail') {
									alert("임시 비밀번호 발급 도중 문제가 발생했어요. 다시 시도해주세요.");
									return false;
								} else {
									alert("입력하신 정보가 정확한지 확인해주세요.");
									return false;
								}
							}
						});
					}
				} else {
					alert("입력하신 정보가 정확한지 확인해 주세요.");
					return false;
				}
			}
		});
	});
</script>

<%@ include file="includes/footer.jsp"%>