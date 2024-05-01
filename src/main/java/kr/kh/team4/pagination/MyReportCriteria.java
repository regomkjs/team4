package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MyReportCriteria extends Criteria {
	private String me_id;
	private int rp_num;
	
	public MyReportCriteria(String me_id, int rp_num) {
		super();
		this.me_id = me_id;
		this.rp_num = rp_num;
	}
}