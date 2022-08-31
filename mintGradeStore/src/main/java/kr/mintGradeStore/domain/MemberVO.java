package kr.mintGradeStore.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userId;
	private String userPw;
	private String userName;

	private String userMail;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;

	private Date regDate;
	private Date updateDate;
	
	private List<AuthVO> authList;
	// 하나의 아이디는 여러 개의 권한 소유 가능.

	private boolean enabled; // 계정 정지 유무.
}