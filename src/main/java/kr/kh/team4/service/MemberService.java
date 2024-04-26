package kr.kh.team4.service;

import java.util.ArrayList;

import kr.kh.team4.model.dto.LoginDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.member.GradeVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.Criteria;
import kr.kh.team4.pagination.MemberCriteria;

public interface MemberService {

	boolean insertMember(MemberVO member);

	boolean idCheck(String id);

	MemberVO login(LoginDTO loginDto);

	boolean nickNameCheck(String nickName);

	MemberVO findId(String email, String phone);

	boolean findPw(String id);

	boolean updateMember(MemberVO member, MemberVO user);

	ArrayList<GradeVO> getGradeList();

	boolean insertGrade(GradeVO grade);

	GradeVO getGrade(int num);

	boolean updateGrade(GradeVO grade);

	MemberVO getMember(String id);

	void failCountUp(MemberVO failUser, int failCount);

	void updateMemberState(MemberVO failUser, int num);

	boolean deleteGrade(int gr_num);

	MemberVO getMemberByNick(String me_nick);

	ArrayList<BookVO> getMyLoanBookList(Criteria cri, MemberVO user);

	int totalCountMyLoanBook(Criteria cri, MemberVO user);

	MemberVO getMemberByLoan(int bookNum);
	
	int addBlockDay(MemberVO member, int day);

	void resetBlockToNull(String me_id);

	ArrayList<MemberVO> getMemberList(MemberCriteria me_cri);

	int getTotalCountMember(MemberCriteria me_cri);

}
