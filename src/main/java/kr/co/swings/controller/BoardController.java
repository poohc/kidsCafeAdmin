package kr.co.swings.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.swings.service.BoardService;
import kr.co.swings.vo.PagingVo;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "board")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	BoardService boardService;
	
	/**
	 * 요청게시판
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "requestBoard.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView requestBoard(PagingVo pagingVo, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		boardService.requestBoardView(pagingVo, request);
		mav.setViewName("/board/requestBoardList");
		return mav;
	}
	
	/**
	 * A/S 접수 팝업 오픈
	 * @param pagingVo
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "requestReceptionPopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView requestReceptionPopup(PagingVo pagingVo, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		boardService.requestReceptionPopup(request);
		mav.setViewName("/board/requestReceptionPopup");
		return mav;
	}
	
	/**
	 * A/S 추가
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "requestReceptionWrite.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject requestReceptionWrite(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = boardService.requestReceptionWrite(paramMap);
		return result;
	}
	
	/**
	 * A/S 삭제
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "requestReceptionDelete.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject requestReceptionDelete(@RequestBody Map<String, Object> paramMap, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		logger.info("paramMap : " + paramMap.toString());
		result = boardService.requestReceptionDelete(paramMap, request);
		return result;
	}
	
	/**
	 * A/S 처리 팝업 오픈
	 * @param pagingVo
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "requestProcessingPopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView requestProcessingPopup(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		boardService.requestProcessingPopup(request);
		mav.setViewName("/board/requestProcessingPopup");
		return mav;
	}
	
	/**
	 * A/S 처리
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "requestProcessing.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject requestProcessing(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = boardService.requestProcessing(paramMap);
		return result;
	}
	
	/**
	 * 공지사항게시판
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "noticeBoard.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView noticeBoard(PagingVo pagingVo, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		boardService.noticeBoardView(pagingVo, request);
		mav.setViewName("/board/noticeBoardList");
		return mav;
	}
	
	/**
	 * 공지 쓰기 팝업 오픈
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "noticeWritePopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView noticeWritePopup(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("mode", "insert");
		mav.setViewName("/board/noticeWritePopup");
		return mav;
	}
	
	/**
	 * 공지 수정 팝업 오픈
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "noticeUpdatePopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView noticeUpdatePopup(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		boardService.noticeUpdatePopup(request);
		mav.setViewName("/board/noticeWritePopup");
		return mav;
	}
	
	/**
	 * 공지사항 INSERT
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "noticeWrite.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject noticeWrite(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = boardService.noticeWrite(paramMap);
		return result;
	}
	
	/**
	 * 공지사항 UPDATE
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "noticeUpdate.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject noticeUpdate(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = boardService.noticeUpdate(paramMap);
		return result;
	}
	
	/**
	 * 공지사항 삭제
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "noticeDelete.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject noticeDelete(@RequestBody Map<String, Object> paramMap, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		logger.info("paramMap : " + paramMap.toString());
		result = boardService.noticeDelete(paramMap, request);
		return result;
	}
	
}