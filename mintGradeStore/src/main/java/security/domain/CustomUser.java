package security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.mintGradeStore.domain.MemberVO;

public class CustomUser extends User {
	// 사용자 계정과 권한 정보 저장.

	private static final long serialVersionUID = 1L;

	private MemberVO member;
	// 디비에서 추출한 회원 정보 초기화.

	public CustomUser(String userId, String password, Collection<? extends GrantedAuthority> authorities) {

		super(userId, password, authorities);
		// 상속을 받으면서 의무적으로 구현한 생성자.
		// <? extends 클래스명>: 제너릭 타입의 상위 제한.
		// <? super 클래스명>: 제너릭 타입의 하위 제한.
		// <?>: 제너릭 타입 제한 없다.
	}

	public CustomUser(MemberVO vo) {

		super(vo.getUserId(), vo.getUserPw(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));

		this.member = vo;
		// 사용자 아이디, 패스워드, 권한 목록으로 초기화.
	}
}