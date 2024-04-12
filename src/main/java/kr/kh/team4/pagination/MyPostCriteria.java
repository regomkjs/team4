package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MyPostCriteria extends Criteria {
	private String me_id;
	private int ca;
	public MyPostCriteria(String me_id) {
		super();
		this.me_id = me_id;
	}
	
	public MyPostCriteria(int ca) {
		super();
		this.ca = ca;
	}
}