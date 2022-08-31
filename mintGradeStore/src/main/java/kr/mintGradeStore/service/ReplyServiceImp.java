package kr.mintGradeStore.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.mintGradeStore.domain.Criteria;
import kr.mintGradeStore.domain.ReplyPageDTO;
import kr.mintGradeStore.domain.ReplyVO;
import kr.mintGradeStore.mapper.BoardMapper;
import kr.mintGradeStore.mapper.ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImp implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	// 게시물 테이블과 댓글 테이블은 동시에 동작하거나 취소 되어야 한다.
	// @Transactional 이용.
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Transactional
	@Override
	public int register(ReplyVO vo) {

		log.info("댓글 등록...... " + vo);

		boardMapper.updateReplyCnt(vo.getBno(), 1);
		// 댓글이 등록 된다면 게시물 테이블의 댓글 총 개수 1 증가.

		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(long rno) {

		log.info("댓글 읽기...... " + rno);

		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO reply) {

		log.info("댓글 수정...... " + reply);

		return mapper.update(reply);
	}

	@Transactional
	@Override
	public int remove(long rno) {

		log.info("댓글 삭제...... " + rno);
		
		ReplyVO vo = mapper.read(rno);
		
		boardMapper.updateReplyCnt(vo.getBno(), -1);

		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, long bno) {

		log.info("댓글 목록 가져오기" + bno);

		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, long bno) {

		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
		// 각각의 매퍼를 이용하여 댓글의 개수와 댓글의 목록 추출.
	}
}
