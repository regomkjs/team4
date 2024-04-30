package kr.kh.team4.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.LoanVO;
import kr.kh.team4.model.vo.book.ReserveVO;
import kr.kh.team4.model.vo.book.ReviewVO;
import kr.kh.team4.model.vo.book.UpperVO;
import kr.kh.team4.model.vo.member.GradeVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.BookCriteria;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.MyBookCriteria;
import kr.kh.team4.pagination.PageMaker;
import kr.kh.team4.service.BookService;
import kr.kh.team4.service.MemberService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LibraryController {
	private static String kakaoAPI="431afaf3fc91157f82c7d1868604f275";
	private static String aladinAPI="ttbquddjcho1722001";
	private static String imp="imp20747315";
	
	@Autowired
	BookService bookService;
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/library")
	public String home(Model model) {
		
		return "/library/book/home";
	}
	
	
	@GetMapping("/library/management/manager")
	public String libraryManagement(Model model) {	
		ArrayList<UpperVO> upperList=bookService.getUpperList();
		model.addAttribute("api",kakaoAPI);
		model.addAttribute("upList", upperList);
		return "/library/management/manager";
	}
	
	@GetMapping("/library/book/list")
	public String libraryList(Model model,BookCriteria boCri) {	
		boCri.setPerPageNum(10);
		boCri.setBo_code(2);
		System.out.println(boCri);
		if(boCri.getSearch()!=null||boCri.getSearch().length()!=0) {			
			ArrayList<BookVO> bookList=bookService.getBookList(boCri);
			model.addAttribute("bookList",bookList);
		}
		ArrayList<UpperVO> upList=bookService.getUpperList();
		model.addAttribute("upList",upList);
		return "/library/book/list";
	}
	
	@GetMapping("/library/book/detail")
	public String libraryDetail(Model model,int num,HttpSession session) {	
		BookVO book=bookService.getBook(num);
		ArrayList<BookVO> code=bookService.getBookIsbn(book.getBo_isbn());
		ArrayList<LoanVO> loanList = bookService.getLoanList(book.getBo_isbn());
		ArrayList<ReserveVO> reserveList = bookService.getReserveList(book.getBo_num());
		ReviewVO avgReview = bookService.getAvgReview(book.getBo_num());
		ReviewVO review = bookService.getReview(num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		model.addAttribute("user", user);
		model.addAttribute("avgReview", avgReview);
		model.addAttribute("reserveList", reserveList);
		model.addAttribute("review", review);
		model.addAttribute("loanList", loanList);
		model.addAttribute("book",book);
		model.addAttribute("code",code);
		return "/library/book/detail";
	}
	
	@GetMapping("/library/management/bookCategory")
	public String managementBookCatgory(Model model) {
		ArrayList<UpperVO> upList=bookService.getUpperList();
		model.addAttribute("upList",upList);
		return "/library/management/bookCategory";
	}
	

	@GetMapping("/library/bookSale/list")
	public String bookSale(Model model) {
		model.addAttribute("api",aladinAPI);
		return "/library/book/bookSaleList";
	}

	@GetMapping("/library/book/sale")
	public String Sale(Model model,HttpSession session) {
		MemberVO user=(MemberVO)session.getAttribute("user");
		GradeVO grade=memberService.getGrade(user.getMe_gr_num());
		model.addAttribute("imp",imp);
		model.addAttribute("user",user);
		model.addAttribute("grade",grade);
		return "/library/book/bookSale";
	}
	
	@GetMapping("/library/bookSale/search")
	public String bookSaleSearch(Model model,Criteria cri){
		try {
			StringBuilder urlBuilder = new StringBuilder("http://www.aladin.co.kr/ttb/api/ItemSearch.aspx"); /* URL */
			urlBuilder.append("?" + URLEncoder.encode("ttbkey", "UTF-8") +"="+aladinAPI); /* Service Key */
			urlBuilder.append("&" + URLEncoder.encode("Query", "UTF-8") + "=" + URLEncoder.encode(cri.getSearch(), "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("QueryType", "UTF-8") + "=" + URLEncoder.encode(cri.getType(), "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("Output", "UTF-8") + "=" + URLEncoder.encode("js", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("Start", "UTF-8") + "=" + cri.getPage());
			urlBuilder.append("&" + URLEncoder.encode("Version", "UTF-8") + "=" + 20131101);
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");		
			conn.setRequestProperty("Content-type", "application/json");
			BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
	        conn.disconnect();
			// 1. 문자열 형태의 JSON을 파싱하기 위한 JSONParser 객체 생성.
	        JSONParser parser = new JSONParser();
	        // 2. 문자열을 JSON 형태로 JSONObject 객체에 저장. 	
	        JSONObject obj = (JSONObject)parser.parse(sb.toString());
	        int total= Integer.parseInt(obj.get("totalResults").toString());
	        PageMaker pm=new PageMaker(10, cri,total);
	        model.addAttribute("obj",obj);       
	        model.addAttribute("pm",pm);       
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/library/book/bookSaleSearch";
	}
	
	@GetMapping("/library/management/loan")
	public String loan(Model model, HttpSession session, MyBookCriteria cri) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<BookVO> list = bookService.getLoanBookList(cri, user);
		
		int totalCount = bookService.totalCountLoanBook(cri, user);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("loanList", list);
		model.addAttribute("pm", pm);
		return "/library/management/loan";
	}
	
	@GetMapping("/library/bookSale/detail")
	public String bookSaleDetail(Model model,String isbn){
		try {
			StringBuilder urlBuilder = new StringBuilder("http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx"); /* URL */
			urlBuilder.append("?" + URLEncoder.encode("ttbkey", "UTF-8") + "="+aladinAPI); /* Service Key */		
			urlBuilder.append("&" + URLEncoder.encode("ItemIdType", "UTF-8") + "=" + URLEncoder.encode("ISBN13", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("ItemId", "UTF-8") + "=" + isbn);
			urlBuilder.append("&" + URLEncoder.encode("Output", "UTF-8") + "=" + URLEncoder.encode("js", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("OptResult", "UTF-8") + "=" + URLEncoder.encode("ratingInfo", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("Version", "UTF-8") + "=" + 20131101);
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");		
			conn.setRequestProperty("Content-type", "application/json");
			BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
	        conn.disconnect();
	        JSONParser parser = new JSONParser();
	        JSONObject obj = (JSONObject)parser.parse(sb.toString());
	        model.addAttribute("book",obj);           
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/library/book/bookSaleDetail";
	}
	
	@GetMapping("/library/order/list")
	public String SaleList() {
		
		return "/library/book/order";
	}

	
	@GetMapping("/library/management/order")
	public String managementOrder() {
		
		return "/library/management/order";
	}
}
