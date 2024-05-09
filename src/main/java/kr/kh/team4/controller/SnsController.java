package kr.kh.team4.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.service.MemberService;

@Controller
public class SnsController {

	@Autowired
	MemberService memberService;
	
	@ResponseBody
	@PostMapping("/sns/{sns}/check/id")
	public boolean snsCheckId(@PathVariable("sns")String sns, @RequestParam("id")String id) {
		
		return memberService.idCheck(sns, id);
	}
	@ResponseBody
	@PostMapping("/sns/{sns}/signup")
	public boolean snsSignup(@PathVariable("sns")String sns, @RequestParam("id")String id,
				@RequestParam("email")String email, @RequestParam("phone_number")String phone_number,
				@RequestParam("nick")String nick) {
		
		return memberService.signupSns(sns, id, email, phone_number, nick);
	}
	@ResponseBody
	@PostMapping("/sns/{sns}/login")
	public Map<String, Object> snsLogin(@PathVariable("sns")String sns, @RequestParam("id")String id, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = memberService.loginSns(sns, id); 
		boolean res;
		if(user == null) {
			res = false;
			String message = "회원 정보를 불러오는데 실패했습니다.";
			map.put("message", message);
		}
		else {
			if(user.getMe_ms_num() == 1) {
				res = false;
				String message = "[영구정지] 된 계정입니다.";
				map.put("message", message);
			}
			else {
				res = true;
				session.setAttribute("user", user);
			}
		}
		map.put("result", res);
		return map;
	}
}