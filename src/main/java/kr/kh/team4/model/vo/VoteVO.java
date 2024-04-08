package kr.kh.team4.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class VoteVO {
	private int vo_num; 
	private int vo_state; 
	private Date vo_date; 
	private int vo_po_num;
}
