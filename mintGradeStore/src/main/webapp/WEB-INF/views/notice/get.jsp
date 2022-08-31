<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<div class="getPage">
	<h1>공지 사항</h1>
	<br>
	<hr class="underLine">
	<br>
	<br>
	<form role="form" style="margin: 0px 0px 0 12px;">
		<div class="getPageBox">
			<div class="getPageTitle">
				<span class="getPageCategoryNotice">
					<c:out value="${notice.category}" />
				</span>
				<br>
				<span class="getPageTitleNotice">
					<c:out value="${notice.title}" />
					<br>
				</span>
				<span class="getPageRegDateNotice">
					<fmt:formatDate value="${notice.regDate}" pattern="yyyy.MM.dd. hh:mm:ss" />
				</span>
				<span class="getPageBno">
					&nbsp;|
					<c:out value="${notice.bno}" />
					번 공지
				</span>
			</div>

			<br>
			<br>
			<br>

			<div class="getPageTitle" style="white-space: pre-wrap;"><c:out value="${notice.content}" /></div>
			<span class="noticeUpdateDateInfo">
				<c:if test="${notice.regDate != notice.updateDate}">
					<fmt:formatDate value="${notice.updateDate}" pattern="yyyy.MM.dd. hh:mm:ss" />
				에 수정되었어요.
				</c:if>
			</span>
			<br>
			<br>
			<br>
			<!-- 첨부 파일 시작. -->
			<sec:authentication property="principal" var="pinfo" />
			<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')">
				<div class="adminGetPage">
					<br>
					<span class="onlyAdminGetPage">[ADMIN ONLY]</span>
					<span class="onlyAdminGetPageInfo">상세 정보</span>
					<c:if test="${pinfo.username eq notice.writer}">
						<div class="attachList">
							<div class="form-group uploadDiv">
								<br>
								&gt;&gt; 첨부 이미지
								<br>
							</div>
							<div class="uploadResult">
								<ul></ul>
							</div>
							<div class="attachFooter"></div>
						</div>
					</c:if>
					<!-- 첨부 파일 끝. -->

					<div class="getPageWriter">
						&gt;&gt;
						<span class="getPageWriterSp">
							<c:out value="${notice.writer}" />
						</span>
						님이 작성한 공지
					</div>
					<br>
				</div>
				<br>
				<br>
				<br>
			</sec:authorize>
		</div>
		<div class="getBtnTwins">
			<sec:authentication property="principal" var="pinfo" />
			<!-- 프린시펄 정보를 pinfo라는 이름으로 JSP에서 이용. -->
			<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')">
				<button data-oper="modify" id="modBtn" class="getBtnModify">수정</button>
			</sec:authorize>
			<button data-oper="list" id="listBtn" class="getBtnList">목록</button>
		</div>
	</form>
	<br>
	<br>
	<form id="operForm" action="/notice/modify" method="get">
		<input type="hidden" id="bno" name="bno" value="${notice.bno}" /> <input type="hidden" name="pageNum" value="${cri.pageNum}" /> <input type="hidden" name="amount" value="${cri.amount}" /> <input
			type="hidden" name="type" value="${cri.type}"
		/> <input type="hidden" name="keyword" value="${cri.keyword}" />
	</form>

</div>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
	$(document).ready(function() {

		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";

		$(document).ajaxSend(function(e, xhr, options) {

			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		}); // csrf 값을 미리 설정해두고 AJAX 처리 시마다 이용.

		var bnoValue = '<c:out value="${notice.bno}" />';

		// 첨부 파일 목록 표시.(익명 즉시 실행 함수)
		(function() {

			var bno = '<c:out value="${notice.bno}"/>';

			$.getJSON("/notice/getAttachList", {
				bno : bno
			}, function(arr) {

				console.log(arr);

				var str = "";

				$(arr).each(function(i, attach) {

					str += "<li data-path='";
					str += attach.uploadPath+"' data-uuid='";
					str += attach.uuid+"' data-filename='";
					str += attach.fileName+"' data-type='";
					str += attach.fileType+"'><div>";
					str += "<img src='/resources/img/attach.png' width='20' height='20' display='inline-block'>&nbsp;&nbsp;";
					str += "<span>" + attach.fileName + "</span><br/> ";
					str += "</div></li>";
				});

				$(".uploadResult ul").html(str);
			});
		})();

		// 첨부 파일 클릭 시 다운로드 처리.
		$(".uploadResult").on("click", "li", function(e) {

			console.log("download file");

			var liObj = $(this);
			var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));

			self.location = "/download?fileName=" + path;
		});
	});
</script>

<script>
	$(document).ready(function() {

		// 페이지 이동 관련 정보 스크립트 시작.
		var formObj = $("form");

		$("#modBtn").on("click", function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");

			console.log(operation);

			if (operation === 'modify') {
				formObj.attr("action", "/notice/modify");
				// form의 액션 속성을 변경.
			}

			formObj.submit();
		});

		$("#listBtn").on("click", function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");

			console.log(operation);

			if (operation === 'list') {
				formObj.attr("action", "/notice/list");
				formObj.find("#bno").remove();
				// form에서 아이디 bno 요소를 찾아서 삭제.
			}

			formObj.submit();
		});
	});
</script>


<%@ include file="../includes/footer.jsp"%>