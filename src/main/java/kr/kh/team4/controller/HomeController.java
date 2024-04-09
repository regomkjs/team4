package kr.kh.team4.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team4.model.dto.LoginDTO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.service.MemberService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "/main/home";
	}
	
	@GetMapping("/signup")
	public String signup(Model model) {
		model.addAttribute("title", "회원가입");
		return "/member/signup";
	}
	
	@PostMapping("/signup")
	public String signupPost(Model model, MemberVO member) {
		if(memberService.insertMember(member)) {
			model.addAttribute("msg","회원가입 성공");
			model.addAttribute("url","/");
		}else {
			model.addAttribute("msg","회원가입 실패");
			model.addAttribute("url","/signup");
		}
		return "message";
	}
	
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
	
	@GetMapping("/login")
	public String login(Model model) {
		model.addAttribute("title", "로그인");
		return "/member/login";
	}
	
	@PostMapping("/login")
	public String loginPost(Model model, LoginDTO loginDto) {
		MemberVO user = memberService.login(loginDto);

		if(user != null) {
			model.addAttribute("user", user);
			model.addAttribute("msg", "로그인 성공");
			model.addAttribute("url", "/");
		}else {
			model.addAttribute("msg", "로그인 실패");
			model.addAttribute("url", "/login");
		}
		return "message";
	}
	
	@GetMapping("logout")
	public String logout(Model model, HttpSession session) {
		session.removeAttribute("user");
		model.addAttribute("msg", "로그아웃 했습니다.");
		model.addAttribute("url", "/");
		return "message";
	}
	
	@GetMapping("/find/id")
	public String findId(Model model) {
		model.addAttribute("title", "아이디 찾기");
		return "/member/findid";
	}
	
	@PostMapping("/find/id")
	public String findIdPost(Model model,String me_email, String me_phone) {
		MemberVO member = memberService.findId(me_email, me_phone);
		if(member != null) {
			model.addAttribute("msg", "회원의 아이디는 [" + member.getMe_id() + "] 입니다.");
			model.addAttribute("url", "/login");
		}else {
			model.addAttribute("msg", "이메일 또는 전화번호를 잘못 입력했습니다");
			model.addAttribute("url", "/find/id");
		}
		return "message";
	}
	
	@GetMapping("/find/pw")
	public String findPw(Model model) {
		model.addAttribute("title", "비밀번호 찾기");
		return "/member/findpw";
	}
	
	@ResponseBody
	@PostMapping("/find/pw")
	public Map<String, Object> findPwPost(@RequestParam("id") String id){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = memberService.findPw(id);
		map.put("result", res);
		return map;
	}
	
	@GetMapping("/mypage")
	public String mypage(Model model) {
		model.addAttribute("title", "내 정보");
		return "/member/mypage";
	}
	
	@PostMapping("/mypage")
	public String mypagePost(Model model, MemberVO member, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = memberService.updateMember(member, user);
		if(res) {
			model.addAttribute("msg", "회원 정보를 수정했습니다.");
			model.addAttribute("url", "/mypage");
		}else {
			model.addAttribute("msg", "회원 정보를 수정하지 못했습니다.");
			model.addAttribute("url", "/mypage");
		}
		//세션에 회원 정보 수정
		session.setAttribute("user", user);
		return "message";
	}
	
}
