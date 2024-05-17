package kr.kh.team4.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team4.model.vo.book.LoanVO;
import kr.kh.team4.model.vo.book.ReserveVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.service.BookService;
import kr.kh.team4.service.MemberService;

@Controller
public class SnsController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	BookService bookService;
	
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
				
				ArrayList<ReserveVO> reserveList = bookService.getReList(user);
				ArrayList<LoanVO> loanList = bookService.getLoan();
				
				LocalDate now = LocalDate.now();
				DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				String formatedNow = now.format(format);
				if(user.getMe_block() != null && user.getMe_block().compareTo(formatedNow) < 0) {
					memberService.resetBlockToNull(user.getMe_id());
				}
				
				Date date = new Date();
				Date blockDate = user.getMe_loan_block();
				if(user.getMe_loan_block() != null && blockDate.before(date)) {
					memberService.updateResetLoanBlock(user);
				}
				
				
				for (LoanVO loan : loanList) {
				    for (ReserveVO reserve : reserveList) {
				        if (reserve.getRe_bo_num() == loan.getLo_bo_num()) {
				            Date re_date = reserve.getRe_date();
				            boolean isExpired = date.after(re_date);

				            if (loan.getLo_state() == 1 && isExpired) {
				                bookService.updateReserve(reserve);
				            } else if (loan.getLo_state() == 0 && isExpired) {
				                int count = user.getMe_count() + 1;
				                memberService.updateMemberCount(user, count);
				                bookService.deleteReserve(reserve, user);
				            }
				        }
				    }
				}
				String message;
				if(user.getMe_report_count() > 4 && user.getMe_count() > 2) {
					memberService.updateMemberLoanBlock(user);
					memberService.updateMemberCount(user, 0);
					message = "예약 후 3회 이상 대출 안 했으므로 대출/예약이 정지됩니다.\n신고당한 횟수가 " + user.getMe_report_count()+ "회 입니다. 커뮤니티 이용에 주의하세요.";
				}else if(user.getMe_report_count() > 4 && user.getMe_count() == 2) {
					message = "예약 후 2회 이상 대출 안 했으므로 1번 더 안 할 때 대출/예약이 정지됩니다.\n신고당한 횟수가 " + user.getMe_report_count()+ "회 입니다. 커뮤니티 이용에 주의하세요.";
				}else if(user.getMe_count() > 2) {
					memberService.updateMemberLoanBlock(user);
					memberService.updateMemberCount(user, 0);
					message = "예약 후 3회 이상 대출 안 했으므로 대출/예약이 정지됩니다.";
				}else if(user.getMe_count() == 2) {
					message = "예약 후 2회 이상 대출 안 했으므로 1번 더 안 할 때 대출/예약이 정지됩니다.";
				}else if(user.getMe_report_count() > 4) {
					message = "신고당한 횟수가 " + user.getMe_report_count()+ "회 입니다. 커뮤니티 이용에 주의하세요.";
				}else {
					message = "로그인 되었습니다.";
				}
				user = memberService.getMember(user.getMe_id());
				map.put("message", message);
				session.setAttribute("user", user);
			}
		}
		map.put("result", res);
		return map;
	}
}