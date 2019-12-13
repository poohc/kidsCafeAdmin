package kr.co.swings.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.swings.vo.PagingVo;

@Repository
public class BoardDao {
	@Autowired
	private SqlSession sqlSession; 
	
	private final String NS = "kr.co.swings.board.";
	
	/**
	 * 요청 게시판 총 카운트
	 * @param param
	 * @return
	 */
	public int selectRequestBoardCount() {
		return sqlSession.selectOne(NS + "selectRequestBoardCount");
	}
	
	/**
	 * 요청 게시판 리스트 가져오기
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectRequestBoardList(PagingVo pagingVo){
		return sqlSession.selectList(NS + "selectRequestBoardList", pagingVo);
	}
	
	/**
	 * 요청 게시판 정보 가져오기
	 * @param param
	 * @return
	 */
	public Map<String, Object> selectRequestBoardInfo(Map<String, Object> param){
		return sqlSession.selectOne(NS + "selectRequestBoardInfo", param);
	}
	
	/**
	 * 접수번호 가져오기
	 * @return
	 */
	public int selectReceptionNo(Map<String, Object> param){
		return sqlSession.selectOne(NS + "selectReceptionNo", param);
	}
	
	/**
	 * 요청 게시물 INSERT
	 * @param param
	 * @return
	 */
	public int insertRequestBoard(Map<String, Object> param) {
		return sqlSession.insert(NS + "insertRequestBoard", param);
	}
	
	/**
	 * 요청 게시물 UPDATE
	 * @param param
	 * @return
	 */
	public int updateRequestBoard(Map<String, Object> param) {
		return sqlSession.update(NS + "updateRequestBoard", param);
	}
	
	/**
	 * 요청 게시물 삭제
	 * @param param
	 * @return
	 */
	public int deleteRequestBoard(Map<String, Object> param) {
		return sqlSession.delete(NS + "deleteRequestBoard", param);
	}
	
	/**
	 * 공지 게시판 총 카운트
	 * @param param
	 * @return
	 */
	public int selectNoticeBoardCount() {
		return sqlSession.selectOne(NS + "selectNoticeBoardCount");
	}
	
	/**
	 * 공지 게시판 리스트 가져오기
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectNoticeBoardList(PagingVo pagingVo){
		return sqlSession.selectList(NS + "selectNoticeBoardList", pagingVo);
	}
	
	/**
	 * 공지사항 가져오기
	 * @param param
	 * @return
	 */
	public Map<String, Object> selectNoticeBoardInfo(Map<String, Object> param){
		return sqlSession.selectOne(NS + "selectNoticeBoardInfo", param);
	}
	
	/**
	 * 공지 게시물 INSERT
	 * @param param
	 * @return
	 */
	public int insertNoticeBoard(Map<String, Object> param) {
		return sqlSession.insert(NS + "insertNoticeBoard", param);
	}
	
	/**
	 * 공지 게시물 UPDATE
	 * @param param
	 * @return
	 */
	public int updateNoticeBoard(Map<String, Object> param) {
		return sqlSession.update(NS + "updateNoticeBoard", param);
	}
	
	/**
	 * 공지 게시물 삭제
	 * @param param
	 * @return
	 */
	public int deleteNoticeBoard(Map<String, Object> param) {
		return sqlSession.delete(NS + "deleteNoticeBoard", param);
	}
	
	/**
	 * 요청사항 게시판 리스트 가져오기(최근 10개만)
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectRequestBoardListLimitTen(Map<String, Object> param){
		return sqlSession.selectList(NS + "selectRequestBoardListLimitTen", param);
	}
	
	/**
	 * 공지 게시판 리스트 가져오기(최근 10개만)
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> selectNoticeBoardListLimitTen(){
		return sqlSession.selectList(NS + "selectNoticeBoardListLimitTen");
	}
}