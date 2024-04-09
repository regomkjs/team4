package kr.kh.team4.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import kr.kh.team4.model.dto.BookDTO;


@RestController
public class LibraryAjaxController {

	@ResponseBody
	@PostMapping("/management/insert")
	public Map<String, Object> test(@RequestBody ArrayList<BookDTO> book){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(book);
		return map;
	}
}
