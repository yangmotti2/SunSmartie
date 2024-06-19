package api;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class CityAPIBinder {
	
	private List<Object[]> city_list;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public CityAPIBinder(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
		
        if (!iscityTableExists()) {
        	System.out.println("테이블이 존재하지 않음. 만드는중...");
        	createcityTable();
            setCity_list();
            insertDataIntoUVIndexTable();
        }
	}
	
    public boolean iscityTableExists() {
        String sql = "SELECT COUNT(*) FROM user_tables WHERE table_name = 'CITY'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        if(count != null && count > 0) {
        	return true;
        }
        return false;
    }

    public boolean isUVIndexTableNotEmpty() {
        String sql = "SELECT COUNT(*) FROM city";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        if(count != null && count > 0) {
        	return true;
        }
        return false;
    }

    private void createcityTable() {
    	String isSeqExist = "SELECT count(*) "
    			+ "FROM user_sequences "
    			+ "WHERE sequence_name = 'SEQ_CITY_IDX'";
    	if(jdbcTemplate.queryForObject(isSeqExist, Integer.class) == 0) {
    		jdbcTemplate.execute("create sequence seq_city_idx");
    	}
    	
        String sql = "CREATE TABLE city ("
                + "idx NUMBER PRIMARY KEY, "
                + "city_name VARCHAR2(100), "
                + "latitude NUMBER, "
                + "longitude NUMBER)";
        jdbcTemplate.execute(sql);
        
        String isIdxExist = "SELECT count(*) "
        		+ "FROM user_indexes "
        		+ "WHERE index_name = 'IDX_LATLONG_city'";
        if(jdbcTemplate.queryForObject(isIdxExist, Integer.class) == 0) {
        	jdbcTemplate.execute("CREATE INDEX IDX_LATLONG_city ON city(latitude, longitude)");
        }
    }
    
    private void insertDataIntoUVIndexTable() {
    	String sql = "INSERT INTO city (idx, city_name, latitude, longitude) VALUES (seq_city_idx.nextVal, ?, ?, ?)";
    	
    	jdbcTemplate.batchUpdate(sql, city_list);
    }

	public List<Object[]> getCity_list() {
		return city_list;
	}

	public void setCity_list() {
		city_list = new ArrayList<Object[]>();
        // 시의 위도와 경도 추가
		city_list.add(new Object[]{"서울시", 37.5519, 126.9918});
		city_list.add(new Object[]{"강릉시", 37.7491, 128.8785});
        city_list.add(new Object[]{"동해시", 37.5219, 129.1166});
        city_list.add(new Object[]{"삼척시", 37.4471, 129.1675});
        city_list.add(new Object[]{"속초시", 38.2043, 128.5942});
        city_list.add(new Object[]{"원주시", 37.3391, 127.9221});
        city_list.add(new Object[]{"춘천시", 37.8785, 127.7323});
        city_list.add(new Object[]{"태백시", 37.1612, 128.988});
        city_list.add(new Object[]{"고양시", 37.6559, 126.7771});
        city_list.add(new Object[]{"과천시", 37.4264, 126.9898});
        city_list.add(new Object[]{"광명시", 37.4757, 126.8667});
        city_list.add(new Object[]{"광주시", 37.4145, 127.2578});
        city_list.add(new Object[]{"구리시", 37.5916, 127.1319});
        city_list.add(new Object[]{"군포시", 37.3587, 126.9375});
        city_list.add(new Object[]{"김포시", 37.6125, 126.7178});
        city_list.add(new Object[]{"남양주시", 37.6332, 127.2186});
        city_list.add(new Object[]{"동두천시", 37.9009, 127.0627});
        city_list.add(new Object[]{"부천시", 37.5036, 126.766});
        city_list.add(new Object[]{"성남시", 37.4475, 127.1477});
        city_list.add(new Object[]{"수원시", 37.301, 127.0122});
        city_list.add(new Object[]{"시흥시", 37.3773, 126.8051});
        city_list.add(new Object[]{"안산시", 37.2985, 126.8468});
        city_list.add(new Object[]{"안성시", 37.0052, 127.2818});
        city_list.add(new Object[]{"안양시", 37.3897, 126.9534});
        city_list.add(new Object[]{"양주시", 37.7824, 127.0478});
        city_list.add(new Object[]{"여주시", 37.2954, 127.6396});
        city_list.add(new Object[]{"오산시", 37.1469, 127.0796});
        city_list.add(new Object[]{"용인시", 37.2315, 127.2038});
        city_list.add(new Object[]{"의왕시", 37.3419, 126.9704});
        city_list.add(new Object[]{"의정부시", 37.7353, 127.0358});
        city_list.add(new Object[]{"이천시", 37.2754, 127.4432});
        city_list.add(new Object[]{"파주시", 37.7571, 126.782});
        city_list.add(new Object[]{"평택시", 36.9894, 127.1147});
        city_list.add(new Object[]{"포천시", 37.8922, 127.2024});
        city_list.add(new Object[]{"하남시", 37.5365, 127.217});
        city_list.add(new Object[]{"화성시", 37.1968, 126.8335});
        city_list.add(new Object[]{"인천시", 37.4562, 126.7059});
        city_list.add(new Object[]{"거제시", 34.8774, 128.6234});
        city_list.add(new Object[]{"경산시", 35.8221, 128.7435});
        city_list.add(new Object[]{"경주시", 35.8532, 129.227});
        city_list.add(new Object[]{"구미시", 36.1165, 128.3468});
        city_list.add(new Object[]{"김천시", 36.1369, 128.1158});
        city_list.add(new Object[]{"김해시", 35.2255, 128.8917});
        city_list.add(new Object[]{"마산시", 35.1969, 128.5679});
        city_list.add(new Object[]{"문경시", 36.5836, 128.189});
        city_list.add(new Object[]{"밀양시", 35.5008, 128.7489});
        city_list.add(new Object[]{"사천시", 35.0003, 128.0668});
        city_list.add(new Object[]{"상주시", 36.408, 128.1613});
        city_list.add(new Object[]{"안동시", 36.5655, 128.7316});
        city_list.add(new Object[]{"양산시", 35.3319, 129.0394});
        city_list.add(new Object[]{"영주시", 36.8029, 128.6263});
        city_list.add(new Object[]{"당진시", 36.8907, 126.6303});
        city_list.add(new Object[]{"보령시", 36.3306, 126.6149});
        city_list.add(new Object[]{"서산시", 36.7821, 126.4522});
        city_list.add(new Object[]{"아산시", 36.7871, 127.0046});
        city_list.add(new Object[]{"제천시", 37.1298, 128.1932});
        city_list.add(new Object[]{"천안시", 36.8041, 127.1525});
        city_list.add(new Object[]{"청주시", 36.584, 127.5117});
        city_list.add(new Object[]{"충주시", 36.9882, 127.9281});
        city_list.add(new Object[]{"대전시", 36.3506, 127.3849});
	}
	
	
	
}
