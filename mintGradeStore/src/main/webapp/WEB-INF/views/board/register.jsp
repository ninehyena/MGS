<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<div class=writePage>
	<h1>상품 등록</h1>
	<br>
	<hr class="underLine">
	<br>
	<br>
	<form role="form" action="/board/register" method="post" style="margin: 0px 0px 0 12px;">

		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

		<div class="form-group">
			<label>등록자</label>
			<input class="form-control" name="writer" value='<sec:authentication property="principal.username"/>' readonly="readonly">
		</div>
		<br>
		<div class="form-group">
			<label>콘솔 이름</label>
			<input class="form-control" name="consoleName" placeholder="* 콘솔 이름을 입력해주세요.">
		</div>
		<br>
		<div class="form-group">
			<label>게임 이름</label>
			<input class="form-control" name="gameName" placeholder="* 게임 이름을 입력해주세요.">
		</div>
		<br>
		<div class="form-group">
			<label>게임 이름 상세</label>
			<input class="form-control" name="gameNameOriginal" placeholder="* 게임 원제목을 입력해주세요.">
		</div>
		<br>
		<div class="form-group">
			<label>발매 연도</label>
			<input class="form-control" name="gameReleaseDate" placeholder="* 4자리의 연도를 입력해주세요. [Number Only]">
		</div>
		<br>
		<div class="form-group">
			<label>발매 연도 상세</label>
			<input class="form-control" name="gameReleaseDateYMD" placeholder="* 8자리의 상세 연도를 입력해주세요. [Number Only]">
		</div>
		<br>
		<div class="form-group">
			<label>상품 상태</label>
			<input class="form-control" name="gameCondition" placeholder="* 제품 상태를 입력해주세요. 예) 미개봉, 박스 없음 등...">
		</div>
		<br>
		<div class="form-group">
			<label>판매가</label>
			<input class="form-control" name="gamePrice" placeholder="* 가격을 입력해주세요. [Number Only]">
		</div>
		<br>
		<div class="form-group">
			<label>종합등급</label>
			<input class="form-control" name="gameGrade" placeholder="* 1~5:감정 등급 / 6: 신상품 [Number Only]">
		</div>
		<br>
		<div class="form-group">
			<label>재고량</label>
			<input class="form-control" name="gameQuantity" placeholder=" 3자리 숫자까지 [Number Only]">
		</div>
		<br>
		<div class="form-group">
			<label>내용</label>
			<textarea class="form-control" name="content" rows="3" placeholder="* 내용을 입력해주세요."></textarea>
		</div>
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

		<br>
		<div class="registerBtnTwins">
			<sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')">
				<button id="submitBtn" type="submit">등록</button>
				<button id="resetBtn" type="reset">초기화</button>
			</sec:authorize>
		</div>
	</form>
</div>

<script>
	$(document).ready(function(e) {

		var formObj = $("form[role='form']");

		$("button[type='submit']").on("click", function(e) {
			e.preventDefault();

			console.log("submit clicked");

			// 글 등록 버튼을 누르면 첨부 파일의 정보도 함께 전송되도록 수정.
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
			formObj.append(str).submit();
			// 첨부 파일의 정보들을 li의 data 값으로 가지고 있다가 hidden으로 폼에 포함.
			// 첨부 파일 정보를 폼에 담아서 콘트롤러로 전송 처리 끝.
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

		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		// AJAX 처리 시 csrf 값을 함께 전송하기 위한 준비.
		// 스프링 시큐리티는 데이터 POST 전송시 csrf 값을 꼭 확인한다.

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
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : formData,
				type : 'POST',
				dataType : 'json',
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
		} // end_showUploadResult

		$(".uploadResult").on("click", "b", function(e) {

			console.log("delete file");

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
			})
		});
	});
</script>

<%@ include file="../includes/footer.jsp"%>