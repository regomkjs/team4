package kr.kh.team4.model.vo.book;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BookVO {
	private int bo_num;
	private String bo_title; 
	private String bo_contents; 
	private Date bo_date; 
	private String bo_publisher; 
	private int bo_price; 
	private int bo_sale_price;
	private String bo_thumbnail; 
	private String bo_isbn; 
	private int bo_un_num;
	private String bo_code;
	private int bo_loan_count;
	
	private String bo_au_name;
	private String bo_tr_name;
	
	private Date lo_date;
	private Date lo_limit;
	private String me_nick;
	private String me_phone;
	public BookVO(int bo_num) {
		this.bo_num = bo_num;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookVO other = (BookVO) obj;
		if (bo_num != other.bo_num)
			return false;
		return true;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + bo_num;
		return result;
	}

	
	
}
