package kr.kh.team4.model.vo.book;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SaleVO {
	private int sa_num; 
	private int sa_price; 
	private Date sa_date;
	private String sa_bo_num; 
	private String sa_me_id;
}
