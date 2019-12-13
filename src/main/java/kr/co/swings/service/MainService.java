package kr.co.swings.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.swings.dao.BoardDao;
import kr.co.swings.dao.MainDao;
import kr.co.swings.dao.SalesDao;
import kr.co.swings.util.SessionUtil;
import kr.co.swings.vo.FranchiseInfoVo;

@Service
public class MainService {
	
	@Autowired
	private MainDao mainDao;
	
	@Autowired
	private SalesDao salesDao;
	
	@Autowired
	private BoardDao boardDao;
	
	private static final Logger logger = LoggerFactory.getLogger(MainService.class);
	
	public void dashBoardView(HttpServletRequest request) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("today", sdf.format(date));
		param.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		param.put("franchiseStatus", franchiseInfoVo.getFranchiseeStatus());
		
		request.setAttribute("dashBoardViewInfo", mainDao.selectDashboardViewInfo(param)); 
		request.setAttribute("salesInfo", salesDao.selectSalesInfo(param));
		request.setAttribute("today", sdf.format(date));
		request.setAttribute("requestList", boardDao.selectRequestBoardListLimitTen(param));
		request.setAttribute("noticeList", boardDao.selectNoticeBoardListLimitTen());
	}
	
}
