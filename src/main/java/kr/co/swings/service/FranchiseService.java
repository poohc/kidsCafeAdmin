package kr.co.swings.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.ObjectUtils;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.swings.constants.CommonConstants;
import kr.co.swings.dao.FranchiseDao;
import kr.co.swings.util.SessionUtil;
import kr.co.swings.vo.FranchiseInfoVo;

@Service
public class FranchiseService {
	
	@Autowired
	private FranchiseDao franchiseDao;
	
	private static final Logger logger = LoggerFactory.getLogger(FranchiseService.class);
	
	/**
	 * 매장정보 처리
	 * @param request
	 */
	public void franchiseInfo(HttpServletRequest request) {
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		param.put("franchiseStatus", franchiseInfoVo.getFranchiseeStatus());
		request.setAttribute("franchiseInfoList", franchiseDao.selectFranchiseInfoList(param));
	}
	
	/**
	 * 매장비밀번호 변경 팝업 노출
	 * @param request
	 */
	public void franchisePwPopup(HttpServletRequest request) {
		request.setAttribute("franchiseNum", request.getParameter("franchiseNum"));
	}
	
	/**
	 * 매장비밀번호 변경 처리
	 * @param paramMap
	 * @return
	 */
	public JSONObject changeFranchisePw(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "비밀번호 변경에 실패했습니다.");
		
		paramMap.put("franchiseStatus", "0");
		List<Map<String, Object>> franchiseInfoList = franchiseDao.selectFranchiseInfoList(paramMap);
		
		if(franchiseInfoList !=null && franchiseInfoList.size() > 0) {
			Map<String, Object> franchiseInfo = franchiseInfoList.get(0);
			
			String currentPw1 = ObjectUtils.toString(franchiseInfo.get("MasterPassword"), ""); 
			String currentPw2 = ObjectUtils.toString(paramMap.get("currentPw"), "");
			
			if(!currentPw1.equals(currentPw2)) {
				result.put("resultMessage", "현재 비밀번호가 불일치 합니다.");
			} else {
				if(franchiseDao.updateFranchisePw(paramMap) > 0) {
					result.put("resultCode", CommonConstants.RESULT_SUCCESS);
					result.put("resultMessage", "비밀번호가 변경되었습니다.");
				}
			}
		}
		
		return result;
	}
	
	/**
	 * 문자, 카카오톡 처리
	 * @param request
	 */
	public void smsCalculate(HttpServletRequest request) {
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		param.put("franchiseStatus", franchiseInfoVo.getFranchiseeStatus());
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		
		request.setAttribute("year", sdf.format(date).substring(0,4));
		request.setAttribute("month", sdf.format(date).substring(4,6));
		request.setAttribute("smsSendStatByMonth", franchiseDao.selectSmsSendStatByMonth(param));
		request.setAttribute("smsSendList", franchiseDao.selectSmsSendList(param));
	}
	
	/**
	 * 문자, 카카오톡 처리
	 * @param request
	 */
	public void kakaoCalculate(HttpServletRequest request) {
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		param.put("franchiseStatus", franchiseInfoVo.getFranchiseeStatus());
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		
		request.setAttribute("year", sdf.format(date).substring(0,4));
		request.setAttribute("month", sdf.format(date).substring(4,6));
		request.setAttribute("kakaoSendStatByMonth", franchiseDao.selectKakaoSendStatByMonth(param));
	}
}