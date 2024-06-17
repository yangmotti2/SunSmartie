package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import vo.DirectRadiationVO;

public class UVDAO {
	
	SqlSession sqlSession;
	
	public UVDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<DirectRadiationVO> pullList() {
		List<DirectRadiationVO> list = sqlSession.selectList("uv.select_list");
		return list;
	}
	
}









