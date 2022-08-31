package kr.mintGradeStore.controller;

import java.util.UUID;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.mintGradeStore.domain.MemberVO;
import kr.mintGradeStore.service.MemberService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {

	@Setter(onMethod_ = @Autowired)
	private MemberService service;

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	@Autowired
	private JavaMailSender mailSender;

	// 로그인.
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {

		if (error != null)
			model.addAttribute("error", "아이디 또는 비밀번호를 다시 확인해주세요.");

		if (logout != null)
			model.addAttribute("logout", "로그아웃 되었어요.");
	}

	// 로그아웃.
	@GetMapping("/customLogout")
	public void logoutGet() {

		log.info("로그아웃");
	}
	// Authorize : 승인.
	// Authenticated : 인증.

	// 회원 가입 양식.
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signupGet() {

		log.info("회원 가입 양식");
	}

	// 회원 가입 처리.
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signupPost(MemberVO member) throws Exception {

		log.info("회원 가입");

		member.setUserPw(pwencoder.encode(member.getUserPw()));

		String userId = member.getUserId();

		service.signup(member, userId);

		log.info("회원 가입: " + member);

		return "redirect:/customLogin";
	}

	// 아이디 중복 검사.
	@RequestMapping(value = "/userIdCheck", method = RequestMethod.POST)
	@ResponseBody
	public String userIdCheck(String userId) throws Exception {

		log.info("아이디 중복 검사");

		int result = service.userIdCheck(userId);

		log.info("아이디 중복 검사 결과: " + result);

		if (result != 0) {
			return "find";
		} else {
			return "available";
		}
	}

	// 이메일 중복 검사.
	@RequestMapping(value = "/userMailCheck", method = RequestMethod.POST)
	@ResponseBody
	public String userMailCheck(String userMail) throws Exception {

		log.info("이메일 중복 검사");

		int result = service.userMailCheck(userMail);

		log.info("이메일 중복 검사 결과: " + result);

		if (result != 0) {
			return "find";
		} else {
			return "available";
		}
	}

	// 아이디, 비밀번호 찾기 양식.
	@GetMapping("/findUserIdPw")
	public void selectAccount() {
	}

	// 아이디 찾기
	@RequestMapping(value = "/findUserIdPw/id", method = RequestMethod.POST)
	@ResponseBody
	public String findUserId(String userMail) throws Exception {

		log.info("아이디 찾기");

		String result = service.findId(userMail);

		if (result != null) {
			return result;
		} else {
			return "not found";
		}
	}

	// 비밀번호 찾기.
	@RequestMapping(value = "/findUserIdPw/pw", method = RequestMethod.POST)
	@ResponseBody
	public String findUserPw(String userId, String userPwMail) throws Exception {

		log.info("비밀번호 찾기");

		int result = service.findPw(userId, userPwMail);

		if (result == 1) {
			return "found";
		} else {
			return "not found";
		}
	}

	// 임시 비밀번호 발급.
	@RequestMapping(value = "/findUserIdPw/pwMail", method = RequestMethod.POST)
	@ResponseBody
	public String pwMailSend(String userId, String userPwMail) throws Exception {

		log.info("비밀번호 메일 전송 준비");

		// 임시 비밀번호 생성.
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		uuid = uuid.substring(0, 10);

		log.info("UUID: " + uuid);

		// 이메일 전송.
		log.info("비밀번호 메일 전송");

		String setFrom = "09_hyena@naver.com";
		String toMail = userPwMail;
		String title = "[Mint Grade Store] " + userId + "님. 민트 그레이드 스토어 임시 비밀번호입니다.";
		String content = "[Mint Grade Store]" + "<br><br><br>" + "안녕하세요 민트 그레이드 스토어입니다." + "<br><br>" + "회원님의 임시 비밀번호는 "
				+ "<b>" + uuid + "</b>" + "입니다." + "<br><br>" + "회원님의 개인 정보 보호를 위해 로그인 후 꼭 비밀번호를 변경해주세요."
				+ "<br><br><br>" + "감사합니다.";

		// 유저 비밀번호 변경,
		MemberVO member = new MemberVO();

		member.setUserId(userId);
		member.setUserMail(userPwMail);
		member.setUserPw(uuid);
		member.setUserPw(pwencoder.encode(member.getUserPw()));

		int result = service.sendPwMail(member);

		// 비밀번호를 변경 되었다면 메일 전송, 변경되지 않았다면 실패.
		if (result == 1) {
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				helper.setText(content, true);
				mailSender.send(message);
				return "success";
			} catch (Exception e) {
				e.printStackTrace();
				return "fail";
			}
		} else {
			return "not found";
		}
	}
}