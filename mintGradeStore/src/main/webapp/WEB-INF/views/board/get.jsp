<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<div class="getPage">
	<h1>상품 정보</h1>
	<br>
	<hr class="underLine">
	<br>
	<br>
	<form role="form" style="margin: 0px 0px 0 12px;">
		<div class="getPageBox">
			<div class="getPageTitle">
				<span class="getPageConsoleName">
					<c:out value="${board.consoleName}" />
				</span>
				<br>
				<span class="getPageGameName">
					<c:out value="${board.gameName}" />
					<br>
				</span>
				<span class="getPageGameNameOriginal">
					<c:out value="${board.gameNameOriginal}" />
				</span>
				<span class="getPageBno">
					&nbsp;|
					<c:out value="${board.bno}" />
					번 상품
				</span>
			</div>

			<br>
			<br>
			<br>

			<div class="getPageInfoFirst">
				<div class="gameImage">
					<img id="gameImage" src="/resources/img/will.png">
				</div>
				<table class="gamePageInfoTable" style="table-layout: fixed;">
					<tr>
						<td colspan="2" style="border-bottom: solid 1px #333; vertical-align: top; height: 25%;"><span class="tableConsoleName">
								<c:out value="${board.consoleName}" />
							</span> <br> <span class="tableGameName">
								<c:out value="${board.gameName}" />
								<br>
							</span> <span class="tableGameNameOriginal">
								<c:out value="${board.gameNameOriginal}" />
								<br>
							</span> <span class="tableGameReleaseDateYMD" style="float: right; padding: 0px 0px 5px 0px;">
								<fmt:parseDate value='${board.gameReleaseDateYMD}' var='gameReleaseDateYMD' pattern='yyyymmdd' />
								<fmt:formatDate value="${gameReleaseDateYMD}" pattern="yyyy.MM.dd." />
								<br>
								<br>
							</span> <br> <span class="tablePageBno">
								No.
								<c:out value="${board.bno}" />
							</span> <br></td>
					</tr>
					<tr>
						<td>판매가</td>
						<td><span class="tableGamePrice">
								<fmt:formatNumber value="${board.gamePrice}" pattern="#,###" />
							</span> 원</td>
					</tr>
					<tr>
						<td>배송료</td>
						<td><span class="">2,500 </span> 원 <br> <span class="jeju">(제주, 도서지역 4,000 원 추가)</span></td>
					</tr>
					<tr>
						<td colspan="2" style="border-bottom: solid 1px #333;">
					</tr>
					<tr>
						<td>등록일</td>
						<td><span class="tableRegDate">
								<fmt:formatDate value="${board.regDate}" pattern="yyyy.MM.dd." />
							</span></td>
					<tr>
						<td>상품상태 <img src="/resources/img/question.png" id="question">
						</td>
						<td><span class="tableGameCondition">
								<c:out value="${board.gameCondition}" />
							</span></td>
					</tr>
					<tr>
						<td>종합등급 <img src="/resources/img/question.png" id="question">
						</td>
						<td><img id="tableGameGradeImg" src="/resources/img/mintGrade<c:out value='${board.gameGrade}' />.png" style="vertical-align: bottom;"></td>
					</tr>
					<tr>
						<td colspan="2" style="border-bottom: solid 1px #333; vertical-align: middle; color: #444; font-size: 13px;">* 레트로 상품의 경우, 상품 상태에 대한 자세한 사항은 반드시 본문의 내용을 참고해 주세요.</td>
					</tr>
				</table>
			</div>
			<div class="buyBuyBrothers">
				<button id="cartBtn" type="button">장바구니</button>
				<button id="buyBtn" type="button">바로 구매</button>
				<br>
				<br>
			</div>
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
					<c:if test="${pinfo.username eq board.writer }">
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
							<c:out value="${board.writer}" />
						</span>
						님이 등록한 상품
					</div>
					<br>
					<span class="getPageWriter">
						&gt;&gt;
						<span class="getPageWriterSp">
							<c:out value="${board.gameQuantity}" />
						</span>
						개의 재고가 남아있습니다.
						<br>
						<br>
					</span>
				</div>
			</sec:authorize>
		</div>
		<br>
		<br>
		<br>
		<div class="getBtnTwins">
			<sec:authentication property="principal" var="pinfo" />
			<!-- 프린시펄 정보를 pinfo라는 이름으로 JSP에서 이용. -->
			<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')">
				<%-- <sec:authorize access="isAuthenticated()"> --%>
				<!-- 인증된 사용자만 허가 -->
				<%-- <c:if test="${pinfo.username eq board.writer }"> --%>
				<!-- 인증되었으면서 작성자가 본인일 때 수정 버튼 표시. -->
				<button data-oper="modify" id="modBtn" class="getBtnModify">수정</button>
				<%-- </c:if> --%>
			</sec:authorize>
			<button data-oper="list" id="listBtn" class="getBtnList">목록</button>
		</div>
	</form>
	<br>
	<hr>

	<!-- 댓글 목록 시작. -->
	<h1>게임 이야기</h1>
	<div class="replyContent">
		<sec:authorize access="isAuthenticated()">
			<div class="replyHead">
				이 게임에 대한 이야기를 나누어 보세요.
				<br>
				<br>
				<button id=replyAddBtn>댓글 남기기</button>
			</div>
			<br>
		</sec:authorize>
		<div class="replyBody">
			<ul class="chat">
				<li>COMMENT</li>
			</ul>
		</div>
		<div class="replyFooter"></div>
	</div>
	<!-- 댓글 목록 끝. -->

	<br>
	<form id="operForm" action="/board/modify" method="get">
		<input type="hidden" id="bno" name="bno" value="${board.bno}" /> <input type="hidden" name="pageNum" value="${cri.pageNum}" /> <input type="hidden" name="amount" value="${cri.amount}" /> <input
			type="hidden" name="type" value="${cri.type}"
		/> <input type="hidden" name="keyword" value="${cri.keyword}" />
	</form>

</div>

<!-- 댓글 입력 모달 창 시작.  -->
<div class="replyModal" id="myModal2" tabindex="-1" role="dialog">
	<div class="replyModalContent" title="알림">
		<div class="replyModalHeader">
			<img src="/resources/img/mainLogo.png" width="30" height="30" alt="icon"> &nbsp;COMMENT...
		</div>
		<br>
		<div class="replyModalBody">
			<div class="form-group">
				<label>댓글</label>
				<input class="form-control-reply" name="reply" value="reply">
				<br>
			</div>
			<div class="form-group">
				<label>작성자</label>
				<input class="form-control-reply" name="replyer" value="replyer" readonly>
				<br>
			</div>
			<div class="form-group">
				<label>댓글 작성일</label>
				<input class="form-control-reply" name="replyDate" value="">
				<br>
			</div>
		</div>
		<br>
		<button id="modalModifyBtn" type="button" class="replyBtnModify">수정</button>
		<button id="modalRemoveBtn" type="button" class="replyBtnRemove">삭제</button>
		<button id="modalRegisterBtn" type="button" class="replyBtnRegister">등록</button>
		<button id="modalCloseBtn" type="button" class="replyBtnClose">닫기</button>
		<div class="replyModalFooter"></div>
		<br>
	</div>
</div>
<!-- 댓글 입력 모달 창 끝. -->

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
	$(document).ready(function() {

		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";

		$(document).ajaxSend(function(e, xhr, options) {

			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		}); // csrf 값을 미리 설정해두고 AJAX 처리 시마다 이용.

		var bnoValue = '<c:out value="${board.bno}" />';
		var modalModifyBtn = $("#modalModifyBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");

		var replyer = null;
		
		<sec:authorize access="isAuthenticated()">
		// replyer = '<sec:authentication property="principal.username" />';
		replyer = '${pinfo.username}';
		</sec:authorize>

		//		replyService.add({
		//			reply : "js test",
		//			replyer : "tester",
		//			bno : bnoValue
		//		}, function(result) {
		//			alert("result: " + result);
		//		});
		// 게시글을 읽을 때 자동으로 댓글 1개 등록.

		// 		var modal = $("#myModal2");
		// 댓글용 모달.
		var modalInputReplyDate = $("#myModal2").find("input[name='replyDate']");
		// 댓글 작성일 항목.
		var modalRegisterBtn = $("#modalRegisterBtn");
		// 모달에서 표시되는 글쓰기 버튼.
		var modalInputReply = $("#myModal2").find("input[name='reply']");
		// 댓글 내용.
		var modalInputReplyer = $("#myModal2").find("input[name='replyer']")
		// 댓글 작성자.

		// 댓글 입력 모달 창 보이기.
		$("#replyAddBtn").on("click", function(e) {
			// 댓글 쓰기 버튼을 클릭한다면,

			$("#myModal2").find("input").val("");
			// 모달의 모든 입력 창을 초기화.

			$("#myModal2").find("input[name='replyer']").val(replyer);

			$("#myModal2").find("input[name='replyer']").attr("readonly", "readonly");

			modalInputReplyDate.closest("div").hide();
			// closest: 선택 요소와 가장 가까운 요소를 지정.
			// modalInputReplyDate 요소의 가장 가까운 div를 찾아서 숨긴다.(날짜 창 숨김)

			$("#myModal2").find("button[id != 'modalCloseBtn']").hide();
			// 닫기 버튼 제외하고 숨긴다.

			modalRegisterBtn.show(); // 등록 버튼은 보인다.

			$("#myModal2").fadeIn(); // 모달 숨기기.
		});

		// 모달 창 닫기.
		$("#modalCloseBtn").on("click", function(e) {

			$("#myModal2").fadeOut();
			// 모달 닫기 버튼을 클릭하면 모달 창을 숨긴다.
		});

		// 댓글 쓰기.
		modalRegisterBtn.on("click", function(e) {
			// 댓글 등록 버튼을 눌렀다면,

			var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
			}; // ajax로 전달할 reply 객체 선언 및 할당.

			replyService.add(reply, function(result) {

				alert(result);
				// ajax 처리 후 결과 리턴.

				$("#myModal2").find("input").val("");
				// 모달 창 초기화.
				$("#myModal2").fadeOut(); // 모달 창 숨기기.

				modalInputReplyDate.closest("div").show();

				showList(-1);
			});
		});

		// 댓글 목록 보이기.
		var replyUL = $(".chat");
		// reply Unorderd List

		function showList(page) {

			replyService.getList({
				bno : bnoValue,
				page : page || 1
			}, function(replyTotalCnt, list) {

				console.log("replyTotalCnt: " + replyTotalCnt);

				if (page == -1) {
					// 페이지 번호가 음수값이라면,
					pageNum = Math.ceil(replyTotalCnt / 10.0);
					// 댓글의 마지막 페이지 구하기.
					showList(pageNum);
					// 댓글 목록 새로고침.(갱신)
					return;
				}

				var str = "";

				if (list == null || list.length == 0) {
					replyUL.html("");
					return;
				}

				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='left ";
					str += "clearfix' data-rno='";
					str += list[i].rno + "'>";
					str += "<div><div class='header' ";
					str += "><img src='/resources/img/mainLogo.png'>&nbsp;<strong class='";
					str += "primary-font'>";
					str += list[i].replyer + "</strong>&nbsp;&nbsp;";
					str += "<small class='float-sm-right '>";
					str += replyService.displayTime(list[i].replyDate) + "</small></div>";
					str += "<p>" + list[i].reply;
					str += "</p></div></li>";
				}

				replyUL.html(str);

				showReplyPage(replyTotalCnt);
			});
		}

		showList(-1);

		// 댓글 페이징 시작.
		var pageNum = 1;
		var replyPageFooter = $(".replyFooter");

		function showReplyPage(replyCnt) {

			var endNum = Math.ceil(pageNum / 10.0) * 10;
			// pageNum이 1이라고 가정하면 Math.ceil(1 / 10.0) 처리하고 * 10.
			// endNum은 10.
			var startNum = endNum - 9;
			var prev = startNum != 1;
			var next = false;

			if (endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt / 10.0);
			}

			if (endNum * 10 < replyCnt) {
				next = true;
			}

			var str = "<ul class='pagingNumberReply";
			
			str += "'>";

			if (prev) {
				str += "<li class='pageItemReply'><a ";
				str += "class='pageLinkReply' href='";
				str += (startNum - 1);
				str += "'>&lt;</a></li>";
			}

			for (var i = startNum; i <= endNum; i++) {

				var active = pageNum == i ? "active" : "";

				str += "<li class='pageItemReply " + active + "'><a class='pageLinkReply' ";
				str += "href='" + i + "'>" + i + "</a></li>";
			}

			if (next) {
				str += "<li class='pageItemReply'>";
				str += "<a class='pageLinkReply' href='";
				str += (endNum + 1) + "'>&gt;</a></li>";
			}

			str += "</ul>";

			console.log(str);
			
			replyPageFooter.html(str);
		}
		// 댓글 페이징 끝.

		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();

			var targetPageNum = $(this).attr("href");

			pageNum = targetPageNum;

			showList(pageNum);
		});

		$(".chat").on("click", "li", function(e) {
			// .chat을 클릭하는데 하위 요소가 li라면,
			
			var rno = $(this).data("rno");
			// 댓글이 포함된 값들 중에서 rno를 추출하여 변수 할당.

			console.log(rno);

			replyService.get(rno, function(reply) {
				
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				// 댓글 목록의 값들을 모달 창에 할당.

				$("#myModal2").data("rno", reply.rno)
				// 표시되는 모달 창에 rno라는 이름으로 data-rno를 저장.

				$("#myModal2").find("button[id != 'modalCloseBtn']").hide();
				modalModifyBtn.show();
				modalRemoveBtn.show();
				// 버튼 보이기 설정.

				modalInputReplyDate.closest("div").show();

				$("#myModal2").fadeIn();
			});
		});

		modalModifyBtn.on("click", function(e) {

			var originalReplyer = modalInputReplyer.val();

			var reply = {
				rno : $("#myModal2").data("rno"),
				reply : modalInputReply.val(),
				replyer : originalReplyer
			};

			if (!replyer) {
				alert("로그인 후에 수정 가능해요.");
				$("#myModal2").fadeOut();
				return;
			}

			if (replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 수정 가능해요.");
				$("#myModal2").fadeOut();
				return;
			}

			replyService.update(reply, function(result) {
				
				alert(result);
				
				$("#myModal2").fadeOut();
				
				showList(-1);
			});
		});

		modalRemoveBtn.on("click", function(e) {

			var rno = $("#myModal2").data("rno");
			var originalReplyer = modalInputReplyer.val();

			if (!replyer) {
				alert("로그인 후에 삭제 가능해요.");
				$("#myModal2").fadeOut();
				return;
			}

			if (replyer != originalReplyer) {
				alert("자신이 작성한 댓글만 삭제 가능해요.");
				$("#myModal2").fadeOut();
				return;
			}

			console.log(rno);

			replyService.remove(rno, originalReplyer, function(result) {

				alert(result);
				
				$("#myModal2").fadeOut();
				
				showList(-1);
			});
		});

		// 첨부 파일 목록 표시.(익명 즉시 실행 함수)
		(function() {

			var bno = '<c:out value="${board.bno}"/>';

			$.getJSON("/board/getAttachList", {
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
				formObj.attr("action", "/board/modify");
				// form의 액션 속성을 변경.
			}

			formObj.submit();
		});

		$("#listBtn").on("click", function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");

			console.log(operation);

			if (operation === 'list') {
				formObj.attr("action", "/board/list");
				formObj.find("#bno").remove();
				// form에서 아이디 bno 요소를 찾아서 삭제.
			}
			
			formObj.submit();
		});
	});
</script>


<%@ include file="../includes/footer.jsp"%>