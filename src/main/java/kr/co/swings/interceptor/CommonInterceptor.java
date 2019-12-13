package kr.co.swings.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CommonInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(CommonInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		String requestUri = request.getRequestURI();
		logger.info("===========================          START         ===========================");
		logger.info(" Request URI \t:  " + requestUri);

		Enumeration<String> paramNames = request.getParameterNames();
		while (paramNames.hasMoreElements()) {
			String key = (String) paramNames.nextElement();
			String value = request.getParameter(key);
			logger.debug(" RequestParameter Data ==>  " + key + " : " + value + "");
		}
		
		//로그인이 필요한 메뉴 접근 시 세션 체크
		if(requestUri.indexOf("/member/myInfo.view") > -1 || 
				requestUri.indexOf("/member/passwordChange.json") > -1 || 
					requestUri.indexOf("/member/pointAndStoreInfo.view") > -1 || 
						requestUri.indexOf("/member/memberOut.view") > -1) {
			HttpSession session = request.getSession();
			if(session.getAttribute("masterInfoVo") == null) {
				logger.info("로그인 세션 없음!!");
				response.sendRedirect("/main/needLogin.view");
				return false;
			}
		}
		
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		logger.info("===========================          END           ===========================");
	}
}
