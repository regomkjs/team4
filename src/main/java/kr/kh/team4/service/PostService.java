package kr.kh.team4.service;

import java.util.ArrayList;

import kr.kh.team4.model.dto.ItemListDTO;
import kr.kh.team4.model.dto.VoteListDTO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.ChooseVO;
import kr.kh.team4.model.vo.post.CommentVO;
import kr.kh.team4.model.vo.post.ItemVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.model.vo.post.VoteVO;
import kr.kh.team4.pagination.CommentCriteria;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.MyCommentCriteria;
import kr.kh.team4.pagination.PostCriteria;

public interface PostService {

	ArrayList<CategoryVO> getCategoryList();

	ArrayList<PostVO> getPostList(Criteria cri);

	int totalCountPost(Criteria cri);

	boolean insertPost(PostVO post, VoteListDTO votes, ItemListDTO items);

	PostVO getPost(int po_num);

	int toggleHeart(MemberVO user, int po_num);

	boolean searchHeart(MemberVO user, int po_num);

	int totalCountHeart(int po_num);

	ArrayList<CommentVO> getCommentList(Criteria cri);

	int getTotalCountComment(Criteria cri);

	boolean insertComment(CommentVO comment);

	boolean updateComment(int num, String content, MemberVO user);

	boolean deleteComment(int num, MemberVO user);

	ArrayList<PostVO> getMyPostList(Criteria cri, MemberVO user);

	int totalCountMyPost(Criteria cri, MemberVO user);

	ArrayList<PostVO> getMyCommentList(Criteria cri, MemberVO user);

	int totalCountMyComment(Criteria cri, MemberVO user);
	
	boolean updatePost(PostVO post, VoteListDTO votes, ItemListDTO items);

	boolean deletePost(PostVO post);

	ArrayList<VoteVO> getVoteList(int po_num);

	ArrayList<ItemVO> getItemList(ArrayList<VoteVO> voteList);

	ArrayList<ChooseVO> getChooseList(int po_num, MemberVO user);

	boolean isSelectedItem(int it_num, String me_id);

	boolean insertChoose(int it_num, String me_id);

	boolean deleteChoose(int it_num, String me_id);

	boolean anotherSelectedItem(int it_num, String me_id);

	boolean updateChoose(int it_num, String me_id);

	boolean updateVoteState(VoteVO vote);

	ArrayList<ItemVO> getItemList(int vo_num);

	int countTotalVoteMember(int vo_num);

	VoteVO getVote(int vo_num);

	ItemVO getItem(int it_num);

}
