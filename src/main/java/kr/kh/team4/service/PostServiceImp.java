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
}
