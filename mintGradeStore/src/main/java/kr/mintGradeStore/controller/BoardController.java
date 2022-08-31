package kr.mintGradeStore.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mintGradeStore.domain.BoardAttachVO;
import kr.mintGradeStore.domain.BoardVO;
import kr.mintGradeStore.domain.Criteria;
import kr.mintGradeStore.domain.PageDTO;
import kr.mintGradeStore.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;

	// @GetMapping: 페이지 요청 방식이 get일 경우.
	// @PostMapping: 페이지 요청 방식이 post일 경우.
	@GetMapping("/list")
	public void list(Model model, Criteria cri) {

//		log.info("list");
//
//		model.addAttribute("list", service.getList());
//		// Controller >>> Service >>> Mapper >>> MyBatis

		log.info("전체 상품 목록: " + cri);

		model.addAttribute("list", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTO(cri, 190));

		int total = service.getTotalCount(cri);

		log.info("총 개수: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()") // 로그인 사용자만 접근.
	public String register(BoardVO board, RedirectAttributes rttr) {
		// 클래스에 @Controller 어노테이션이 붙고 컴포넌트 스캔에 패키지가 지정되어 있다면(root-context.xml),
		// 매개 변수 인자들은 스프링이 자동으로 생성하고 할당한다.

//		if (board.getAttachList() != null) {
//			// 첨부 파일이 있다면,
//			board.getAttachList().forEach(attach -> log.info(attach));
//			// 첨부 파일의 각 요소를 로그로 출력.
//		}

		log.info("상품 등록: " + board);

		service.register(board);

		rttr.addFlashAttribute("result", board.getBno());
		// 리다이렉트 시키면서 1회용 값을 전달.

		return "redirect:/board/list";
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
		// 이동할 주소를 리턴하지 않는다면 요청한 이름으로의 JSP 파일을 찾는다.
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// @RequestParam: 요청을 통해 전달되는 변수 값.
		// 예) bno 이름으로 받은 변수를 bno로 할당.(글 번호 이용)
		// @ModelAttribute("cri")는 자동으로 객체 할당 저장.
		// 자동으로 생성된 Criteria cri를 모델값으로 저장하는데 저장명은 cri.

		log.info("/get");

		model.addAttribute("board", service.get(bno));
		// 전달값으로 명시만 하면 스프링이 자동으로 처리.
		// 사용하는 부분만 추가 구현.
	}

	@PostMapping("/modify")
	// @PreAuthorize("principal.username == #board.writer")
	@PreAuthorize("isAuthenticated()")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {

		log.info("상품 수정: " + board);

		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "상품 정보를 수정했어요.");
			// 수정 성공하면 success 메시지가 포함되어 이동.
			// 실패해도 메시지 빼고 이동.
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		// addFlashAttribute: 1회성. URL이 표시 창에 전달되지 않는다.
		// addAttribute: 지속. URL이 표시된다.
		// list 표시할 때 @GetMapping으로 목록을 처리.
		// 결과적으로 addFlashAttribute하는 경우에는 URL에 값이 전달되지 않으므로 1페이지로 돌아간다.
		// 전달한 pageNum과 amount가 전달되지 않는다.
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/board/list";
	}

	@PostMapping("/remove")
	// @PreAuthorize("principal.username == #writer")
	@PreAuthorize("isAuthenticated()")
	public String remove(@RequestParam("bno") long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,
			String writer) {

		log.info("상품 삭제...... " + bno);

		List<BoardAttachVO> attachList = service.getAttachList(bno);

		if (service.remove(bno)) {
			deleteFiles(attachList); // 서버 디스크의 파일 정보 삭제.
			rttr.addFlashAttribute("result", "상품 정보를 삭제했어요.");
		}

//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/board/list" + cri.getListLink();
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(long bno) {

		log.info("첨부 파일 목록 가져오기: " + bno);

		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}

	private void deleteFiles(List<BoardAttachVO> attachList) {

		if (attachList == null || attachList.size() == 0) {
			return;
		}

		log.info("첨부 파일 삭제...... ");
		log.info(attachList);

		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(
						"c:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				Files.deleteIfExists(file);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}
}