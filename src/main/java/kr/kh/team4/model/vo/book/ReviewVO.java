package kr.kh.team4.model.vo.book;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReviewVO {
	private int rv_num; 
	private String rv_content; 
	private int rv_score; 
	private Date rv_date;
	private String rv_me_id; 
	private int rv_bo_num;
	
}
