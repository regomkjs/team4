package kr.kh.team4.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.HeartVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.pagination.Criteria;

public interface PostDAO {

	ArrayList<CategoryVO> selectCategoryList();

	ArrayList<PostVO> selectPostList(@Param("cri")Criteria cri);

	int totalCountPost(@Param("cri")Criteria cri);

	boolean insertPost(@Param("post")PostVO post);

	PostVO selectPost(@Param("po_num")int po_num);

	HeartVO selectHeart(@Param("user")MemberVO user, @Param("po_num")int po_num);

	void deleteHeart(@Param("user")MemberVO user, @Param("po_num")int po_num);

	void insertHeart(@Param("user")MemberVO user, @Param("po_num")int po_num);

	int selectTotalCountHeart(@Param("po_num")int po_num);

}
