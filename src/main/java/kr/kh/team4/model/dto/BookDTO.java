package kr.kh.team4.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
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
	
	public String authorsToString(String[] authors) {
		// String[] -> String 으로 만들어 DB에 저장하거나 출력하는 용도.
		// ["홍길동","나길동"] -> 홍길동, 나길동 식으로 DB 저장 및 콘솔에 출력되기 위함.
	    String str_author = "";
        for (int i = 0; i < authors.length-1; i++) {
        	str_author += authors[i] + ", ";
	    }
	    if (authors.length > 0) str_author += authors[authors.length-1];
	    return str_author;
	}
}
