package kr.kh.team4.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.UnderVO;
import kr.kh.team4.model.vo.book.UpperVO;
import kr.kh.team4.pagination.BookCriteria;
import kr.kh.team4.pagination.PageMaker;
import kr.kh.team4.service.BookService;


@RestController
public class LibraryAjaxController {
	
	@Autowired
	BookService bookService;
	
	@ResponseBody
	@PostMapping("/management/insert")
	public Map<String, Object> insertBook(@RequestBody ArrayList<BookDTO> book){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(book.size());
		boolean res=bookService.insertBook(book);
		map.put("result", res);
		return map;
	}
	
	@PostMapping("/management/list")
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
	
	@PostMapping("/management/category")
	public Map<String, Object> categoryType(int num){
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<UnderVO> list=bookService.getUnder(num);
		map.put("list", list);
		return map;
	}
	
	@PostMapping("/management/update")
	public Map<String, Object> bookUpdate(int caNum,int tyNum,int boNum){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res=bookService.updateBook(boNum,caNum,tyNum);
		map.put("res", res);
		return map;
	}

	@PostMapping("/management/delete")
	public Map<String, Object> bookDelete(int num){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res=bookService.deleteBook(num);
		map.put("res", res);
		return map;
	}
}
