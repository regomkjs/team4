package kr.kh.team4.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team4.model.dto.LoginDTO;
import kr.kh.team4.model.vo.member.GradeVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.pagination.MyPostCriteria;
import kr.kh.team4.pagination.PageMaker;
import kr.kh.team4.service.MemberService;
import kr.kh.team4.service.PostService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class HomeAjaxController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PostService postService;
	
	@ResponseBody
	@GetMapping("/id/check/dup")
	public Map<String, Object> idCheckDup(@RequestParam("id")String id){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = memberService.idCheck(id);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@GetMapping("/nickName/check/dup")
	public Map<String, Object> nickNameCheckDup(@RequestParam("nickName")String nickName){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = memberService.nickNameCheck(nickName);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/find/pw")
	public Map<String, Object> findPwPost(@RequestParam("id") String id){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = memberService.findPw(id);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/grade/insert")
	public Map<String, Object> gradeInsertPost(Model model, @RequestBody GradeVO grade) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<GradeVO> gradeList = memberService.getGradeList();
		if(gradeList.size() < 6) {
			boolean res = memberService.insertGrade(grade);
			map.put("result", res);
			return map;
		}
		return map;
	}
	
	@ResponseBody
	@PostMapping("/grade/update")
	public Map<String, Object> gradeUpdate(@RequestBody GradeVO grade){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = memberService.updateGrade(grade);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/grade/delete")
	public Map<String, Object> gradeDelete(@RequestParam("gr_num") int  gr_num){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = memberService.deleteGrade(gr_num);
		map.put("result", res);
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/member/block")
	public Map<String, Object> memberBlockPost(@RequestParam("me_id")String me_id, @RequestParam("day")int day){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO member = memberService.getMember(me_id);
		int res = memberService.addBlockDay(member, day);
		map.put("result", res);
		return map;
	}

}
