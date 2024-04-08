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

}
