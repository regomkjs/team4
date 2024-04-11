package kr.kh.team4.model.vo.post;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
public class CommentVO {
	
	private int co_num; 
	private int co_ori_num; 
	private String co_content; 
	private Date co_datetime; 
	private int co_state; 
	private String co_me_id; 
	private int co_po_num;
	
	//작성자 닉네임
	private String me_nick;
	
	
	public CommentVO(int co_ori_num, String co_content, String co_me_id, int co_po_num) {
		this.co_ori_num = co_ori_num;
		this.co_content = co_content;
		this.co_me_id = co_me_id;
		this.co_po_num = co_po_num;
	}

}
