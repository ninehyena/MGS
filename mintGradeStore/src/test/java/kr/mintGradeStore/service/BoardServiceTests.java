package kr.mintGradeStore.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.mintGradeStore.domain.Criteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {

	@Setter(onMethod_ = { @Autowired })
	private BoardService service;
	
//	@Test
//	public void testRegister() {
//		
//		BoardVO board = new BoardVO();
//		
//		board.setWriter("새 작성자(Service)");
//		board.setConsoleName("XStation(Service)");
//		board.setGameName("Beyond the Game(Service)");
//		board.setGameReleaseDate(3022);
//		board.setGameCondition("새 상품(Service)");
//		board.setGamePrice(65000);
//		board.setGameGrade(6);
//		board.setContent("새 상품입니다.(Service)");
//		service.register(board);
//		
//		log.info("생성된 게시물 번호: " + board.getBno());
//	}

	@Test
	public void testPaging2() {
		
		service.getList(new Criteria(4, 10)).forEach(board -> log.info(board));
	}
}

// Service >>> Mapper >>> MyBatis Query