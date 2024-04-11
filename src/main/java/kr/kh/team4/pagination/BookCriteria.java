package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BookCriteria extends Criteria {
	boolean bo_code;
	
	public BookCriteria(int page, boolean bo_code) {
		super(page);
		this.bo_code = bo_code;
	}
}
