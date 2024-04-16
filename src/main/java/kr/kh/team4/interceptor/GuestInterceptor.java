package kr.kh.team4.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.team4.model.vo.member.MemberVO;

public class GuestInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
	    throws Exception {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
	
		if(user != null) {
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		
		return true;
	}
}
