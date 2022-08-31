<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<div class="getPage">
	<h1>공지 수정</h1>
	<br>
	<hr class="underLine">
	<br>
	<br>
	<form role="form" action="/notice/modify" method="post" style="margin: 0px 0px 0 12px;">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <input type="hidden" name="bno" value="${notice.bno}" /> <input type="hidden" name="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="amount" value="${cri.amount}" /> <input type="hidden" name="type" value="${cri.type}" /> <input type="hidden" name="keyword" value="${cri.keyword}" />

		<div class="form-group">
			<label>공지 번호</label>
			<input class="form-control" name="bno" value='<c:out value="${notice.bno}" />' readonly>
		</div>
		<br>
		<div class="form-group">
			<label>작성자</label>
			<input class="form-control" name="writer" value='<c:out value="${notice.writer}" />' readonly>
		</div>
		<br>
		<div class="form-group">
			<label>카테고리</label>
			<input class="form-control" name="category" value='<c:out value="${notice.category}" />'>
		</div>
		<br>
		<div class="form-group">
			<label>공지 제목</label>
			<input class="form-control" name="title" value='<c:out value="${notice.title}" />'>
		</div>
		<br>
		<div class="form-group">
			<label>공지 내용</label>
			<textarea class="form-control" name="content" rows="3"><c:out value="${notice.content}" /></textarea>
		</div>

		<sec:authentication property="principal" var="pinfo" />
		<sec:authorize access="isAuthenticated()">
			<c:if test="${pinfo.username eq notice.writer }">
				<br>
				<br>
				<div class="attachList">
					<div class="attachHeader"></div>
					<div class="attachBody"></div>
					<div class="form-group uploadDiv">
						이미지 첨부
						<br>
						<input type="file" class="uploadFile" name="uploadFile" multiple>
					</div>
					<div class="uploadResult">
						<ul></ul>
					</div>
					<div class="attachFooter"></div>
				</div>
			</c:if>
		</sec:authorize>

		<br>
		<div class="modifyBtnBrothers">
			<sec:authentication property="principal" var="pinfo" />
			<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')">
				<button type="submit" data-oper="modify" class="modifyBtnModify">수정</button>
				<button type="submit" data-oper="remove" class="modifyBtnRemove">삭제</button>
			</sec:authorize>
			<button type="submit" data-oper="list" class="modifyBtnList">목록</button>
		</div>
	</form>
</div>

<script>
	$(document).ready(function(e) {
		// 문서가 준비 되었다면 아래의 함수 수행.

		var formObj = $("form"); // 문서 중 form 요소를 찾아서 변수에 할당.

		$('button').on("click", function(e) {
			// 버튼이 클릭 되었다면 아래의 함수 수행.
			// e라는 이벤트 객체를 전달하면서,
			e.preventDefault(); // 기본 이벤트 동작 막기.

			var operation = $(this).data("oper");
			// 버튼에서 oper 속성 읽어서 변수에 할당.

			console.log(operation);
			// 브라우저 로그로 oper 값 출력.

			if (operation === 'remove') {
				formObj.attr("action", "/notice/remove");
				// form 액션 속성을 변경.
			} else if (operation === 'list') {
				//				self.location = "/notice/list";
				//				return;
				var pageNumTag = $(".getPage input[name='pageNum']");
				var amountTag = $(".getPage input[name='amount']");
				var typeTag = $(".getPage input[name='type']");
				var keywordTag = $(".getPage input[name='keyword']");
				formObj.attr("action", "/notice/list").attr("method", "get");
				formObj.empty(); // 폼의 내용 비우기.
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(typeTag);
				formObj.append(keywordTag);
			} else if (operation === 'modify') {
				var str = "";
				$(".uploadResult ul li").each(function(i, obj) {
					var jobj = $(obj);
					console.dir(jobj);
					// console.dir(): JavaScript 객체의 모든 속성을 보는 방법.
					console.log("------------------------");
					console.log(jobj.data("filename"));
					str += "<input type='hidden' name='attachList[";
					str += i + "].fileName' value='" + jobj.data("filename");
					str += "'>";
					str += "<input type='hidden' name='attachList[";
					str += i + "].uuid' value='" + jobj.data("uuid");
					str += "'>";
					str += "<input type='hidden' name='attachList[";
					str += i + "].uploadPath' value='" + jobj.data("path");
					str += "'>";
					str += "<input type='hidden' name='attachList[";
					str += i + "].fileType' value='" + jobj.data("type");
					str += "'>";
				});
				formObj.append(str);
			}

			formObj.submit();
			// 위의 조건이 아니라면 수정 처리.
		});

		// 첨부 파일 목록 표시.(익명 즉시 실행 함수)
		(function() {

			var bno = '<c:out value="${notice.bno}"/>';

			$.getJSON("/notice/getAttachList", {
				bno : bno
			}, function(arr) {

				console.log(arr);

				var str = "";

				$(arr).each(function(i, attach) {

					var fileCallPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);

					str += "<li data-path='";
					str += attach.uploadPath+"' data-uuid='";
					str += attach.uuid+"' data-filename='";
					str += attach.fileName+"' data-type='";
					str += attach.fileType+"'><div>";
					str += "<img src='/resources/img/attach.png' width='20' height='20' display='inline-block'>&nbsp;&nbsp;";
					str += "<span>" + attach.fileName + "</span>&nbsp; ";
					str += "<b data-file='" + fileCallPath;
					str += "' data-type='file'><img src='/resources/img/attachDelete.png' width='20' height='20' display='inline-block'></b>";
					str += "</div></li>";
				});

				$(".uploadResult ul").html(str);
			});
		})();

		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";

		$(".uploadResult").on("click", "b", function(e) {

			console.log("delete file");

			var delConfirm = confirm("선택한 파일을 삭제하시겠어요?\n 확인을 선택하면 복구할 수 없어요.");

			if (delConfirm) {
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				var targetLi = $(this).closest("li");
				$.ajax({
					url : '/deleteFile',
					data : {
						fileName : targetFile,
						type : type
					},
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					dataType : 'text',
					type : 'POST',
					success : function(result) {
						alert(result);
						targetLi.remove();
					}
				});
			} else {
				return;
			}
		});

		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		// 정규 표현식. 일부 파일의 업로드 제한.

		var maxSize = 5242880; // 5MB.

		function checkExtension(fileName, fileSize) {

			if (fileSize >= maxSize) {
				alert("파일 크기를 초과하였습니다.")
				return false;
			}

			if (regex.test(fileName)) {
				alert("해당 유형의 파일은 업로드가 불가합니다.")
				return false;
			}

			return true;
		}

		$("input[type='file']").change(function(e) {
			// 파일을 첨부한다면,

			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			// 등록하려는 파일 요소들을 배열 형태로 리턴.

			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}

			// 일반 정보의 전달(태그와 값의 쌍)과 첨부 파일(메타 정보와 2진 바이너리 데이터)의 처리는 다르다.
			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				type : 'POST',
				dataType : 'JSON',
				success : function(result) {
					console.log(result);
					showUploadResult(result);
				}
			});
		}); // end_upload_change

		function showUploadResult(uploadResultArr) {

			if (!uploadResultArr || uploadResultArr.length == 0) {
				// JSON 처리 결과가 없다면 함수 종료.
				return;
			}

			var uploadUL = $(".uploadResult ul");
			var str = "";

			// each 구문은 전달된 배열의 길이만큼 each 이후의 함수를 반복 처리.
			$(uploadResultArr).each(function(i, obj) {

				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				// encodeURIComponent: URI로 전달되는 특수문자의 치환. // &, ?
				var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
				// 전달되는 값들 중에서 역슬래시를 찾아 슬래시로 변경.

				str += "<li data-path='";
				str += obj.uploadPath+"' data-uuid='";
				str += obj.uuid+"' data-filename='";
				str += obj.fileName+"' data-type='";
				str += obj.image+"'><div>";
				str += "<img src='/resources/img/attach.png' width='20' height='20' display='inline-block'>&nbsp;&nbsp;";
				str += "<span>" + obj.fileName + "</span>&nbsp; ";
				str += "<b data-file='"+fileCallPath;
				str += "' data-type='file'><img src='/resources/img/attachDelete.png' width='20' height='20' display='inline-block'></b>";
				str += "</div></li>";
			});

			uploadUL.append(str);
		}
	});
</script>

<%@ include file="../includes/footer.jsp"%>