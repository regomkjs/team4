package kr.kh.team4.model.vo.post;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class VoteVO {
	private int vo_num; 
	private String vo_title; 
	private boolean vo_dup;
	private int vo_state; 
	private String vo_date; 
	private int vo_po_num;
	
	//화면에서 받을때 item 구분을 위한 카운트
	private int vo_count;
	
	//투표 총 참여자 수
	private int vo_totalMember;
	
	// vote/close ajax를 위한 생성자 
	public VoteVO(int vo_num, int vo_po_num) {
		this.vo_num = vo_num;
		this.vo_po_num = vo_po_num;
	}

	//contains를 위한 equals
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		VoteVO other = (VoteVO) obj;
		if (vo_num != other.vo_num)
			return false;
		return true;
	}

}
