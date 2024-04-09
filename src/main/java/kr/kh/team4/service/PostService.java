package kr.kh.team4.service;

import java.util.ArrayList;

import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.PostCriteria;

public interface PostService {

	ArrayList<CategoryVO> getCategoryList();

	ArrayList<PostVO> getPostList(Criteria cri);

	int totalCountPost(Criteria cri);

	boolean insertPost(PostVO post);

}
