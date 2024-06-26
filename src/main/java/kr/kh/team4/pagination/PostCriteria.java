package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PostCriteria extends Criteria{
	private int ca;
	private String order = "new";
	private String role = "desc";
	
	public PostCriteria(int ca) {
		super();
		this.ca = ca;
		order = "new";
	}
	
	public PostCriteria (String order) {
		super();
		this.order = order;
	}
	
	public PostCriteria (String order, String role) {
		super();
		this.order = order;
		this.role = role;
	}
	
	public PostCriteria(int ca, String order, String role) {
		super();
		this.ca = ca;
		this.order = order;
		this.role = role;
	}
	
}
