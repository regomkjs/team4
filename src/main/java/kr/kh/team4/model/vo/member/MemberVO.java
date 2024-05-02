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
	private String me_date; 
	private int me_fail_count; 
	private String me_block; 
	private Date me_loan_block; 
	private int me_count;
	private int me_post_count;
	private int me_loan_count;
	private int me_report_count;
	private int me_ms_num; 
	private int me_gr_num;
	private int me_mr_num;
	//자동로그인
	private boolean autoLogin;
	private String me_cookie;
	private Date me_cookie_limit;
	//등급명
	private String me_gr_name;
	//상태명
	private String me_ms_name;
	//권한명
	private String me_mr_name;
	
	//sns로그인용 생성자
	public MemberVO(String me_id, String me_email, String me_phone, String me_nick) {
		this.me_id = me_id;
		this.me_email = me_email;
		this.me_phone = me_phone;
		this.me_nick = me_nick;
	}
	
	
}
