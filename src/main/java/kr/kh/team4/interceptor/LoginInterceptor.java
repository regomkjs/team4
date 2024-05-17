package kr.kh.team4.interceptor;

import java.net.URL;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.kh.team4.model.vo.member.MemberVO;
import kr.kh.team4.service.MemberService;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	MemberService memberService;
	
	@Override
	public void postHandle(
	    HttpServletRequest request, 
	    HttpServletResponse response, 
	    Object handler, 
	    ModelAndView modelAndView)
	    throws Exception {
		MemberVO user = (MemberVO)modelAndView.getModel().get("user");
		if(user != null) {
			request.getSession().setAttribute("user", user);
			//자동로그인을 체크했으면
			if(user.isAutoLogin()) {
				//쿠키를 생성
				String value = request.getSession().getId();
				Cookie cookie = new Cookie("loginCookie", value);
				cookie.setPath("/");
				//1주일
				int time = 7 * 24 * 60 * 60;//7일을 초로 환산
				cookie.setMaxAge(time);
				//화면에 전송
				response.addCookie(cookie);
				//DB에 관련 정보를 추가
				//세션 아이디와 만료시간
				user.setMe_cookie(value);
				Date date = new Date(System.currentTimeMillis()+ time*1000);
				user.setMe_cookie_limit(date);
				memberService.updateMemberCookie(user);
			}
			String url = (String)request.getSession().getAttribute("prevUrl");
			//되돌아갈 url이 있으면 해당 url로 돌아감
			if(url != null) {
				URL tmpUrl = new URL(url);
				String auth = tmpUrl.getAuthority();
				String contextPath = request.getContextPath();
				String tmp = auth + contextPath;
				int index = url.indexOf(tmp);
				url= url.substring(index).replace(tmp, "");
				// url = url.replaceFirst("/", "");
				modelAndView.getModel().put("url", url);
				// response.sendRedirect(url);
				request.getSession().removeAttribute("prevUrl");
			}
		}
	}
	
}
