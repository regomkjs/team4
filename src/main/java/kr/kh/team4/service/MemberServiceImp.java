package kr.kh.team4.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.mail.internet.MimeMessage;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.team4.dao.MemberDAO;
import kr.kh.team4.model.dto.LoginDTO;
import kr.kh.team4.model.vo.book.BookVO;
import kr.kh.team4.model.vo.member.GradeVO;
import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.pagination.Criteria;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

import kr.kh.team4.pagination.MemberCriteria;


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

	@Override
	public boolean deleteGrade(int gr_num) {
		if(gr_num == 0) {
			return false;
		}
		return memberDao.deleteGrade(gr_num);
	}

	@Override
	public MemberVO getMemberByNick(String me_nick) {
		return memberDao.selectMemberByNick(me_nick);
	}

	@Override
	public ArrayList<BookVO> getMyLoanBookList(Criteria cri, MemberVO user) {
		if(cri == null) {
			cri = new Criteria();
		}
		if(user == null) {
			return null;
		}
		return memberDao.selectMyLoanBook(cri, user);
	}

	@Override
	public int totalCountMyLoanBook(Criteria cri, MemberVO user) {
		if(cri == null) {
			cri = new Criteria();
		}
		if(user == null) {
			return 0;
		}
		return memberDao.selectTotalCountMyLoanBook(cri, user);
	}

	@Override
	public MemberVO getMemberByLoan(int bookNum) {
		return memberDao.selectMemberByLoan(bookNum);
	}
	
	public int addBlockDay(MemberVO member, int day) {
		if(member == null) {
			return 0;
		}
		if(member.getMe_mr_num() <= 1) {
			return 3;
		}
		
		if(member.getMe_block() == null) {
			//신규 정지일 생성
			memberDao.insertBlock(member.getMe_id(), day);
			return 1;
		} 
		else {
			LocalDate now = LocalDate.now();
			DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String formatedNow = now.format(format);
			if(member.getMe_block().compareTo(formatedNow) >= 0) {
				//기존값에 추가로 수정
				memberDao.updateBlock(member.getMe_id(), day);
				return 2;
			}
			else {
				//기존값 대신 신규 정지일 생성
				memberDao.insertBlock(member.getMe_id(), day);
				return 1;
			}
		}
	}

	@Override
	public void resetBlockToNull(String me_id) {
		memberDao.resetBlockToNull(me_id);
	}

	@Override
	public boolean sendMailPhone(String phone, String numStr) {
		if(phone == "") {
			return false;
		}
		String api_key = "NCSJAUZLM1DHEWEW";
	    String api_secret = "RM7CHJOAGAI3S9CBNC92JDBHOPO8LTFV";
	    Message coolsms = new Message(api_key, api_secret);
	    
	    
	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone);	// 수신전화번호
	    params.put("from", "01050602154");	// 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");	// 타입
	    params.put("text", "인증번호는" + "["+numStr+"]" + "입니다.");
	    params.put("app_version", "test app 1.2"); // application name and version
	
	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
		}
	    return true;
	}

	@Override
	public boolean checkMailPhone(String savedCode, String num) {
		if(savedCode == "" || num == "") {
			return false;
		}
		if(savedCode.equals(num)) {
			return true;
		}
		return false;
	}
	@Override
	public ArrayList<MemberVO> getMemberList(MemberCriteria cri) {
		if(cri == null) {
			cri = new MemberCriteria();
		}
		return memberDao.selectMemberList(cri);
	}

	@Override
	public int getTotalCountMember(MemberCriteria cri) {
		if(cri == null) {
			cri = new MemberCriteria();
		}
		return memberDao.totalCountMember(cri);

	}
	
}
