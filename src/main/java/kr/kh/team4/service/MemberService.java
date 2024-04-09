package kr.kh.team4.service;

import java.util.ArrayList;

import kr.kh.team4.model.dto.LoginDTO;
import kr.kh.team4.model.vo.member.GradeVO;
import kr.kh.team4.model.vo.member.MemberVO;

public interface MemberService {

	boolean insertMember(MemberVO member);

	boolean idCheck(String id);

	MemberVO login(LoginDTO loginDto);

	boolean nickNameCheck(String nickName);

	MemberVO findId(String email, String phone);

	boolean findPw(String id);

	boolean updateMember(MemberVO member, MemberVO user);

	ArrayList<GradeVO> selectGradeList();

	boolean insertGrade(GradeVO grade);

	GradeVO selectGrade(int num);

	boolean updateGrade(GradeVO grade);

}
