package kr.kh.team4.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.kh.team4.model.dto.ItemListDTO;
import kr.kh.team4.model.dto.VoteListDTO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.ItemVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.model.vo.post.VoteVO;
import kr.kh.team4.pagination.MyCommentCriteria;
import kr.kh.team4.pagination.MyPostCriteria;
import kr.kh.team4.pagination.PageMaker;
import kr.kh.team4.pagination.PostCriteria;
import kr.kh.team4.service.MemberService;
import kr.kh.team4.service.PostService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class PostController {
	
	//유저의 커뮤이용 정지기한 비교를 위한 오늘 날짜
	LocalDate now = LocalDate.now();
	DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	String formatedNow = now.format(format);
	
	
	@Autowired
	PostService postService;
	
	@Autowired
	MemberService memberService;
	
	
	@GetMapping("/post")
	public String postMain(Model model) {
		PostCriteria tmp = new PostCriteria(-2);
		PageMaker pm = new PageMaker(5, tmp, 5);
		ArrayList<CategoryVO> list = postService.getCategoryList();
		ArrayList<PostVO> noticeList = postService.getNoticeList();
		ArrayList<PostVO> hotList = postService.getHotList();
		ArrayList<PostVO> newPostList = postService.getNewPostList();
		ArrayList<PostVO> votePostList = postService.getVotePostList();
		model.addAttribute("pm", pm);
		model.addAttribute("categoryList", list);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("hotList", hotList);
		model.addAttribute("newPostList", newPostList);
		model.addAttribute("votePostList", votePostList);
		model.addAttribute("title", "커뮤니티");
		return "/community/post/main";
	}
	
	@GetMapping("/post/list")
	public String postList(Model model, PostCriteria cri) {
		ArrayList<PostVO> list = postService.getPostList(cri);
		
		int totalCount = postService.totalCountPost(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("postList", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "게시글 목록");
		
		return "/community/post/list";
	}
	
	@GetMapping("/post/popular")
	public String postPopular(Model model, PostCriteria cri) {
		if(cri.getPage() > 5) {
			cri.setPage(5);
		}
		ArrayList<PostVO> list = postService.getPopularPostList(cri);
		
		int totalCount = postService.totalCountPopularPost(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("postList", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "인기글 목록");
		
		return "/community/post/popular";
	}
	
	
	
	@GetMapping("/post/insert")
	public String postInsert(Model model, PostCriteria cri, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null || 
				user.getMe_id() == null || 
				user.getMe_id().length() == 0) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			model.addAttribute("url", "/login");
			return "message";
		}
		
		if(user.getMe_block() != null && user.getMe_block().compareTo(formatedNow) >= 0) {
			model.addAttribute("msg", "커뮤니티 이용이 정지됐습니다.                                                 정지기한 : "+ user.getMe_block());
			model.addAttribute("url", "/post/list");
			return "message";
		}
		int totalCount = postService.totalCountPost(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("pm", pm);
		ArrayList<CategoryVO> list = postService.getCategoryList();
		model.addAttribute("categoryList", list);
		if(cri.getCa() != 0) {
			model.addAttribute("ca_num", cri.getCa());
		}
		return "/community/post/insert";
	}
	
	
	@PostMapping("/post/insert")
	public String postInsertPost(Model model, HttpSession session, PostVO post, 
			VoteListDTO votes, ItemListDTO items) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null || 
				user.getMe_id() == null || 
				user.getMe_id().length() == 0) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("url", "/login");
			return "message";
		}
		user = memberService.getMember(user.getMe_id());
		if(user.getMe_ms_num() == 1) {
			session.removeAttribute("user");
			model.addAttribute("msg", "커뮤니티 이용이 정지됐습니다.                                                 정지기한 : "+ user.getMe_block());
			model.addAttribute("url", "/post/list");
			return "message";
		}
		if(user.getMe_block() != null && user.getMe_block().compareTo(formatedNow) >= 0) {
			session.setAttribute("user", user);
			model.addAttribute("msg", "커뮤니티 이용이 정지됐습니다.                                                 정지기한 : "+ user.getMe_block());
			model.addAttribute("url", "/post/list");
			return "message";
		}
		
		
		post.setPo_me_id(user.getMe_id());
		boolean res = postService.insertPost(post, votes, items);
		if(res) {
			MemberVO renewalUser = memberService.getMember(user.getMe_id());
			session.setAttribute("user", renewalUser);
			model.addAttribute("msg", "게시글을 등록했습니다.");
			model.addAttribute("url", "/post/list?ca=" + post.getPo_ca_num());
		}
		else {
			model.addAttribute("msg", "게시글 등록에 실패했습니다.");
			model.addAttribute("url", "/post/insert?ca="+ post.getPo_ca_num());
		}
		return "message";
	}
	
	@GetMapping("/post/detail")
	public String postDetail(Model model, int num, PostCriteria cri) {
		PostVO post = postService.getPost(num);
		if(post == null || 
				post.getPo_me_id() == null || post.getPo_me_id().length() == 0 ||
				post.getPo_title() == null || post.getPo_title().length() == 0 ||
				post.getPo_content() == null || post.getPo_content().length() == 0) {
			model.addAttribute("msg", "삭제되거나 없는 게시글입니다.");
			model.addAttribute("url", "/post/list");
			return "message";
		}
		ArrayList<VoteVO> voteList = postService.getVoteList(post.getPo_num());
		for(VoteVO vote : voteList) {
			int count = postService.countTotalVoteMember(vote.getVo_num());
			vote.setVo_totalMember(count);
		}
		if(voteList.size() != 0 && voteList != null) {
			ArrayList<ItemVO> itemList = postService.getItemList(voteList);
			if(itemList.size() != 0 && itemList !=null) {
				model.addAttribute("voteList", voteList);
				model.addAttribute("itemList", itemList);
			}
		}
		int totalCount = postService.totalCountPost(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "게시글 상세");
		model.addAttribute("post", post);
		return "/community/post/detail";
	}
	
	@GetMapping("/post/update")
	public String postUpdate(Model model, HttpSession session, int num, PostCriteria cri) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		PostVO post = postService.getPost(num);
		if(post == null || 
				post.getPo_me_id() == null || post.getPo_me_id().length() == 0 ||
				post.getPo_title() == null || post.getPo_title().length() == 0 ||
				post.getPo_content() == null || post.getPo_content().length() == 0) {
			model.addAttribute("msg", "삭제되거나 없는 게시글입니다.");
			model.addAttribute("url", "/post/list");
			return "message";
		}
		if(user == null || 
				!post.getPo_me_id().equals(user.getMe_id())) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			model.addAttribute("url", "/post/detail?num="+num);
			return "message";
		}
		user = memberService.getMember(user.getMe_id());
		if(user.getMe_ms_num() == 1) {
			session.removeAttribute("user");
			model.addAttribute("msg", "커뮤니티 이용이 정지됐습니다.                                                 정지기한 : "+ user.getMe_block());
			model.addAttribute("url", "/post/list");
			return "message";
		}
		if(user.getMe_block() != null && user.getMe_block().compareTo(formatedNow) >= 0) {
			session.setAttribute("user", user);
			model.addAttribute("msg", "커뮤니티 이용이 정지됐습니다.                                                 정지기한 : "+ user.getMe_block());
			model.addAttribute("url", "/post/detail?num="+num);
			return "message";
		}
		int totalCount = postService.totalCountPost(cri);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("pm", pm);
		ArrayList<CategoryVO> list = postService.getCategoryList();
		model.addAttribute("categoryList", list);
		model.addAttribute("title", "게시글 수정");
		model.addAttribute("post", post);
		return "/community/post/update";
	}
	
	@PostMapping("/post/update")
	public String postUpdatePost(Model model, HttpSession session, PostVO post, 
				VoteListDTO votes, ItemListDTO items) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null || 
				user.getMe_id() == null || 
				user.getMe_id().length() == 0) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("url", "/login");
			return "message";
		}
		if(user == null || 
				!post.getPo_me_id().equals(user.getMe_id())) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			model.addAttribute("url", "/post/detail?num=" + post.getPo_num());
			return "message";
		}
		user = memberService.getMember(user.getMe_id());
		if(user.getMe_ms_num() == 1) {
			session.removeAttribute("user");
			model.addAttribute("msg", "커뮤니티 이용이 정지됐습니다.                                                 정지기한 : "+ user.getMe_block());
			model.addAttribute("url", "/post/list");
			return "message";
		}
		if(user.getMe_block() != null && user.getMe_block().compareTo(formatedNow) >= 0) {
			session.setAttribute("user", user);
			model.addAttribute("msg", "커뮤니티 이용이 정지됐습니다.                                                 정지기한 : "+ user.getMe_block());
			model.addAttribute("url", "/post/detail?num=" + post.getPo_num());
			return "message";
		}
		boolean res = postService.updatePost(post, votes, items);
		if(res) {
			model.addAttribute("msg", "게시글이 수정되었습니다.");
		}
		else {
			model.addAttribute("msg", "게시글 수정에 실패했습니다.");
		}
		model.addAttribute("url", "/post/detail?num=" + post.getPo_num());
		return "message";
	}
	
	@GetMapping("/post/delete")
	public String postDelete(Model model, HttpSession session, int num) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		PostVO post = postService.getPost(num);
		if(post == null || 
				post.getPo_me_id() == null || post.getPo_me_id().length() == 0 ||
				post.getPo_title() == null || post.getPo_title().length() == 0 ||
				post.getPo_content() == null || post.getPo_content().length() == 0) {
			model.addAttribute("msg", "이미 삭제되거나 없는 게시글입니다.");
			model.addAttribute("url", "/post/list");
			return "message";
		}
		if(user == null) {
			model.addAttribute("msg", "삭제 권한이 없습니다.");
			model.addAttribute("url", "/post/detail?num="+num);
			return "message";
		}
		user = memberService.getMember(user.getMe_id());
		if(user.getMe_ms_num() == 1) {
			session.removeAttribute("user");
			model.addAttribute("msg", "커뮤니티 이용이 정지됐습니다.                                                 정지기한 : "+ user.getMe_block());
			model.addAttribute("url", "/post/list");
			return "message";
		}
		if(user.getMe_block() != null && user.getMe_block().compareTo(formatedNow) >= 0) {
			session.setAttribute("user", user);
			model.addAttribute("msg", "커뮤니티 이용이 정지됐습니다.                                                 정지기한 : "+ user.getMe_block());
			model.addAttribute("url", "/post/detail?num=" + post.getPo_num());
			return "message";
		}
		if(user.getMe_id().equals(post.getPo_me_id())) {
			boolean res = postService.deletePost(post);
			if(res) {
				model.addAttribute("msg", "게시글이 삭제되었습니다.");
				model.addAttribute("url", "/post/list");
			}
			else {
				model.addAttribute("msg", "게시글 삭제에 실패했습니다.");
				model.addAttribute("url", "/post/detail?num=" + post.getPo_num());
			}
			return "message";
		}
		
		if(user.getMe_mr_num() == 0) {
			boolean res = postService.deletePost(post);
			if(res) {
				model.addAttribute("msg", "게시글이 삭제되었습니다.");
				model.addAttribute("url", "/post/list");
			}
			else {
				model.addAttribute("msg", "게시글 삭제에 실패했습니다.");
				model.addAttribute("url", "/post/detail?num=" + post.getPo_num());
			}
			return "message";
		} 
		else if(user.getMe_mr_num() == 1) {
			MemberVO writer = memberService.getMember(post.getPo_me_id());
			if(writer.getMe_mr_num() <= user.getMe_mr_num()) {
				model.addAttribute("msg", "다른 운영진의 글은 지울 수 없습니다.");
				model.addAttribute("url", "/post/detail?num="+num);
				return "message";
			}
			else {
				boolean res = postService.deletePost(post);
				if(res) {
					model.addAttribute("msg", "게시글이 삭제되었습니다.");
					model.addAttribute("url", "/post/list");
				}
				else {
					model.addAttribute("msg", "게시글 삭제에 실패했습니다.");
					model.addAttribute("url", "/post/detail?num=" + post.getPo_num());
				}
				return "message";
			}
		}
		model.addAttribute("msg", "삭제 권한이 없습니다.");
		model.addAttribute("url", "/post/detail?num="+num);
		return "message";

	}
	
	
	@GetMapping("/mypage/post")
	public String myPost(Model model, MyPostCriteria cri, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<PostVO> list = postService.getMyPostList(cri, user);
		
		int totalCount = postService.totalCountMyPost(cri, user);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("postList", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "내가 쓴 게시글");
		
		return "/member/post";
	}
	

	@GetMapping("/mypage/comment")
	public String myComment(Model model, MyCommentCriteria cri, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		ArrayList<PostVO> list = postService.getMyCommentList(cri, user);
		int totalCount = postService.totalCountMyComment(cri, user);
		PageMaker pm = new PageMaker(5, cri, totalCount);
		model.addAttribute("commentList", list);
		model.addAttribute("pm", pm);
		model.addAttribute("title", "내가 쓴 댓글");
		return "/member/comment";
	}
	
	
}
