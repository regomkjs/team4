package kr.kh.team4.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.member.GradeVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.MemberCriteria;

public interface MemberDAO {

	boolean insertMember(@Param("member")MemberVO member);

	MemberVO selectMember(@Param("me_id")String me_id);

	MemberVO selectNickName(@Param("me_nick")String nickName);

	MemberVO selectMemberId(@Param("email")String email, @Param("phone")String phone);

	void updatePassword(@Param("id")String id, @Param("pw")String encPw);

	boolean updateMember(@Param("member")MemberVO member);

	ArrayList<GradeVO> selectGradeList();

	boolean insertGrade(@Param("grade")GradeVO grade);

	GradeVO selectGrade(@Param("gr_num")int num);

	boolean updateGrade(@Param("grade")GradeVO grade);

	void updateFailCount(@Param("me_id")String me_id, @Param("failCount")int failCount);

	void updateMemberState(@Param("me_id")String me_id, @Param("num")int num);

	boolean deleteGrade(@Param("gr_num")int gr_num);

	void updateLoanCount(@Param("member")MemberVO member);

	MemberVO selectMemberByNick(@Param("me_nick")String me_nick);

	ArrayList<BookVO> selectMyLoanBook(@Param("cri")Criteria cri, @Param("user")MemberVO user);

	int selectTotalCountMyLoanBook(@Param("cri")Criteria cri, @Param("user")MemberVO user);

	MemberVO selectMemberByLoan(@Param("book")int bookNum);
	
	void insertBlock(@Param("me_id")String me_id, @Param("day")int day);

	void updateBlock(@Param("me_id")String me_id, @Param("day")int day);

	void updateUserGrade(@Param("me_id")String me_id, @Param("gr_num")int gr_num);
	
	void resetBlockToNull(@Param("me_id")String me_id);

	ArrayList<MemberVO> selectMemberList(@Param("cri")MemberCriteria cri);

	int totalCountMember(@Param("cri")MemberCriteria cri);

	void permanentBlock(@Param("me_id")String me_id);

	void decreaseBlock(@Param("me_id")String me_id, @Param("day")int day);

	void updateLoanBlock(@Param("me_id")String me_id);

	void updatePostCount(@Param("user")MemberVO user);

	MemberVO selectEmail(@Param("email")String email);

	void updateBlockRenewal();

	boolean updateMemberRight(@Param("me_id")String me_id, @Param("num")int num);

	void updateMemberCookie(@Param("user")MemberVO user);

	MemberVO selectMemberByCookie(@Param("me_cookie")String sessionId);

	boolean insertSnsMember(@Param("member")MemberVO member);

}
