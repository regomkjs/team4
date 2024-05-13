package kr.kh.team4.service;

import java.io.IOException;
import java.util.ArrayList;

import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.dto.SaleDTO;
import kr.kh.team4.model.dto.UnderDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.LoanVO;
import kr.kh.team4.model.vo.book.OpinionVO;
import kr.kh.team4.model.vo.book.ReserveVO;
import kr.kh.team4.model.vo.book.ReviewVO;
import kr.kh.team4.model.vo.book.SaleStateVO;
import kr.kh.team4.model.vo.book.SaleVO;
import kr.kh.team4.model.vo.book.UnderVO;
import kr.kh.team4.model.vo.book.UpperVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.BookCriteria;
import kr.kh.team4.pagination.CommentCriteria;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.MyBookCriteria;
import kr.kh.team4.pagination.ReviewCriteria;
import kr.kh.team4.pagination.SaleListCriteria;

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

	boolean extendBook(MemberVO user, BookVO book);

	ArrayList<LoanVO> getLoanList(String bo_isbn);
	
	boolean deleteUpper(int caNum);

	boolean insertUnder(UnderDTO underDto);

	boolean deleteUnder(int num);

	boolean reserveBook(MemberVO user, BookVO book);

	boolean returnBook(MemberVO user, BookVO book);

	ArrayList<ReviewVO> getReviewList(ReviewCriteria cri);

	int getTotalCountReview(ReviewCriteria cri);

	boolean insertReview(ReviewVO review, MemberVO user);

	boolean deleteReview(ReviewVO review, MemberVO user);

	boolean updateReview(ReviewVO review, MemberVO user);

	boolean insertSale(MemberVO user, SaleDTO saleDto);

	ReviewVO getAvgReview(int bo_num);

	int opinion(OpinionVO opinion, MemberVO user);

	int getUserOpinion(int rv_num, MemberVO user);

	ReviewVO getReview(int rv_num);

	ArrayList<BookVO> getLoanBookList(Criteria cri, MemberVO user);

	int totalCountLoanBook(Criteria cri, MemberVO user);

	ArrayList<ReserveVO> getReserveList(int bo_num);

	ArrayList<SaleVO> getSaleList(String me_id, SaleListCriteria cri);

	SaleVO getSale(String sa_merchant_uid);

	void updateSale(SaleVO order);

	ArrayList<SaleStateVO> getSaleStateList();

	int getUserSaleTotalCount(String me_id, SaleListCriteria cri);

	ArrayList<ReserveVO> getReList(MemberVO user);

	void deleteReserve(ReserveVO reserve, MemberVO user);
	
	ArrayList<SaleVO> selectSaleList(SaleListCriteria cri);

	int selectSaleTotalCount(SaleListCriteria cri);

	ArrayList<LoanVO> getLoan();

	void updateReserve(ReserveVO reserve);

	void updateLoanCount(int bo_loan_count, int bo_num);

	ArrayList<BookVO> getBookLoanList(BookVO book);

	int totalCountBookNum();

	ArrayList<BookVO> getReBookList(Criteria cri);

	int getReTotalCount(Criteria cri);

}
