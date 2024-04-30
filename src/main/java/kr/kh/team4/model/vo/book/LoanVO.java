package kr.kh.team4.model.vo.book;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LoanVO {
	private int lo_num;  
	private Date lo_date; 
	private Date lo_return; 
	private Date lo_limit; 
	private int lo_state; 
	private String lo_me_id;
	private int lo_bo_num;
	
	//책 번호
	private int bo_num;
	//책 고유번호
	private String bo_isbn;
}
