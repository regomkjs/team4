package kr.kh.team4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class PostController {
	
	@GetMapping("/post")
	public String postMain(Model model) {
		model.addAttribute("title", "커뮤니티");
		return "/post/main";
	}
}
