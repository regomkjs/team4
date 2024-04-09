package kr.kh.team4.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.vo.member.MemberVO;

public interface MemberDAO {

	boolean insertMember(@Param("member")MemberVO member);

	MemberVO selectMember(@Param("me_id")String me_id);

	MemberVO selectNickName(@Param("me_nick")String nickName);

	MemberVO selectMemberId(@Param("email")String email, @Param("phone")String phone);

	void updatePassword(@Param("id")String id, @Param("pw")String encPw);

	boolean updateMember(@Param("member")MemberVO member);

}
