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

import kr.co.swings.service.SalesService;


@Controller
@RequestMapping(value = "sales")
public class SalesController {
	
	private static final Logger logger = LoggerFactory.getLogger(SalesController.class);
	
	@Autowired
	private SalesService salesService;
	
	/**
	 * 당일매출
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "salesToday.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView salesToday(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		salesService.todaySalesViewProcess(request);
		mav.setViewName("/sales/salesToday");
		return mav;
	}
	
	/**
	 * 일별 매출
	 * @param paramMap
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "salesDaily.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView salesDaily(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		salesService.dailyViewProcess(paramMap, request);
		mav.setViewName("/sales/salesDaily");
		return mav;
	}
	
	/**
	 * 엑셀 다운로드
	 * @param pagingVo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "excelDownload.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView excelDownload(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model) {
		ModelAndView mav = new ModelAndView("excelDownloadView");
		SXSSFWorkbook workbook = null;
		String workBookName = "당일매출엑셀";
		
		if("today".equals(String.valueOf(paramMap.get("salesType")))) {
			workbook = salesService.createTodaySalesExcelFile(request, paramMap);	
		} else if("daily".equals(String.valueOf(paramMap.get("salesType")))) {
			workbook = salesService.createDailySalesExcelFile(request, paramMap);
			workBookName = "일매출엑셀";
		} else if("monthly".equals(String.valueOf(paramMap.get("salesType")))) {
			workbook = salesService.createMonthlySalesExcelFile(request, paramMap);
			workBookName = "월매출엑셀";
		}
		
		model.addAttribute("workbookName", workBookName);
		model.addAttribute("workbook", workbook);
		return mav;
	}
	
	/**
	 * 월별 매출
	 * @param paramMap
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "salesMonthly.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView salesMonthly(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		salesService.monthlyViewProcess(paramMap, request);
		mav.setViewName("/sales/salesMonthly");
		return mav;
	}
	
	/**
	 * 결제내역관리
	 * @param paramMap
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "salesPay.view", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView salesPay(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		salesService.payViewProcess(paramMap, request);
		mav.setViewName("/sales/salesPay");
		return mav;
	}
	
	/**
	 * 결제내역 취소 && 직권취소 처리
	 * @param paramMap
	 * @return
	 */
	@RequestMapping(value = "salesPayCancel.json", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public JSONObject salesPayCancel(@RequestBody Map<String, Object> paramMap, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		logger.info("paramMap : " + paramMap.toString());
		result = salesService.salesPayCancel(paramMap, request);
		return result;
	}
}
