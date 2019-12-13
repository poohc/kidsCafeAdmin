package kr.co.swings.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MasterDao {
	@Autowired
	private SqlSession sqlSession; 
	
	private final String NS = "kr.co.swings.master.";
	
	/**
	 * 입장권 정보 가져오기
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectTicketList() {
		return sqlSession.selectList(NS + "selectTicketList");
	}
	
	/**
	 * 입장권 추가하기
	 * @param param
	 * @return
	 */
	public int insertTicket(Map<String, Object> param) {
		return sqlSession.delete(NS + "insertTicket", param);
	}
	
	/**
	 * 입장권 삭제하기
	 * @param param
	 * @return
	 */
	public int deleteTicket(Map<String, Object> param) {
		return sqlSession.delete(NS + "deleteTicket", param);
	}
	
}
