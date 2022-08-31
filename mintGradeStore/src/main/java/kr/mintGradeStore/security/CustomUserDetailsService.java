package kr.mintGradeStore.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.mintGradeStore.domain.MemberVO;
import kr.mintGradeStore.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import security.domain.CustomUser;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	// 사용자가 로그인 창에서 아이디와 패스워드를 입력하면 해당 아이디를 가지고 일치하는 회원 정보 찾기.(서비스 처리)

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;
	// 쿼리 조작을 위한 인터페이스 초기화.

	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {

		log.warn("불러온 유저 이름: " + userId);

		MemberVO vo = memberMapper.login(userId);
		// 전달된 ID로 사용자 정보를 검색.

		return vo == null ? null : new CustomUser(vo);
		// 검색되지 않으면 null, 검색되면 해당 정보 리턴.
	}
}