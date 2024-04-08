package kr.kh.team4.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.team4.service.PostService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class PostController {
	
	
	@Autowired
	PostService postService;
	
	
	@GetMapping("/post")
	public String postMain(Model model) {
		model.addAttribute("title", "커뮤니티");
		return "/post/main";
	}
	
	
}
