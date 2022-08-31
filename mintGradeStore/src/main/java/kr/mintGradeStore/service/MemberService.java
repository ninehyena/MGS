package kr.mintGradeStore.service;

import org.apache.ibatis.annotations.Param;

import kr.mintGradeStore.domain.MemberVO;

public interface MemberService {

	public void signup(MemberVO member, String userId) throws Exception; // 회원 가입.

	public int userIdCheck(String userId) throws Exception; // 아이디 중복 체크.

	public int userMailCheck(String userMail) throws Exception; // 이메일 중복 체크.

	public String findId(String userMail); // 아이디 찾기.

	public int findPw(@Param("userId") String userId, @Param("userMail") String userMail); // 비밀번호 찾기.

	public int sendPwMail(MemberVO member); // 비밀번호 변경.
}