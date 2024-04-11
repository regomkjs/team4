package kr.kh.team4.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.CommentVO;
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

	void updateView(@Param("po_num")int po_num);

	ArrayList<CommentVO> selectCommentList(@Param("cri")Criteria cri);

	int selectTotalCountComment(@Param("cri")Criteria cri);

	boolean insertComment(@Param("comment")CommentVO comment);

	void updateOriComment();

	CommentVO selectComment(@Param("co_num")int num);

	boolean updateComment(@Param("co_num")int num, @Param("co_content")String content);

	boolean updateCommentState(@Param("co_num")int num);

	boolean deleteComment(@Param("co_num")int num);

	int countReply(@Param("co_ori_num")int co_ori_num);

}
