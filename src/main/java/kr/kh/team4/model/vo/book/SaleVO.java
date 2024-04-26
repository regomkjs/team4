package kr.kh.team4.model.vo.book;



import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SaleVO {
	private int sa_num; 
	private Date sa_date;
	private String sa_uid; 
	private String sa_name; 
	private String sa_merchant_uid; 
	private int sa_ss_num; 
	private String sa_me_id;
	
	private String sa_state;
	private String sa_nick;
}
