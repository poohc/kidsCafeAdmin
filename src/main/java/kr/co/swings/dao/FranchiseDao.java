package kr.co.swings.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FranchiseDao {
	@Autowired
	private SqlSession sqlSession; 
	
	private final String NS = "kr.co.swings.franchise.";
	
	/**
	 * 매장정보 가져오기
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectFranchiseInfoList(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectFranchiseInfoList", param);
	}

	/**
	 * 매장정보 패스워드 업데이트
	 * @param param
	 * @return
	 */
	public int updateFranchisePw(Map<String, Object> param) {
		return sqlSession.update(NS + "updateFranchisePw", param);
	}
	
	/**
	 * SMS, 카카오톡 정산 정보 가져오기 (월별)
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectSmsSendStatByMonth(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectSmsSendStatByMonth", param);
	}
	
	/**
	 * SMS발송정보 가져오기
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectSmsSendList(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectSmsSendList", param);
	}
	
	/**
	 * 카카오알림톡 정산 정보 가져오기(월별)
	 * @param param
	 * @return
	 */
	public Map<String, Object> selectKakaoSendStatByMonth(Map<String, Object> param){
		return sqlSession.selectOne(NS + "selectKakaoSendStatByMonth", param);
	}
	
}