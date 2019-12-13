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

import kr.co.swings.service.MasterService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "master")
public class MasterController {
	
	private static final Logger logger = LoggerFactory.getLogger(MasterController.class);
	
	@Autowired
	private MasterService masterService;
	
	/**
	 * 입장권 관리
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "ticket.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView intro(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		masterService.ticketView(request);
		mav.setViewName("/master/ticket");
		return mav;
	}
	
	/**
	 * 입장권 추가
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "ticketInsert.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject ticketInsert(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = masterService.ticketInsert(paramMap);
		return result;
	}
	
	/**
	 * 입장권 삭제
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "ticketDelete.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject ticketDelete(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = masterService.ticketDelete(paramMap);
		return result;
	}
	
}