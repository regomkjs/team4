package kr.kh.team4.service;

import java.io.IOException;
import java.util.ArrayList;

import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.dto.UnderDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.LoanVO;
import kr.kh.team4.model.vo.book.ReserveVO;
import kr.kh.team4.model.vo.book.UnderVO;
import kr.kh.team4.model.vo.book.UpperVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.Criteria;

public interface BookService {

	boolean insertBook(ArrayList<BookDTO> book);

	ArrayList<UpperVO> getUpperList();
	
	ArrayList<UnderVO> getUnderList();

	ArrayList<BookVO> getBookList(Criteria cri);

	int getTotalCount(Criteria cri);

	ArrayList<UnderVO> getUnder(int num);

	boolean updateBook(int boNum, int caNum, int tyNum);

	boolean deleteBook(int num);

	BookVO getBook(int num);

	ArrayList<BookVO> getBookIsbn(String bo_isbn);

	boolean insertUpper(int caNum, String caName);

	boolean loanBook(MemberVO user, BookVO book);

	LoanVO getLoan(int num);

	boolean extendBook(MemberVO user, BookVO book);

	ArrayList<LoanVO> getLoanList(String bo_isbn);
	
	boolean deleteUpper(int caNum);

	boolean insertUnder(UnderDTO underDto);

	boolean deleteUnder(int num);

	boolean reserveBook(MemberVO user, BookVO book);

	ArrayList<ReserveVO> getReserveList(String bo_isbn);

	
}
