package kr.kh.team4.model.vo.book;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AuthorsVO {
	private int au_num; 
	private String au_name; 
	private String au_bo_num;
}
