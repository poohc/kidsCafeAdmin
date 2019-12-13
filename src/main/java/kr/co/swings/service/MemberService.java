package kr.co.swings.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.swings.constants.CommonConstants;
import kr.co.swings.dao.MemberDao;
import kr.co.swings.util.ExcelUtil;
import kr.co.swings.util.PagingUtil;
import kr.co.swings.util.SessionUtil;
import kr.co.swings.vo.ExcelVo;
import kr.co.swings.vo.FranchiseInfoVo;
import kr.co.swings.vo.PagingVo;

@Service
public class MemberService {

	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ExcelUtil excelUtil;
	
	/**
	 * 회원 리스트 가져오기
	 * @param pagingVo
	 * @param request
	 */
	public void selectMemberList(PagingVo pagingVo, HttpServletRequest request) {
		
		int totalCount = 0;
		int currentPage = 0;
		String pageSb = "";
		
		if(pagingVo.getCurrentPage() == 0) {
			pagingVo.setCurrentPage(1);
		}
		currentPage = pagingVo.getCurrentPage();
		
		FranchiseInfoVo vo = SessionUtil.getFranchiseInfoVo(request);
		//어드민 계정이 아닌 가맹점주 계정일 경우 해당 가맹점 회원정보만 검색
		pagingVo.setFranchiseStatus(vo.getFranchiseeStatus());
		if(vo != null && "0".equals(vo.getFranchiseeStatus())) {
			pagingVo.setFranchiseNum(vo.getFranchiseeNum());	
		} else {
			if(pagingVo.getFranchiseNum() != null) {
				List<String> franchiseNumList = new ArrayList<String>();
				franchiseNumList = Arrays.asList(pagingVo.getFranchiseNum().split(","));
				pagingVo.setFranchiseNumList(franchiseNumList);
				request.setAttribute("franchiseNumList", pagingVo.getFranchiseNumList());
			}
		}
		
		logger.info("PAGINGVO : " + pagingVo.toString());
		
		totalCount = memberDao.selectMasterInfoCount(pagingVo);
		request.setAttribute("franchiseList", memberDao.selectFranchiseList());
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("selectedFrachiseNum", pagingVo.getFranchiseNum());
		request.setAttribute("searchKeyword", pagingVo.getSearchKeyword());
		request.setAttribute("searchMonth", pagingVo.getSearchMonth());
		
		if(totalCount > 0) {
			pageSb = PagingUtil.createPaging(pagingVo, totalCount);
			List<Map<String, Object>> memberList = memberDao.selectMasterInfoList(pagingVo);
			request.setAttribute("pagingTag", pageSb);
			request.setAttribute("memberList", memberList);			
		}		
	}
	
	/**
	 * 회원 정보 가져오기
	 * @param request
	 */
	public void memberDetail(HttpServletRequest request) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("mCode", String.valueOf(request.getParameter("mCode")));
		param.put("phone", String.valueOf(request.getParameter("phone")));
		request.setAttribute("franchiseList", memberDao.selectFranchiseList());
		request.setAttribute("memberInfo", memberDao.selectMemberInfo(param));
		request.setAttribute("familyInfo", memberDao.selectMemberFamilyInfo(param));
		request.setAttribute("visitInfo", memberDao.selectStoreVisitInfo(param));
		request.setAttribute("storeUseInfo", memberDao.selectStoreUseInfo(param));
		request.setAttribute("multiTicketList", memberDao.selectMultiTicketList(param));
		request.setAttribute("searchKeyword", StringUtils.defaultIfEmpty(request.getParameter("searchKeyword"), ""));
	}
	
	/**
	 * 회원 정보 업데이트
	 * @param paramMap
	 * @return
	 */
	public JSONObject memberInfoUpdate(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "회원정보 업데이트에 실패했습니다.");
		
		if(memberDao.updateMasterInfo(paramMap) > 0) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "회원정보를 업데이트 했습니다.");
		}
		
		return result;
	}
	
	/**
	 * 삭제 여부 판별
	 * @param paramMap
	 * @return
	 */
	public JSONObject deleteMemberAvailable(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "회원정보 불러오기에 실패했습니다. 관리자에게 문의하여 주세요.");
		
		Map<String, Object> resultMap = memberDao.deleteMemberAvailable(paramMap);
		
		if(resultMap != null) {
			if("0".equals(String.valueOf(resultMap.get("MFLAG")))) {
				result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			} else if("1".equals(String.valueOf(resultMap.get("MFLAG")))) {
				result.put("resultCode", CommonConstants.MEMBER_DELETE_NOT_AVAILABLE);
			}
		}
		
		return result;
	}
	
	/**
	 * 회원 정보 업데이트
	 * @param paramMap
	 * @return
	 */
	public JSONObject pointInfoUpdate(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "회원정보 업데이트에 실패했습니다.");
		
		if(memberDao.pointInfoUpdate(paramMap) > 0) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "회원정보를 업데이트 했습니다.");
		}
		
		return result;
	}
	
	/**
	 * 가족정보 업데이트
	 * @param paramMap
	 * @return
	 */
	public JSONObject familyInfoUpdate(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "가족정보 업데이트에 실패했습니다.");
		
		//가족 정보 삭제 처리 (mflag = '0' 인 정보만 삭제)
		paramMap.put("phone", paramMap.get("familyPhone"));
		paramMap.put("mflag","0");
		memberDao.deleteMemberInfo(paramMap);
		
		List<String> familyQrCodeArray = (List<String>) paramMap.get("familyQrCode");
		List<String> familyNameArray = (List<String>) paramMap.get("familyName");
		List<String> familyAdultArray = (List<String>) paramMap.get("familyAdult");
		List<String> familyMflagArray = (List<String>) paramMap.get("familyMflag");
		
		int insertCnt = 0;
		int mlfagCnt = 0;
		
		for(String tempMflag : familyMflagArray) {
			if("0".equals(tempMflag)) {
				mlfagCnt++;
			}
		}
		
		for(int i=0 ; i<familyQrCodeArray.size(); i++) {
			if("0".equals(familyMflagArray.get(i))) {
				Map<String, Object> memberParam = new HashMap<String, Object>();
				memberParam.put("MCode", paramMap.get("familyMcode"));
				memberParam.put("Phone", paramMap.get("familyPhone"));
				memberParam.put("Password", paramMap.get("familyPw"));
				memberParam.put("Name", familyNameArray.get(i));
	    		memberParam.put("QRCode", familyQrCodeArray.get(i));
	    		memberParam.put("Adult", familyAdultArray.get(i));
	    		memberParam.put("MFlag", "0");
	    		if(memberDao.insertMemberInfo(memberParam) > 0) {
	    			insertCnt++;
	    		}	
			}
		}
		
		if(insertCnt == mlfagCnt) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "가족정보가 업데이트 되었습니다.");
		}
		
		return result;
	}
	
	/**
	 * 새로운 회원정보 가져오기
	 * @param paramMap
	 * @return
	 */
	public JSONObject getNewMemberInfo(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_SUCCESS);
		
		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			result.put("qrCode", getQrCode(1)); 
			result.put("joinDate", sdf.format(date));
		} catch (Exception e) {
			result.put("resultCode", CommonConstants.RESULT_FAIL);
			result.put("resultMessage", "회원정보 업데이트에 실패했습니다.");
		}
		
		return result;
	}
	
	/**
	 * 회원 탈퇴 처리
	 * @param memberVo
	 * @param request
	 */
	public JSONObject memberSignOutProcess(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		
		if(memberDao.deleteMasterInfoByMemberOut(paramMap) > 0) {
			if(memberDao.deleteMemberInfo(paramMap) > 0) {
				memberDao.deleteMultiticketSalesUse(paramMap);
				result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			}
		}
		return result;
	}
	
	/**
	 * 회원 리스트 엑셀다운로드 처리
	 * @param pagingVo
	 * @return
	 */
	public SXSSFWorkbook createMemberExcelList(PagingVo pagingVo) {
		
		List<Map<String, Object>> memberList = memberDao.selectMasterInfoExcelList(pagingVo);
		SXSSFWorkbook workBook = new SXSSFWorkbook();
		
		if(memberList != null && memberList.size() > 0) {
			ExcelVo excelVo = new ExcelVo();
//			String[] columnNameArray = {"회원명", "고객번호", "가입일", "전화번호", "가족수", "가입매장", "최근방문일", "최근방문매장"};
//			String[] dbColumnNameArray = {"Name" , "MCode", "JoinDate", "Phone", "Num", "fName", "LastVisit", "lastVisitFname"};
			String[] columnNameArray = {"회원명", "가입일", "전화번호", "가족수", "가입매장", "최근방문일", "최근방문매장"};
			String[] dbColumnNameArray = {"Name", "JoinDate", "Phone", "Num", "fName", "LastVisit", "lastVisitFname"};
			//ColumnWidth 의 경우 글자수 만큼 표기
			int[] columnWidthArray = {5, 8, 11, 2, 20, 8, 20};
			excelVo.setSheetName("회원리스트");
			excelVo.setColumnNameArray(columnNameArray);
			excelVo.setColumnWidthArray(columnWidthArray);
			excelVo.setDbColumnNameArray(dbColumnNameArray);
			
			workBook = excelUtil.createExcelWorkbook(excelVo, memberList);
		}
		
		return workBook;
	}
	
	/**
	 * 회원 리스트 엑셀다운로드 처리
	 * @param pagingVo
	 * @return
	 */
	public SXSSFWorkbook createSearchMemberExcelList(PagingVo pagingVo) {
		
		List<Map<String, Object>> memberList = memberDao.selectSearchMasterInfoExcelList(pagingVo);
		SXSSFWorkbook workBook = new SXSSFWorkbook();
		
		if(memberList != null && memberList.size() > 0) {
			ExcelVo excelVo = new ExcelVo();
//			String[] columnNameArray = {"회원명", "고객번호", "가입일", "전화번호", "가족수", "가입매장", "최근방문일", "최근방문매장", "현재입장여부", "아동위탁동의"};
//			String[] dbColumnNameArray = {"Name" , "MCode", "JoinDate", "Phone", "Num", "fName", "LastVisit", "lastVisitFname", "EntFlag", "TermsFlag"};
			
			String[] columnNameArray = {"회원명", "가입일", "전화번호", "가족수", "가입매장", "최근방문일", "최근방문매장", "현재입장여부", "아동위탁동의"};
			String[] dbColumnNameArray = {"Name", "JoinDate", "Phone", "Num", "fName", "LastVisit", "lastVisitFname", "EntFlag", "TermsFlag"};
			//ColumnWidth 의 경우 글자수 만큼 표기
			int[] columnWidthArray = {5, 8, 11, 2, 20, 8, 20, 5, 5};
			excelVo.setSheetName("회원리스트");
			excelVo.setColumnNameArray(columnNameArray);
			excelVo.setColumnWidthArray(columnWidthArray);
			excelVo.setDbColumnNameArray(dbColumnNameArray);
			
			workBook = excelUtil.createExcelWorkbook(excelVo, memberList);
		}
		
		return workBook;
	}
	
	public String getQrCode(int n) {
        Date today = new Date();
        today.setSeconds(today.getSeconds() + n);
        return new SimpleDateFormat("yyyyMMddHHmmssSSSS").format(today);
    }
	
}