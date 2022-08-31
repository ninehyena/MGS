package kr.mintGradeStore.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
// @Setter, @Getter, @ToString
// setter, getter, toString hashcode, equals 등을 자동 생성 처리하는 만능 어노테이션.
public class BoardVO {

	private long bno;
	private String writer;
	private String consoleName;
	private String gameName;
	private String gameNameOriginal;
	private long gameReleaseDate;
	private String gameReleaseDateYMD;
	private String gameCondition;
	private long gamePrice;
	private long gameGrade;
	private long gameQuantity;
	private String content;
	private Date regDate;
	private Date updateDate;

	private int replyCnt;

	private List<BoardAttachVO> attachList;
}