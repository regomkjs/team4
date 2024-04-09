package kr.kh.team4.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.vo.book.UnderVO;
import kr.kh.team4.model.vo.book.UpperVO;

public interface BookDAO {

	boolean insertBook(@Param("book")BookDTO book);

	ArrayList<UpperVO> getUpperList();

	ArrayList<UnderVO> getUnderList();

	void insertAuthors(@Param("bo_num") int num, @Param("authors")String authors);

	void insertTranslators(@Param("bo_num") int num, @Param("translators")String translators);

	int selectBookNum(@Param("isbn") String isbn);


}
