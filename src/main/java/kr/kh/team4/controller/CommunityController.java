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
import kr.kh.team4.model.vo.member.ReportVO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.MemberCriteria;
import kr.kh.team4.pagination.PageMaker;
import kr.kh.team4.service.MemberService;
import kr.kh.team4.service.PostService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommunityController {

	@Autowired
	PostService postService;
	
	@Autowired
	MemberService memberService;
	
	
	@GetMapping("/community/main")
	public String communityMain (Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("url", "/login");
			return "message";
		}
		if(user.getMe_mr_num() > 1) {
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
		if(user.getMe_mr_num() > 1) {
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
	
	
	@ResponseBody
	@PostMapping("/category/update")
	public Map<String, Object> categoryUpdatePost(HttpSession session, 
				@RequestParam("ca_name")String ca_name, @RequestParam("ca_num")int ca_num){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		String errorMessage = "";
		if(user == null) {
			errorMessage = "세션이 만료되었습니다.";
			map.put("errorMessage", errorMessage);
			return map;
		}
		if(user.getMe_mr_num() > 1) {
			errorMessage = "운영자만 접근할 수 있습니다.";
			map.put("errorMessage", errorMessage);
			return map;
		}
		CategoryVO category = postService.getCategory(ca_num);
		if(category == null) {
			errorMessage = "수정될 게시판이 없습니다.";
			map.put("errorMessage", errorMessage);
			return map;
		}
		if(category.getCa_name().equals(ca_name)) {
			errorMessage = "기존과 같은 게시판 명입니다.";
			map.put("errorMessage", errorMessage);
			return map;
		}
		ArrayList<CategoryVO> categoryList = postService.getCategoryList();
		for(CategoryVO tmp : categoryList) {
			if(tmp.getCa_name().equals(ca_name)) {
				errorMessage = "이미 있는 게시판 명으로 수정할 수 없습니다.";
				map.put("errorMessage", errorMessage);
				return map;
			}
		}
		category.setCa_name(ca_name);
		boolean res = postService.updateCategory(category);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/category/delete")
	public Map<String, Object> categoryDeletePost(HttpSession session, @RequestParam("ca_num")int ca_num){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res;
		if(user == null) {
			res = false;
			map.put("result", res);
		}
		if(user.getMe_mr_num() > 1) {
			res = false;
			map.put("result", res);
		}
		res = postService.deleteCategory(ca_num);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/report/list")
	public Map<String, Object> reportListPost(@RequestBody Criteria cri){
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ReportVO> reportList = postService.getReportList(cri);
		int totalCount = postService.getTotalCountReport();
		PageMaker pm = new PageMaker(5,cri, totalCount);
		map.put("reportList", reportList);
		map.put("pm", pm);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/report/arr/reject")
	public Map<String, Object> reportArrRejectPost(@RequestBody int[] reportArr){
		Map<String, Object> map = new HashMap<String, Object>();
		int count = postService.rejectReportList(reportArr);
		map.put("count", count);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/report/reject")
	public Map<String, Object> reportRejectPost(@RequestParam("rp_num")int rp_num){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = postService.rejectReport(rp_num); 
		map.put("result", res);
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/report/post/delete")
	public Map<String, Object> reportPostDeletePost(@RequestParam("rp_num")int rp_num, @RequestParam("po_num")int po_num){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res1 = postService.deletePost(new PostVO(po_num));
		map.put("result1", res1);
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/report/comment/delete")
	public Map<String, Object> reportCommentDeletePost(@RequestParam("rp_num")int rp_num, @RequestParam("co_num")int co_num){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res1 = postService.deleteCommentAdmin(co_num);
		map.put("result1", res1);
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/member/list")
	public Map<String, Object> memberListPost(@RequestBody MemberCriteria me_cri){
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<MemberVO> list = memberService.getMemberList(me_cri);
		int totalCount = memberService.getTotalCountMember(me_cri);
		PageMaker pm = new PageMaker(5, me_cri, totalCount);
		map.put("pm", pm);
		map.put("list", list);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/report/block/reporter")
	public Map<String, Object> reportBlockReporterPost(@RequestParam("rp_num")int rp_num){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = postService.blockReporter(rp_num); 
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/report/block/writer")
	public Map<String, Object> reportBlockWriterPost(@RequestParam("rp_num")int rp_num){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = postService.blockWriter(rp_num); 
		map.put("result", res);
		return map;
	}
	
	
}	
