package kr.co.swings.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MainDao {
	@Autowired
	private SqlSession sqlSession; 
	
	private final String NS = "kr.co.swings.main.";
	
	/**
	 * 대쉬보드 표츌 정보 가져오기
	 * @param param
	 * @return
	 */
	public Map<String, Object> selectDashboardViewInfo(Map<String, Object> param) {
		return sqlSession.selectOne(NS + "selectDashboardViewInfo", param);
	}
	
	/**
	 * 월별 매출액 그래프 데이터(1년 기준)
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectYearSalesInfoByMonth(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectYearSalesInfoByMonth", param);
	}
	
	/**
	 * 월별 방문객 그래프 데이터(1년 기준)
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectYearVisitInfoByMonth(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectYearVisitInfoByMonth", param);
	}
}
