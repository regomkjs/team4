package kr.kh.team4.model.dto;

import java.util.ArrayList;

import kr.kh.team4.model.vo.post.ItemVO;
import lombok.Data;

@Data
public class ItemListDTO {
	private ArrayList<ItemVO> it_list;
}
