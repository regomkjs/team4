package kr.kh.team4.model.vo.member;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberVO {
	private String me_id; 
	private String me_pw; 
	private String me_email; 
	private String me_phone; 
	private String me_nick; 
	private Date me_date; 
	private int me_fail_count; 
	private String me_block; 
	private Date me_loan_block; 
	private int me_count;
	private int me_loan_count;
	private int me_ms_num; 
	private int me_gr_num;
	private int me_mr_num;
}
