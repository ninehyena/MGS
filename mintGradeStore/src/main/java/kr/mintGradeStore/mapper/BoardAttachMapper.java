package kr.mintGradeStore.mapper;

import java.util.List;

import kr.mintGradeStore.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public List<BoardAttachVO> findByBno(long bno); // 첨부 파일 목록.

	public void insert(BoardAttachVO vo); // 첨부 파일 등록.

	public void delete(String uuid); // 첨부 파일 삭제.

	public void deleteAll(long bno); // 첨부 파일 여러 개 한꺼번에 삭제.

	public List<BoardAttachVO> getOldFiles();
	// 커뮤니티를 이용하는 이용자들은 중복 파일명을 사용할 수도 있다.
	// 시스템은 동일 파일명에 대해 내부적으로 저장하는 다른 이름을 가진다.
}