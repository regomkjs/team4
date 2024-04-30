package kr.kh.team4.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.kh.team4.model.dto.LoginDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.member.GradeVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.MyBookCriteria;
import kr.kh.team4.pagination.PageMaker;
import kr.kh.team4.service.BookService;
import kr.kh.team4.service.MemberService;
import kr.kh.team4.service.PostService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BookService bookService;
	
	@Autowired
	PostService postService;
	
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
	public String signupPost(Model model, MemberVO member,HttpSession session) {
		if(memberService.insertMember(member)) {
			model.addAttribute("msg","회원가입 성공");
			session.removeAttribute("authCode");
			model.addAttribute("url","/");
		}else {
			model.addAttribute("msg","회원가입 실패");
			model.addAttribute("url","/signup");
		}
		return "message";
	}
	
	@GetMapping("/login")
	public String login(Model model, HttpServletRequest request) {
		//로그인 페이지로 넘어오기 이전 경로를 가져옴
		String url = request.getHeader("Referer");
		//이전 url에 login이 들어가 있는 경우를 제외
		if(url != null && !url.contains("login")) {
			request.getSession().setAttribute("prevUrl", url);
		}
		model.addAttribute("title", "로그인");
		return "/member/login";
	}
	
	@PostMapping("/login")
	public String loginPost(Model model, LoginDTO loginDto) {
		MemberVO user = memberService.login(loginDto);
		ArrayList<GradeVO> gradeList = memberService.getGradeList();
		if(user != null) {
			if(user.getMe_ms_num() == 3) {
				model.addAttribute("msg", "현재 계정이 [정지] 상태라서 로그인이 불가능합니다.");
				model.addAttribute("url", "/login");
				return "message";
			}
			if(user.getMe_ms_num() == 1) {
				model.addAttribute("msg", "[영구정지] 된 계정입니다.");
				model.addAttribute("url", "/login");
				return "message";
			}
			//실패횟수 초기화
			memberService.failCountUp(user, 0);
			//오늘 날짜와 유저의 커뮤이용 정지기한 비교 
			LocalDate now = LocalDate.now();
			DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String formatedNow = now.format(format);
			if(user.getMe_block() != null && user.getMe_block().compareTo(formatedNow) < 0) {
				memberService.resetBlockToNull(user.getMe_id());
			}
			for(GradeVO grade : gradeList) {
				if(user.getMe_loan_count() >= grade.getGr_loan_condition() && user.getMe_post_count() >= grade.getGr_post_condition()) {
					memberService.updateMemberGrade(user.getMe_id(), grade);
				}
			}
			user.setAutoLogin(loginDto.isAutoLogin());
			model.addAttribute("user", user);
			model.addAttribute("msg", "로그인 성공");
			model.addAttribute("url", "/");
		}else {
			MemberVO failUser = memberService.getMember(loginDto.getId());
			int failCount;
			if(failUser != null) {
				failCount = failUser.getMe_fail_count() + 1;
				memberService.failCountUp(failUser, failCount);
				model.addAttribute("msg", "로그인에 실패했습니다. 현재 실패횟수는 " + failCount + "번 입니다. 5회 초과시 계정이 정지됩니다.");
				model.addAttribute("url", "/login");
			}else {
				model.addAttribute("msg", "로그인 실패");
				model.addAttribute("url", "/login");
				return "message";
			}
			if(failUser.getMe_fail_count() >= 5) {
				int num = 3;
				memberService.updateMemberState(failUser, num);
				model.addAttribute("msg", "로그인 5회 초과 실패하여 계정이 정지됩니다. 비밀번호 찾기를 통해 풀고 다시 시도하세요.");
				model.addAttribute("url", "/login");
			}
		}
		return "message";
	}
	
	@GetMapping("logout")
	public String logout(Model model, HttpSession session) {
		//DB에서 쿠키정보 삭제
		MemberVO user = (MemberVO)session.getAttribute("user");
		user.setMe_cookie(null);
		user.setMe_cookie_limit(null);
		memberService.updateMemberCookie(user);
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
			session.removeAttribute("authCode");
			model.addAttribute("url", "/mypage");
		}else {
			model.addAttribute("msg", "회원 정보를 수정하지 못했습니다.");
			model.addAttribute("url", "/mypage");
		}
		//세션에 회원 정보 수정
		session.setAttribute("user", user);
		return "message";
	}
	
	@GetMapping("/grade/list")
	public String grade(Model model, GradeVO grade) {
		ArrayList<GradeVO> gradeList = memberService.getGradeList();
		model.addAttribute("title", "등급 관리");
		model.addAttribute("gradeList", gradeList);
		return "/grade/list";
	}
	
	@GetMapping("/mypage/loan")
	public String myLoanBook(Model model, MyBookCriteria cri, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<BookVO> list = memberService.getMyLoanBookList(cri, user);
		
		int totalCount = memberService.totalCountMyLoanBook(cri, user);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("loanList", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "내가 대출한 도서");
		return "/member/loan";
	}
}
