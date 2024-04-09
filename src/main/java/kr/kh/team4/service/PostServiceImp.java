package kr.kh.team4.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team4.dao.PostDAO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.PostCriteria;

@Service
public class PostServiceImp implements PostService {
	
	@Autowired
	PostDAO postDAO;

	private boolean checkString(String str) {
		if(str.length() == 0 || str == null) {
			return false;
		}
		return true;
	}
	
	
	
	@Override
	public ArrayList<CategoryVO> getCategoryList() {
		return postDAO.selectCategoryList();
	}

	@Override
	public ArrayList<PostVO> getPostList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		
		return postDAO.selectPostList(cri);
	}

	@Override
	public int totalCountPost(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		
		return postDAO.totalCountPost(cri);
	}

	@Override
	public boolean insertPost(PostVO post) {
		if(post == null||
				!checkString(post.getPo_title()) ||
				!checkString(post.getPo_content())) {
			return false;
		}
		return postDAO.insertPost(post);
	}
}
