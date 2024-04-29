package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SaleListCriteria extends Criteria {
	String year;
	String month;
	
	public SaleListCriteria(int page, String year,String month) {
		super(page);
		this.year = year;
		this.month = month;
	}
}
