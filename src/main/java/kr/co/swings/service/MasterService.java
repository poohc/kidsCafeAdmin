package kr.co.swings.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.swings.constants.CommonConstants;
import kr.co.swings.dao.MasterDao;

@Service
public class MasterService {
	
	@Autowired
	private MasterDao masterDao;
	
	private static final Logger logger = LoggerFactory.getLogger(MasterService.class);
	
	/**
	 * 입장권 리스트 설정
	 * @param request
	 */
	public void ticketView(HttpServletRequest request) {
		request.setAttribute("ticketList", masterDao.selectTicketList()); 
	}
	
	/**
	 * 입장권 추가
	 * @param paramMap
	 * @return
	 */
	public JSONObject ticketInsert(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "입장권 추가에 실패했습니다.");
		
		if(masterDao.insertTicket(paramMap) > 0) {
			result.put("resultCode", CommonConstants.RESULT_SUCCESS);
			result.put("resultMessage", "입장권을 추가했습니다.");
		}		
		return result;
	}
	
	/**
	 * 입장권 삭제
	 * @param paramMap
	 * @return
	 */
	public JSONObject ticketDelete(Map<String, Object> paramMap) {
		JSONObject result = new JSONObject();
		result.put("resultCode", CommonConstants.RESULT_FAIL);
		result.put("resultMessage", "입장권 삭제에 실패했습니다.");
		
		List<String> deleteTicketNameList = (List<String>) paramMap.get("deleteTicketName");
		List<String> deleteTicketPriceList = (List<String>) paramMap.get("deleteTicketPrice");
		List<String> deleteTicketPlayTimeList = (List<String>) paramMap.get("deleteTicketPlayTime");
		
		
		if(deleteTicketNameList != null && deleteTicketNameList.size() > 0) {
			
			int cnt = deleteTicketNameList.size();
			int tempCnt = 0;
			
			for(int i=0 ; i<deleteTicketNameList.size(); i++) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("ticketName", deleteTicketNameList.get(i));
				param.put("ticketPrice", deleteTicketPriceList.get(i));
				param.put("ticketPlayTime", deleteTicketPlayTimeList.get(i));
				
				if(masterDao.deleteTicket(param) > 0) {
					tempCnt++;
				}
			}	
			
			if(cnt == tempCnt) {
				result.put("resultCode", CommonConstants.RESULT_SUCCESS);
				result.put("resultMessage", "입장권을 삭제했습니다.");
			}
		} 	
		return result;
	}
	
}
