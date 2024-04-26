package kr.kh.team4.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SaleDTO {
	private String book_name;
	private String imp_uid;
	private String merchant_uid;
}
