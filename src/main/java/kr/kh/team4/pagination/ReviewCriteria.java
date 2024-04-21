package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReviewCriteria extends Criteria{
	int boNum;
	
	public ReviewCriteria(int page, int boNum) {
		super(page);
		this.boNum = boNum;
	}
}
