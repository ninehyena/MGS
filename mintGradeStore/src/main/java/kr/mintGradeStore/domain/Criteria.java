package kr.mintGradeStore.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum; // 현재 페이지 번호.
	private int amount; // 페이지당 게시물 수.

	public Criteria() {

		this(1, 12); // 아래 부분 전달값 2개 생성자 호출.
	}

	public Criteria(int pageNum, int amount) {

		this.pageNum = pageNum;
		this.amount = amount;
	}

	private String type; // 키워드.

	public String[] getTypeArr() {
		// 검색 타입의 배열 가져오기.

		return type == null ? new String[] {} : type.split("");
		// 검색 타입이 null이라면 비어있는 문자열 배열을 만들고 그렇지 않다면 검색 타입을 한 글자씩 잘라서 문자열 배열로 만든다.
	}

	private String keyword; // 검색어.

	public String getListLink() {

		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("").queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount()).queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());

		return builder.toUriString();
		// 기존에 get 방식으로 전달하던 page, amount, type, keyword를 주소 창에 get 방식으로 붙여서 보냈었는데,
		// 일일히 값을 호출하여 처리하는 것이 아니라 getListLink 메소드로 한꺼번에 처리하도록 변경.
	}
}