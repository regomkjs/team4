package kr.kh.team4.model.vo.book;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OpinionVO {
	private int op_num; 
	private int op_state; 
	private int op_rv_num; 
	private String op_me_id;
	
	public OpinionVO(int rv_num, String me_id) {
		this.op_rv_num = rv_num;
		this.op_me_id = me_id;
	}
}
