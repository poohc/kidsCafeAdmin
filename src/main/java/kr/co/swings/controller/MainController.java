package kr.co.swings.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.swings.service.MainService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "main")
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private MainService mainService;
	
	/**
	 * 현황판
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "dashboard.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView intro(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mainService.dashBoardView(request);
		mav.setViewName("/main/dashboard");
		return mav;
	}
	
	/**
	 * 로그인이 필요한 메뉴 접근 시 인터셉터에서 이동할 페이지
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "needLogin.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView needLogin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/main/needLogin");
		return mav;
	}
	
}