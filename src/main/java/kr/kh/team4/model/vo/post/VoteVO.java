package kr.kh.team4.model.vo.post;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class VoteVO {
	private int vo_num; 
	private String vo_title; 
	private boolean vo_dup;
	private int vo_state; 
	private String vo_date; 
	private int vo_po_num;
	
	//화면에서 받을때 item 구분을 위한 카운트
	private int vo_count;
	
	
}
