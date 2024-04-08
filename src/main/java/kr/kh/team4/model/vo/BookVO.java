package kr.kh.team4.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BookVO {
	private String bo_num;
	private String bo_title; 
	private String bo_contents; 
	private Date bo_date; 
	private String bo_publisher; 
	private int bo_price; 
	private int bo_sale_price;
	private String bo_thumbnail; 
	private String bo_isbn; 
	private int bo_un_num;
}
