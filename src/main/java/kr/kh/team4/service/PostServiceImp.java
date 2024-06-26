package kr.kh.team4.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team4.dao.MemberDAO;
import kr.kh.team4.dao.PostDAO;
import kr.kh.team4.model.dto.ItemListDTO;
import kr.kh.team4.model.dto.VoteListDTO;
import kr.kh.team4.model.vo.member.GradeVO;
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
import kr.kh.team4.pagination.PostCriteria;

@Service
public class PostServiceImp implements PostService {
	
	@Autowired
	PostDAO postDAO;
	
	@Autowired
	MemberDAO memberDao;
	
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
	
	private void clearVote() {
		ArrayList<VoteVO> allVote = postDAO.selectAllVote();
		for(VoteVO vote : allVote) {
			int count = postDAO.countItemByVoNum(vote.getVo_num());
			if(count == 0) {
				postDAO.deleteVote(vote.getVo_num());
			}
		}
	}
	
	private void makeNewVote(int po_num,VoteListDTO votes, ItemListDTO items) {
		try {
			if(votes.getVo_list().size() == 0 || votes.getVo_list() == null || votes == null ||
					items.getIt_list().size() == 0 || items.getIt_list() == null  || items == null) {
				return;
			}

			for(VoteVO vote : votes.getVo_list()) {
				if(vote == null || !checkString(vote.getVo_date())) {
					continue;
				}
				vote.setVo_po_num(po_num);
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
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		clearVote();
	}
	
	private void resetVote(VoteVO vote) {
		ArrayList<ItemVO> itemList = postDAO.selectItemList(vote.getVo_num());
		if(itemList.size()==0 || itemList == null) {
			return;
		}
		for(ItemVO item : itemList) {
			postDAO.updateItemCount(item.getIt_num());
			postDAO.deleteChooseByItNum(item.getIt_num());
		}
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
		}else {
			MemberVO user = memberDao.selectMember(post.getPo_me_id());
			updateMemberGrade(user);
		}
		makeNewVote(post.getPo_num(), votes, items);
		return true;
	}
	
	private void updateMemberGrade(MemberVO user) {
		memberDao.updatePostCount(user);
		ArrayList<GradeVO> gradeList = memberDao.selectGradeList();
		for(GradeVO grade : gradeList) {
			if(user.getMe_loan_count() >= grade.getGr_loan_condition() && user.getMe_post_count() >= grade.getGr_post_condition()) {
				memberDao.updateUserGrade(user.getMe_id(), grade.getGr_num());
			}
		}
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
		if(comment == null) {
			return false;
		}
		String rp_target = "co_"+comment.getCo_num();
		postDAO.acceptReportByTarget(rp_target);
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
	public boolean updatePost(PostVO post,  VoteListDTO votes, ItemListDTO items) {
		if(post == null || 
				!checkString(post.getPo_title()) ||
				!checkString(post.getPo_content())) {
			return false;
		}
		boolean res = postDAO.updatePost(post);
		ArrayList<VoteVO> voteList = postDAO.selectVoteList(post.getPo_num());
		if(voteList.size() == 0 || voteList == null) {
			makeNewVote(post.getPo_num(), votes, items);
			return res;
		}
		if(votes.getVo_list() == null) {
			postDAO.deleteVoteNotEnd(post.getPo_num());
			return res;
		}
		for(VoteVO vote : votes.getVo_list()) {
			if(vote == null || !checkString(vote.getVo_date())) {
				continue;
			}
			vote.setVo_po_num(post.getPo_num());
			if(voteList.contains(vote)) {
				VoteVO tmpVote = voteList.get(voteList.indexOf(vote));
				if(!tmpVote.getVo_title().equals(vote.getVo_title())) {
					resetVote(vote);
				}
				postDAO.updateVote(vote);
			}
			else {
				postDAO.insertVote(vote);
			}
			ArrayList<ItemVO> itemList = postDAO.selectItemList(vote.getVo_num());
			if(itemList.size() == 0 || itemList == null) {
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
			else {
				for(ItemVO item : items.getIt_list()) {
					if(!checkString(item.getIt_name()) || item == null) {
						continue;
					}
					if(vote.getVo_count() == item.getIt_vo_count()) {
						item.setIt_vo_num(vote.getVo_num());
						if(itemList.contains(item)) {
							ItemVO tmpItem = itemList.get(itemList.indexOf(item));
							if(!tmpItem.getIt_name().equals(item.getIt_name())) {
								resetVote(vote);
								postDAO.updateItem(item);
							}
						}
						else {
							resetVote(vote);
							postDAO.insertItem(item);
						}
					}
				}
				
				for(ItemVO item : itemList) {
					if(!items.getIt_list().contains(item) && item.getIt_vo_num() == vote.getVo_num()) {
						resetVote(vote);
						postDAO.deleteItem(item.getIt_num());
					}
				}
			}
		}
		for(VoteVO vote : voteList) {
			if(!votes.getVo_list().contains(vote) && vote.getVo_state() != 0) {
				postDAO.deleteVote(vote.getVo_num());
			}
		}
		clearVote();
		return res;
	}

	@Override
	public boolean deletePost(PostVO post) {
		if(post == null) {
			return false;
		}
		ArrayList<CommentVO> commentList = postDAO.selectCommentListByPost(post.getPo_num());
		for(CommentVO comment : commentList) {
			String rp_target = "co_"+comment.getCo_num();
			ArrayList<ReportVO> reportList = postDAO.selectReportListByTarget(rp_target);
			for(ReportVO report : reportList) {
				postDAO.decreaseReportCount(report.getRp_writer());
			}
			postDAO.acceptReportByTarget(rp_target);
		}
		String rp_target = "po_"+ post.getPo_num();
		ArrayList<ReportVO> reportList = postDAO.selectReportListByTarget(rp_target);
		for(ReportVO report : reportList) {
			postDAO.decreaseReportCount(report.getRp_writer());
		}
		postDAO.acceptReportByTarget(rp_target);
		return postDAO.deletePost(post);
	}

	@Override
	public ArrayList<VoteVO> getVoteList(int po_num) {
		postDAO.timeLimitVote();
		return postDAO.selectVoteList(po_num);
	}



	@Override
	public ArrayList<ItemVO> getItemList(ArrayList<VoteVO> voteList) {
		if(voteList.size() == 0 || voteList == null) {
			return null;
		}
		ArrayList<ItemVO> itemList = new ArrayList<ItemVO>();
		for(VoteVO vote : voteList) {
			ArrayList<ItemVO> items = postDAO.selectItemList(vote.getVo_num());
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
		boolean res = postDAO.insertChoose(it_num, me_id);
		if(res) {
			postDAO.increaseCount(it_num);
		}
		return res;
	}



	@Override
	public boolean deleteChoose(int it_num, String me_id) {
		boolean res = postDAO.deleteChoose(it_num, me_id);
		if (res) {
			postDAO.decreaseCount(it_num);
		}
		return res;
	}



	@Override
	public boolean anotherSelectedItem(int it_num, String me_id) {
		ItemVO tmp = postDAO.selectTmpItem(it_num);
		ArrayList<ItemVO> itemList = postDAO.selectItemList(tmp.getIt_vo_num());
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
		ArrayList<ItemVO> itemList = postDAO.selectItemList(tmp.getIt_vo_num());
		for(ItemVO item : itemList) {
			if(postDAO.deleteChoose(item.getIt_num(), me_id)) {
				postDAO.decreaseCount(item.getIt_num());
			}
		}
		return insertChoose(it_num, me_id);
	}



	@Override
	public boolean updateVoteState(VoteVO vote) {
		if(vote == null) {
			return false;
		}
		return postDAO.updateVoteState(vote.getVo_num());
	}



	@Override
	public ArrayList<ItemVO> getItemList(int vo_num) {
		return postDAO.selectItemList(vo_num);
	}



	@Override
	public int countTotalVoteMember(int vo_num) {
		return postDAO.countTotalVoteMember(vo_num);
	}



	@Override
	public VoteVO getVote(int vo_num) {
		postDAO.timeLimitVote();
		return postDAO.selectVote(vo_num);
	}



	@Override
	public ItemVO getItem(int it_num) {
		return postDAO.selectItem(it_num);
	}

	@Override
	public boolean insertCategory(String ca_name) {
		return postDAO.insertCategory(ca_name);
	}

	@Override
	public CategoryVO getCategory(int ca_num) {
		return postDAO.selectCategory(ca_num);
	}

	@Override
	public boolean updateCategory(CategoryVO category) {
		if(category == null || !checkString(category.getCa_name())) {
			return false;
		}
		
		return postDAO.updateCategory(category);
	}

	@Override
	public boolean deleteCategory(int ca_num) {
		return postDAO.deleteCategory(ca_num);
	}

	@Override
	public boolean getReportByTarget(String target, String me_id) {
		ReportVO report = postDAO.selectReportByTarget(target, me_id);
		if(report == null) {
			return false;
		}
		return true;
	}

	@Override
	public boolean insertReport(String note, String type, String target, String writer, String me_id) {
		boolean res = postDAO.insertReport(note, type, target, writer, me_id);
		if(res) {
			postDAO.increaseReportCount(writer);
		}
		return res;
	}

	@Override
	public ArrayList<ReportVO> getReportList(Criteria cri) {
		ArrayList<ReportVO> reportList = postDAO.selectReportList(cri);
		if(reportList == null || reportList.size()==0) {
			return null;
		}
		for(ReportVO report : reportList) {
			String[] tmp = report.getRp_target().split("_");
			if(tmp[0].equals("po")) {
				int num = Integer.parseInt(tmp[1]);
				PostVO post = postDAO.selectPost(num);
				report.setRp_writer_nick(post.getMe_nick());
				report.setRp_post(post);
			}
			else {
				int num = Integer.parseInt(tmp[1]);
				CommentVO comment = postDAO.selectComment(num);
				report.setRp_writer_nick(comment.getMe_nick());
				PostVO post = postDAO.selectPost(comment.getCo_po_num());
				report.setRp_post(post);
				report.setRp_comment(comment);
			}
		}
		return reportList;
	}

	@Override
	public int getTotalCountReport() {
		return postDAO.totalCountReport();
	}

	@Override
	public int rejectReportList(int[] reportArr) {
		int count = 0;
		for(int rp_num : reportArr) {
			boolean res = postDAO.rejectReport(rp_num);
			if(res) {
				ReportVO tmp = postDAO.selectReport(rp_num);
				postDAO.decreaseReportCount(tmp.getRp_writer());
				count++;
			}
		}
		return count;
	}

	@Override
	public boolean rejectReport(int rp_num) {
		boolean res = postDAO.rejectReport(rp_num);
		if(res) {
			ReportVO tmp = postDAO.selectReport(rp_num);
			postDAO.decreaseReportCount(tmp.getRp_writer());
		}
		return res;
	}

	@Override
	public boolean deleteCommentAdmin(int num) {
		CommentVO comment = postDAO.selectComment(num);
		String rp_target = "co_"+comment.getCo_num();
		ArrayList<ReportVO> reportList = postDAO.selectReportListByTarget(rp_target);
		if(reportList.size() == 0 || reportList == null) {
			return postDAO.deleteCommentAdmin(num);
		}
		for(ReportVO report : reportList) {
			postDAO.decreaseReportCount(report.getRp_writer());
		}
		postDAO.acceptReportByTarget(rp_target);
		return postDAO.deleteCommentAdmin(num);
	}

	@Override
	public CommentVO getComment(int num) {
		return postDAO.selectComment(num);
	}

	@Override
	public boolean blockReporter(int rp_num) {
		ReportVO tmp = postDAO.selectReport(rp_num);
		postDAO.decreaseReportCount(tmp.getRp_writer());
		return postDAO.updateReportBlockReporter(rp_num);
	}

	@Override
	public boolean blockWriter(int rp_num) {
		ReportVO tmp = postDAO.selectReport(rp_num);
		postDAO.decreaseReportCount(tmp.getRp_writer());
		return postDAO.updateReportBlockWriter(rp_num);
	}

	@Override
	public ArrayList<PostVO> getNoticeList() {
		return postDAO.selectNoticeList();
	}

	@Override
	public ArrayList<PostVO> getHotList() {
		return postDAO.selectHotList();
	}

	@Override
	public int totalCountPostNum() {
		return postDAO.totalCountPostNum();
	}

	@Override
	public ArrayList<PostVO> getPopularPostList(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		
		
		return postDAO.selectPopularPostList(cri);
	}

	@Override
	public int totalCountPopularPost(Criteria cri) {
		if(cri == null) {
			cri = new Criteria();
		}
		
		return postDAO.totalCountPopularPost(cri);
	}

	@Override
	public ArrayList<PostVO> getNewPostList() {
		return postDAO.selectNewPostList();
	}

	@Override
	public ArrayList<PostVO> getVotePostList() {
		return postDAO.selectVotePostList();
	}

	@Override
	public boolean targetState(String target) {
		String[] tmp = target.split("_");
		if(tmp[0].equals("po")) {
			PostVO post = getPost(Integer.parseInt(tmp[1]));
			if(post == null) {
				return true;
			}
		} else {
			CommentVO comment = getComment(Integer.parseInt(tmp[1]));
			if(comment == null) {
				return true;
			}
			if(comment.getCo_state() != 1) {
				return true;
			}
		}
		return false;
	}

}
