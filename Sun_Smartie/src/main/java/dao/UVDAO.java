package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import vo.DirectRadiationVO;
import vo.CityVO;

public class UVDAO {
	
	SqlSession sqlSession;
	
	public UVDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public Map<Integer, double[]> city_list() {
		List<CityVO> list = sqlSession.selectList("uv.select_city_list");
		Map<Integer, double[]> map = new HashMap<Integer, double[]>();
		for(int i = 0; i < list.size(); i++) {
			map.put(list.get(i).getIdx(), 
					new double[]{list.get(i).getLatitude(), list.get(i).getLongitude()});
		}
		return map;
	}
	
	public CityVO selectOneCity(int city_idx) {
		CityVO city = sqlSession.selectOne("uv.select_city_with_idx", city_idx);
		return city;
	}
	
	public List<DirectRadiationVO> direct_radiation_list(double latitude, double longitude) {
		Map<String, Double> map = new HashMap<String, Double>();
		map.put("latitude", latitude);
		map.put("longitude", longitude);
		List<DirectRadiationVO> list = sqlSession.selectList("uv.select_direct_radiation_list", map);
		return list;
	}
	
	public List<DirectRadiationVO> pullList() {
		List<DirectRadiationVO> list = sqlSession.selectList("uv.select_list");
		return list;
	}
	
}









