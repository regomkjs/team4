package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReviewCriteria extends Criteria{
	int boNum;
	int rv_num;
	private String order = "rv_num";
	
	public ReviewCriteria(int page, int boNum,int rv_num) {
		super(page);
		this.boNum = boNum;
		this.rv_num = rv_num;
	}
	
	public ReviewCriteria (String order) {
		super();
		this.order = order;
	}
}
