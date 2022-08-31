package kr.mintGradeStore.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.mintGradeStore.domain.MemberVO;
import kr.mintGradeStore.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImp implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Override
	public void signup(MemberVO member, String userId) throws Exception {

		mapper.signup(member);

		mapper.userAuth(userId);
	}

	@Override
	public int userIdCheck(String userId) throws Exception {

		return mapper.userIdCheck(userId);
	}

	@Override
	public int userMailCheck(String userMail) throws Exception {

		return mapper.userMailCheck(userMail);
	}

	@Override
	public String findId(String userMail) {

		log.info("아이디 찾기...... " + userMail);

		return mapper.findId(userMail);
	}

	@Override
	public int findPw(String userId, String userMail) {

		log.info("비밀번호 찾기...... " + userId);

		return mapper.findPw(userId, userMail);
	}

	@Override
	public int sendPwMail(MemberVO member) {

		log.info("비밀번호 변경...... " + member);

		return mapper.sendPwMail(member);
	}
}