package kr.kh.team4.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.pagination.PageMaker;
import kr.kh.team4.pagination.PostCriteria;
import kr.kh.team4.service.PostService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class PostController {
	
	
	@Autowired
	PostService postService;
	
	
	@GetMapping("/post")
	public String postMain(Model model) {
		ArrayList<CategoryVO> list = postService.getCategoryList();
		model.addAttribute("categoryList", list);
		model.addAttribute("title", "커뮤니티");
		return "/post/main";
	}
	
	@GetMapping("/post/list")
	public String postList(Model model, PostCriteria cri) {
		ArrayList<PostVO> list = postService.getPostList(cri);
		
		int totalCount = postService.totalCountPost(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("postList", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "게시글 목록");
		
		return "/post/list";
	}
}
