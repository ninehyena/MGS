package kr.mintGradeStore.domain;

import lombok.Data;

@Data
public class AuthVO {
	
	private String userId; // 사용자 아이디.
	
	private String auth; // 사용자 권한.
	// 사용자별 권한 등록.
}
