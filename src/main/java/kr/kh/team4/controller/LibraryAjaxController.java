package kr.kh.team4.controller;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.kh.team4.model.dto.BookDTO;
import kr.kh.team4.model.dto.SaleDTO;
import kr.kh.team4.model.dto.UnderDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.book.OpinionVO;
import kr.kh.team4.model.vo.book.ReviewVO;
import kr.kh.team4.model.vo.book.SaleStateVO;
import kr.kh.team4.model.vo.book.SaleVO;
import kr.kh.team4.model.vo.book.UnderVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.BookCriteria;
import kr.kh.team4.pagination.PageMaker;
import kr.kh.team4.pagination.ReviewCriteria;
import kr.kh.team4.pagination.SaleListCriteria;
import kr.kh.team4.service.BookService;
import kr.kh.team4.service.MemberService;

@RestController
public class LibraryAjaxController {

	@Autowired
	BookService bookService;

	@Autowired
	MemberService memberService;

	private void saleCancel(String imp_uid, String merchant_uid) throws Exception {
		HttpRequest request = HttpRequest.newBuilder().uri(URI.create("https://api.iamport.kr/payments/cancel"))
				.header("Content-Type", "application/json").header("Authorization", token())
				.method("POST", HttpRequest.BodyPublishers
						.ofString("{\"imp_uid\":\"" + imp_uid + "\",\"merchant_uid\":\"" + merchant_uid + "\"}"))
				.build();
		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		System.out.println(response.body());

	}

	private String token() throws Exception {
		HttpRequest request = HttpRequest.newBuilder().uri(URI.create("https://api.iamport.kr/users/getToken"))
				.header("Content-Type", "application/json")
				.method("POST", HttpRequest.BodyPublishers.ofString(
						"{\"imp_key\":\"4625415628107468\",\"imp_secret\":\"JzR8w8KQn6BsCSMUVRc4UEuR1bSfMaFTJwLJgMAw1IIpUWLkaPs1tlZqdCeObKQ4Ln7RrV69zCzlGeck\"}"))
				.build();
		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject) parser.parse(response.body());
		JSONObject obj2 = (JSONObject) obj.get("response");
		String token = (String) obj2.get("access_token");
		return token;
	}

	private JSONObject payments(String uid) throws Exception {
		HttpRequest request = HttpRequest.newBuilder().uri(URI.create("https://api.iamport.kr/payments/"+uid))
				.header("Content-Type", "application/json").header("Authorization", token())
				.method("GET", HttpRequest.BodyPublishers.ofString("{}")).build();
		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject) parser.parse(response.body());
		JSONObject obj2 = (JSONObject) obj.get("response");
		return obj2;
	}

	@ResponseBody
	@PostMapping("/management/manager/insert")
	public Map<String, Object> insertBook(@RequestBody ArrayList<BookDTO> book) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(book.size());
		boolean res = bookService.insertBook(book);
		map.put("result", res);
		return map;
	}

	@PostMapping("/management/manager/list")
	public Map<String, Object> managerBookList(@RequestBody BookCriteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		cri.setPerPageNum(10);
		System.out.println(cri);
		ArrayList<BookVO> bookList = bookService.getBookList(cri);
		int totalCount = bookService.getTotalCount(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		map.put("pm", pm);
		map.put("bookList", bookList);
		return map;
	}

	@PostMapping("/management/manager/category")
	public Map<String, Object> categoryType(int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<UnderVO> list = bookService.getUnder(num);
		map.put("list", list);
		return map;
	}

	@PostMapping("/management/manager/update")
	public Map<String, Object> bookUpdate(int caNum, int tyNum, int boNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = bookService.updateBook(boNum, caNum, tyNum);
		map.put("res", res);
		return map;
	}

	@PostMapping("/management/manager/delete")
	public Map<String, Object> bookDelete(int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = bookService.deleteBook(num);
		map.put("res", res);
		return map;
	}

	@PostMapping("/management/bookCategory/insert")
	public Map<String, Object> CategoryInsert(int caNum, String caName) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = bookService.insertUpper(caNum, caName);
		map.put("res", res);
		return map;
	}

	@ResponseBody
	@PostMapping("/loan/book")
	public Map<String, Object> loanBook(@RequestBody BookVO book, HttpSession session, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		String message = "";
		boolean res;
		if(user.getMe_loan_block() != null) {
			res = false;
			message = "계정이 정지되어 대출할 수 없습니다.";
			map.put("result", res);
			map.put("message", message);
			return map;
		}else {
			res = bookService.loanBook(user, book);
			if(!res) {
				message = "이미 대출된 책이거나 예약된 책입니다.";
				map.put("message", message);
			}
			map.put("result", res);
			return map;
		}
	}

	@ResponseBody
	@PostMapping("/extend/book")
	public Map<String, Object> extendBook(@RequestBody BookVO book, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		boolean res = bookService.extendBook(user, book);
		map.put("result", res);
		return map;
	}

	@PostMapping("/management/bookCategory/delete")
	public Map<String, Object> CategoryDelete(int caNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = bookService.deleteUpper(caNum);
		map.put("res", res);
		return map;
	}

	@PostMapping("/management/bookType/insert")
	public Map<String, Object> TypeInsert(@RequestBody UnderDTO underDto) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = bookService.insertUnder(underDto);
		map.put("res", res);
		return map;
	}

	@PostMapping("/management/bookType/delete")
	public Map<String, Object> TypeDelete(int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean res = bookService.deleteUnder(num);
		map.put("res", res);
		return map;
	}

	@ResponseBody
	@PostMapping("/reserve/book")
	public Map<String, Object> reserveBook(@RequestBody BookVO book, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		String message = "";
		boolean res;
		if(user.getMe_loan_block() != null) {
			res = false;
			message = "계정이 정지되어 예약할 수 없습니다.";
			map.put("result", res);
			map.put("message", message);
			return map;
		}else {
			res = bookService.reserveBook(user, book);
			if(!res) {
				message = "예약을 취소하거나 못했습니다.";
				map.put("message", message);
			}
			map.put("result", res);
			return map;
		}
	}

	@ResponseBody
	@PostMapping("/return/book")
	public Map<String, Object> returnBook(@RequestBody BookVO book, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		boolean res = bookService.returnBook(user, book);
		map.put("result", res);
		return map;
	}

	@ResponseBody
	@PostMapping("/review/list")
	public Map<String, Object> reviewListPost(@RequestBody ReviewCriteria cri) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ReviewVO> list = bookService.getReviewList(cri);
		int totalCount = bookService.getTotalCountReview(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		map.put("list", list);
		map.put("pm", pm);
		return map;
	}

	@PostMapping("/review/insert")
	public Map<String, Object> reviewInsert(@RequestBody ReviewVO review, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		boolean res = bookService.insertReview(review, user);
		map.put("result", res);
		return map;
	}

	@PostMapping("/review/delete")
	public Map<String, Object> reviewDelete(@RequestBody ReviewVO review, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		boolean res = bookService.deleteReview(review, user);
		map.put("result", res);
		return map;
	}

	@PostMapping("/review/update")
	public Map<String, Object> reviewUpdate(@RequestBody ReviewVO review, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		boolean res = bookService.updateReview(review, user);
		map.put("result", res);
		return map;
	}

	@PostMapping("/library/sale/insert")
	public Map<String, Object> saleInsert(SaleDTO saleDto,int amount, HttpSession session)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		JSONObject obj = payments(saleDto.getImp_uid());
		int money = Integer.parseInt(String.valueOf(obj.get("amount")));
		if (money == amount) {
			boolean res = bookService.insertSale(user, saleDto);
			map.put("res", res);
		} else {
			saleCancel(saleDto.getImp_uid(), saleDto.getMerchant_uid());
			map.put("res", false);
		}
		return map;
	}

	@PostMapping("/order/list") // Criteria cri,
	public Map<String, Object> orderList(HttpSession session,SaleListCriteria cri) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		System.out.println(cri);
		ArrayList<SaleVO> order = bookService.getSaleList(user.getMe_id(),cri);
		int totalCount=bookService.getUserSaleTotalCount(user.getMe_id(),cri);
		PageMaker pm=new PageMaker(10, cri, totalCount);
		map.put("order", order);
		map.put("pm", pm);
		return map;
	}
	
	@PostMapping("/order/detail")
	public Map<String, Object> orderDetail(String merchant_uid) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		SaleVO order = bookService.getSale(merchant_uid);
		if(order==null) {
			map.put("info",null);			
		}else {
			JSONObject data = payments(order.getSa_uid());
			System.out.println(data);
			map.put("info",data);
		}
		return map;
	}
	
	@PostMapping("/order/cancel") 
	public Map<String, Object> orderCancel(String merchant_uid) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(merchant_uid);
		SaleVO order = bookService.getSale(merchant_uid);
		ArrayList<SaleStateVO> ssVO=bookService.getSaleStateList();
		if(order==null) {
			map.put("res",false);			
		}else {
			for(SaleStateVO tmp:ssVO) {
				if(tmp.getSs_state().equals("취소")){
					order.setSa_ss_num(tmp.getSs_num());
				}
			}
			bookService.updateSale(order);
			saleCancel(order.getSa_uid(),order.getSa_merchant_uid());
			map.put("res",true);
		}
		return map;
	}

	@ResponseBody
	@PostMapping("/opinion/check")
	public Map<String, Object> opinionCheck(@RequestBody OpinionVO opinion, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		int res = bookService.opinion(opinion, user);
		map.put("result", res);
		return map;
	}

	@ResponseBody
	@PostMapping("/opinion")
	public Map<String, Object> opinion(@RequestParam("rv_num") int rv_num, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		int state = bookService.getUserOpinion(rv_num, user);
		ReviewVO review = bookService.getReview(rv_num);
		map.put("state", state);
		map.put("review", review);
		return map;
	}

	@ResponseBody
	@PostMapping("/book/check")
	public Map<String, Object> bookCheck(@RequestParam("bookNum") int bookNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = memberService.getMemberByLoan(bookNum);
		map.put("result", user);
		return map;
	}

}
