package kr.mintGradeStore.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	// 첨부 파일 1개 처리.
	// BoardAttachVO는 어느 게시물의 첨부 파일인지 처리.

	private String fileName;
	private String uploadPath;
	private String uuid;
	
	private boolean image;
}
