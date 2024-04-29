package kr.kh.team4.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.service.MemberService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class PopupController {
	
	@Autowired
	MemberService memberService;
	
	
	@GetMapping("/popup/member/punish")
	public String popupMemberPunish (Model model, String nick, HttpSession session) {
		MemberVO member = memberService.getMemberByNick(nick);
		model.addAttribute("member", member);
		return "/popup/member/punish";
	}
	
	@GetMapping("/popup/member/forgive")
	public String popupMemberForgive (Model model, String nick, HttpSession session) {
		MemberVO member = memberService.getMemberByNick(nick);
		model.addAttribute("member", member);
		return "/popup/member/forgive";
	}
	
}
