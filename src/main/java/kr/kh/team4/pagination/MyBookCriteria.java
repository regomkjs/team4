package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MyBookCriteria extends Criteria{
	private int bo_num;
	private String me_id;
	
	public MyBookCriteria(int page, int bo_num, String me_id) {
		super(page);
		this.bo_num = bo_num;
		this.me_id = me_id;
	}
}
