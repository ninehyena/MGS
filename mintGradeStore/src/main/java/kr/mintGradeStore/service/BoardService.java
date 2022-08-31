package kr.mintGradeStore.service;

import java.util.List;

import kr.mintGradeStore.domain.BoardAttachVO;
import kr.mintGradeStore.domain.BoardVO;
import kr.mintGradeStore.domain.Criteria;

public interface BoardService {

	public List<BoardVO> getList(); // 목록

	public List<BoardVO> getList(Criteria cri); // 위와 다른 메소드라 추가 해도 된다.

	public int getTotalCount(Criteria cri);

	public void register(BoardVO board); // 쓰기

	public BoardVO get(long bno); // 읽기

	public boolean modify(BoardVO board); // 수정

	public boolean remove(long bno); // 삭제

	public List<BoardAttachVO> getAttachList(long bno);
	// 게시물의 정보를 가지고 오면서 첨부 파일의 정보도 포함.
}