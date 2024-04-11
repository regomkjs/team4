package kr.kh.team4.model.dto;

import java.sql.Date;


import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BookDTO {
	private String title;//도서명
	private String contents;//도서내용
	private Date datetime;//출판날짜
	private String publisher;//출판사
	private Integer price;//정가
	private Integer sale_price;//판매가
	private String thumbnail;//이미지
	private String isbn;//표준번호
	
	private String[] authors;//저자 리스트
	private String[] translators;//역자 리스트
	
	@Override
	public String toString() {
		return "BookDTO [title=" + title + ", isbn=" + isbn + "]";
	}
	
}
