package kr.kh.team4.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.service.BookService;
import lombok.extern.log4j.Log4j2;


@RestController
public class LibraryAjaxController {
	
	@Autowired
	BookService bookService;
	
	@ResponseBody
	@PostMapping("/management/insert")
	public Map<String, Object> test(@RequestBody ArrayList<BookDTO> book){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(book.size());
		boolean res=bookService.insertBook(book);
		map.put("result", res);
		return map;
	}
	
}
