package kr.kh.team4.model.vo.member;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GradeVO {
	private int gr_num; 
	private String gr_name; 
	private int gr_discount; 
	private int gr_loan_condition; 
	private int gr_post_condition;
}
