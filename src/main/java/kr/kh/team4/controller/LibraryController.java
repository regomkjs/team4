package kr.kh.team4.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.LoanVO;
import kr.kh.team4.model.vo.book.ReserveVO;
import kr.kh.team4.model.vo.book.UpperVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.BookCriteria;
import kr.kh.team4.service.BookService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LibraryController {
	private static String API="431afaf3fc91157f82c7d1868604f275";
	
	@Autowired
	BookService bookService;
	
	@GetMapping("/library")
	public String home(Model model) {
		
		return "/library/book/home";
	}
	
	
	@GetMapping("/library/management/manager")
	public String libraryManagement(Model model) {	
		ArrayList<UpperVO> upperList=bookService.getUpperList();
		model.addAttribute("api",API);
		model.addAttribute("upList", upperList);
		return "/library/management/manager";
	}
	
	@GetMapping("/library/book/list")
	public String libraryList(Model model,BookCriteria boCri) {	
		boCri.setPerPageNum(10);
		boCri.setBo_code(2);
		System.out.println(boCri);
		if(boCri.getSearch()!=null||boCri.getSearch().length()!=0) {			
			ArrayList<BookVO> bookList=bookService.getBookList(boCri);
			model.addAttribute("bookList",bookList);
		}
		ArrayList<UpperVO> upList=bookService.getUpperList();
		model.addAttribute("upList",upList);
		return "/library/book/list";
	}
	
	@GetMapping("/library/book/detail")
	public String libraryDetail(Model model,int num,HttpSession session) {	
		BookVO book=bookService.getBook(num);
		ArrayList<BookVO> code=bookService.getBookIsbn(book.getBo_isbn());
		ArrayList<LoanVO> loanList = bookService.getLoanList(book.getBo_isbn());
		ArrayList<ReserveVO> reserveList = bookService.getReserveList(book.getBo_isbn());
		MemberVO user = (MemberVO)session.getAttribute("user");
		model.addAttribute("user", user);
		model.addAttribute("loanList", loanList);
		model.addAttribute("reserveList", reserveList);
		model.addAttribute("book",book);
		model.addAttribute("code",code);
		return "/library/book/detail";
	}
	
	@GetMapping("/library/management/bookCategory")
	public String managementBookCatgory(Model model) {
		ArrayList<UpperVO> upList=bookService.getUpperList();
		model.addAttribute("upList",upList);
		return "/library/management/bookCategory";
	}
	
}
