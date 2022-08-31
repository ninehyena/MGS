package kr.mintGradeStore.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.mintGradeStore.domain.BoardVO;
import kr.mintGradeStore.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> getList(); // 목록 가져오기.

	public List<BoardVO> getListWithPaging(Criteria cri); // 페이징 처리된 목록 가져오기.

	public int getTotalCount(Criteria cri);
	// 총 개시물 개수 파악.

	public void insertSelectKey(BoardVO board);
	// 생성되는 시퀀스 값을 확인하고 나머지 값 입력.
	// 새로운 게시물 1개 추가.

	public BoardVO read(long bno);
	// bno가 아닌 다른 값이 들어가도 작동.

	public int update(BoardVO vo);

	public int delete(long bno);

	public void updateReplyCnt(@Param("bno") long bno, @Param("amount") int amount);
}