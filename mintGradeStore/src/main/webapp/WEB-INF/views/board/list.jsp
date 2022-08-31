<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSP Page 지시자: JSP는 서버와 연동하여 동적으로 정보를 갱신. --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- jstl core 쓸 때 태그에 c로 표시. --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- jstl fmt 쓸 때 위와 같다. fmt: formatter 형식 맞춰 표시. --%>
<%@ include file="../includes/header.jsp"%>

<div class="wrap">
	<h1>ALL PRODUCTS</h1>
	<br>
	<hr class="underLine">
	<br>
	<div class="thumbItemList" id="thumbItemList">
		<c:forEach var="board" items="${list}">
			<ul>
				<li><a href="${board.bno}" class="move"> <span class="thumbItem">
							<img src="/resources/img/will.png">
						</span> <span class="consoleNameL">
							<c:out value="${board.consoleName}" />
						</span> <br> <strong> <span class="gameNameK">
								<c:out value="${board.gameName}" />
								&nbsp; <img src="/resources/img/mainLogo.png">
							</span>
					</strong> <span class="gameReleaseDate">
							<c:out value="(${board.gameReleaseDate})" />
						</span> <c:if test="${board.replyCnt ne 0}">
							<span class="replyCount">
								<c:out value="${board.replyCnt}" />
								개의 이야기
							</span>
						</c:if>

						<hr>
				</a> <span class="gameCondition">
						<c:out value="${board.gameCondition}" />
					</span> <span class="gamePrice">
						<fmt:formatNumber value="${board.gamePrice}" pattern="#,###" />
						원
					</span> <br> <span id="gameGrade" class="gameGrade">
						<img id="gameGradeImg" src="/resources/img/mintGrade<c:out value='${board.gameGrade}' />.png">
					</span></li>
			</ul>
		</c:forEach>
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
					<li class='pageItem ${pageMaker.cri.pageNum == num ? "active" : ""}'><a href="${num}" class="pageLink">${num}</a></li>
					<!-- pageMaker 객체의 cri 객체의 pageNum이 현재 num과 같다면 active 출력. 아니라면 공백 출력. -->
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
<!-- http://localhost:8090/board/list?pageNum=2&amount=10 -->
<form id="actionForm" action="/board/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"> <input type="hidden" name="amount" value="${pageMaker.cri.amount}"> <input type="hidden" name="type"
		value="${pageMaker.cri.type}"
	> <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
</form>
<!-- 페이지 이동 시 물고 갈 정보 끝. -->

<div class="modal" id="myModal" tabindex="-1" role="dialog">
	<div class="modalContent" title="알림">
		<div class="modalHeader">
			<img src="/resources/img/mainLogo.png" width="30" height="30" alt="icon"> &nbsp;SUCCESS!
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
					$(".modalBody").html(parseInt(result) + "번째 상품 정보를 등록했어요.");
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

		var actionForm = $("#actionForm");
		// 클래스 page-item에 a 링크가 클릭된다면(쪽 번호를 선택했다면),

		$(".pageItem a").on("click", function(e) {
			e.preventDefault();
			// 기본 이벤트 동작을 막고,

			console.log("click");
			// 웹 브라우저 검사 창에 클릭을 표시.

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			// 2페이지를 선택한다면 localhost:8090/board/2
			// 액션폼 인풋 태그에 페이지넘의 값을 찾아서 href 값으로 대체한다.

			actionForm.submit();
		});
		// 처음 액션폼에는 히든(숨김)으로 쪽 번호 1과 쪽당 게시물 10이 할당되어 있다.
		// 아래쪽 쪽 번호 2를 선택한다면 액션폼의 쪽 번호를 2로 변경하고 폼 서브밋.
		// 리스트 컨트롤러가 받아서 Criteria 객체를 초기화하고,
		// 그것을 통해 게시물(list)과 쪽 번호 속성(pageMaker)들을 초기화 한다.

		// 글 읽기 후 목록을 선택했을 때 보고있던 페이지로 돌아가기 시작.
		$(".move").on("click", function(e) {
			e.preventDefault();

			var bno = actionForm.find("input[name='bno']").val();

			if (bno != '') {
				actionForm.find("input[name='bno']").remove();
			}

			actionForm.append("<input type='hidden' name='bno' " + "value='" + $(this).attr("href") + "'>");
			// <input type='hidden' name='bno' value='글 번호'>

			actionForm.attr("action", "/board/get");

			actionForm.submit();
		});
		// 글 읽기 후 목록을 선택했을 때 보고있던 페이지로 돌아가기 끝.
		// http://localhost:8090/board/get?bno=636(수정 전)
		// http://localhost:8090/board/get?pageNum=2&amount=10&bno=636(수정 후)

		var bno = actionForm.find("input[name='bno']").val();

		if (bno != '') {
			actionForm.find("input[name='bno']").remove();
		}
	});
</script>

<%@ include file="../includes/footer.jsp"%>