console.log("reply module......");

var replyService = (function() {
	function add(reply, callback, error) {
		// reply: 댓글 객체.
		// callback: 댓글 등록 후 수행할 메소드. 비동기.
		// 주문과 동시에 처리할 내용도 전달. 페이지 이동 없이 새로운 내용 갱신.

		console.log("add reply......");

		$.ajax({
			type: 'POST',
			url: '/replies/new',
			data: JSON.stringify(reply),
			// 전달 받은 객체를 JSON으로 변환.
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				// result와 status의 차이는 없다. xhr은 status와 responseText를 모두 가지고 있다.
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

	// 댓글 목록 가져오기.
	function getList(param, callback, error) {

		console.log("getList......");

		var bno = param.bno;
		var page = param.page || 1;
		// 페이지 번호가 있으면 페이지 번호 전달. 없으면 1을 전달.

		$.getJSON("/replies/pages/" + bno + "/" + page,
			function(data) {
				if (callback) {
					//					callback(data);
					callback(data.replyTotalCnt, data.list);
				}
			}).fail(function(xhr, status, err) {
				if (error) {
					error(er);
				}
			});
	}

	// 댓글 시간.
	function displayTime(timeValue) {

		var today = new Date(); // 현재 시간.
		var gap = today.getTime() - timeValue;
		// 시간 차이 연산.
		var dateObj = new Date(timeValue);
		// 댓글이 등록된 시간을 변수에 할당.
		var str = "";

		if (gap < (1000 * 60 * 60 * 24)) {
			// 시간 차이가 24시간 초과라면,
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			return [(hh > 9 ? '' : '0') + hh, ":", (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
			// 배열 요소를 문자열로 변환 .join
			// 시간 포맷을 맞추기 위해 0~9까지는 앞에 0을 추가로 표시.
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			return [yy, '/', (mm > 9 ? '' : '0') + mm, '/',
				(dd > 9 ? '' : '0') + dd].join('');
		}
	}

	// 댓글 읽기 처리.
	function get(rno, callback, error) {

		$.get("/replies/" + rno, function(result) {
			if (callback) {
				callback(result);
			}
		}).fail(function(xhr, status, er) {
			if (error) {
				error(er);
			}
		});
	}

	// 댓글 수정 처리.
	function update(reply, callback, error) {

		console.log("rno: " + reply.rno);

		$.ajax({
			type: 'PUT',
			url: '/replies/' + reply.rno,
			// url을 대문자로 쓰면 에러.
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

	// 댓글 삭제 처리.
	function remove(rno, replyer, callback, error) {

		$.ajax({
			type: 'delete',
			url: '/replies/' + rno,
			data: JSON.stringify({rno:rno, replyer:replyer}),
			contentType : "application/json; charset=utf-8",
			success: function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

	return {
		add: add, // 변수명.호출명 // 예) replyService.add
		getList: getList,
		displayTime: displayTime,
		get: get,
		update: update,
		remove: remove
	};
})(); // 즉시 실행 함수: 명시하는 것과 동시에 메모리 등록.