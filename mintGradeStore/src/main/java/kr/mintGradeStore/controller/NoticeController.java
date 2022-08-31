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
import kr.mintGradeStore.domain.Criteria;
import kr.mintGradeStore.domain.NoticeVO;
import kr.mintGradeStore.domain.PageDTO;
import kr.mintGradeStore.service.NoticeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NoticeController {

	private NoticeService service;

	@GetMapping("/list")
	public void list(Model model, Criteria cri) {

		log.info("전체 공지 목록: " + cri);

		model.addAttribute("list", service.getListNotice(cri));

		int total = service.getTotalCountNotice(cri);

		log.info("총 개수: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()") // 로그인 사용자만 접근.
	public String register(NoticeVO notice, RedirectAttributes rttr) {

		log.info("공지 등록: " + notice);

		service.registerNotice(notice);

		rttr.addFlashAttribute("result", notice.getBno());

		return "redirect:/notice/list";
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") long bno, @ModelAttribute("cri") Criteria cri, Model model) {

		log.info("/get");

		model.addAttribute("notice", service.getNotice(bno));
	}

	@PostMapping("/modify")
	@PreAuthorize("isAuthenticated()")
	// @PreAuthorize("principal.username == #notice.writer")
	public String modify(NoticeVO notice, Criteria cri, RedirectAttributes rttr) {

		log.info("공지 수정: " + notice);

		if (service.modifyNotice(notice)) {
			rttr.addFlashAttribute("result", "공지 사항을 수정했어요.");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/notice/list";
	}

	@PostMapping("/remove")
	@PreAuthorize("isAuthenticated()")
	// @PreAuthorize("principal.username == #writer")
	public String remove(@RequestParam("bno") long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,
			String writer) {

		log.info("공지 삭제...... " + bno);

		List<BoardAttachVO> attachList = service.getAttachListNotice(bno);

		if (service.removeNotice(bno)) {
			deleteFiles(attachList); // 서버 디스크의 파일 정보 삭제.
			rttr.addFlashAttribute("result", "공지 사항을 삭제했어요.");
		}

		return "redirect:/notice/list" + cri.getListLink();
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(long bno) {

		log.info("첨부 파일 목록 가져오기: " + bno);

		return new ResponseEntity<>(service.getAttachListNotice(bno), HttpStatus.OK);
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