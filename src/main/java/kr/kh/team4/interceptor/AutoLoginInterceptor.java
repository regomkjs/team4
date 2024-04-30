package kr.kh.team4.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.service.MemberService;

public class AutoLoginInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	MemberService memberService;
	
	
	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
	    throws Exception {
		
		MemberVO user= (MemberVO) request.getSession().getAttribute("user");
		//로그인이 안되어 있다면 자동 로그인 체크를 해야함
		if(user == null) {
			//loginCookie 정보를 가져옴
			Cookie cookie = WebUtils.getCookie(request, "loginCookie");
			//쿠키가 있으면 자동 로그인을 진행
			if(cookie != null) {
				String sessionId = cookie.getValue();
				user = memberService.getMemberByCookie(sessionId);
				if(user != null) {
					request.getSession().setAttribute("user", user);
				}
			}
		}
		
		return true;
	}
	
	
	
}
