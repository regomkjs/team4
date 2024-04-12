package kr.kh.team4.model.dto;

import java.util.ArrayList;

import kr.kh.team4.model.vo.post.VoteVO;
import lombok.Data;

@Data
public class VoteListDTO {
	private ArrayList<VoteVO> vo_list;
}
