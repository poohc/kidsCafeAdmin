package kr.co.swings.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.swings.constants.CommonConstants;
import kr.co.swings.dao.LoginDao;
import kr.co.swings.vo.FranchiseInfoVo;

@Service
public class LoginService {
	
	@Autowired
	private LoginDao loginDao;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginService.class);
	
	/**
	 * 로그인 처리
	 * @param memberVo
	 * @param request
	 * @return
	 */
	public JSONObject loginProcess(HttpServletRequest request) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "로그인에 실패했습니다.");
		HttpSession session = request.getSession();
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("franchiseeNum", String.valueOf(request.getParameter("fid")));
		param.put("masterPassword", String.valueOf(request.getParameter("password")));
		
		FranchiseInfoVo loginInfo = loginDao.selectLoginInfo(param);
		
		if(loginInfo != null && loginInfo.getFranchiseeNum().length() > 0) {
			
			// 기존 세션정보 있다면 삭제
			if (session.getAttribute("franchiseInfoVo") != null ){
				session.removeAttribute("franchiseInfoVo");
	        } 
			//MasterInfo 테이블의 존재할 경우 세션 설정
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "로그인에 성공했습니다.");
			session.setAttribute("franchiseInfoVo", loginInfo);
		} else {
			result.put("resultMessage", "없는 정보입니다.");
		}
		
		return result;
	}
	
	/**
	 * 로그아웃 처리
	 * @param request
	 * @return
	 */
	public JSONObject logoutProcess(HttpServletRequest request) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_SUCCESS);
		HttpSession session = request.getSession();
		try {
			session.invalidate();
		} catch (Exception e) {
			result.put("resultCode", CommonConstants.RESULT_FAIL);
			logger.error("로그아웃 에러 : " + e);
		}
		
		return result;
		
	}
	
}
