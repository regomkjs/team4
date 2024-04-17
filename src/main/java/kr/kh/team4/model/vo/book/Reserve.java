package kr.kh.team4.model.vo.book;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Reserve {
	private int re_num; 
	private Date re_date; 
	private String re_bo_num;
	private int re_state;
	private String re_me_id;

}
