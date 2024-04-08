package kr.kh.team4.pagination;

import lombok.Data;

@Data
public class PageMaker {
	private int totalCount; 
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum;
	private Criteria cri;
	
	public void calculate() {
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
		startPage = endPage - displayPageNum + 1;
		int tmpEndPage = (int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
		if(endPage > tmpEndPage) {
			endPage = tmpEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage == tmpEndPage ? false : true;
	}
	public PageMaker(int displayPageNum, Criteria cri, int totalCount) {
		this.displayPageNum = displayPageNum;
		this.cri = cri;
		this.totalCount = totalCount;
		calculate();
	}
}