<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Mint Grade Store 민트 그레이드 스토어</title>

<link rel="stylesheet" href="/resources/css/mintGradeStore.css" type="text/css">
<link rel="stylesheet" href="/resources/css/mintGradeStoreAnimations.css" type="text/css">

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>

<body>
	<div class="header">
		<div class="headerIntro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;콘솔 게임의 과거와 현재가 공존하는 곳</div>
		<div class="headerMainLogo">
			<img src="/resources/img/mainLogo.png" alt="icon"> <a href="/">Mint Grade Store</a>
		</div>

		<div class="welcomeUser">
			<sec:authorize access="isAuthenticated()">
				<!-- 정상 로그인 및 찾기: 예) Douglas -->
				<span class="loginIdText">
					<!-- 예) Douglas -->
					반가워요!
					<span class="user">
						<sec:authentication property="principal.username" />
					</span>
					님
					<!-- 프린시펄: 세션의 일종. 접속자 계정 정보. -->
				</span>
			</sec:authorize>

			<sec:authorize access="isAnonymous()">
				<!-- 익명. -->
				<span class="loginIdText">
					<span class="userHide">반가워요!</span>
				</span>
			</sec:authorize>
		</div>

		<div class="headerThreeBrothers">
			<div class="brotherSearchBox">
				<form id="searchForm" action="/board/list" method="get">
					<select name="type">
						<option value="G" ${pageMaker.cri.type eq "G" ? "selected" : ""}>게임 타이틀</option>
						<option value="C" ${pageMaker.cri.type eq "C" ? "selected" : ""}>콘솔 이름</option>
					</select> <input type="text" name="keyword" value="${pageMaker.cri.keyword}" placeholder="검색어를 입력해주세요." /> <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"> <input
						type="hidden" name="amount" value="${pageMaker.cri.amount}"
					>
					<button id=searchBtn class="buttonSearch">검색</button>
				</form>
			</div>
			<div class="brotherSubtitle">민트 그레이드 스토어</div>
			<div class="brotherRightHead">
				<span class="cart">
					<a href="">장바구니</a> /
				</span>
				<span class="order">
					<a href="">주문내역</a> /
				</span>

				<sec:authorize access="isAuthenticated()">
					<a class="logInOut" href="/myPage"> <span class="loginIdTextSp2">내 정보</span>
					</a>
					<span class="slash">/</span>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<a class="logInOut" href="/signup"> <span class="loginIdText">
							<span class="loginIdText">회원가입</span>
						</span>
					</a>
					<span class="slash">/</span>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<a class="logInOut" href="/customLogout" data-toggle="modal" data-target="#logoutModal"> <span class="loginIdText">로그아웃</span>
					</a>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<a class="logInOut" href="/customLogin"> <span class="loginIdText">
							<span class="loginIdTextSp">로그인</span>
						</span>
					</a>
					<!-- 익명 상태라면 로그인 표시. -->
				</sec:authorize>
			</div>
		</div>
	</div>

	<div class="necker">
		<span class="noticeLink">
			<a href="http://localhost:8090/notice/list" style="padding-left: 28px;"> NOTICE <span class="noticeLinkK">공지</span> &nbsp; <img src="http://localhost:8090/resources/img/mainLogo.png">
			</a>
		</span>
		<span class="preOrder">
			<a href=""> PRE-ORDER <span class="preOrderK">사전예약</span> &nbsp; <img src="/resources/img/mainLogo.png">
			</a>
		</span>
		<span class="newArrival">
			<a href=""> NEW ARRIVAL <span class="newArrivalK">신착품</span> &nbsp; <img src="/resources/img/mainLogo.png">
			</a>
		</span>
		<span class="journal">
			<a href=""> JOURNAL <span class="journalK">저널</span> &nbsp; <img src="/resources/img/mainLogo.png">
			</a>
		</span>
	</div>

	<div class="mainer">
		<div class="sideCategoryBar">

			<div class="allProducts">
				<a href="/board/list"> All Products <span class="allProductsK"> _ 전체 상품</span>
				</a>
			</div>

			<div class="currentGen">
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;CURRENT GENERATION
				<br>
				&nbsp;&nbsp;&nbsp;
				<span class="currentGenK"> _ 현 세대 콘솔</span>
				<ul>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;Nintendo <span class=consoleK>닌텐도</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;SONY <span class=consoleK>소니</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;Microsoft <span class=consoleK>마이크로소프트</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
				</ul>
				<br>
			</div>
			<div class="previousGen">
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;PREVIOUS GENERATION
				<br>
				&nbsp;&nbsp;&nbsp;
				<span class="previousGenK"> _ 레트로 콘솔</span>
				<ul>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;Nintendo <span class=consoleK>닌텐도</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;SEGA <span class=consoleK>세가</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;NEC <span class=consoleK>닛폰덴키</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;SNK <span class=consoleK>에스엔케이</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;SONY <span class=consoleK>소니</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;BANDAI <span class=consoleK>반다이</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;Microsoft <span class=consoleK>마이크로소프트</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
					<br>
					<li><a href=""> &nbsp;&nbsp;&nbsp;&nbsp;ETC. <span class=consoleK>기타 제조사</span> &nbsp; <img src="/resources/img/mainLogo.png">
					</a></li>
				</ul>
				<br>
			</div>

			<div class="writing" align="center">
				<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')">
					<button id="regBtn" style="color: #111; width: 225px; margin: 0px 0px 0px 0px;">
						<img src="/resources/img/mainLogo.png" alt="icon">
						<br>
						<span>
							상품 등록
							<br>
							<span class="adminOnlyRegBtn">[ADMIN ONLY]</span>
						</span>
					</button>
				</sec:authorize>
			</div>
		</div>

		<form id="actionForm" action="/board/list" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"> <input type="hidden" name="amount" value="${pageMaker.cri.amount}"> <input type="hidden" name="type"
				value="${pageMaker.cri.type}"
			> <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>

		<script>
			$(document).ready(function() {

				$("#regBtn").on("click", function() {

					self.location = "/board/register";
					// id=regBtn을 클릭한다면 현재 창의 URL을 쓰기로 변경.
				});

				$('#searchBtn').on("click", function(e) {
					e.preventDefault();

					var searchForm = $("#searchForm");
					var searchKeyword = $("input[name='keyword']").val();
					var sKey = '<c:out value="${pageMaker.cri.keyword}"/>';

					console.log("이전 검색어: " + sKey);
					console.log("현재 검색어: " + searchKeyword);

					if (sKey != searchKeyword) { // 이 부분을 지우면 검색어 비교를 하지 않기 때문에 동일 검색어 검색 시에도 1페이지로 이동.
						searchForm.find("input[name='pageNum']").val(1);
						// 새로운 검색어라면 1페이지로 이동.
					}

					searchForm.submit();
				});

				var searchForm = $("#searchForm");

				$("#searchForm button").on("click", function(e) {

					if (!searchForm.find("option:selected").val()) {
						alert("검색 유형을 선택해주세요.");
						return false;
					}

					if (!searchForm.find("input[name='keyword']").val()) {
						alert("검색어를 입력해주세요.");
						return false;
					}

					searchForm.find("input[name='pageNum']").val(1);
					searchForm.find("input[name='amount']").val(12);

					e.preventDefault();

					searchForm.submit();
				});
			});
		</script>