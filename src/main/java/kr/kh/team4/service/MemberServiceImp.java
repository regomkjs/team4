package kr.kh.team4.service;

import java.util.ArrayList;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.team4.dao.MemberDAO;
import kr.kh.team4.model.dto.LoginDTO;
import kr.kh.team4.model.vo.member.GradeVO;
import kr.kh.team4.model.vo.member.MemberVO;

@Service
public class MemberServiceImp implements MemberService {
	
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	private String randomPassword(int size) {
		String strs = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#";
		String newPw = "";
		int min = 0, max = strs.length() - 1;
		while(newPw.length() < size) {
			int r = (int)(Math.random() * (max-min + 1) + min);
			newPw += strs.charAt(r);
		}
		return newPw;
	}
	
	public boolean mailSend(String to, String title, String content) {

	    String setfrom = "regomkjs2013@gmail.com";
	   try{
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper messageHelper
	            = new MimeMessageHelper(message, true, "UTF-8");

	        messageHelper.setFrom(setfrom);// 보내는사람 생략하거나 하면 정상작동을 안함
	        messageHelper.setTo(to);// 받는사람 이메일
	        messageHelper.setSubject(title);// 메일제목은 생략이 가능하다
	        messageHelper.setText(content, true);// 메일 내용

	        mailSender.send(message);
	        return true;
	    } catch(Exception e){
	        e.printStackTrace();
	        return false;
	    }
	}
	
	private boolean checkString(String str) {
		return str != null && str.length() != 0; 
	}
	
	@Override
	public boolean insertMember(MemberVO member) {
		if( member == null ||
			!checkString(member.getMe_id()) ||
			!checkString(member.getMe_pw()) ||
			!checkString(member.getMe_email()) ||
			!checkString(member.getMe_nick()) ||
			!checkString(member.getMe_phone())) {
			return false;
		}
		MemberVO user = memberDao.selectMember(member.getMe_id());
		if(user != null) {
			return false;
		}
		String encPw = passwordEncoder.encode(member.getMe_pw());
		member.setMe_pw(encPw);
		try {
			return memberDao.insertMember(member);
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
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
	
	@Override
	public boolean nickNameCheck(String nickName) {
		MemberVO member = memberDao.selectNickName(nickName);
		return member == null;
	}

	@Override
	public MemberVO findId(String email, String phone) {
		MemberVO member = memberDao.selectMemberId(email, phone);
		if(member == null) {
			return null;
		}
		return member;
	}

	@Override
	public boolean findPw(String id) {
		MemberVO member = memberDao.selectMember(id);
		if(member == null) {
			return false;
		}
		
		String newPw = randomPassword(6);
		
		String title = "새 비밀번호입니다.";
		String content = "새 비밀번호는 <b>"+ newPw +"</b> 입니다.";
		boolean res = mailSend(member.getMe_email(), title, content);
		
		String encPw = passwordEncoder.encode(newPw);
		memberDao.updatePassword(id, encPw);
		memberDao.updateFailCount(id, 0);
		memberDao.updateMemberState(id, 2);
		return res;
	}

	@Override
	public boolean updateMember(MemberVO member, MemberVO user) {
		if( member == null || user == null ||
			!checkString(member.getMe_id()) ||
			!checkString(member.getMe_email()) ||
			!checkString(member.getMe_nick()) ||
			!checkString(member.getMe_phone())) {
			return false;
		}
		if(!checkString(member.getMe_pw())) {
			member.setMe_pw(user.getMe_pw());
		}else {
			String encPw = passwordEncoder.encode(member.getMe_pw());
			member.setMe_pw(encPw);
		}
		
		member.setMe_id(user.getMe_id());
		try {
			boolean res = memberDao.updateMember(member);
			if(!res) {
				return false;
			}
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		user.setMe_pw(member.getMe_pw());
		user.setMe_email(member.getMe_email());
		user.setMe_nick(member.getMe_nick());
		user.setMe_phone(member.getMe_phone());
		return true;
	}

	@Override
	public ArrayList<GradeVO> getGradeList() {
		return memberDao.selectGradeList();
	}

	@Override
	public boolean insertGrade(GradeVO grade) {
		if(grade == null) {
			return false;
		}
		return memberDao.insertGrade(grade);
	}

	@Override
	public GradeVO getGrade(int num) {
		return memberDao.selectGrade(num);
	}

	@Override
	public boolean updateGrade(GradeVO grade) {
		if(grade == null) {
			return false;
		}
		return memberDao.updateGrade(grade);
	}

	@Override
	public MemberVO getMember(String id) {
		if(id == null) {
			return null;
		}
		return memberDao.selectMember(id);
	}

	@Override
	public void failCountUp(MemberVO failUser, int failCount) {
		memberDao.updateFailCount(failUser.getMe_id(), failCount);
	}

	@Override
	public void updateMemberState(MemberVO failUser, int num) {
		memberDao.updateMemberState(failUser.getMe_id(), num);
	}
	
}
