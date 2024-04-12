package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MyCommentCriteria extends Criteria{
	int poNum;
	String me_id;
	public MyCommentCriteria(int poNum, String me_id) {
		super();
		this.poNum = poNum;
		this.me_id = me_id;
	}
}
