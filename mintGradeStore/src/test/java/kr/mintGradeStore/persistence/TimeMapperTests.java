package kr.mintGradeStore.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.mintGradeStore.mapper.TimeMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j // 시스템의 발생 상황을 쉽게 확인할 수 있도록 로그 생성. syso 출력과 비슷하다.
public class TimeMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private TimeMapper timeMapper;
	
	@Test // Add JUnit 4 library to the build path
	public void testGetTimeMintGradeStore() {
		
		log.info("XML 이용: " + timeMapper.getTimeMintGradeStore());
		// timeMapper: 인터페이스.
		// getTimeMintGradeStore: 메서드 선언.
		// 인터페이스를 implements 받아서 자식 클래스를 생성. 메서드 오버라이드 처리는 스프링 컴파일러가 자동으로 수행.
		// getTimeMintGradeStore와 매칭되는 XML 파일의 값을 읽어서 결과를 리턴.
	}
}