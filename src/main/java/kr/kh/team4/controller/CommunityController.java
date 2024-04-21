package kr.kh.team4.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.service.PostService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommunityController {

	@Autowired
	PostService postService;
	
	@GetMapping("/community/main")
	public String communityMain (Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("url", "/login");
			return "message";
		}
		if(user.getMe_gr_num() == 0) {
			model.addAttribute("msg", "운영자만 접근할 수 있습니다.");
			model.addAttribute("url", "/post/main");
			return "message";
		}
		return "/community/main";
	}
	
	
	@ResponseBody
	@PostMapping("/category/list")
	public Map<String, Object> categoryListPost(){
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<CategoryVO> categoryList = postService.getCategoryList();
		map.put("categoryList", categoryList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/category/insert")
	public Map<String, Object> categoryInsertPost(@RequestParam("ca_name")String ca_name, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		String errorMessage = "";
		if(user == null) {
			errorMessage = "세션이 만료되었습니다.";
			map.put("errorMessage", errorMessage);
			return map;
		}
		if(user.getMe_gr_num() == 0) {
			errorMessage = "운영자만 접근할 수 있습니다.";
			map.put("errorMessage", errorMessage);
			return map;
		}
		ArrayList<CategoryVO> categoryList = postService.getCategoryList();
		for(CategoryVO category : categoryList) {
			if(category.getCa_name().equals(ca_name)) {
				errorMessage = "이미 있는 게시판입니다.";
				map.put("errorMessage", errorMessage);
				return map;
			}
		}
		boolean res = postService.insertCategory(ca_name);
		map.put("result", res);
		return map;
	}
	
	
}	
