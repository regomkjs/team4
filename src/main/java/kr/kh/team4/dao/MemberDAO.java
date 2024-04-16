package kr.kh.team4.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.vo.member.GradeVO;
import kr.kh.team4.model.vo.member.MemberVO;

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

}
