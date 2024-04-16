package kr.kh.team4.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team4.dao.PostDAO;
import kr.kh.team4.model.dto.ItemListDTO;
import kr.kh.team4.model.dto.VoteListDTO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.model.vo.post.CategoryVO;
import kr.kh.team4.model.vo.post.ChooseVO;
import kr.kh.team4.model.vo.post.CommentVO;
import kr.kh.team4.model.vo.post.HeartVO;
import kr.kh.team4.model.vo.post.ItemVO;
import kr.kh.team4.model.vo.post.PostVO;
import kr.kh.team4.model.vo.post.VoteVO;
import kr.kh.team4.pagination.CommentCriteria;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.MyCommentCriteria;
import kr.kh.team4.pagination.PostCriteria;

@Service
public class PostServiceImp implements PostService {
	
	@Autowired
	PostDAO postDAO;

	private boolean checkString(String str) {
		try {
			if(str.length() == 0 || str == null) {
				return false;
			}
		} catch (Exception e) {
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
	public boolean insertPost(PostVO post , VoteListDTO votes, ItemListDTO items) {
		if(post == null||
				!checkString(post.getPo_title()) ||
				!checkString(post.getPo_content())) {
			return false;
		}
		boolean res =postDAO.insertPost(post);
		if(!res) {
			return false;
		}
		try {
			if(votes.getVo_list().size() == 0 || votes.getVo_list() == null || votes == null ||
					items.getIt_list().size() == 0 || items.getIt_list() == null  || items == null) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		for(VoteVO vote : votes.getVo_list()) {
			if(vote == null || !checkString(vote.getVo_date())) {
				continue;
			}
			vote.setVo_po_num(post.getPo_num());
			postDAO.insertVote(vote);
			for(ItemVO item : items.getIt_list()) {
				if(!checkString(item.getIt_name()) || item == null) {
					continue;
				}
				if(vote.getVo_count() == item.getIt_vo_count()) {
					item.setIt_vo_num(vote.getVo_num());
					postDAO.insertItem(item);
				}
			}
		}
		ArrayList<VoteVO> allVote = postDAO.selectAllVote();
		for(VoteVO vote : allVote) {
			int count = postDAO.countItemByVoNum(vote.getVo_num());
			if(count == 0) {
				postDAO.deleteVote(vote.getVo_num());
			}
		}
		return true;
	}



	@Override
	public PostVO getPost(int po_num) {
		postDAO.updateView(po_num);
		return postDAO.selectPost(po_num);
	}



	@Override
	public int toggleHeart(MemberVO user, int po_num) {
		if(user == null || !checkString(user.getMe_id())) {
			return -1;
		}
		HeartVO heart = postDAO.selectHeart(user, po_num);
		if(heart != null) {
			postDAO.deleteHeart(user, po_num);
			return 0; 
		}
		else {
			postDAO.insertHeart(user, po_num);
			return 1;
		}
	}



	@Override
	public boolean searchHeart(MemberVO user, int po_num) {
		if(user == null || !checkString(user.getMe_id())) {
			return false;
		}
		HeartVO heart = postDAO.selectHeart(user, po_num);
		if(heart != null) {
			return true;
		}
		else {
			return false;
		}
	}



	@Override
	public int totalCountHeart(int po_num) {
		return postDAO.selectTotalCountHeart(po_num);
	}



	@Override
	public ArrayList<CommentVO> getCommentList(Criteria cri) {
		if(cri == null) {
			return null;
		}
		return postDAO.selectCommentList(cri);
	}



	@Override
	public int getTotalCountComment(Criteria cri) {
		if(cri == null) {
			return 0;
		}
		return postDAO.selectTotalCountComment(cri);
	}



	@Override
	public boolean insertComment(CommentVO comment) {
		if(comment == null || 
				!checkString(comment.getCo_content()) || 
				!checkString(comment.getCo_me_id())) {
			return false;
		}
		boolean res = postDAO.insertComment(comment);
		if(res) {
			postDAO.updateOriComment();
		}
		return res;
	}



	@Override
	public boolean updateComment(int num, String content, MemberVO user) {
		if(user == null || !checkString(content)) {
			return false;
		}
		CommentVO comment = postDAO.selectComment(num);
		if(comment == null || !comment.getCo_me_id().equals(user.getMe_id())) {
			return false;
		}
		return postDAO.updateComment(num, content);
	}



	@Override
	public boolean deleteComment(int num, MemberVO user) {
		if(user == null) {
			return false;
		}
		CommentVO comment = postDAO.selectComment(num);
		if(comment == null || !comment.getCo_me_id().equals(user.getMe_id())) {
			return false;
		}
		if(comment.getCo_ori_num() == num && postDAO.countReply(comment.getCo_ori_num()) > 1) {
			return postDAO.updateCommentState(num);
		}
		else {
			CommentVO oriComment = postDAO.selectComment(comment.getCo_ori_num());
			if(oriComment.getCo_state() == 0 &&  postDAO.countReply(comment.getCo_ori_num()) == 2) {
				postDAO.deleteComment(oriComment.getCo_num());
			}
			return postDAO.deleteComment(num);
		}
	}

	@Override
	public ArrayList<PostVO> getMyPostList(Criteria cri, MemberVO user) {
		if(cri == null) {
			cri = new Criteria(); 
		}
		if(user == null) {
			return null;
		}
		return postDAO.selectMyPostList(cri, user.getMe_id());
	}

	@Override
	public int totalCountMyPost(Criteria cri, MemberVO user) {
		if(cri == null) {
			cri = new Criteria();
		}
		if(user == null) {
			return 0;
		}
		return postDAO.totalCountMyPost(cri, user.getMe_id());
	}

	@Override
	public ArrayList<PostVO> getMyCommentList(Criteria cri, MemberVO user) {
		if(cri == null) {
			cri = new Criteria();
		}
		if(user == null) {
			return null;
		}
		return postDAO.selectMyCommentList(cri, user.getMe_id());
	}

	@Override
	public int totalCountMyComment(Criteria cri, MemberVO user) {
		if(cri == null) {
			cri = new Criteria();
		}
		if(user == null) {
			return 0;
		}
		return postDAO.totalCountMyComment(cri, user.getMe_id());	
	}
	
	@Override
	public boolean updatePost(PostVO post) {
		if(post == null || 
				!checkString(post.getPo_title()) ||
				!checkString(post.getPo_content())) {
			return false;
		}
		return postDAO.updatePost(post);
	}

	@Override
	public boolean deletePost(PostVO post) {
		if(post == null) {
			return false;
		}
		return postDAO.deletePost(post);
	}

	@Override
	public ArrayList<VoteVO> getVoteList(int po_num) {
		return postDAO.selectVote(po_num);
	}



	@Override
	public ArrayList<ItemVO> getItemList(ArrayList<VoteVO> voteList) {
		if(voteList.size() == 0 || voteList == null) {
			return null;
		}
		ArrayList<ItemVO> itemList = new ArrayList<ItemVO>();
		for(VoteVO vote : voteList) {
			ArrayList<ItemVO> items = postDAO.selectItem(vote.getVo_num());
			if(items.size() !=0 && items !=null) {
				itemList.addAll(items);
			}
		}
		return itemList;
	}



	@Override
	public ArrayList<ChooseVO> getChooseList(int po_num, MemberVO user) {
		if(user == null || !checkString(user.getMe_id())) {
			return new ArrayList<ChooseVO>();
		}
		ArrayList<ItemVO> itemList = postDAO.selectPostItem(po_num);
		ArrayList<ChooseVO> chooseList = new ArrayList<ChooseVO>();
		for(ItemVO item : itemList) {
			ChooseVO choose = postDAO.selectChoose(item.getIt_num(), user.getMe_id());
			chooseList.add(choose);
		}
		return chooseList;
	}



	@Override
	public boolean isSelectedItem(int it_num, String me_id) {
		ChooseVO choose = postDAO.selectChoose(it_num, me_id);
		if(choose == null) {
			return false;
		}
		return true;
	}



	@Override
	public boolean insertChoose(int it_num, String me_id) {
		return postDAO.insertChoose(it_num, me_id);
	}



	@Override
	public boolean deleteChoose(int it_num, String me_id) {
		return postDAO.deleteChoose(it_num, me_id);
	}



	@Override
	public boolean anotherSelectedItem(int it_num, String me_id) {
		ItemVO tmp = postDAO.selectTmpItem(it_num);
		ArrayList<ItemVO> itemList = postDAO.selectItem(tmp.getIt_vo_num());
		boolean res = false;
		for(ItemVO item : itemList) {
			if(isSelectedItem(item.getIt_num(), me_id)) {
				res = true;
			}
		}
		return res;
	}



	@Override
	public boolean updateChoose(int it_num, String me_id) {
		ItemVO tmp = postDAO.selectTmpItem(it_num);
		ArrayList<ItemVO> itemList = postDAO.selectItem(tmp.getIt_vo_num());
		for(ItemVO item : itemList) {
			postDAO.deleteChoose(item.getIt_num(), me_id);
		}
		return postDAO.insertChoose(it_num, me_id);
	}

}
