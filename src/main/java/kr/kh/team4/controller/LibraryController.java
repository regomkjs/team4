package kr.kh.team4.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.LoanVO;
import kr.kh.team4.model.vo.book.ReviewVO;
import kr.kh.team4.model.vo.book.UpperVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.BookCriteria;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.service.BookService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LibraryController {
	private static String API="431afaf3fc91157f82c7d1868604f275";
	
	@Autowired
	BookService bookService;
	
	@GetMapping("/library")
	public String home(Model model) {
		
		return "/library/book/home";
	}
	
	
	@GetMapping("/library/management/manager")
	public String libraryManagement(Model model) {	
		ArrayList<UpperVO> upperList=bookService.getUpperList();
		model.addAttribute("api",API);
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
		ReviewVO avgReview = bookService.getAvgReview(book.getBo_num());
		MemberVO user = (MemberVO)session.getAttribute("user");
		model.addAttribute("user", user);
		model.addAttribute("review", avgReview);
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
		model.addAttribute("api",API);
		return "/library/book/bookSaleList";
	}

	@GetMapping("/library/book/sale")
	public String Sale(Model model) {
		
		return "/library/book/bookSale";
	}
	
	@GetMapping("/library/bookSale/search")
	public String bookSaleSearch(Model model,String search,String type,int page){
		try {
			StringBuilder urlBuilder = new StringBuilder("http://www.aladin.co.kr/ttb/api/ItemSearch.aspx"); /* URL */
			urlBuilder.append("?" + URLEncoder.encode("ttbkey", "UTF-8") + "=ttbquddjcho1722001"); /* Service Key */
			urlBuilder.append("&" + URLEncoder.encode("Query", "UTF-8") + "=" + URLEncoder.encode(search, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("Output", "UTF-8") + "=" + URLEncoder.encode("js", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("Start", "UTF-8") + "=" + page);
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
	        // 3. 필요한 리스트 데이터 부분만 가져와 JSONArray로 저장.
	        JSONArray dataArr = (JSONArray) obj.get("item");
	        //JSONObject dataArr = (JSONObject) obj.get("item");
	        model.addAttribute("obj",obj);
	        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/library/book/bookSaleSearch";
	}
}
