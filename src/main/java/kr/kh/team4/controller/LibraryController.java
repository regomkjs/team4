package kr.kh.team4.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LibraryController {
	//431afaf3fc91157f82c7d1868604f275
	@GetMapping("/library")
	public String home(Model model) {
		
		return "/library/home";
	}
	
	
	@GetMapping("/library/management")
	public String libraryManagement(Model model) {
		String API="431afaf3fc91157f82c7d1868604f275";
		model.addAttribute("api",API);
		return "/library/management";
	}
	
}
