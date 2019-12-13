package kr.co.swings.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.swings.vo.PagingVo;

@Repository
public class MemberDao {
	
	@Autowired
	private SqlSession sqlSession; 
	
	private final String NS = "kr.co.swings.member.";
	
	//가맹점 리스트 가져오기
	public List<Map<String, Object>> selectFranchiseList() {
		return sqlSession.selectList(NS + "selectFranchiseList");
	}
	
	//회원 리스트 COUNT 가져오기
	public int selectMasterInfoCount(PagingVo pagingVo) {
		return sqlSession.selectOne(NS + "selectMasterInfoCount" , pagingVo);
	}
	
	//회원 리스트 가져오기
	public List<Map<String, Object>> selectMasterInfoList(PagingVo pagingVo) {
		return sqlSession.selectList(NS + "selectMasterInfoList" , pagingVo);
	}
	
	//회원 엑셀 리스트 가져오기
	public List<Map<String, Object>> selectMasterInfoExcelList(PagingVo pagingVo) {
		return sqlSession.selectList(NS + "selectMasterInfoExcelList" , pagingVo);
	}
	
	//검색 회원 엑셀 리스트 가져오기
	public List<Map<String, Object>> selectSearchMasterInfoExcelList(PagingVo pagingVo) {
		return sqlSession.selectList(NS + "selectSearchMasterInfoExcelList" , pagingVo);
	}
	
	//회원 정보 가져오기
	public Map<String, Object> selectMemberInfo(Map<String, Object> param){
		return sqlSession.selectOne(NS + "selectMemberInfo", param);
	}
	
	//가족 정보 가져오기
	public List<Map<String, Object>> selectMemberFamilyInfo(Map<String, Object> param){
		return sqlSession.selectList(NS + "selectMemberFamilyInfo", param);
	}
	
	//방문 정보 가져오기
	public List<Map<String, Object>> selectStoreVisitInfo(Map<String, Object> param){
		return sqlSession.selectList(NS + "selectStoreVisitInfo", param);
	}
	
	//매장이용정보 가져오기
	public List<Map<String, Object>> selectStoreUseInfo(Map<String, Object> param){
		return sqlSession.selectList(NS + "selectStoreUseInfo", param);
	}
	
	//다회권 정보 가져오기
	public List<Map<String, Object>> selectMultiTicketList(Map<String, Object> param){
		return sqlSession.selectList(NS + "selectMultiTicketList", param);
	}
	
	//MasterInfo 테이블 업데이트
	public int updateMasterInfo(Map<String, Object> param){
		return sqlSession.update(NS + "updateMasterInfo", param);
	}
	
	//MemberInfo 테이블 데이터 추가
	public int insertMemberInfo(Map<String, Object> param){
		return sqlSession.insert(NS + "insertMemberInfo", param);
	}
	
	//MemberInfo 테이블 데이터 삭제
	public int deleteMemberInfo(Map<String, Object> param){
		return sqlSession.delete(NS + "deleteMemberInfo", param);
	}
	
	//삭제 가능 여부 판단
	public Map<String, Object> deleteMemberAvailable(Map<String, Object> param){
		return sqlSession.selectOne(NS + "deleteMemberAvailable", param);
	}
	
	//포인트 업데이트
	public int pointInfoUpdate(Map<String, Object> param){
		return sqlSession.update(NS + "pointInfoUpdate", param);
	}
	
	//MASTERInfo 삭제
	public int deleteMasterInfoByMemberOut(Map<String, Object> param){
		return sqlSession.delete(NS + "deleteMasterInfoByMemberOut", param);
	}
	
	//티켓 삭제
	public int deleteMultiticketSalesUse(Map<String, Object> param){
		return sqlSession.delete(NS + "deleteMultiticketSalesUse", param);
	}
}
