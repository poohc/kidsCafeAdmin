package kr.co.swings.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.swings.service.LoginService;
import kr.co.swings.util.SessionUtil;
import kr.co.swings.vo.FranchiseInfoVo;

@Controller
@RequestMapping(value = "login")
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService loginService;
	
	/**
	 * 로그인화면
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 * @throws ServletException 
	 */
	@RequestMapping(value = "login.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView();
		
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		
		if(franchiseInfoVo != null && franchiseInfoVo.getFaseName().length() > 0) {
			request.getRequestDispatcher("/main/dashboard.view").forward(request, response);
		}
		
		mav.setViewName("/login/login");
		return mav;
	}
	
	/**
	 * 로그인 처리
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "loginProcess.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject loginProcess(HttpServletRequest request, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		result = loginService.loginProcess(request);
		return result;
	}
	
	/**
	 * 로그아웃 처리
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "logoutProcess.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject logoutProcess(HttpServletRequest request, HttpServletResponse response) {
		JSONObject result = new JSONObject();
		result = loginService.logoutProcess(request);
		return result;
	}
	
}