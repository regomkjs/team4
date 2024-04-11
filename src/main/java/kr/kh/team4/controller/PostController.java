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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.CommentVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.pagination.CommentCriteria;
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
	
	@GetMapping("/post/insert")
	public String postInsert(Model model, int ca, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null || 
				user.getMe_id() == null || 
				user.getMe_id().length() == 0) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			model.addAttribute("url", "/login");
			return "message";
		}
		ArrayList<CategoryVO> list = postService.getCategoryList();
		model.addAttribute("categoryList", list);
		if(ca != 0) {
			model.addAttribute("ca_num", ca);
		}
		return "/post/insert";
	}
	
	
	@PostMapping("/post/insert")
	public String postInsertPost(Model model, HttpSession session, PostVO post) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null || 
				user.getMe_id() == null || 
				user.getMe_id().length() == 0) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("url", "/login");
			return "message";
		}
		post.setPo_me_id(user.getMe_id());
		boolean res = postService.insertPost(post);
		if(res) {
			model.addAttribute("msg", "게시글을 등록했습니다.");
			model.addAttribute("url", "/post/list?ca=" + post.getPo_ca_num());
		}
		else {
			model.addAttribute("msg", "게시글 등록에 실패했습니다.");
			model.addAttribute("url", "/post/insert?ca="+ post.getPo_ca_num());
		}
		return "message";
	}
	
	@GetMapping("/post/detail")
	public String postDetail(Model model, int num) {
		PostVO post = postService.getPost(num);
		if(post == null || 
				post.getPo_me_id() == null || post.getPo_me_id().length() == 0 ||
				post.getPo_title() == null || post.getPo_title().length() == 0 ||
				post.getPo_content() == null || post.getPo_content().length() == 0) {
			model.addAttribute("msg", "삭제되거나 없는 게시글입니다.");
			model.addAttribute("url", "/post/list");
			return "message";
		}
		model.addAttribute("post", post);
		return "/post/detail";
	}
	
	@GetMapping("/post/update")
	public String postUpdate(Model model, HttpSession session, int num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		PostVO post = postService.getPost(num);
		if(post == null || 
				post.getPo_me_id() == null || post.getPo_me_id().length() == 0 ||
				post.getPo_title() == null || post.getPo_title().length() == 0 ||
				post.getPo_content() == null || post.getPo_content().length() == 0) {
			model.addAttribute("msg", "삭제되거나 없는 게시글입니다.");
			model.addAttribute("url", "/post/list");
			return "message";
		}
		if(user == null || 
				!post.getPo_me_id().equals(user.getMe_id())) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			model.addAttribute("url", "/post/detail?num="+num);
			return "message";
		}
		ArrayList<CategoryVO> list = postService.getCategoryList();
		model.addAttribute("categoryList", list);
		model.addAttribute("post", post);
		return "/post/update";
	}
	
	@PostMapping("/post/update")
	public String postUpdatePost(Model model, HttpSession session, PostVO post) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null || 
				user.getMe_id() == null || 
				user.getMe_id().length() == 0) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("url", "/login");
			return "message";
		}
		if(user == null || 
				!post.getPo_me_id().equals(user.getMe_id())) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			model.addAttribute("url", "/post/detail?num=" + post.getPo_num());
			return "message";
		}
		boolean res = postService.updatePost(post);
		if(res) {
			model.addAttribute("msg", "게시글이 수정되었습니다.");
		}
		else {
			model.addAttribute("msg", "게시글 수정에 실패했습니다.");
		}
		model.addAttribute("url", "/post/detail?num=" + post.getPo_num());
		return "message";
	}
	
	@GetMapping("/post/delete")
	public String postDelete(Model model, HttpSession session, int num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		PostVO post = postService.getPost(num);
		if(post == null || 
				post.getPo_me_id() == null || post.getPo_me_id().length() == 0 ||
				post.getPo_title() == null || post.getPo_title().length() == 0 ||
				post.getPo_content() == null || post.getPo_content().length() == 0) {
			model.addAttribute("msg", "이미 삭제되거나 없는 게시글입니다.");
			model.addAttribute("url", "/post/list");
			return "message";
		}
		if(user == null || 
				!post.getPo_me_id().equals(user.getMe_id())
				//관리자인지 예외처리 추가요망
				) {
			model.addAttribute("msg", "삭제 권한이 없습니다.");
			model.addAttribute("url", "/post/detail?num="+num);
			return "message";
		}
		boolean res = postService.deletePost(post);
		if(res) {
			model.addAttribute("msg", "게시글이 삭제되었습니다.");
			model.addAttribute("url", "/post/list");
		}
		else {
			model.addAttribute("msg", "게시글 삭제에 실패했습니다.");
			model.addAttribute("url", "/post/detail?num=" + post.getPo_num());
		}
		return "message";
	}
	
	
	
	@ResponseBody
	@PostMapping("/post/heart")
	public Map<String, Object> postHeartPost(@RequestParam("po_num")int po_num, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		int res = postService.toggleHeart(user, po_num);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/post/countHeart")
	public Map<String, Object> postCountHeartPost(@RequestParam("po_num")int po_num, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = postService.searchHeart(user, po_num);
		int totalCount = postService.totalCountHeart(po_num);
		map.put("result", res);
		map.put("totalCountHeart", totalCount);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/comment/list")
	public Map<String, Object> commentListPost(@RequestBody CommentCriteria cri){
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<CommentVO> list = postService.getCommentList(cri);
		int totalCount = postService.getTotalCountComment(cri);
		PageMaker pm = new PageMaker(5,cri, totalCount);
		log.info(list);
		map.put("list", list);
		map.put("pm", pm);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/comment/insert")
	public Map<String, Object> commentListPost(@RequestParam("po_num")int po_num, 
				@RequestParam("content")String content, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		CommentVO comment = new CommentVO(0, content, user.getMe_id(), po_num);
		boolean res = postService.insertComment(comment);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/comment/update")
	public Map<String, Object> commentUpdatePost(@RequestParam("num")int num, 
				@RequestParam("content")String content, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = postService.updateComment(num, content, user);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/comment/delete")
	public Map<String, Object> commentDeletePost(@RequestParam("num")int num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = postService.deleteComment(num, user);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/reply/insert")
	public Map<String, Object> replyInsert(@RequestParam("ori")int ori, 
				@RequestParam("content") String content, 
				@RequestParam("po_num")int po_num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		CommentVO comment = new CommentVO(ori, content, user.getMe_id(), po_num);
		boolean res = postService.insertComment(comment);
		map.put("result", res);
		return map;
	}
	
}
