package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberCriteria extends Criteria {
	private String order = "right";
	private String role = "asc";
	
	public MemberCriteria (int page, int perPageNum,String search, String type,String order,String role) {
		super(page, perPageNum, search, type);
		this.order = order == null ? "right" : order;
		this.role = role == null ? "asc" : role;
	}
}
