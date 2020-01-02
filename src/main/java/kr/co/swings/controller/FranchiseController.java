package kr.co.swings.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.swings.service.FranchiseService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "franchise")
public class FranchiseController {
	
	private static final Logger logger = LoggerFactory.getLogger(FranchiseController.class);
	
	@Autowired
	private FranchiseService franchiseService;
	
	/**
	 * 매장현황
	 * @param pagingVo
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "franchiseInfo.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView franchiseInfo(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();		
		mav.setViewName("/franchise/franchiseInfo");
		franchiseService.franchiseInfo(request);
		return mav;
	}
	
	/**
	 * 매장 비밀번호 변경 팝업
	 * @param pagingVo
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "franchisePwChangePopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView franchisePwChangePopup(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();		
		mav.setViewName("/franchise/franchisePwChangePopup");
		franchiseService.franchisePwPopup(request);
		return mav;
	}
	
	/**
	 * 매장 비밀번호 변경처리
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "changeFranchisePw.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject changeFranchisePw(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = franchiseService.changeFranchisePw(paramMap);
		return result;
	}
	
	/**
	 * 문자발송정산
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "smsCalculate.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView smsCalculate(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();		
		mav.setViewName("/franchise/smsCalculate");
		franchiseService.smsCalculate(request);
		return mav;
	}
	
	/**
	 * 문자발송정산
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "kakaoCalculate.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView kakaoCalculate(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();		
		mav.setViewName("/franchise/kakaoCalculate");
		franchiseService.kakaoCalculate(request);
		return mav;
	}
}