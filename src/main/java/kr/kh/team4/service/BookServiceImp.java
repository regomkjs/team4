package kr.kh.team4.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team4.dao.BookDAO;
import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.UnderVO;
import kr.kh.team4.model.vo.book.UpperVO;
import kr.kh.team4.pagination.Criteria;

@Service
public class BookServiceImp implements BookService {
	
	@Autowired
	BookDAO bookDao;
	
	private boolean checkString(String str) {
		return str != null && str.length() != 0; 
	}
	private String dateFomat(Date date) {
		SimpleDateFormat fm= new SimpleDateFormat("yy-MM-dd");
		return fm.format(date);
	}
	
	public String authorsToString(String[] authors) {
		// String[] -> String 으로 만들어 DB에 저장하거나 출력하는 용도.
		// ["홍길동","나길동"] -> 홍길동, 나길동 식으로 DB 저장 및 콘솔에 출력되기 위함.
	    String str_author = "";
        for (int i = 0; i < authors.length-1; i++) {
        	str_author += authors[i] + ", ";
	    }
	    if (authors.length > 0) str_author += authors[authors.length-1];
	    return str_author;
	}
	
	//책 등록
	@Override
	public boolean insertBook(ArrayList<BookDTO> book) {
		if(book==null||book.size()==0) {
			return false;
		}
		//책 등록후 역자,저자를 추가함
		for(BookDTO tmp:book) {
			if(bookDao.insertBook(tmp)) {
				int num=bookDao.selectBookNum(tmp.getIsbn());
				bookDao.insertAuthors(num,authorsToString(tmp.getAuthors()));
				bookDao.insertTranslators(num,authorsToString(tmp.getTranslators()));
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
		if(cri==null) {
			cri=new Criteria();
		}
		return bookDao.getBookList(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		if(cri==null) {
			cri=new Criteria();
		}
		return bookDao.getTotalCount(cri);
	}

	@Override
	public ArrayList<UnderVO> getUnder(int num) {
		return bookDao.getUnder(num);
	}

	@Override
	public boolean updateBook(int boNum, int caNum, int tyNum) {
		ArrayList<BookVO> books=bookDao.selectBookList();
		int index=books.indexOf(new BookVO(boNum));
		String name=books.get(index).getBo_title();
		String date=dateFomat(books.get(index).getBo_date());
		
		ArrayList<UnderVO> under=bookDao.getUnder(caNum);
		int unIndex=under.indexOf(new UnderVO(tyNum));
		int un_num=under.get(unIndex).getUn_num();
		
		String bo_code= caNum+""+(tyNum<10?"0"+tyNum:tyNum)+"-"+date;
		if(caNum==100) {
			bo_code="미정";
			return bookDao.updateBook(bo_code,boNum,un_num);
		}
		int i=1;
		String text=bo_code;
		for(BookVO tmp:books) {
			if(tmp.getBo_title().equals(name)&&tmp.getBo_code().equals(text)) {
				i++;
				text=bo_code+"-c"+i;
			}
		}
		if(i>1) {
			bo_code=text;
		}
		return bookDao.updateBook(bo_code,boNum,un_num);
	}
	@Override
	public boolean deleteBook(int num) {
		return bookDao.deleteBook(num);
	}

	
	
}
