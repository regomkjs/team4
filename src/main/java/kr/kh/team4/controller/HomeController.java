package kr.kh.team4.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
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
import kr.kh.team4.model.vo.book.LoanVO;
import kr.kh.team4.model.vo.book.ReserveVO;
import kr.kh.team4.model.vo.member.GradeVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.member.ReportVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.pagination.MyBookCriteria;
import kr.kh.team4.pagination.MyReportCriteria;
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
	
	private static String aladinAPI="ttbquddjcho1722001";
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session, BookVO book) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<PostVO> noticeList = postService.getNoticeList();
		ArrayList<PostVO> hotList = postService.getHotList();
		ArrayList<GradeVO> gradeList = memberService.getUserGradeList(user);
		ArrayList<GradeVO> grade = memberService.getGradeList();
		ArrayList<BookVO> bookList = bookService.getBookLoanList(book);
		model.addAttribute("book", bookList);
		model.addAttribute("grade", grade);
		model.addAttribute("gradeList", gradeList);
		model.addAttribute("hotList", hotList);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("api",aladinAPI);
		return "/main/home";
	}
	
	@GetMapping("/nav")
	public String nav(Model model) {
		
		return "/nav";
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
		if(loginDto.getId().indexOf('!') != -1) {
			model.addAttribute("msg", loginDto.getId().substring(0, loginDto.getId().indexOf('!')) +"를(을) 통해 가입된 회원입니다.\\n"+ loginDto.getId().substring(0, loginDto.getId().indexOf('!'))+"로그인을 이용해 주세요");
			model.addAttribute("url", "/login");
			return "message";
		}
		
		MemberVO user = memberService.login(loginDto);
		ArrayList<ReserveVO> reserveList = bookService.getReList(user);
		ArrayList<LoanVO> loanList = bookService.getLoan();
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
			if(user.getMe_report_count() > 4 && user.getMe_count() > 2) {
				memberService.updateMemberLoanBlock(user);
				memberService.updateMemberCount(user, 0);
				model.addAttribute("msg", "예약 후 3회 이상 대출 안 했으므로 대출/예약이 정지됩니다.\\n신고당한 횟수가 " + user.getMe_report_count()+ "회 입니다. 커뮤니티 이용에 주의하세요.");
				model.addAttribute("url", "");
				
			}else if(user.getMe_report_count() > 4 && user.getMe_count() == 2) {
				model.addAttribute("msg", "예약 후 2회 이상 대출 안 했으므로 1번 더 안 할 때 대출/예약이 정지됩니다.\\n신고당한 횟수가 " + user.getMe_report_count()+ "회 입니다. 커뮤니티 이용에 주의하세요.");
				model.addAttribute("url", "");
			}else if(user.getMe_count() > 2) {
				memberService.updateMemberLoanBlock(user);
				memberService.updateMemberCount(user, 0);
				model.addAttribute("msg", "예약 후 3회 이상 대출 안 했으므로 대출/예약이 정지됩니다.");
				model.addAttribute("url", "");
			}else if(user.getMe_count() == 2) {
				model.addAttribute("msg", "예약 후 2회 이상 대출 안 했으므로 1번 더 안 할 때 대출/예약이 정지됩니다.");
				model.addAttribute("url", "");
			}else if(user.getMe_report_count() > 4) {
				model.addAttribute("msg", "신고당한 횟수가 " + user.getMe_report_count()+ "회 입니다. 커뮤니티 이용에 주의하세요.");
				model.addAttribute("url", "");
			}else {
				model.addAttribute("msg", "로그인 성공");
				model.addAttribute("url", "");
			}
			user = memberService.getMember(user.getMe_id());
			user.setAutoLogin(loginDto.isAutoLogin());
			model.addAttribute("user", user);
			return "message";
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
				return "message";
			}
		}
		return "message";
	}
	
	@GetMapping("logout")
	public String logout(Model model, HttpSession session) {
		//DB에서 쿠키정보 삭제
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			session.removeAttribute("user");
			session.removeAttribute("chGuest");
			model.addAttribute("msg", "로그아웃 했습니다.");
			model.addAttribute("url", "/");
			return "message";
		}
		user.setMe_cookie(null);
		user.setMe_cookie_limit(null);
		memberService.updateMemberCookie(user);
		
		session.removeAttribute("user");
		session.removeAttribute("chGuest");
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
	public String mypage(Model model, HttpSession session) {
		model.addAttribute("title", "내 정보");
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<GradeVO> gradeList = memberService.getUserGradeList(user);
		model.addAttribute("gradeList", gradeList);
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
	
	@GetMapping("/mypage/report")
	public String myReport(Model model, HttpSession session, MyReportCriteria cri) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<ReportVO> list = memberService.getMyReportList(cri, user);
		int totalCount = memberService.totalCountMyReport(cri, user);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("reportList", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "내가 대출한 도서");
		return "/member/report";
	}
	
	@GetMapping("/mypage/reserve")
	public String myReserveBook(Model model, MyBookCriteria cri, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<BookVO> list = memberService.getMyReserveBookList(cri, user);
		int totalCount = memberService.totalCountMyReserveBook(cri, user);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("reserveList", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "내가 예약한 도서");
		return "/member/reserve";
	}
}
