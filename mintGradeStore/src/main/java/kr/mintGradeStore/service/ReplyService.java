package kr.mintGradeStore.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.mintGradeStore.domain.Criteria;
import kr.mintGradeStore.domain.ReplyPageDTO;
import kr.mintGradeStore.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);

	public ReplyVO get(long rno);

	public int modify(ReplyVO reply);

	public int remove(long rno);

	public List<ReplyVO> getList(@Param("cri") Criteria cri, @Param("bno") long bno);
	// 페이지 정보와 게시물 번호를 전달.
	
	public ReplyPageDTO getListPage(Criteria cri, long bno);
	// ReplyPageDTO: 댓글의 목록과 게시물의 개수.
}