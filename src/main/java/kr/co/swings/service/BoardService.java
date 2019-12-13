package kr.co.swings.service;

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
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.swings.constants.CommonConstants;
import kr.co.swings.dao.BoardDao;
import kr.co.swings.util.PagingUtil;
import kr.co.swings.util.SessionUtil;
import kr.co.swings.vo.FranchiseInfoVo;
import kr.co.swings.vo.PagingVo;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardService.class);
	
	/**
	 * 요청 게시판 View 처리
	 * @param pagingVo
	 * @param request
	 */
	public void requestBoardView(PagingVo pagingVo, HttpServletRequest request) {
		
		int totalCount = 0;
		int currentPage = 0;
		String pageSb = "";
		
		if(pagingVo.getCurrentPage() == 0) {
			pagingVo.setCurrentPage(1);
		}
		currentPage = pagingVo.getCurrentPage();
		totalCount = boardDao.selectRequestBoardCount();
		
		FranchiseInfoVo franchiseVo = SessionUtil.getFranchiseInfoVo(request);
		request.setAttribute("franchiseNum", franchiseVo.getFranchiseeNum());
		request.setAttribute("currentPage", currentPage);
		pagingVo.setFranchiseStatus(franchiseVo.getFranchiseeStatus());
		
		if(totalCount > 0) {
			pageSb = PagingUtil.createPaging(pagingVo, totalCount);
			List<Map<String, Object>> requestBoardList = boardDao.selectRequestBoardList(pagingVo);
			request.setAttribute("pagingTag", pageSb);
			request.setAttribute("requestBoardList", requestBoardList);			
		}
	}
	
	/**
	 * 요청 접수 팝업
	 * @param request
	 */
	public void requestReceptionPopup(HttpServletRequest request) {
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		request.setAttribute("receptionNo", boardDao.selectReceptionNo(param));
		request.setAttribute("localName", franchiseInfoVo.getLocalName());
		request.setAttribute("franchiseNum", franchiseInfoVo.getFranchiseeNum());
	}
	
	/**
	 * A/S 팝업 오픈
	 * @param request
	 */
	public void requestProcessingPopup(HttpServletRequest request) {
		FranchiseInfoVo franchiseInfoVo = SessionUtil.getFranchiseInfoVo(request);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("indexNo", ObjectUtils.toString(request.getParameter("indexNo"), ""));
		
		request.setAttribute("franchiseNum", franchiseInfoVo.getFranchiseeNum());
		request.setAttribute("requestBoardInfo", boardDao.selectRequestBoardInfo(param));
	}
	
	/**
	 * A/S 접수 INSERT
	 * @param paramMap
	 * @return
	 */
	public JSONObject requestReceptionWrite(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "A/S 접수에 실패했습니다.");
		
		if(boardDao.insertRequestBoard(paramMap) > 0) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "A/S 가 접수되었습니다.");
		}
		
		return result;
	}
	
	/**
	 * A/S 삭제처리
	 * @param paramMap
	 * @return
	 */
	public JSONObject requestReceptionDelete(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "A/S 삭제에 실패했습니다.");
		int deleteCnt = 0;
		int listCnt = 0;
		
		//하나만 지울 떄
		if(paramMap.get("selectChk") instanceof String) {
			listCnt = 1;
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("indexNo", String.valueOf(paramMap.get("selectChk")));
			if(boardDao.deleteRequestBoard(param) > 0) {
				deleteCnt++;
			}
		} else {
			List<String> selectChkArray = (List<String>) paramMap.get("selectChk");
			listCnt = selectChkArray.size();
			for(String selectChk : selectChkArray) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("indexNo", selectChk);
				if(boardDao.deleteRequestBoard(param) > 0) {
					deleteCnt++;
				}
			}
		}
		
		if(deleteCnt == listCnt) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "A/S 가 삭제 되었습니다.");
		}
		
		return result;
	}
	
	/**
	 * A/S 접수 처리
	 * @param paramMap
	 * @return
	 */
	public JSONObject requestProcessing(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "A/S 처리에 실패했습니다.");
		
		if(boardDao.updateRequestBoard(paramMap) > 0) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "A/S 가 처리되었습니다.");
		}
		
		return result;
	}
	
	/**
	 * 공지 게시판 View 처리
	 * @param pagingVo
	 * @param request
	 */
	public void noticeBoardView(PagingVo pagingVo, HttpServletRequest request) {
		
		int totalCount = 0;
		int currentPage = 0;
		String pageSb = "";
		
		if(pagingVo.getCurrentPage() == 0) {
			pagingVo.setCurrentPage(1);
		}
		currentPage = pagingVo.getCurrentPage();
		totalCount = boardDao.selectNoticeBoardCount();
		request.setAttribute("currentPage", currentPage);
		
		if(totalCount > 0) {
			pageSb = PagingUtil.createPaging(pagingVo, totalCount);
			List<Map<String, Object>> noticeBoardList = boardDao.selectNoticeBoardList(pagingVo);
			request.setAttribute("pagingTag", pageSb);
			request.setAttribute("noticeBoardList", noticeBoardList);			
		}
	}
	
	/**
	 * 공지사항 수정 처리
	 * @param request
	 */
	public void noticeUpdatePopup(HttpServletRequest request) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("noticeId", ObjectUtils.toString(request.getParameter("noticeId"), ""));
		request.setAttribute("noticeInfo", boardDao.selectNoticeBoardInfo(param));
		request.setAttribute("mode", "update");
	}
	
	/**
	 * 공지사항 INSERT
	 * @param paramMap
	 * @return
	 */
	public JSONObject noticeWrite(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "공지사항 등록에 실패했습니다.");
		
		if(boardDao.insertNoticeBoard(paramMap) > 0) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "공지사항이 등록 되었습니다.");
		}
		
		return result;
	}
	
	/**
	 * 공지사항 UPDATE
	 * @param paramMap
	 * @return
	 */
	public JSONObject noticeUpdate(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "공지사항 수정에 실패했습니다.");
		
		if(boardDao.updateNoticeBoard(paramMap) > 0) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "공지사항이 수정 되었습니다.");
		}
		
		return result;
	}
	
	/**
	 * 공지사항 삭제처리
	 * @param paramMap
	 * @return
	 */
	public JSONObject noticeDelete(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "공지사항 삭제에 실패했습니다.");
		int deleteCnt = 0;
		int listCnt = 0;
		
		//하나만 지울 떄
		if(paramMap.get("selectChk") instanceof String) {
			listCnt = 1;
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("noticeId", String.valueOf(paramMap.get("selectChk")));
			if(boardDao.deleteNoticeBoard(param) > 0) {
				deleteCnt++;
			}
		} else {
			List<String> selectChkArray = (List<String>) paramMap.get("selectChk");
			listCnt = selectChkArray.size();
			for(String selectChk : selectChkArray) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("noticeId", selectChk);
				if(boardDao.deleteNoticeBoard(param) > 0) {
					deleteCnt++;
				}
			}
		}
		
		if(deleteCnt == listCnt) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "공지사항이 삭제 되었습니다.");
		}
		
		return result;
	}
	
}