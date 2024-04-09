package kr.kh.team4.service;

import kr.kh.team4.model.dto.LoginDTO;
import kr.kh.team4.model.vo.member.MemberVO;

public interface MemberService {

	boolean insertMember(MemberVO member);

	boolean idCheck(String id);

	MemberVO login(LoginDTO loginDto);

	boolean nickNameCheck(String nickName);

	MemberVO findId(String email, String phone);

	boolean findPw(String id);

}
