package kr.co.swings.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.swings.vo.FranchiseInfoVo;

@Repository
public class LoginDao {
	@Autowired
	private SqlSession sqlSession; 
	
	private final String NS = "kr.co.swings.login.";
	
	public FranchiseInfoVo selectLoginInfo(Map<String, Object> param) {
		return sqlSession.selectOne(NS + "selectLoginInfo", param);
	}
	
}
