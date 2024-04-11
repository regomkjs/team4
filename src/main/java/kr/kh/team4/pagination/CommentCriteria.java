package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CommentCriteria extends Criteria {
	int poNum;
	
	public CommentCriteria(int page, int poNum) {
		super(page);
		this.poNum = poNum;
	}
}
