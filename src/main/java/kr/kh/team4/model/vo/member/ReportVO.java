package kr.kh.team4.model.vo.member;

import kr.kh.team4.model.vo.post.CommentVO;
import kr.kh.team4.model.vo.post.PostVO;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
public class ReportVO {
	private int rp_num; 
	private String rp_note; 
	private String rp_type; 
	private String rp_target; 
	private String rp_writer;
	private String rp_me_id;
	//신고 대상 닉네임
	private String rp_writer_nick;
	//신고자 닉네임
	private String rp_me_nick;
	//신고 위치의 게시글
	private PostVO rp_post;
	//신고 위치의 댓글
	private CommentVO rp_comment;
}
