package kr.mintGradeStore.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.mintGradeStore.domain.BoardVO;
import kr.mintGradeStore.domain.Criteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

//	@Test
//	public void testGetList() {
//
//		mapper.getList().forEach(board -> log.info(board));
//		// 향상된 for: 배열 그리고 배열 1개를 담을 변수.
//		// 람다식: ->를 기준으로 좌항은 전달값이고 우항은 처리.
//		// 목록은 게시물 여러 개(배열). 그 중 1개를 board에 담은 다음에 해당 내용을 로그로 출력. 배열 원소가 끝날 때까지 반복.
//	}

//	@Test
//	public void testRead() {
//		
//		BoardVO board = mapper.read(10l);
//		// 10번째 글 읽어오기.
//		// l은 bno가 long 타입이라는 것을 가르킨다.
//		
//		log.info(board);
//	}

//	@Test
//	public void testInsertSelectKey() {
//		
//		BoardVO board = new BoardVO();
//		
//		board.setWriter("새 작성자");
//		board.setConsoleName("XStation");
//		board.setGameName("Beyond the Game");
//		board.setGameReleaseDate(3022);
//		board.setGameCondition("새 상품");
//		board.setGamePrice(65000);
//		board.setGameGrade(6);
//		board.setContent("새 상품입니다.");
//		mapper.insertSelectKey(board);
//		
//		log.info(board);
//	}

//	@Test
//	public void testUpdate() {
//
//		BoardVO board = new BoardVO();
//
//		board.setBno(10l);
//		board.setWriter("수정된 작성자");
//		board.setConsoleName("XStation 2");
//		board.setGameName("Beyond the Game 2");
//		board.setGameReleaseDate(3025);
//		board.setGameCondition("미개봉");
//		board.setGamePrice(85000);
//		board.setGameGrade(5);
//		board.setContent("미개봉 상품입니다.");
//
//		int count = mapper.update(board);
//		log.info("update cnt:" + count);
//		// 10번째 글 수정하기.
//		// 수정 성공 시 수정된 레코드 개수 리턴.
//		// 수정 실패 시 0을 리턴.
//	}
	
//	@Test
//	public void testDelete() {
//		
//		log.info("delete cnt: " + mapper.delete(13l));
//		// 오라클에서는 해당 데이터가 삭제되지만 JUnit 상에서는 실패라고 뜬다.(why?)
//	}
	
	@Test
	public void testPaging() {
		
		Criteria cri = new Criteria();
		
		cri.setPageNum(1);
		cri.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board.getBno()));
	}
}

// 인터페이스에 메서드 추가. >>> .xml에 쿼리문 작성 >>> 테스트 코드 작성.
// (반복)