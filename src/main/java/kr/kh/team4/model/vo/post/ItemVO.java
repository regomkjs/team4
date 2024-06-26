package kr.kh.team4.model.vo.post;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ItemVO {
	private int it_num; 
	private String it_name; 
	private int it_count; 
	private int it_vo_num;
	
	private boolean vo_dup;
	private int vo_state;
	private String vo_date;
	
	//화면에서 받아올때 vote와의 상관관계를 나타내기위한 카운트
	private int it_vo_count;
	
	//contains를 위한 equals
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ItemVO other = (ItemVO) obj;
		if (it_num != other.it_num)
			return false;
		return true;
	}
	
}
