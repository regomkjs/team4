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
	
	//카테고리 이름
	private String ca_name;
	//댓글수
	private int po_co_count;
	//좋아요수
	private int po_totalHeart;
	//작성자 닉네임
	private String me_nick;
}
