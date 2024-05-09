package kr.kh.team4.model.vo.post;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
public class CommentVO {
	
	private int co_num; 
	private int co_ori_num; 
	private String co_content; 
	private String co_datetime; 
	private int co_state; 
	private String co_me_id; 
	private int co_po_num;
	/*
	private String dateString = calDateString(co_datetime);
	*/
	
	//작성자 닉네임
	private String me_nick;
	//작성자 권한
	private int me_mr_num;
	//작성자 등급
	private int me_gr_num;
	//게시글 번호
	private String po_num;
	//게시글 제목
	private String po_title;
	
	/*
	public String calDateString(Date co_datetime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return "" + format.format(co_datetime);
	}
	*/
	
	public CommentVO(int co_ori_num, String co_content, String co_me_id, int co_po_num) {
		this.co_ori_num = co_ori_num;
		this.co_content = co_content;
		this.co_me_id = co_me_id;
		this.co_po_num = co_po_num;
	}

}
