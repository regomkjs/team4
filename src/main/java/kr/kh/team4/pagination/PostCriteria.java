package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PostCriteria extends Criteria{
	private int ca;

	public PostCriteria(int ca) {
		super();
		this.ca = ca;
	}
	
	
}
