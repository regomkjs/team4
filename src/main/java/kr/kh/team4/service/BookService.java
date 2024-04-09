package kr.kh.team4.service;

import java.util.ArrayList;

import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.vo.book.UnderVO;
import kr.kh.team4.model.vo.book.UpperVO;

public interface BookService {

	boolean insertBook(ArrayList<BookDTO> book);

	ArrayList<UpperVO> getUpperList();

	ArrayList<UnderVO> getUnderList();

	
}
