package kr.kh.team4.model.vo.book;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class UnderVO {
	private int un_num; 
	private String un_name;
	private int un_code;
	private int un_up_num;
	
	public UnderVO(int un_code) {
		this.un_code = un_code;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UnderVO other = (UnderVO) obj;
		if (un_code != other.un_code)
			return false;
		return true;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + un_code;
		return result;
	}
	
	
}
