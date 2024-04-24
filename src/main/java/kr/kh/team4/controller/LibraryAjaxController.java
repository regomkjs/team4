package kr.kh.team4.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.dto.UnderDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.OpinionVO;
import kr.kh.team4.model.vo.book.ReviewVO;
import kr.kh.team4.model.vo.book.UnderVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.BookCriteria;
import kr.kh.team4.pagination.PageMaker;
import kr.kh.team4.pagination.ReviewCriteria;
import kr.kh.team4.service.BookService;
import kr.kh.team4.service.MemberService;


@RestController
public class LibraryAjaxController {
	
	@Autowired
	BookService bookService;
	
	@Autowired
	MemberService memberService;
	
	@ResponseBody
	@PostMapping("/management/manager/insert")
	public Map<String, Object> insertBook(@RequestBody ArrayList<BookDTO> book){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(book.size());
		boolean res=bookService.insertBook(book);
		map.put("result", res);
		return map;
	}
	
	@PostMapping("/management/manager/list")
	public Map<String, Object> managerBookList(@RequestBody BookCriteria cri){
		Map<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		System.out.println(cri);
		ArrayList<BookVO> bookList = bookService.getBookList(cri);
		int totalCount=bookService.getTotalCount(cri);
		PageMaker pm=new PageMaker(5, cri, totalCount);
		map.put("pm", pm);
		map.put("bookList", bookList);
		return map;
	}
	
	@PostMapping("/management/manager/category")
	public Map<String, Object> categoryType(int num){
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<UnderVO> list=bookService.getUnder(num);
		map.put("list", list);
		return map;
	}
	
	@PostMapping("/management/manager/update")
	public Map<String, Object> bookUpdate(int caNum,int tyNum,int boNum){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res=bookService.updateBook(boNum,caNum,tyNum);
		map.put("res", res);
		return map;
	}

	@PostMapping("/management/manager/delete")
	public Map<String, Object> bookDelete(int num){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res=bookService.deleteBook(num);
		map.put("res", res);
		return map;
	}
	
	@PostMapping("/management/bookCategory/insert")
	public Map<String, Object> CategoryInsert(int caNum,String caName){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res=bookService.insertUpper(caNum,caName);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/loan/book")
	public Map<String, Object> loanBook(@RequestBody BookVO book, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = bookService.loanBook(user, book);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/extend/book")
	public Map<String, Object> extendBook(@RequestBody BookVO book, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = bookService.extendBook(user, book);
		map.put("result", res);
		return map;
	}
	
	@PostMapping("/management/bookCategory/delete")
	public Map<String, Object> CategoryDelete(int caNum){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res=bookService.deleteUpper(caNum);
		map.put("res", res);
		return map;
	}
	
	@PostMapping("/management/bookType/insert")
	public Map<String, Object> TypeInsert(@RequestBody UnderDTO underDto){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res=bookService.insertUnder(underDto);
		map.put("res", res);
		return map;
	}
	
	@PostMapping("/management/bookType/delete")
	public Map<String, Object> TypeDelete(int num){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res=bookService.deleteUnder(num);
		map.put("res", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/reserve/book")
	public Map<String, Object> reserveBook(@RequestBody BookVO book, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = bookService.reserveBook(user, book);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/return/book")
	public Map<String, Object> returnBook(@RequestBody BookVO book, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = bookService.returnBook(user, book);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/review/list")
	public Map<String, Object> reviewListPost(@RequestBody ReviewCriteria cri){
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ReviewVO> list = bookService.getReviewList(cri);
		int totalCount = bookService.getTotalCountReview(cri);
		PageMaker pm = new PageMaker(5,cri, totalCount);
		map.put("list", list);
		map.put("pm", pm);
		return map;
	}
	
	@PostMapping("/review/insert")
	public Map<String, Object> reviewInsert(@RequestBody ReviewVO review, 
			HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = bookService.insertReview(review, user);
		map.put("result", res);
		return map;
	}
	
	@PostMapping("/review/delete")
	public Map<String, Object> reviewDelete(@RequestBody ReviewVO review, 
			HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = bookService.deleteReview(review,user);
		map.put("result", res);
		return map;
	}
	
	@PostMapping("/review/update")
	public Map<String, Object> reviewUpdate(@RequestBody ReviewVO review, 
			HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = bookService.updateReview(review,user);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/opinion/check")
	public Map<String, Object> opinionCheck(@RequestBody OpinionVO opinion, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		int res = bookService.opinion(opinion, user);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/opinion")
	public Map<String, Object> opinion(@RequestParam("rv_num") int rv_num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		int state = bookService.getUserOpinion(rv_num, user);
		ReviewVO review = bookService.getReview(rv_num);
		map.put("state", state);
		map.put("review", review);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/book/check")
	public Map<String, Object> bookCheck(@RequestParam("bookNum") int bookNum){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = memberService.getMemberByLoan(bookNum);
		map.put("result", user);
		return map;
	}
}
