package kr.kh.team4.service;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team4.dao.BookDAO;
import kr.kh.team4.dao.MemberDAO;
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

@Service
public class BookServiceImp implements BookService {

	@Autowired
	BookDAO bookDao;

	@Autowired
	MemberDAO memberDao;
	private boolean checkString(String str) {
		return str == null && str.length() == 0;
	}

	private String dateFomat(Date date) {
		SimpleDateFormat fm = new SimpleDateFormat("yy-MM-dd");
		return fm.format(date);
	}

	public String authorsToString(String[] authors) {
		// String[] -> String 으로 만들어 DB에 저장하거나 출력하는 용도.
		// ["홍길동","나길동"] -> 홍길동, 나길동 식으로 DB 저장 및 콘솔에 출력되기 위함.
		String str_author = "";
		for (int i = 0; i < authors.length - 1; i++) {
			str_author += authors[i] + ", ";
		}
		if (authors.length > 0)
			str_author += authors[authors.length - 1];
		return str_author;
	}

	// 책 등록
	@Override
	public boolean insertBook(ArrayList<BookDTO> book) {
		if (book == null || book.size() == 0) {
			return false;
		}
		// 책 등록후 역자,저자를 추가함
		for (BookDTO tmp : book) {
			if (bookDao.insertBook(tmp)) {
				int num = bookDao.selectBookNum(tmp.getIsbn());
				bookDao.insertAuthors(num, authorsToString(tmp.getAuthors()));
				bookDao.insertTranslators(num, authorsToString(tmp.getTranslators()));
			}
		}
		return true;
	}

	@Override
	public ArrayList<UpperVO> getUpperList() {
		return bookDao.getUpperList();
	}

	@Override
	public ArrayList<UnderVO> getUnderList() {
		return bookDao.getUnderList();
	}

	@Override
	public ArrayList<BookVO> getBookList(Criteria cri) {
		if (cri == null) {
			cri = new Criteria();
		}
		return bookDao.getBookList(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		if (cri == null) {
			cri = new Criteria();
		}
		return bookDao.getTotalCount(cri);
	}

	@Override
	public ArrayList<UnderVO> getUnder(int num) {
		return bookDao.getUnder(num);
	}

	@Override
	public boolean updateBook(int boNum, int caNum, int tyNum) {
		ArrayList<BookVO> books = bookDao.selectBookList();
		int index = books.indexOf(new BookVO(boNum));
		String name = books.get(index).getBo_title();
		String date = dateFomat(books.get(index).getBo_date());

		ArrayList<UnderVO> under = bookDao.getUnder(caNum);
		int unIndex = under.indexOf(new UnderVO(tyNum));
		int un_num = under.get(unIndex).getUn_num();

		String bo_code = caNum + "" + (tyNum < 10 ? "0" + tyNum : tyNum) + "-" + date;
		if (caNum == 100) {
			bo_code = "미정";
			return bookDao.updateBook(bo_code, boNum, un_num);
		}
		int i = 1;
		String text = bo_code;
		for (BookVO tmp : books) {
			if (tmp.getBo_title().equals(name) && tmp.getBo_code().equals(text)) {
				i++;
				text = bo_code + "-c" + i;
			}
		}
		if (i > 1) {
			bo_code = text;
		}
		return bookDao.updateBook(bo_code, boNum, un_num);
	}

	@Override
	public boolean deleteBook(int num) {
		return bookDao.deleteBook(num);
	}

	@Override
	public BookVO getBook(int num) {
		return bookDao.getBook(num);
	}

	@Override
	public ArrayList<BookVO> getBookIsbn(String bo_isbn) {
		return bookDao.getBookIsbn(bo_isbn);
	}

	@Override
	public boolean insertUpper(int caNum, String caName) {
		if (checkString(caName)) {
			return false;
		}
		ArrayList<UpperVO> upList = bookDao.getUpperList();
		for (UpperVO tmp : upList) {
			if (tmp.getUp_num() == caNum || tmp.getUp_name().equals(caName)) {
				return false;
			}
		}
		return bookDao.insertUpper(caNum, caName);
	}

	@Override
	public boolean deleteUpper(int caNum) {
		return bookDao.deleteUpper(caNum);
	}

	@Override
	public boolean insertUnder(UnderDTO underDto) {
		if (underDto == null || checkString(underDto.getUnName())) {
			return false;
		}
		ArrayList<UnderVO> underList = bookDao.getUnder(underDto.getUn_upNum());
		for (UnderVO tmp : underList) {
			if (tmp.getUn_code() == underDto.getUnCode() || tmp.getUn_name().equals(underDto.getUnName())) {
				return false;
			}
		}
		return bookDao.insertUnder(underDto);
	}

	@Override
	public boolean deleteUnder(int num) {
		return bookDao.deleteUnder(num);
	}

	@Override
	public boolean loanBook(MemberVO user, BookVO book) {
		if(user == null || book == null) {
			return false;
		}
		LoanVO loan = bookDao.selectLoan(book.getBo_num());
		try {
			if(loan != null) {
				return false;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		boolean res = bookDao.insertLoan(user.getMe_id(), book.getBo_num());
		if(res) {
			memberDao.updateLoanCount(user);
		}else {
			return false;
		}
		return true; 
	}

	@Override
	public LoanVO getLoan(int num) {
		return bookDao.selectLoan(num);
	}

	@Override
	public boolean extendBook(MemberVO user, BookVO book) {
		if(user == null || book == null) {
			return false;
		}
		LoanVO loan = bookDao.selectLoan(book.getBo_num());
		if(loan == null) {
			return false;
		}
		//대출한 회원과 로그인한 회원이 다를경우
		if(!loan.getLo_me_id().equals(user.getMe_id())) {
			return false;
		}
		
		Date today = new Date();
		Date limit = loan.getLo_limit();
		long difference = Math.abs(limit.getTime() - today.getTime());
        long differenceDays = difference / (24 * 60 * 60 * 1000);
        //반납만기일까지 3일이 넘는 경우
        if(differenceDays > 3) {
        	return false;
        }
        
        ArrayList<ReserveVO> list = bookDao.selectReserveList(book.getBo_num());
        //예약 된 경우
        if(list != null) {
        	return false;
        }
        
		return bookDao.updateLoan(user.getMe_id(), book.getBo_num());
	}

	@Override
	public ArrayList<LoanVO> getLoanList(String bo_isbn) {
		return bookDao.selectLoanList(bo_isbn);
	}

	@Override
	public boolean reserveBook(MemberVO user, BookVO book) {
		if(user == null || book == null) {
			return false;
		}
		ArrayList<ReserveVO> list = bookDao.selectReserveList(book.getBo_num());
		
		//중복된경우
		for(ReserveVO reserve : list) {
			if(reserve.getRe_me_id().equals(user.getMe_id())) {
				bookDao.deleteReserve(user.getMe_id(), book.getBo_num());
				return false;
			}
		}
		LoanVO loan = bookDao.selectLoan(book.getBo_num());
		//대출이 안 된 경우
		if(loan == null) {
			return false;
		}
		// 대출한 사람과 로그인한 사람이 같은 경우
		if (loan.getLo_me_id().equals(user.getMe_id())) {
			return false;
		}
		return bookDao.insertReserve(user.getMe_id(), book.getBo_num());
	}

	@Override
	public boolean returnBook(MemberVO user, BookVO book) {
		if(user == null || book == null) {
			return false;
		}
		LoanVO loan = bookDao.selectLoan(book.getBo_num());
		if(loan == null) {
			return false;
		}
		
		if(user.getMe_ms_num() != 1) {
			return false;
		}
		return bookDao.deleteLoan(book.getBo_num());
	}
	@Override
	public ArrayList<ReviewVO> getReviewList(ReviewCriteria cri) {
		if(cri == null) {
			return null;
		}
		return bookDao.selectReviewList(cri);
	}
	@Override
	public int getTotalCountReview(ReviewCriteria cri) {
		if(cri == null) {
			return 0;
		}
		return bookDao.selectTotalCountReview(cri);
	}
	@Override
	public boolean insertReview(ReviewVO review, MemberVO user) {
		if(review == null) {
			return false;
		}
		if(user == null) {
			return false;
		}
		review.setRv_me_id(user.getMe_id());
		return bookDao.insertReview(review);
	}
	@Override
	public boolean deleteReview(ReviewVO review, MemberVO user) {
		if(review == null || user == null) {
			return false;
		}
		ReviewVO dbReview = bookDao.selectReview(review.getRv_num());
		if( dbReview == null ||
			!dbReview.getRv_me_id().equals(user.getMe_id()))
			return false;
		
		return bookDao.deleteReview(review.getRv_num());
	}
	@Override
	public boolean updateReview(ReviewVO review, MemberVO user) {
		if(review == null || review.getRv_content() == null) {
			return false;
		}
		if(user == null ) {
			return false;
		}
		
		ReviewVO dbReview = bookDao.selectReview(review.getRv_num());
		if( dbReview == null ||
			!dbReview.getRv_me_id().equals(user.getMe_id())) {
			return false;
		}
		return bookDao.updateReview(review);
	}

	@Override
	public ReviewVO getAvgReview(int bo_num) {
		return bookDao.selectAvgReview(bo_num);
	}

	@Override
	public int opinion(OpinionVO opinion, MemberVO user) {
		if(opinion == null) {
			return -2;
		}
		if(user == null) {
			return -2;
		}
		
		opinion.setOp_me_id(user.getMe_id());
		OpinionVO dbOpinion = bookDao.selectOpinion(opinion);
		
		if(dbOpinion == null) {
			bookDao.insertOpinion(opinion);
		}
		else {
			if(opinion.getOp_state() == dbOpinion.getOp_state()) {
				opinion.setOp_state(0);
			}
			bookDao.updateOpinion(opinion);
		}
		return opinion.getOp_state();
	}

	@Override
	public int getUserOpinion(int rv_num, MemberVO user) {
		if(user == null) {
			return -2;
		}
		OpinionVO opinion = bookDao.selectOpinion(new OpinionVO(rv_num, user.getMe_id()));
		return opinion == null ? -2 : opinion.getOp_state();
	}

	@Override
	public ReviewVO getReview(int rv_num) {
		return bookDao.selectReview(rv_num);
	}

	@Override
	public ArrayList<BookVO> getLoanBookList(Criteria cri, MemberVO user) {
		if(cri == null) {
			cri = new Criteria();
		}
		if(user.getMe_ms_num() != 1) {
			return null;
		}
		return bookDao.selectLoanBookList(cri, user);
	}

	@Override
	public int totalCountLoanBook(Criteria cri, MemberVO user) {
		if(cri == null) {
			cri = new Criteria();
		}
		if(user.getMe_ms_num() != 1) {
			return 0;
		}
		return bookDao.selectTotalCountLoanBook(cri, user);
	}

	@Override
	public ArrayList<ReserveVO> getReserveList(int bo_num) {
		return bookDao.selectReserveList(bo_num);
	}
}
