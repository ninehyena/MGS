package kr.mintGradeStore.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.mintGradeStore.domain.Criteria;
import kr.mintGradeStore.domain.ReplyPageDTO;
import kr.mintGradeStore.domain.ReplyVO;
import kr.mintGradeStore.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController // JSON이나 XML로 데이터 변환.
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService service;
	// 요청이 /replies/new로 오면 정보를 조회하여 리턴하는데 정보 형태는 JSON이고, 전달 결과물은 평범한 문자열 형태.

	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", produces = "application/text;charset=utf8")
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		// RequsetBody는 JSON 형태로 받은 값을 객체로 변환.

		log.info("댓글 정보: " + vo);

		int insertCount = service.register(vo);

		log.info("댓글 입력 개수: " + insertCount);

		return insertCount == 1 ? new ResponseEntity<>("댓글을 남겼어요.", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		// ResponseEntity: 웹 페이지 생성.(상태 코드, 헤더, 응답, 데이터)
		// 3항 연산자 이용. 정상 처리되면 정상 처리 status를 전달하고 아니면 오류 status를 전달.
		// HttpStatus: 페이지 상태를 전달.
	}

	@GetMapping(value = "/pages/{bno}/{page}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") long bno) {
		// @PathVariable: URL로 넘겨 받은 값 이용.

		log.info("댓글 목록...... ");

		Criteria cri = new Criteria(page, 10);

		log.info(cri);

		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
		// T<List<ReplyVO>> t = new T<>();
		// 댓글 목록을 출력하고 정상 처리 상태를 리턴.
	}

	// 댓글 1개 읽기.
	@GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") long rno) {

		log.info("댓글 읽기: " + rno);

		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}

	// 댓글 1개 수정.
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method = { RequestMethod.PUT,
			RequestMethod.PATCH }, value = "/{rno}", consumes = "application/json", produces = {
					"application/text;charset=utf8" })
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") long rno) {
		// PUT, PATCH 둘 다 수정 처리를 가리킨다.
		// 생성되는 정보의 형태는 JSON에 일반적인 문자열을 이용.
		// @RequestBody: JSON으로 생성된 정보를 객체화.

		vo.setRno(rno);

		log.info("댓글 번호: " + rno);
		log.info("수정 정보: " + vo);

		return service.modify(vo) == 1 ? new ResponseEntity<>("댓글을 수정했어요.", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 댓글 1개 삭제.
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value = "/{rno}", produces = "application/text;charset=utf8")
	public ResponseEntity<String> remove(@PathVariable("rno") long rno, @RequestBody ReplyVO vo) {

		log.info("댓글 삭제: " + rno);

		return service.remove(rno) == 1 ? new ResponseEntity<>("댓글을 삭제했어요.", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}