package kr.mintGradeStore.mapper;

import java.util.List;

import kr.mintGradeStore.domain.Criteria;
import kr.mintGradeStore.domain.NoticeVO;

public interface NoticeMapper {

	public List<NoticeVO> getListNotice(); // 목록 가져오기.

	public List<NoticeVO> getListWithPagingNotice(Criteria cri); // 페이징 처리된 목록 가져오기.

	public int getTotalCountNotice(Criteria cri);
	// 총 개시물 개수 파악.

	public void insertSelectKeyNotice(NoticeVO Notice);
	// 생성되는 시퀀스 값을 확인하고 나머지 값 입력.
	// 새로운 게시물 1개 추가.

	public NoticeVO readNotice(long bno);
	// bno가 아닌 다른 값이 들어가도 작동.

	public int updateNotice(NoticeVO vo);

	public int deleteNotice(long bno);
}
