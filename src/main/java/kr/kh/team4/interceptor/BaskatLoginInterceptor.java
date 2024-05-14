package kr.kh.team4.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.team4.model.vo.member.MemberVO;

public class BaskatLoginInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(
		HttpServletRequest request, 
		HttpServletResponse response, 
		Object handler)
	    throws Exception {
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
	
		if(user==null) {
			request.getSession().setAttribute("chGuest","gues");
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}
		return true;
	}
}
