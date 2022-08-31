package kr.mintGradeStore.mapper;

import org.apache.ibatis.annotations.Param;

import kr.mintGradeStore.domain.MemberVO;

public interface MemberMapper {

	public void signup(MemberVO vo); // 회원 가입.

	public int userIdCheck(String userId); // 아이디 중복 검사.

	public int userMailCheck(String userMail); // 아이디 중복 검사.

	public void userAuth(String userId); // 회원 권한.

	public MemberVO login(String userId); // 로그인.
	// 사용자가 아이디를 입력하면 그에 해당하는 계정 정보를 디비에서 추출.

	public String findId(String userMail); // 아이디 찾기.

	public int findPw(@Param("userId") String userId, @Param("userMail") String userMail); // 비밀번호 찾기.

	public int sendPwMail(MemberVO member); // 임시 비밀번호 발급.
	
	public int updateMember(MemberVO vo);
}