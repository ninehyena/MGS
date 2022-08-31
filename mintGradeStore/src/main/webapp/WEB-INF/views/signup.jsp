<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="fmt"%>
<%@ include file="includes/header.jsp"%>

<div class="signupPage">
	<div class="signupMessage">
		<h1>회원가입</h1>
		<img src="/resources/img/mainLogo.png" width="30" height="30" alt="icon">
		<h3></h3>
		<h3></h3>
	</div>
	<div class="signupBox">
		<form id="signupBox" role="form" method="post" autocomplete="off" style="border: solid 2px #01b4c4; padding: 22px 30px 22px 30px; border-radius: .5rem;">
			<span class="must">* 표시된 항목은 꼭 입력해주세요.</span>
			<br>
			<div class="form-group">
				<label>
					<span class="star">*</span>
					아이디
					<span> (ID)</span>
				</label>
				<input type="text" required id="userId" name="userId" placeholder="사용하실 아이디를 입력해주세요." class="form-control">
				<div id="checkInfo">(영문자 또는 영문자와 숫자 조합 5~15자)</div>
				<span id="ava" class="checkB">사용 가능한 아이디에요.</span>
				<span id="over" class="checkR">이미 존재하는 아이디에요.</span>
				<span id="impo" class="checkR">사용할 수 없는 아이디에요.</span>
			</div>
			<br>
			<div class="form-group">
				<label>
					<span class="star">*</span>
					비밀번호
					<span> (PASSWORD)</span>
				</label>
				<input type="password" required id="userPw" name="userPw" required="required" placeholder="사용하실 비밀번호를 입력해주세요." class="form-control">
				<div id="checkInfo">(영문자와 숫자 특수문자(!@#$%^&*~) 조합 8~20자)</div>
				<span id="impoPw" class="checkR">비밀번호를 양식에 맞게 입력해주세요.</span>
			</div>
			<br>
			<div class="form-group">
				<label>
					<span class="star">*</span>
					비밀번호 확인
					<span> (PASSWORD CHECK)</span>
				</label>
				<input type="password" required id="userPw" name="userPwCheck" required="required" placeholder="입력한 비밀번호를 다시 입력해주세요." class="form-control">
				<span id="checkYes" class="checkB">비밀번호가 일치해요.</span>
				<span id="checkNo" class="checkR">비밀번호가 일치하지 않아요.</span>
			</div>
			<br>
			<div class="form-group">
				<label>
					<span class="star">*</span>
					닉네임
					<span> (NICKNAME)</span>
				</label>
				<input type="text" required id="userName" name="userName" placeholder="사용하실 닉네임을 입력해주세요." class="form-control">
				<span id="impoName" class="checkR">닉네임을 양식에 맞게 입력해주세요.</span>
			</div>
			<br>
			<div class="form-group">
				<label>
					<span class="star">*</span>
					이메일
					<span> (E-MAIL)</span>
				</label>
				<input type="text" required id="userMail" name="userMail" placeholder="사용하시는 이메일을 입력해주세요." class="form-control">
				<span id="overMail" class="checkR">이미 가입된 이메일이에요.</span>
				<span id="mailCheck" class="checkR">이메일을 양식에 맞게 입력해주세요.</span>
			</div>
			<br>
			<div class="form-group">
				<label>
					<span class="star">*</span>
					주소
					<span> (ADDRESS)</span>
				</label>
				<div class="addrForms">
					<div class="zipCode">
						<input type="text" name="userAddr1" id="userAddr1" readonly="readonly" placeholder="우편번호" required class="form-control">
						<button type="button" id="addrBtn" class="addrBtn">주소 찾기</button>
					</div>
					<input type="text" required name="userAddr2" id="userAddr2" readonly="readonly" placeholder="기본 주소" required class="form-control"> <input type="text" name="userAddr3" id="userAddr3"
						placeholder="상세 주소를 입력해주세요." class="form-control"
					>
				</div>
			</div>
			<br>
			<br>
			<div class="form-group">
				<div class="signupThree">
					<button type="button" class="signupBackBtn" onclick="history.back(-1);">뒤로</button>
					<button type="reset" class="signupResetBtn">초기화</button>
					<button type="submit" id="signupBtn" name="signupBtn">가입</button>
				</div>
			</div>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token}" />
			<br>
			<br>
		</form>
	</div>
</div>

<script>
	$(document).ready(function(e) {

		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";

		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});

		// 아이디 입력.
		var idReg = /^(?=.*[a-z])[a-z0-9]{5,15}$/i;

		$("#userId").change(function() {

			var userId = $(this).val();

			// 아이디 양식 제한.
			if (userId != '') {
				if (!idReg.test(userId)) {
					alert("아이디는 영문자 또는 영문자와 숫자 조합 5~15자여야 해요.");
					$("#ava").css("display", "none");
					$("#over").css("display", "none");
					$("#impo").css("display", "block");
					$(this).focus();
					return false;
				}
			}

			var data = {
				userId : userId
			}
			// {컨트롤러에 넘기는 이름: 데이터}

			$.ajax({
				type : "POST",
				url : "/userIdCheck",
				data : data,
				success : function(result) {
					if (result != 'find') {
						$("#ava").css("display", "block");
						$("#over").css("display", "none");
						$("#impo").css("display", "none");
					} else {
						$("#over").css("display", "block");
						$("#ava").css("display", "none");
						$("#impo").css("display", "none");
					}
				}
			});
		});

		// 비밀번호 입력.
		var pwReg = /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*~])[a-z0-9!@#$%^&*~]{5,15}$/i;

		$("#userPw").change(function() {

			var userPw = $(this).val();

			// 비밀번호 양식 제한.
			if (!pwReg.test(userPw)) {
				alert("비밀번호는 영문자와 숫자, 특수문자(!@#$%^&*~) 조합 8~20자여야 해요.");
				$("#impoPw").css("display", "block");
				$(this).focus();
				return false;
			} else {
				$("#impoPw").css("display", "none");
			}
		});

		// 이메일 입력.
		var mailReg = /^[a-zA-Z0-9]([-_\.]?[a-zA-Z0-9])*@[a-z0-9]([-_\.]?[a-z0-9])*\.[a-z]{2,3}$/;

		$("#userMail").on('blur', function() {

			var userMail = $(this).val();

			// 이메일 양식 제한.
			if (userMail != '') {
				if (!mailReg.test(userMail)) {
					alert("이메일을 양식에 맞게 입력해주세요.")
					$("#mailCheck").css("display", "block");
					$("#overMail").css("display", "none");
					return false;
				} else {
					$("#mailCheck").css("display", "none");
					$("#overMail").css("display", "none");
				}
			}

			var data = {
				userMail : userMail
			}
			// {컨트롤러에 넘기는 이름: 데이터}

			$.ajax({
				type : "POST",
				url : "/userMailCheck",
				data : data,
				success : function(result) {
					if (result != 'find') {
						$("#overMail").css("display", "none");
						$("#mailCheck").css("display", "none");
					} else {
						$("#overMail").css("display", "block");
						$("#mailCheck").css("display", "none");
					}
				}
			});
		});

		// 다음 주소 연동.
		$("#addrBtn").on("click", function() {

			new daum.Postcode({

				oncomplete : function(data) {

					var add = '';
					var extraAddr = "";

					if (data.userSelectedType === 'R') {
						add = data.roadAddress;
					} else {
						add = data.jibunAddress;
					}

					if (data.userSelectedType === 'R') {
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraAddr += data.bname;
						}
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						if (extraAddr !== '') {
							extraAddr = ' (' + extraAddr + ')';
						}
						add += extraAddr;
					} else {
						add += ' ';
					}
					document.getElementById('userAddr1').value = data.zonecode;
					document.getElementById("userAddr2").value = add;
					document.getElementById("userAddr3").focus();
				}
			}).open();
		});
	});
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<%@ include file="includes/footer.jsp"%>