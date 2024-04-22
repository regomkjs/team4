package kr.kh.team4.model.vo.member;

import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
public class ReportVO {
	private int rp_num; 
	private String rp_note; 
	private String rp_type; 
	private String rp_target; 
	private String re_writer;
	private String rp_me_id;
	
}
