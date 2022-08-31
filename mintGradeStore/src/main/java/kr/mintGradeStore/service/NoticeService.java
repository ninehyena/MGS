package kr.mintGradeStore.service;

import java.util.List;

import kr.mintGradeStore.domain.BoardAttachVO;
import kr.mintGradeStore.domain.Criteria;
import kr.mintGradeStore.domain.NoticeVO;

public interface NoticeService {

	public List<NoticeVO> getListNotice(); // 목록

	public List<NoticeVO> getListNotice(Criteria cri); // 위와 다른 메소드라 추가 해도 된다.

	public int getTotalCountNotice(Criteria cri);

	public void registerNotice(NoticeVO Notice); // 쓰기

	public NoticeVO getNotice(long bno); // 읽기

	public boolean modifyNotice(NoticeVO Notice); // 수정

	public boolean removeNotice(long bno); // 삭제

	public List<BoardAttachVO> getAttachListNotice(long bno);
	// 게시물의 정보를 가지고 오면서 첨부 파일의 정보도 포함.
}