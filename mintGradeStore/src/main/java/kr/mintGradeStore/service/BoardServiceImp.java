package kr.mintGradeStore.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.mintGradeStore.domain.BoardAttachVO;
import kr.mintGradeStore.domain.BoardVO;
import kr.mintGradeStore.domain.Criteria;
import kr.mintGradeStore.mapper.BoardAttachMapper;
import kr.mintGradeStore.mapper.BoardMapper;
import kr.mintGradeStore.mapper.ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j // Lombok 로그 이용.
@Service // 이 클래스가 서비스 계층을 맡는다고 알린다.
// @AllArgsConstructor
// 객체를 생성하면서 선언된 모든 변수를 초기화 시켜주는 생성자를 만든다.
// 모든 매개 변수에 대한 생성자 생성. (생성자는 여러 개가 아니다.)
// 예) 전화번호부 클래스의 멤버 변수(이름, 연락처, 생일)
public class BoardServiceImp implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;

	@Override
	public List<BoardVO> getList() {

		log.info("상품 목록...... ");
		// 모든 레코드 추출.

		return mapper.getList();
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {

		log.info("페이징 처리된 상품 목록...... " + cri);

		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {

		log.info("모든 상품 개수");

		return mapper.getTotalCount(cri);
	}

	@Transactional
	@Override
	public void register(BoardVO board) {

		log.info("상품 등록...... " + board);

		mapper.insertSelectKey(board);

		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}

		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
			// 첨부 파일이 있다면 디비에 등록.
		});
	}

	@Override
	public BoardVO get(long bno) {

		log.info("상품 읽기...... " + bno);

		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {

		log.info("상품 수정...... " + board);

		boolean modifyResult = false; // 게시물 수정 성공 여부.

		modifyResult = mapper.update(board) == 1;

		int attachList = 0;// 첨부 파일 개수.

		if (board.getAttachList() != null) {
			attachList = board.getAttachList().size();
		}

		long bno = board.getBno();

		attachMapper.deleteAll(bno);

		if (modifyResult && attachList > 0) {
			// 등록하려는 첨부 파일 목록(1,2)
			List<BoardAttachVO> inputList = board.getAttachList();
			// 디비에 등록되어 있는 첨부 파일 목록(2,3)
			// List<BoardAttachVO> dbList = attachMapper.findByBno(board.getBno());
			// 파일을 삭제 했어도 디비 정보가 남아 있는 부분을 해소.
			for (BoardAttachVO bav : inputList) {
				bav.setBno(bno);
				attachMapper.insert(bav);
			}
		}
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(long bno) {

		log.info("상품 삭제...... " + bno);

		attachMapper.deleteAll(bno);

		replyMapper.deleteAll(bno); // 댓글 삭제.

		return (mapper.delete(bno)) == 1;
	}

	@Override
	public List<BoardAttachVO> getAttachList(long bno) {

		log.info("상품 첨부 파일 목록 가져오기: " + bno);

		return attachMapper.findByBno(bno);
		// 게시물 번호를 전달하고 게시물 번호와 일치하는 첨부 파일을 모두 리턴.
	}
}