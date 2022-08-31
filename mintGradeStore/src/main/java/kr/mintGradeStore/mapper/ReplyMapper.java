package kr.mintGradeStore.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.mintGradeStore.domain.Criteria;
import kr.mintGradeStore.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);

	public ReplyVO read(long rno);

	public int update(ReplyVO reply);

	public int delete(long rno);

	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") long bno);
	// 페이지 정보와 게시물 번호를 전달.

	public int getCountByBno(long bno);
	// 게시물별 댓글 총 개수 파악.
	
	public int deleteAll(long bno);
}