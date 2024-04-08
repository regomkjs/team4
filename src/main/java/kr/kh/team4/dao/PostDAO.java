package kr.kh.team4.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.pagination.Criteria;

public interface PostDAO {

	ArrayList<CategoryVO> selectCategoryList();

	ArrayList<PostVO> selectPostList(@Param("cri")Criteria cri);

	int totalCountPost(@Param("cri")Criteria cri);

}
