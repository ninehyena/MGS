package kr.mintGradeStore.domain;

import lombok.Data;

@Data
public class BoardAttachVO {

	private long bno;
	
	private String fileName;
	private String uploadPath;
	private String uuid;

	private boolean fileType;
}