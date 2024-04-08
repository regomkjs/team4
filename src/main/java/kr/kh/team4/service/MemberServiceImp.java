package kr.kh.team4.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.team4.dao.MemberDAO;
import kr.kh.team4.model.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService {
	
	@Autowired
	MemberDAO memberDao;

	@Override
	public boolean insertMember(MemberVO member) {
		if(member == null) {
			return false;
		}
		return memberDao.insertMember(member);
	}
}
