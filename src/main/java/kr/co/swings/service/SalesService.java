package kr.co.swings.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.ObjectUtils;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.swings.constants.CommonConstants;
import kr.co.swings.dao.SalesDao;
import kr.co.swings.util.SessionUtil;
import kr.co.swings.vo.FranchiseInfoVo;

@Service
public class SalesService {
	
	@Autowired
	private SalesDao salesDao;
	
	private static final Logger logger = LoggerFactory.getLogger(SalesService.class);
	
	/**
	 * 당일매출 집계 처리
	 * @param request
	 */
	public void todaySalesViewProcess(HttpServletRequest request) {
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		Map<String, Object> param = new HashMap<String, Object>();
		
		String today = "";
		
		if(!"".equals(ObjectUtils.toString(request.getParameter("searchDate"), ""))) {
			param.put("today", ObjectUtils.toString(request.getParameter("searchDate"), "").replaceAll("-", ""));
			request.setAttribute("searchDate", ObjectUtils.toString(request.getParameter("searchDate"), ""));
			today = ObjectUtils.toString(request.getParameter("searchDate"), "").replaceAll("-", "");
		} else {
			param.put("today", sdf.format(date));
			today = sdf.format(date);
		}
		
		param.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		param.put("franchiseStatus", franchiseInfoVo.getFranchiseeStatus());
		
		request.setAttribute("salesInfo", salesDao.selectSalesInfo(param));
		request.setAttribute("pettyCashList", salesDao.selectPettyCash(param));
		request.setAttribute("exOffcioSaleList", salesDao.selectExOfficioSale(param));
		request.setAttribute("visitInfo", salesDao.selectVisitInfo(param));
		request.setAttribute("snsVisitInfo", salesDao.selectSnsVisitInfo(param));		
		request.setAttribute("multiTicketSalesInfo", salesDao.selectMultiTicketSalesInfo(param));		
		param.put("cancel", "N");
		request.setAttribute("casdSalesConfirmInfo", salesDao.selectCardSalesInfo(param));
		param.put("cancel", "Y");
		request.setAttribute("casdSalesCancelInfo", salesDao.selectCardSalesInfo(param));
		
		request.setAttribute("snackSalesList", salesDao.selectSnackSalesList(param));
		request.setAttribute("foodSalesList", salesDao.selectFoodSalesList(param));
		request.setAttribute("beverageSalesList", salesDao.selectBeverageSalesList(param));
		request.setAttribute("mdSalesList", salesDao.selectMdSalesList(param));
		
		request.setAttribute("exitSalesInfo", salesDao.selectExitSalesInfo(param));
		request.setAttribute("discountSalesInfo", salesDao.selectDiscountSalesInfo(param));
		request.setAttribute("multiTicketUseInfo", salesDao.selectMultiTicketUseInfo(param));
		request.setAttribute("groupEnterInfo", salesDao.selectGroupEnterInfo(param));
		request.setAttribute("notMembergroupEnterInfo", salesDao.selectNotMemberGroupEnterInfo(param));
		request.setAttribute("year",  today.substring(0, 4));
		request.setAttribute("month", today.substring(4, 6));
		request.setAttribute("date",  today.substring(6, 8));
		
	}
	
	/**
	 * 일매출 처리
	 * @param request
	 */
	public void dailyViewProcess(Map<String, Object> paramMap, HttpServletRequest request) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String yearMonth = sdf.format(date).substring(0, 6);
		
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		paramMap.put("franchiseStatus", franchiseInfoVo.getFranchiseeStatus());
		
		if("1".equals(franchiseInfoVo.getFranchiseeStatus())) {
			paramMap.put("selectFranchiseNum", ObjectUtils.toString(paramMap.get("selectFranchiseNum"), ""));
		} else {
			paramMap.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		}
		
		if("null".equals(String.valueOf(paramMap.get("searchYear"))) &&
				"null".equals(String.valueOf(paramMap.get("searchMonth")))) {
			paramMap.put("yyyymm", yearMonth);
		} else {
			yearMonth = ObjectUtils.toString(paramMap.get("searchYear")) + ObjectUtils.toString(paramMap.get("searchMonth"));
			paramMap.put("yyyymm", yearMonth);
		}
		
		DateTime dateTime = new DateTime(Integer.parseInt(yearMonth.substring(0,4)), Integer.parseInt(yearMonth.substring(4,6)), 1, 0, 0);
		
		//검색 년월이 현재 년월 보다 작을 경우
		if(Integer.parseInt(yearMonth) < Integer.parseInt(sdf.format(date).substring(0, 6))) {
			LocalDate maxiumDayInMonth = dateTime.toLocalDate().dayOfMonth().withMaximumValue();
			paramMap.put("startDate", yearMonth + "01");
			paramMap.put("endDate", yearMonth + maxiumDayInMonth.getDayOfMonth());
		} else {
			paramMap.put("startDate", yearMonth + "01");
			paramMap.put("endDate", yearMonth + sdf.format(date).substring(6,8));
		}
		
		List<Map<String, Object>> franchiseList = salesDao.selectFranchiseInfo(paramMap);
		String localName = "전지점";
		for(Map<String, Object> franchise : franchiseList) {
			if(ObjectUtils.toString(paramMap.get("selectFranchiseNum"), "").equals(ObjectUtils.toString(franchise.get("FranchiseeNum"), ""))) {
				localName = ObjectUtils.toString(franchise.get("LocalName"), "전지점");
			}
		}
		
		request.setAttribute("franchiseList", franchiseList);
		request.setAttribute("monthSalesInfo", salesDao.selectMonthSalesInfo(paramMap));
		request.setAttribute("monthSalesList", salesDao.selectMonthSalesListByDate(paramMap));
		
		//로그인 계정이 어드민일 경우만 매장 선택가능
		if("1".equals(franchiseInfoVo.getFranchiseeStatus())) {
			request.setAttribute("localName", localName);	
		} else {
			request.setAttribute("localName", franchiseInfoVo.getLocalName());
		}
		
		request.setAttribute("selectFranchiseNum", ObjectUtils.toString(paramMap.get("selectFranchiseNum"), ""));
		
		//검색 년월, Default 현재 년월
		request.setAttribute("searchYear", ObjectUtils.toString(paramMap.get("searchYear"), sdf.format(date).substring(0, 4)));
		request.setAttribute("searchMonth", ObjectUtils.toString(paramMap.get("searchMonth"), sdf.format(date).substring(4, 6)));
	}
	
	/**
	 * 년도별 월 매출 처리
	 * @param request
	 */
	public void monthlyViewProcess(Map<String, Object> paramMap, HttpServletRequest request) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String yearMonth = sdf.format(date).substring(0, 6);
		
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		paramMap.put("franchiseStatus", franchiseInfoVo.getFranchiseeStatus());
		
		if("1".equals(franchiseInfoVo.getFranchiseeStatus())) {
			paramMap.put("selectFranchiseNum", ObjectUtils.toString(paramMap.get("selectFranchiseNum"), ""));
		} else {
			paramMap.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		}
		
		if("null".equals(String.valueOf(paramMap.get("searchYear"))) &&
				"null".equals(String.valueOf(paramMap.get("searchMonth")))) {
			paramMap.put("yyyymm", yearMonth);
		} else {
			yearMonth = ObjectUtils.toString(paramMap.get("searchYear")) + ObjectUtils.toString(paramMap.get("searchMonth"));
			paramMap.put("yyyymm", yearMonth);
		}
		
		paramMap.put("startDate", yearMonth.substring(0,4) + "01");
		paramMap.put("endDate", yearMonth);
		
		List<Map<String, Object>> franchiseList = salesDao.selectFranchiseInfo(paramMap);
		String localName = "전지점";
		for(Map<String, Object> franchise : franchiseList) {
			if(ObjectUtils.toString(paramMap.get("selectFranchiseNum"), "").equals(ObjectUtils.toString(franchise.get("FranchiseeNum"), ""))) {
				localName = ObjectUtils.toString(franchise.get("LocalName"), "전지점");
			}
		}
		
		request.setAttribute("franchiseList", franchiseList);
		request.setAttribute("monthSalesInfo", salesDao.selectMonthSalesInfo(paramMap));
		request.setAttribute("monthSalesList", salesDao.selectMonthSalesListByMonth(paramMap));
		
		//로그인 계정이 어드민일 경우만 매장 선택가능
		if("1".equals(franchiseInfoVo.getFranchiseeStatus())) {
			request.setAttribute("localName", localName);	
		} else {
			request.setAttribute("localName", franchiseInfoVo.getLocalName());
		}
		request.setAttribute("selectFranchiseNum", ObjectUtils.toString(paramMap.get("selectFranchiseNum"), ""));
		
		//검색 년월, Default 현재 년월
		request.setAttribute("searchYear", ObjectUtils.toString(paramMap.get("searchYear"), sdf.format(date).substring(0, 4)));
		request.setAttribute("searchMonth", ObjectUtils.toString(paramMap.get("searchMonth"), sdf.format(date).substring(4, 6)));
	}
	
	/**
	 * 결제내역관리 처리
	 * @param request
	 */
	public void payViewProcess(Map<String, Object> paramMap, HttpServletRequest request) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		paramMap.put("franchiseStatus", franchiseInfoVo.getFranchiseeStatus());
		
		if("1".equals(franchiseInfoVo.getFranchiseeStatus())) {
			paramMap.put("franchiseNum", ObjectUtils.toString(paramMap.get("selectFranchiseNum"), ""));
			request.setAttribute("localName", ObjectUtils.toString(paramMap.get("localName"), "전지점"));
		} else {
			paramMap.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
			request.setAttribute("localName", franchiseInfoVo.getLocalName());
		}
		
		//검색일 없을 떄 기본 오늘 일자 설정
		String today = "";
		
		if("null".equals(String.valueOf(paramMap.get("searchDate")))) {
			paramMap.put("searchDate", sdf.format(date));
			today = sdf.format(date);
			request.setAttribute("searchDate", today.substring(0, 4) + "-" + today.substring(4, 6) + "-" + today.substring(6, 8));
		} else {
			request.setAttribute("searchDate", ObjectUtils.toString(paramMap.get("searchDate"), ""));
			today = String.valueOf(paramMap.get("searchDate")).replaceAll("-", "");
			paramMap.put("searchDate", String.valueOf(paramMap.get("searchDate")).replaceAll("-", ""));
		}
		
		request.setAttribute("year",  today.substring(0, 4));
		request.setAttribute("month", today.substring(4, 6));
		request.setAttribute("date",  today.substring(6, 8));
		
		if("null".equals(String.valueOf(paramMap.get("radioSearch")))) {
			paramMap.put("radioSearch", "confirm");
		} 
		logger.info("paramMap : " + paramMap.toString());
		request.setAttribute("franchiseList", salesDao.selectFranchiseInfo(paramMap));
		request.setAttribute("payList", salesDao.selectPayList(paramMap));
		request.setAttribute("selectFranchiseNum", ObjectUtils.toString(paramMap.get("selectFranchiseNum"), ""));
		request.setAttribute("searchKeyword", ObjectUtils.toString(paramMap.get("searchKeyword"), ""));
		request.setAttribute("radioSearch", ObjectUtils.toString(paramMap.get("radioSearch"), "confirm"));
		request.setAttribute("approvalNum", ObjectUtils.toString(paramMap.get("approvalNum"), ""));
	}
	
	/**
	 * 결제내역 취소, 직권취소 처리 (cancel = 1 : 취소, cancel = 2 : 직권취소)
	 * @param paramMap
	 * @return
	 */
	public JSONObject salesPayCancel(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "결제내역 취소에 실패했습니다.");
		int deleteCnt = 0;
		int listCnt = 0;
		
		//하나만 지울 떄
		if(paramMap.get("selectChk") instanceof String) {
			listCnt = 1;
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("cancel", String.valueOf(paramMap.get("cancel")));
			param.put("approvalNum", String.valueOf(paramMap.get("selectChk")));
			if(salesDao.updateCardOkDataInfo(param) > 0
					&& salesDao.updateGoodsSaleInfo(param) > 0
						&& salesDao.updatePaymentInfo(param) > 0) {
				deleteCnt++;
			}
		} else {
			List<String> selectChkArray = (List<String>) paramMap.get("selectChk");
			listCnt = selectChkArray.size();
			for(String selectChk : selectChkArray) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("cancel", String.valueOf(paramMap.get("cancel")));
				param.put("approvalNum", selectChk);
				if(salesDao.updateCardOkDataInfo(param) > 0
						&& salesDao.updateGoodsSaleInfo(param) > 0
							&& salesDao.updatePaymentInfo(param) > 0) {
					deleteCnt++;	
				}
			}
		}
		
		if(deleteCnt == listCnt) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "결제내역이 취소 되었습니다.");
		}
		
		return result;
	}
	
	public SXSSFWorkbook createDailySalesExcelFile(HttpServletRequest request, Map<String, Object> paramMap) {
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String yearMonth = sdf.format(date).substring(0, 6);
		
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		paramMap.put("franchiseStatus", franchiseInfoVo.getFranchiseeStatus());
		
		if("1".equals(franchiseInfoVo.getFranchiseeStatus())) {
			paramMap.put("selectFranchiseNum", ObjectUtils.toString(paramMap.get("selectFranchiseNum"), ""));
		} else {
			paramMap.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		}
		
		if("null".equals(String.valueOf(paramMap.get("searchYear"))) &&
				"null".equals(String.valueOf(paramMap.get("searchMonth")))) {
			paramMap.put("yyyymm", yearMonth);
		} else {
			yearMonth = ObjectUtils.toString(paramMap.get("searchYear")) + ObjectUtils.toString(paramMap.get("searchMonth"));
			paramMap.put("yyyymm", yearMonth);
		}
		
		DateTime dateTime = new DateTime(Integer.parseInt(yearMonth.substring(0,4)), Integer.parseInt(yearMonth.substring(4,6)), 1, 0, 0);
		
		//검색 년월이 현재 년월 보다 작을 경우
		if(Integer.parseInt(yearMonth) < Integer.parseInt(sdf.format(date).substring(0, 6))) {
			LocalDate maxiumDayInMonth = dateTime.toLocalDate().dayOfMonth().withMaximumValue();
			paramMap.put("startDate", yearMonth + "01");
			paramMap.put("endDate", yearMonth + maxiumDayInMonth.getDayOfMonth());
		} else {
			paramMap.put("startDate", yearMonth + "01");
			paramMap.put("endDate", yearMonth + sdf.format(date).substring(6,8));
		}
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		String sheetName = "일매출";
		
		SXSSFSheet sheet = workbook.createSheet(sheetName);
		
		Row row = null;
        Cell cell = null;
		
        sheet.setColumnWidth(0, 9000);
        sheet.setColumnWidth(1, 9000);
        sheet.setColumnWidth(2, 9000);
        sheet.setColumnWidth(3, 9000);
        sheet.setColumnWidth(4, 9000);
        sheet.setColumnWidth(5, 9000);
        sheet.setColumnWidth(6, 9000);
        sheet.setColumnWidth(7, 9000);
        sheet.setColumnWidth(8, 9000);
        
        //엑셀 스타일 설정
        Font headerFont = workbook.createFont();
        headerFont.setFontName("나눔고딕");
        headerFont.setFontHeight((short)300);
        headerFont.setColor(IndexedColors.BLACK.getIndex());
        headerFont.setBold(true);
            
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setAlignment(HorizontalAlignment.LEFT);
        headerStyle.setVerticalAlignment(VerticalAlignment.BOTTOM);
        headerStyle.setBorderLeft(BorderStyle.DASH_DOT);
        headerStyle.setBorderBottom(BorderStyle.MEDIUM);
        headerStyle.setBorderRight(BorderStyle.MEDIUM_DASH_DOT);
        headerStyle.setFont(headerFont);
            
        CellStyle bodyStyle = workbook.createCellStyle();
        bodyStyle.setAlignment(HorizontalAlignment.CENTER);
        bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        bodyStyle.setBorderTop(BorderStyle.THIN);
        bodyStyle.setBorderBottom(BorderStyle.THIN);
        bodyStyle.setBorderLeft(BorderStyle.THIN);
        bodyStyle.setBorderRight(BorderStyle.THIN);
        XSSFDataFormat format = (XSSFDataFormat) workbook.createDataFormat();
        bodyStyle.setDataFormat(format.getFormat("#,##0"));
        
		row = sheet.createRow(0);
		
		//데이터 설정
		String localName = ObjectUtils.toString(paramMap.get("localName"), "전지점");
		String searchYear = ObjectUtils.toString(paramMap.get("searchYear"), sdf.format(date).substring(0, 4));
		String searchMonth = ObjectUtils.toString(paramMap.get("searchMonth"), sdf.format(date).substring(4, 6));
		
		List<Map<String, Object>> monthSalesInfo = salesDao.selectMonthSalesInfo(paramMap);
		List<Map<String, Object>> monthSalesList = salesDao.selectMonthSalesListByDate(paramMap);
		
		cell = row.createCell(0);
		cell.setCellStyle(headerStyle);
		cell.setCellValue(searchYear + "년 " + searchMonth + "월 " + localName + " 매출");
		
		row = sheet.createRow(1);
		
		String[] headTitleArray = {"지점", "소셜매출", "F&B", "MD상품", "신용카드", "현금", "입장객 수", "매출합계(소셜매출+신용카드+현금)"};  
		String[] headTitleDbArray = {"LOCAL_NAME", "ENTERENCE_FEE_SUM", "FANDB_FEE_SUM", "MD_FEE_SUM", "CREDIT_CARD_SUM", "CASH_SUM", "ENTERENCE_COUNT_SUM", "TOTAL_SUM"};
		
		for(int i=0 ; i<headTitleArray.length; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(headTitleArray[i]);
		}
		
		for(int i=0 ; i<monthSalesInfo.size(); i++) {
			row = sheet.createRow(i + 2);
			for(int j=0; j < headTitleArray.length; j++) {
				cell = row.createCell(j);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(ObjectUtils.toString(monthSalesInfo.get(i).get(headTitleDbArray[j]), ""));
			}
		}
		
		row = sheet.createRow(3 + monthSalesInfo.size());
		cell = row.createCell(0);
		cell.setCellValue(searchYear + "년 " + searchMonth + "월 " + localName + " 일별 매출");
		cell.setCellStyle(headerStyle);
		
		row = sheet.createRow(4 + monthSalesInfo.size());
				
		String[] bodyTitleArray = {"날짜", "지점", "소셜매출", "F&B", "MD상품", "신용카드", "현금", "입장객 수", "매출합계(소셜매출+신용카드+현금)"};  
		String[] bodyTitleDbArray = {"YYYYMMDD", "LOCAL_NAME", "ENTERENCE_FEE_SUM", "FANDB_FEE_SUM", "MD_FEE_SUM", "CREDIT_CARD_SUM", "CASH_SUM", "ENTERENCE_COUNT_SUM", "TOTAL_SUM"};
		
		for(int i=0 ; i<bodyTitleArray.length; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(bodyTitleArray[i]);
		}
		
		for(int i=0 ; i<monthSalesList.size(); i++) {
			row = sheet.createRow(5 + monthSalesInfo.size() + i);
			for(int j=0; j < bodyTitleArray.length; j++) {
				cell = row.createCell(j);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(ObjectUtils.toString(monthSalesList.get(i).get(bodyTitleDbArray[j]), ""));
			}
		}
		
		return workbook;
	}
	
	public SXSSFWorkbook createMonthlySalesExcelFile(HttpServletRequest request, Map<String, Object> paramMap) {
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String yearMonth = sdf.format(date).substring(0, 6);
		
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		paramMap.put("franchiseStatus", franchiseInfoVo.getFranchiseeStatus());
		
		if("1".equals(franchiseInfoVo.getFranchiseeStatus())) {
			paramMap.put("selectFranchiseNum", ObjectUtils.toString(paramMap.get("selectFranchiseNum"), ""));
		} else {
			paramMap.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		}
		
		if("null".equals(String.valueOf(paramMap.get("searchYear"))) &&
				"null".equals(String.valueOf(paramMap.get("searchMonth")))) {
			paramMap.put("yyyymm", yearMonth);
		} else {
			yearMonth = ObjectUtils.toString(paramMap.get("searchYear")) + ObjectUtils.toString(paramMap.get("searchMonth"));
			paramMap.put("yyyymm", yearMonth);
		}
		
		paramMap.put("startDate", yearMonth.substring(0,4) + "01");
		paramMap.put("endDate", yearMonth);
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		String sheetName = "월매출";
		
		SXSSFSheet sheet = workbook.createSheet(sheetName);
		
		Row row = null;
        Cell cell = null;
		
        sheet.setColumnWidth(0, 9000);
        sheet.setColumnWidth(1, 9000);
        sheet.setColumnWidth(2, 9000);
        sheet.setColumnWidth(3, 9000);
        sheet.setColumnWidth(4, 9000);
        sheet.setColumnWidth(5, 9000);
        sheet.setColumnWidth(6, 9000);
        sheet.setColumnWidth(7, 9000);
        sheet.setColumnWidth(8, 9000);
        
        //엑셀 스타일 설정
        Font headerFont = workbook.createFont();
        headerFont.setFontName("나눔고딕");
        headerFont.setFontHeight((short)300);
        headerFont.setColor(IndexedColors.BLACK.getIndex());
        headerFont.setBold(true);
            
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setAlignment(HorizontalAlignment.LEFT);
        headerStyle.setVerticalAlignment(VerticalAlignment.BOTTOM);
        headerStyle.setBorderLeft(BorderStyle.DASH_DOT);
        headerStyle.setBorderBottom(BorderStyle.MEDIUM);
        headerStyle.setBorderRight(BorderStyle.MEDIUM_DASH_DOT);
        headerStyle.setFont(headerFont);
            
        CellStyle bodyStyle = workbook.createCellStyle();
        bodyStyle.setAlignment(HorizontalAlignment.CENTER);
        bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        bodyStyle.setBorderTop(BorderStyle.THIN);
        bodyStyle.setBorderBottom(BorderStyle.THIN);
        bodyStyle.setBorderLeft(BorderStyle.THIN);
        bodyStyle.setBorderRight(BorderStyle.THIN);
        XSSFDataFormat format = (XSSFDataFormat) workbook.createDataFormat();
        bodyStyle.setDataFormat(format.getFormat("#,##0"));
        
		row = sheet.createRow(0);
		
		//데이터 설정
		String localName = ObjectUtils.toString(paramMap.get("localName"), "전지점");
		String searchYear = ObjectUtils.toString(paramMap.get("searchYear"), sdf.format(date).substring(0, 4));
		String searchMonth = ObjectUtils.toString(paramMap.get("searchMonth"), sdf.format(date).substring(4, 6));
		
		List<Map<String, Object>> monthSalesInfo = salesDao.selectMonthSalesInfo(paramMap);
		List<Map<String, Object>> monthSalesList = salesDao.selectMonthSalesListByMonth(paramMap);
		
		cell = row.createCell(0);
		cell.setCellStyle(headerStyle);
		cell.setCellValue(searchYear + "년 " + searchMonth + "월 " + localName + " 매출");
		
		row = sheet.createRow(1);
		String[] headTitleArray = {"지점", "소셜매출", "F&B", "MD상품", "신용카드", "현금", "입장객 수", "매출합계(소셜매출+신용카드+현금)"};  
		String[] headTitleDbArray = {"LOCAL_NAME", "ENTERENCE_FEE_SUM", "FANDB_FEE_SUM", "MD_FEE_SUM", "CREDIT_CARD_SUM", "CASH_SUM", "ENTERENCE_COUNT_SUM", "TOTAL_SUM"};
		
		for(int i=0 ; i<headTitleArray.length; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(headTitleArray[i]);
		}
		
		for(int i=0 ; i<monthSalesInfo.size(); i++) {
			row = sheet.createRow(i + 2);
			for(int j=0; j < headTitleArray.length; j++) {
				cell = row.createCell(j);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(ObjectUtils.toString(monthSalesInfo.get(i).get(headTitleDbArray[j]), ""));
			}
		}
		
		row = sheet.createRow(3 + monthSalesInfo.size());
		cell = row.createCell(0);
		cell.setCellValue(searchYear + "년 " + localName + " 월별 매출");
		cell.setCellStyle(headerStyle);
		
		row = sheet.createRow(4 + monthSalesInfo.size());
				
		String[] bodyTitleArray = {"월", "지점", "소셜매출", "F&B", "MD상품", "신용카드", "현금", "입장객 수", "매출합계(소셜매출+신용카드+현금)"};  
		String[] bodyTitleDbArray = {"YYYYMM", "LOCAL_NAME", "ENTERENCE_FEE_SUM", "FANDB_FEE_SUM", "MD_FEE_SUM", "CREDIT_CARD_SUM", "CASH_SUM", "ENTERENCE_COUNT_SUM", "TOTAL_SUM"};
		
		for(int i=0 ; i<bodyTitleArray.length; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(bodyTitleArray[i]);
		}
		
		for(int i=0 ; i<monthSalesList.size(); i++) {
			row = sheet.createRow(5 + monthSalesInfo.size() + i);
			for(int j=0; j < bodyTitleArray.length; j++) {
				cell = row.createCell(j);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(ObjectUtils.toString(monthSalesList.get(i).get(bodyTitleDbArray[j]), ""));
			}
		}
		
		return workbook;
	}
}
