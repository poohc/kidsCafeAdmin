package kr.co.swings.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SalesDao {
	@Autowired
	private SqlSession sqlSession; 
	
	private final String NS = "kr.co.swings.sales.";
	
	/**
	 * 당일매출 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectSalesInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectSalesInfo", param);
	}
	
	/**
	 * 시제금 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectPettyCash(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectPettyCash", param);
	}
	
	/**
	 * 집권할인 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectExOfficioSale(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectExOfficioSale", param);
	}	
	
	/**
	 * 당일방문 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectVisitInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectVisitInfo", param);
	}
	
	/**
	 * 당일소셜방문 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectSnsVisitInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectSnsVisitInfo", param);
	}
	
	/**
	 * 당일 다회권 판매 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectMultiTicketSalesInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectMultiTicketSalesInfo", param);
	}
	
	/**
	 * 당일 카드 판매 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectCardSalesInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectCardSalesInfo", param);
	}
	
	/**
	 * 스낵 판매 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectSnackSalesList(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectSnackSalesList", param);
	}
	
	/**
	 * 푸드 판매 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectFoodSalesList(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectFoodSalesList", param);
	}
	
	/**
	 * 음료 판매 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectBeverageSalesList(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectBeverageSalesList", param);
	}
	
	/**
	 * MD상품 판매 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectMdSalesList(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectMdSalesList", param);
	}
	
	/**
	 * 퇴장추가요금 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectExitSalesInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectExitSalesInfo", param);
	}
	
	/**
	 * 할인 요금 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectDiscountSalesInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectDiscountSalesInfo", param);
	}
	
	/**
	 * 다회권 집계
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectMultiTicketUseInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectMultiTicketUseInfo", param);
	}
	
	/**
	 * 단체 집계(비회원)
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectNotMemberGroupEnterInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectNotMemberGroupEnterInfo", param);
	}
	
	/**
	 * 단체 집계(회원)
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectGroupEnterInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectGroupEnterInfo", param);
	}
	
	/**
	 * 월매출정보 가져오기
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectMonthSalesInfo(Map<String, Object> param){
		return sqlSession.selectList(NS + "selectMonthSalesInfo", param);
	}
	
	/**
	 * 일별 월매출 정보 가져오기
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectMonthSalesListByDate(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectMonthSalesListByDate", param);
	}
	
	/**
	 * 년도별 월매출 정보 가져오기
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectMonthSalesListByMonth(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectMonthSalesListByMonth", param);
	}
	
	/**
	 * 프랜차이즈 정보 가져오기
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectFranchiseInfo(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectFranchiseInfo", param);
	}
	
	/**
	 * 결제내역관리 정보 가져오기
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectPayList(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectPayList", param);
	}
	
	/**
	 * CARDOKDATEINFO 테이블 업데이트
	 * @param param
	 * @return
	 */
	public int updateCardOkDataInfo(Map<String, Object> param) {
		return sqlSession.update(NS + "updateCardOkDataInfo", param);
	}
	
	/**
	 * GOODSSALEINFO 테이블 업데이트
	 * @param param
	 * @return
	 */
	public int updateGoodsSaleInfo(Map<String, Object> param) {
		return sqlSession.update(NS + "updateGoodsSaleInfo", param);
	}
	
	/**
	 * PAYMENTINFO 테이블 업데이트
	 * @param param
	 * @return
	 */
	public int updatePaymentInfo(Map<String, Object> param) {
		return sqlSession.update(NS + "updatePaymentInfo", param);
	}
}