package kr.kh.team4.model.vo.book;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReserveVO {
	private int re_num; 
	private Date re_date; 
	private int re_state;
	private String re_bo_num;
	private String re_me_id;
	
	//책 번호
	private int bo_num;
	//책 고유번호
	private String bo_isbn;
	private String me_phone;
}
