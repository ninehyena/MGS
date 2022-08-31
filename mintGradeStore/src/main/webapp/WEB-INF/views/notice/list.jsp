<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSP Page 지시자: JSP는 서버와 연동하여 동적으로 정보를 갱신. --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- jstl core 쓸 때 태그에 c로 표시. --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- jstl fmt 쓸 때 위와 같다. fmt: formatter 형식 맞춰 표시. --%>
<%@ include file="../includes/header.jsp"%>

<div class="wrap">
	<h1>NOTICE</h1>
	<br>
	<hr class="underLine">
	<br>
	<table class="notice">
		<thead>
			<tr>
				<th colspan="3" class="th1"><span class="noticeMint">민트 그레이드 스토어</span>에서 알려드립니다. <span class="noticeETC">(입고, 사전예약, 이벤트 안내 등)</span> <br> <br> <img
					src="http://localhost:8090/resources/img/mintGrade5.png" height="20"
				> <br> <br></th>
			</tr>
		</thead>
		<c:forEach var="notice" items="${list}">
			<tbody>

				<tr>
					<td class="td1"><c:out value="${notice.bno}" /></td>
					<td class="td2"><a href="${notice.bno}" class="move"><span class="categoryNoticeInfo">
								<c:out value="[${notice.category}]" />
							</span>&nbsp;&nbsp;<c:out value="${notice.title}" />&nbsp;&nbsp;<img src="http://localhost:8090/resources/img/mainLogo.png" width="17" height="17" alt="icon"></a></td>
					<td class="td3"><fmt:formatDate value="${notice.regDate}" pattern="yyyy.MM.dd." /></td>
				</tr>

			</tbody>
		</c:forEach>
	</table>

	<div class="noticeFooter">

		<div class="brotherSearchBoxNotice">
			<br>
			<form id="searchForm2" action="http://localhost:8090/notice/list" method="get">
				<select name="type">
					<option value="C">카테고리</option>
					<option value="T">제목</option>
					<option value="N">내용</option>
				</select> <input type="text" name="keyword" value="" placeholder="검색어를 입력해주세요.">
				<button id="searchBtn2" class="buttonSearch">검색</button>
			</form>
		</div>

		<div class="writing" align="right">
			<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')">
				<button id="regBtn2" style="color: #111; width: 225px; margin: 0px 0px 0px 0px;">
					<img src="/resources/img/mainLogo.png" alt="icon">
					<br>
					<span>
						공지 등록
						<br>
						<span class="adminOnlyRegBtn">[ADMIN ONLY]</span>
					</span>
				</button>
			</sec:authorize>
		</div>
	</div>

	<!-- 쪽 번호 시작. -->
	<div class="pagingBox">
		<div class="pagingList">
			<ul class="pagingNumber">
				<c:if test="${pageMaker.prev}">
					<li class="pageItem Prev"><a href="${pageMaker.startPage - 1}" class="pageLink">&lt;</a></li>
				</c:if>

				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<!-- 게시물 목록에서 배열을 이용한 것과 같이 begin은 배열의 시작값. end는 배열의 끝값으로 순환 처리. -->
					<li class='pageItem ${pageMaker.cri.pageNum == num ? "active" : ""}'>
						<!-- pageMaker 객체의 cri 객체의 pageNum이 현재 num과 같다면 active 출력. 아니라면 공백 출력. --> <a href="${num}" class="pageLink">${num}</a>
					</li>
				</c:forEach>

				<c:if test="${pageMaker.next}">
					<li class="pageItem next"><a href="${pageMaker.endPage + 1}" class="pageLink">&gt;</a></li>
				</c:if>
			</ul>
		</div>
	</div>
	<!-- 쪽 번호 끝. -->
</div>

<!-- 페이지 이동 시 물고 갈 정보 등록. -->
<form id="actionForm2" action="/notice/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"> <input type="hidden" name="amount" value="${pageMaker.cri.amount}"> <input type="hidden" name="type"
		value="${pageMaker.cri.type}"
	> <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
</form>
<!-- 페이지 이동 시 물고 갈 정보 끝. -->

<div class="modal" id="myModal" tabindex="-1" role="dialog">
	<div class="modalContent" title="알림">
		<div class="modalHeader">
			<img src="http://localhost:8090/resources/img/mainLogo.png" width="30" height="30" alt="icon"> &nbsp;SUCCESS!
		</div>
		<br>
		<div class="modalBody"></div>
		<br>
		<div class="modalFooter">[클릭하면 창이 닫힙니다.]</div>
	</div>
</div>

<script>
	$(document).ready(function() {

		var result = '<c:out value="${result}"/>';

		checkModal(result);

		function checkModal(result) {

			if (result === '') {
				return;
			}

			if ($.isNumeric(result)) {
				if (parseInt(result) > 0) {
					$(".modalBody").html(parseInt(result) + "번째 공지 사항을 등록했어요.");
				}
			} else {
				$(".modalBody").html(result);
				// 수정과 삭제 시에는 success라는 문자열이 전달되므로 숫자화 할 수 없다.
			}

			$("#myModal").fadeIn();
		}

		$(".modalContent").click(function() {

			$("#myModal").fadeOut();
		});

		var actionForm = $("#actionForm2");

		$(".pageItem a").on("click", function(e) {
			e.preventDefault();

			console.log("click");

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));

			actionForm.submit();
		});

		$(".move").on("click", function(e) {
			e.preventDefault();

			var bno = actionForm.find("input[name='bno']").val();

			if (bno != '') {
				actionForm.find("input[name='bno']").remove();
			}

			actionForm.append("<input type='hidden' name='bno' " + "value='" + $(this).attr("href") + "'>");

			actionForm.attr("action", "/notice/get");

			actionForm.submit();
		});

		var bno = actionForm.find("input[name='bno']").val();

		if (bno != '') {
			actionForm.find("input[name='bno']").remove();
		}

		$("#regBtn2").on("click", function() {

			self.location = "/notice/register";
		});

		$('#searchBtn2').on("click", function(e) {
			e.preventDefault();

			var searchForm = $("#searchForm2");
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

		var searchForm = $("#searchForm2");

		$("#searchForm2 button").on("click", function(e) {

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

<%@ include file="../includes/footer.jsp"%>