package kr.kh.team4.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.member.ReportVO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.ChooseVO;
import kr.kh.team4.model.vo.post.CommentVO;
import kr.kh.team4.model.vo.post.HeartVO;
import kr.kh.team4.model.vo.post.ItemVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.model.vo.post.VoteVO;
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

	CommentVO selectComment(@Param("co_num")int co_num);

	boolean updateComment(@Param("co_num")int co_num, @Param("co_content")String content);

	boolean updateCommentState(@Param("co_num")int co_num);

	boolean deleteComment(@Param("co_num")int co_num);

	int countReply(@Param("co_ori_num")int co_ori_num);

	ArrayList<PostVO> selectMyPostList(@Param("cri")Criteria cri, @Param("me_id")String id);

	int totalCountMyPost(@Param("cri")Criteria cri, @Param("me_id")String id);

	ArrayList<PostVO> selectMyCommentList(@Param("cri")Criteria cri, @Param("me_id")String id);

	int totalCountMyComment(@Param("cri")Criteria cri, @Param("me_id")String id);
	
	boolean updatePost(@Param("post")PostVO post);

	boolean deletePost(@Param("post")PostVO post);

	void insertVote(@Param("vote")VoteVO vote);

	void insertItem(@Param("item")ItemVO item);

	ArrayList<VoteVO> selectAllVote();

	int countItemByVoNum(@Param("vo_num")int vo_num);

	void deleteVote(@Param("vo_num")int vo_num);

	ArrayList<VoteVO> selectVoteList(@Param("po_num")int po_num);

	ArrayList<ItemVO> selectItemList(@Param("vo_num")int vo_num);

	ArrayList<ItemVO> selectPostItem(@Param("po_num")int po_num);

	ChooseVO selectChoose(@Param("it_num")int it_num, @Param("me_id")String me_id);

	boolean insertChoose(@Param("it_num")int it_num, @Param("me_id")String me_id);

	boolean deleteChoose(@Param("it_num")int it_num, @Param("me_id")String me_id);

	ItemVO selectTmpItem(@Param("it_num")int it_num);

	void increaseCount(@Param("it_num")int it_num);

	void decreaseCount(@Param("it_num")int it_num);

	boolean updateVoteState(@Param("vo_num")int vo_num);

	int countTotalVoteMember(@Param("vo_num")int vo_num);

	VoteVO selectVote(@Param("vo_num")int vo_num);

	ItemVO selectItem(@Param("it_num")int it_num);

	void deleteItem(@Param("it_num")int it_num);

	void updateVote(@Param("vote")VoteVO vote);

	void updateItem(@Param("item")ItemVO item);

	void deleteChooseByItNum(@Param("it_num")int it_num);

	void updateItemCount(@Param("it_num")int it_num);

	void deleteVoteNotEnd(@Param("po_num")int po_num);

	void timeLimitVote();

	boolean insertCategory(@Param("ca_name")String ca_name);

	CategoryVO selectCategory(@Param("ca_num")int ca_num);

	boolean updateCategory(@Param("category")CategoryVO category);

	boolean deleteCategory(@Param("ca_num")int ca_num);

	ReportVO selectReportByTarget(@Param("target")String target, @Param("me_id")String me_id);

	boolean insertReport(@Param("note")String note, @Param("type")String type, @Param("target")String target,  @Param("writer")String writer, @Param("me_id")String me_id);

	ArrayList<ReportVO> selectReportList();

	
	

}
