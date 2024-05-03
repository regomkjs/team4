package kr.kh.team4.model.vo.post;

import java.text.SimpleDateFormat;
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
	private String po_datetime; 
	private String po_me_id; 
	private int po_ca_num;
	/*
	private String dateString = calDateString(po_datetime);
	*/
	
	//카테고리 이름
	private String ca_name;
	//댓글수
	private int po_co_count;
	//좋아요수
	private int po_totalHeart;
	//작성자 닉네임
	private String me_nick;
	//작성자 권한
	private int me_mr_num;
	//작성자 활동등급
	private int me_gr_num;
	//투표 포함 여부
	private boolean po_votePost;
	
	
	public PostVO(int po_num) {
		this.po_num = po_num;
	}
	
	/*
	public String calDateString(Date po_datetime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return "" + format.format(po_datetime);
	}
	*/
}
