package kr.kh.team4.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.team4.model.vo.member.MemberVO;

public interface MemberDAO {

	boolean insertMember(@Param("member")MemberVO member);

	MemberVO selectMember(@Param("me_id")String me_id);

}
