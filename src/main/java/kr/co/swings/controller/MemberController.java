package kr.co.swings.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.swings.service.MemberService;
import kr.co.swings.vo.PagingVo;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	/**
	 * 회원관리 화면
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "memberList.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView memberList(PagingVo pagingVo, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		pagingVo.setGroup("0");
		memberService.selectMemberList(pagingVo, request);
		mav.setViewName("/member/memberList");
		return mav;
	}
	
	/**
	 * 회원관리 화면
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "memberSearch.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView memberSearch(PagingVo pagingVo, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		pagingVo.setGroup("0");
		memberService.selectMemberList(pagingVo, request);
		mav.setViewName("/member/memberSearch");
		return mav;
	}
	
	/**
	 * 회원관리 화면
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "memberDetail.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView memberDetail(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		memberService.memberDetail(request);
		mav.setViewName("/member/memberDetail");
		return mav;
	}
	
	/**
	 * 단체 회원 리스트 
	 * @param pagingVo
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "groupMemberList.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView groupMemberList(PagingVo pagingVo, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		pagingVo.setGroup("1");
		memberService.selectMemberList(pagingVo, request);
		mav.setViewName("/member/groupMemberList");
		return mav;
	}
	
	/**
	 * 회원 업데이트 팝업 오픈
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "memberInfoUpdatePopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView memberInfoUpdatePopup(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		memberService.memberDetail(request);
		mav.setViewName("/member/memberUpdatePopup");
		return mav;
	}
	
	/**
	 * 회원 업데이트 팝업 오픈
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "memberPointUpdatePopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView memberPointUpdatePopup(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		memberService.memberDetail(request);
		mav.setViewName("/member/memberPointUpdatePopup");
		return mav;
	}
	
	/**
	 * SMS 전송 팝업 오픈
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "memberSmsSendPopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView memberSmsSendPopup(PagingVo pagingVo, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		memberService.selectMemberList(pagingVo, request);
		mav.setViewName("/member/memberSmsSendPopup");
		return mav;
	}
	
	/**
	 * 카카오 알림톡 전송 팝업 오픈
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "memberNoticeTalkSendPopup.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView memberNoticeTalkSendPopup(PagingVo pagingVo, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		memberService.selectMemberList(pagingVo, request);
		mav.setViewName("/member/memberNoticeTalkSendPopup");
		return mav;
	}
	
	/**
	 * 회원정보 업데이트
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "memberInfoUpdate.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject memberInfoUpdate(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = memberService.memberInfoUpdate(paramMap);
		return result;
	}
	
	/**
	 * 가족정보 업데이트
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "familyInfoUpdate.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject familyInfoUpdate(@RequestBody Map<String, Object> paramMap, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		logger.info("paramMap : " + paramMap.toString());
		result = memberService.familyInfoUpdate(paramMap, request);
		return result;
	}
	
	/**
	 * 가족 삭제 여부 판단
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "deleteMemberAvailable.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject deleteMemberAvailable(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = memberService.deleteMemberAvailable(paramMap);
		return result;
	}
	
	/**
	 * 포인트 정보 업데이트
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "pointInfoUpdate.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject pointInfoUpdate(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		result = memberService.pointInfoUpdate(paramMap, request);
		return result;
	}
	
	/**
	 * 새로운 회원정보 가져오기
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "getNewMemberInfo.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject getNewMemberInfo(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = memberService.getNewMemberInfo(paramMap);
		return result;
	}
	
	/**
	 * 회원탈퇴
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "memberSignOut.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject memberSignOutProcess(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = memberService.memberSignOutProcess(paramMap);
		return result;
	}
	
	/**
	 * SMS 전송건수 보관
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "insertSmsSendHistory.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject insertSmsSendHistory(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = memberService.insertSmsSendHistory(paramMap);
		return result;
	}
	
	/**
	 * 카카오톡 전송건수 보관
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "insertSendKakaoHistory.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject insertSendKakaoHistory(@RequestParam Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result = memberService.insertSendKakaoHistory(paramMap);
		return result;
	}
	
	/**
	 * 회원 엑셀다운로드 처리
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "excelDownload.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView excelDownload(PagingVo pagingVo, Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("excelDownloadView");
		pagingVo.setGroup("0");
		SXSSFWorkbook workbook = memberService.createMemberExcelList(pagingVo, request);
		model.addAttribute("workbookName", "회원리스트엑셀");
		model.addAttribute("workbook", workbook);
		return mav;
	}
	
	/**
	 * 검색회원 엑셀다운로드 처리
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "searchExcelDownload.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView searchExcelDownload(PagingVo pagingVo, Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("excelDownloadView");
		pagingVo.setGroup("0");
		SXSSFWorkbook workbook = memberService.createSearchMemberExcelList(pagingVo, request);
		model.addAttribute("workbookName", "검색회원리스트엑셀");
		model.addAttribute("workbook", workbook);
		return mav;
	}
	
	/**
	 * 단체회원 엑셀다운로드 처리
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "groupMemberExcelDownload.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView groupMemberExcelDownload(PagingVo pagingVo, Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("excelDownloadView");
		pagingVo.setGroup("1");
		SXSSFWorkbook workbook = memberService.createMemberExcelList(pagingVo, request);
		model.addAttribute("workbookName", "단체회원리스트엑셀");
		model.addAttribute("workbook", workbook);
		return mav;
	}
}