package kr.kh.team4.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.team4.dao.MemberDAO;
import kr.kh.team4.model.dto.LoginDTO;
import kr.kh.team4.model.vo.member.MemberVO;

@Service
public class MemberServiceImp implements MemberService {
	
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	private boolean checkString(String str) {
		return str != null && str.length() != 0; 
	}
	
	@Override
	public boolean insertMember(MemberVO member) {
		if( member == null ||
			!checkString(member.getMe_id()) ||
			!checkString(member.getMe_pw()) ||
			!checkString(member.getMe_email())) {
			return false;
		}
		MemberVO user = memberDao.selectMember(member.getMe_id());
		if(user != null) {
			return false;
		}
		String encPw = passwordEncoder.encode(member.getMe_pw());
		member.setMe_pw(encPw);
		return memberDao.insertMember(member);
	}

	@Override
	public boolean idCheck(String id) {
		MemberVO member = memberDao.selectMember(id);
		return member == null;
	}

	@Override
	public MemberVO login(LoginDTO loginDto) {
		if( loginDto == null ||
			!checkString(loginDto.getId()) || 
			!checkString(loginDto.getPw())) {
			return null;
		}
		MemberVO user = memberDao.selectMember(loginDto.getId());
		
		if(user == null || !passwordEncoder.matches(loginDto.getPw(), user.getMe_pw())) {
			return null;
		}
		return user;
	}
}
