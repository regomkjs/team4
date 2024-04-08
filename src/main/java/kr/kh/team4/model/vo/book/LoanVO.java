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
	private String lo_bo_num;
}
