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
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}
		String url = (String)request.getSession().getAttribute("prevUrl");
		//되돌아갈 url이 있으면 해당 url로 돌아감
		if(url != null) {
			response.sendRedirect(url);
			request.getSession().removeAttribute("prevUrl");
		}
		return true;
	}
}
