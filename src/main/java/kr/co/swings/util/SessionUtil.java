package kr.co.swings.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.swings.vo.FranchiseInfoVo;

public class SessionUtil {
	
	public static FranchiseInfoVo getFranchiseInfoVo(HttpServletRequest request) {
		HttpSession session = request.getSession();
		FranchiseInfoVo franchiseInfoVo = (FranchiseInfoVo) session.getAttribute("franchiseInfoVo");
		return franchiseInfoVo; 
	}
	
}
