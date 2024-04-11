package kr.kh.team4.service;

import java.util.ArrayList;

import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.UnderVO;
import kr.kh.team4.model.vo.book.UpperVO;
import kr.kh.team4.pagination.Criteria;

public interface BookService {

	boolean insertBook(ArrayList<BookDTO> book);

	ArrayList<UpperVO> getUpperList();

	ArrayList<UnderVO> getUnderList();

	ArrayList<BookVO> getBookList(Criteria cri);

	int getTotalCount(Criteria cri);

	
}
