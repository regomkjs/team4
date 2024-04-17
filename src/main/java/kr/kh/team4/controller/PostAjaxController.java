package kr.kh.team4.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.post.ChooseVO;
import kr.kh.team4.model.vo.post.CommentVO;
import kr.kh.team4.model.vo.post.VoteVO;
import kr.kh.team4.pagination.CommentCriteria;
import kr.kh.team4.pagination.PageMaker;
import kr.kh.team4.service.PostService;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class PostAjaxController {
	
	
	@Autowired
	PostService postService;
	
	
	@ResponseBody
	@PostMapping("/post/heart")
	public Map<String, Object> postHeartPost(@RequestParam("po_num")int po_num, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		int res = postService.toggleHeart(user, po_num);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/post/countHeart")
	public Map<String, Object> postCountHeartPost(@RequestParam("po_num")int po_num, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = postService.searchHeart(user, po_num);
		int totalCount = postService.totalCountHeart(po_num);
		map.put("result", res);
		map.put("totalCountHeart", totalCount);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/comment/list")
	public Map<String, Object> commentListPost(@RequestBody CommentCriteria cri){
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<CommentVO> list = postService.getCommentList(cri);
		int totalCount = postService.getTotalCountComment(cri);
		PageMaker pm = new PageMaker(5,cri, totalCount);
		log.info(list);
		map.put("list", list);
		map.put("pm", pm);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/comment/insert")
	public Map<String, Object> commentListPost(@RequestParam("po_num")int po_num, 
				@RequestParam("content")String content, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		CommentVO comment = new CommentVO(0, content, user.getMe_id(), po_num);
		boolean res = postService.insertComment(comment);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/comment/update")
	public Map<String, Object> commentUpdatePost(@RequestParam("num")int num, 
				@RequestParam("content")String content, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = postService.updateComment(num, content, user);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/comment/delete")
	public Map<String, Object> commentDeletePost(@RequestParam("num")int num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		boolean res = postService.deleteComment(num, user);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/reply/insert")
	public Map<String, Object> replyInsertPost(@RequestParam("ori")int ori, 
				@RequestParam("content") String content, 
				@RequestParam("po_num")int po_num, HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		CommentVO comment = new CommentVO(ori, content, user.getMe_id(), po_num);
		boolean res = postService.insertComment(comment);
		map.put("result", res);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/choose/post")
	public Map<String, Object> choosePostPost(@RequestParam("po_num")int po_num,  HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<ChooseVO> list = postService.getChooseList(po_num, user);
		map.put("chooseList", list);
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/select/item")
	public Map<String, Object> selectItemPost(HttpSession session, 
				@RequestParam("it_num")int it_num, @RequestParam("vo_dup")boolean vo_dup){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		int res; //오류: 0, 생성:1, 삭제:2, 수정(삭제후 생성):3
		if(user == null || user.getMe_id() == null || user.getMe_id().length() == 0) {
			res = 0;
			map.put("result", res);
			return map;
		}
		//중복가능
		if(vo_dup) {
			//이 항목을 선택한 기록이 있는지
			boolean isSelectedItem = postService.isSelectedItem(it_num, user.getMe_id());
			if(isSelectedItem) {
				//있다면 취소
				if(postService.deleteChoose(it_num, user.getMe_id())){
					res = 2;
				} else {res = 0;}
			} 
			else {
				//없다면 생성
				if(postService.insertChoose(it_num, user.getMe_id())) {
					res = 1;
				} else {res = 0;}
			}
		} 
		//중복불가
		else {
			boolean anotherSelectedItem = postService.anotherSelectedItem(it_num, user.getMe_id());
			//항목을 선택한 기록이 있는지
			if(anotherSelectedItem) {
				boolean isSelectedItem = postService.isSelectedItem(it_num, user.getMe_id());
				if(isSelectedItem) {
					//기존과 같은 항목 == 취소
					if(postService.deleteChoose(it_num, user.getMe_id())) {
						res = 2;
					} else {res = 0;}
				}
				else {
					//다른 항목 == 기존 항목 대체
					if(postService.updateChoose(it_num, user.getMe_id())) {
						res = 3;
					} else {res = 0;}
				}
			}
			//선택한 기록이 없다면
			else {
				if(postService.insertChoose(it_num, user.getMe_id())) {
					res = 1;
				} else {res = 0;}
			}
		}
		map.put("result", res);
		return map;
	}
	
	
}
