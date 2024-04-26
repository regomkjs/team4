package kr.kh.team4.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.dto.SaleDTO;
import kr.kh.team4.model.dto.UnderDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.LoanVO;
import kr.kh.team4.model.vo.book.OpinionVO;
import kr.kh.team4.model.vo.book.ReserveVO;
import kr.kh.team4.model.vo.book.ReviewVO;
import kr.kh.team4.model.vo.book.SaleVO;
import kr.kh.team4.model.vo.book.UnderVO;
import kr.kh.team4.model.vo.book.UpperVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.ReviewCriteria;

public interface BookDAO {

	boolean insertBook(@Param("book")BookDTO book);

	ArrayList<UpperVO> getUpperList();

	ArrayList<UnderVO> getUnderList();

	void insertAuthors(@Param("bo_num") int num, @Param("authors")String authors);

	void insertTranslators(@Param("bo_num") int num, @Param("translators")String translators);

	int selectBookNum(@Param("isbn") String isbn);

	ArrayList<BookVO> getBookList(@Param("cri") Criteria cri);

	int getTotalCount(@Param("cri") Criteria cri);

	ArrayList<UnderVO> getUnder(@Param("num") int num);

	ArrayList<BookVO> selectBookList();

	boolean updateBook(@Param("bo_code")String bo_code,@Param("bo_num") int boNum,@Param("un_num")int un_num);

	boolean deleteBook(@Param("bo_num")int num);

	BookVO getBook(@Param("bo_num")int num);

	ArrayList<BookVO> getBookIsbn(@Param("bo_isbn")String bo_isbn);

	boolean insertUpper(@Param("up_num")int caNum,@Param("up_name") String caName);

	boolean insertLoan(@Param("me_id")String me_id, @Param("bo_num")int bo_num);

	LoanVO selectLoan(@Param("bo_num")int num, @Param("me_id")String me_id);

	boolean updateLoan(@Param("me_id")String me_id, @Param("bo_num")int bo_num);

	ArrayList<LoanVO> selectLoanList(@Param("bo_isbn")String bo_isbn);
	
	boolean deleteUpper(@Param("up_num")int caNum);

	boolean insertUnder(@Param("under") UnderDTO underDto);

	boolean deleteUnder(@Param("un_num")int num);

	boolean insertReserve(@Param("me_id")String me_id, @Param("bo_num")int bo_num, @Param("member_id")String member_id);

	boolean updateLoanBook(@Param("bo_num")int bo_num);

	ArrayList<ReserveVO> selectReserveList(@Param("bo_num")int bo_num);

	ArrayList<ReviewVO> selectReviewList(@Param("cri")ReviewCriteria cri);

	int selectTotalCountReview(@Param("cri")ReviewCriteria cri);

	boolean insertReview(@Param("review")ReviewVO review);

	ReviewVO selectReview(@Param("rv_num")int rv_num);

	boolean deleteReview(@Param("rv_num")int rv_num);

	boolean updateReview(@Param("review")ReviewVO review);

	boolean insertSale(@Param("user")MemberVO user, @Param("sa")SaleDTO saleDto);

	ReviewVO selectAvgReview(@Param("bo_num")int bo_num);

	OpinionVO selectOpinion(@Param("op")OpinionVO opinion);

	void insertOpinion(@Param("op")OpinionVO opinion);

	void updateOpinion(@Param("op")OpinionVO opinion);

	ArrayList<BookVO> selectLoanBookList(@Param("cri")Criteria cri, @Param("user")MemberVO user);

	int selectTotalCountLoanBook(@Param("cri")Criteria cri,@Param("user") MemberVO user);

	OpinionVO selectOp(@Param("cri")Criteria cri, @Param("user")MemberVO user);

	void deleteReserve(@Param("me_id")String me_id, @Param("bo_num")int bo_num);

	void updateInsertLoan(@Param("bo_num")int bo_num, @Param("me_id")String me_id);

	ReserveVO selectReserve(@Param("bo_num")int bo_num);

	void updateReserve(@Param("bo_num")String lo_bo_num, @Param("me_id")String lo_me_id);

	LoanVO selectCurrentLoan(@Param("bo_num")int bo_num);

	ArrayList<SaleVO> getSaleList(@Param("me_id")String me_id);

	SaleVO getSale(@Param("sa_merchant_uid")String sa_merchant_uid);

}
