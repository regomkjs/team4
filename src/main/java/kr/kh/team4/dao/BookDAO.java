package kr.kh.team4.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.dto.UnderDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.LoanVO;
import kr.kh.team4.model.vo.book.OpinionVO;
import kr.kh.team4.model.vo.book.ReserveVO;
import kr.kh.team4.model.vo.book.ReviewVO;
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

	LoanVO selectLoan(@Param("bo_num")int num);

	boolean updateLoan(@Param("me_id")String me_id, @Param("bo_num")int bo_num);

	ArrayList<LoanVO> selectLoanList(@Param("bo_isbn")String bo_isbn);
	
	boolean deleteUpper(@Param("up_num")int caNum);

	boolean insertUnder(@Param("under") UnderDTO underDto);

	boolean deleteUnder(@Param("un_num")int num);

	boolean insertReserve(@Param("me_id")String me_id, @Param("bo_num")int bo_num);

	boolean deleteLoan(@Param("bo_num")int bo_num);

	ArrayList<ReserveVO> selectReserveList(@Param("bo_num")int bo_num);

	ArrayList<ReviewVO> selectReviewList(@Param("cri")ReviewCriteria cri);

	int selectTotalCountReview(@Param("cri")ReviewCriteria cri);

	boolean insertReview(@Param("review")ReviewVO review);

	ReviewVO selectReview(@Param("rv_num")int rv_num);

	boolean deleteReview(@Param("rv_num")int rv_num);

	boolean updateReview(@Param("review")ReviewVO review);

	ReviewVO selectAvgReview(@Param("bo_num")int bo_num);

	OpinionVO selectOpinion(@Param("rv_num")int rv_num, @Param("user")MemberVO user);

	void insertOpinion(@Param("rv_num")int rv_num, @Param("user")MemberVO user);

	void deleteOpinion(@Param("rv_num")int rv_num, @Param("user")MemberVO user);

	ArrayList<BookVO> selectLoanBookList(@Param("cri")Criteria cri, @Param("user")MemberVO user);

	int selectTotalCountLoanBook(@Param("cri")Criteria cri,@Param("user") MemberVO user);

}
