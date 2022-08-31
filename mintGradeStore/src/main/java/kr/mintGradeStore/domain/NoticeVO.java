package kr.mintGradeStore.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class NoticeVO {

	private long bno;
	private String writer;
	private String category;
	private String title;
	private String content;
	private Date regDate;
	private Date updateDate;

	private List<BoardAttachVO> attachList;
}
