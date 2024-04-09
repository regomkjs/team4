package kr.kh.team4.service;

import java.util.ArrayList;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.PostCriteria;

public interface PostService {

	ArrayList<CategoryVO> getCategoryList();

	ArrayList<PostVO> getPostList(Criteria cri);

	int totalCountPost(Criteria cri);

	boolean insertPost(PostVO post);

	PostVO getPost(int po_num);

	int toggleHeart(MemberVO user, int po_num);

	boolean searchHeart(MemberVO user, int po_num);

	int totalCountHeart(int po_num);

}
