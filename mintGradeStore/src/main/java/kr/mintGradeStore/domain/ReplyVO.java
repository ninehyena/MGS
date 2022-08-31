package kr.mintGradeStore.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private long bno;
	
	private long rno;
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
}