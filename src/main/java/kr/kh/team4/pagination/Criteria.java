package kr.kh.team4.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Criteria {
	
	private int page = 1;
	private int perPageNum = 10;

	private String search = ""; 
	private String type = "all"; 
	
	public Criteria(int page) {
		this.page = page;
	}
	public Criteria(int page, int perPageNum) {
		this.page = page;
		this.perPageNum = perPageNum;
	}
	public Criteria(int page, int perPageNum, String type, String search) {
		this(page, perPageNum);
		this.type = type == null ? "all" : type;
		this.search = search == null ? "" : search;
	}
	public int getPageStart() {
		return (page - 1) * perPageNum;
	}
}