package kr.kh.team4.model.vo.post;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PostVO {
	private int po_num; 
	private String po_title; 
	private String po_content; 
	private int po_view; 
	private Date po_datetime; 
	private String po_me_id; 
	private int po_ca_num;
	
	private String ca_name;
	
	private int po_co_count;
	
	private int po_totalHeart;
}
