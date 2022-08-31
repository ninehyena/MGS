package kr.mintGradeStore.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.mintGradeStore.domain.BoardAttachVO;
import kr.mintGradeStore.domain.Criteria;
import kr.mintGradeStore.domain.NoticeVO;
import kr.mintGradeStore.mapper.BoardAttachMapper;
import kr.mintGradeStore.mapper.NoticeMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NoticeServiceImp implements NoticeService {

	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;

	@Override
	public List<NoticeVO> getListNotice() {

		log.info("공지 목록...... ");
		// 모든 레코드 추출.

		return mapper.getListNotice();
	}

	@Override
	public List<NoticeVO> getListNotice(Criteria cri) {

		log.info("페이징 처리된 공지 목록...... " + cri);

		return mapper.getListWithPagingNotice(cri);
	}

	@Override
	public int getTotalCountNotice(Criteria cri) {

		log.info("모든 공지 개수");

		return mapper.getTotalCountNotice(cri);
	}

	@Transactional
	@Override
	public void registerNotice(NoticeVO notice) {

		log.info("공지 등록...... " + notice);

		mapper.insertSelectKeyNotice(notice);

		if (notice.getAttachList() == null || notice.getAttachList().size() <= 0) {
			return;
		}

		notice.getAttachList().forEach(attach -> {
			attach.setBno(notice.getBno());
			attachMapper.insert(attach);
			// 첨부 파일이 있다면 디비에 등록.
		});
	}

	@Override
	public NoticeVO getNotice(long bno) {

		log.info("공지 읽기...... " + bno);

		return mapper.readNotice(bno);
	}

	@Transactional
	@Override
	public boolean modifyNotice(NoticeVO notice) {

		log.info("공지 수정...... " + notice);

		boolean modifyResult = false; // 게시물 수정 성공 여부.

		modifyResult = mapper.updateNotice(notice) == 1;

		int attachList = 0;// 첨부 파일 개수.

		if (notice.getAttachList() != null) {
			attachList = notice.getAttachList().size();
		}

		long bno = notice.getBno();

		attachMapper.deleteAll(bno);

		if (modifyResult && attachList > 0) {
			// 등록하려는 첨부 파일 목록(1,2)
			List<BoardAttachVO> inputList = notice.getAttachList();
			// 디비에 등록되어 있는 첨부 파일 목록(2,3)
			// List<NoticeAttachVO> dbList = attachMapper.findByBno(Notice.getBno());
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
	public boolean removeNotice(long bno) {

		log.info("공지 삭제...... " + bno);

		attachMapper.deleteAll(bno);

		return (mapper.deleteNotice(bno)) == 1;
	}

	@Override
	public List<BoardAttachVO> getAttachListNotice(long bno) {

		log.info("공지 첨부 파일 목록 가져오기: " + bno);

		return attachMapper.findByBno(bno);
		// 게시물 번호를 전달하고 게시물 번호와 일치하는 첨부 파일을 모두 리턴.
	}
}