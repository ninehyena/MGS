package kr.mintGradeStore.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
// @Getter 위치 중요. 초기화 후 호출하여야 한다.
// 호출하고 초기화 하면 오류 발생.
public class ReplyPageDTO {

	private int replyTotalCnt; // 댓글의 개수.

	private List<ReplyVO> list;
}