package api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import vo.CityVO;

@Service
public class UVAPIBinder {
	
	@Autowired
    private JdbcTemplate jdbcTemplate;
    
    private final String apiKey = "openuv-13xk1crlxbidfq2-io"; // Replace with your actual access token
    private final String apiUrl = "https://api.openuv.io/api/v1/forecast?lat=%f&lng=%f";
    
    public UVAPIBinder(JdbcTemplate jdbcTemplate) {
    	this.jdbcTemplate = jdbcTemplate;
    	
    	if(!isdirect_radiationTableExists()) {
    		createdirect_radiationTable();
    		fetchAndStoreUVIndex();
    	}
    }
    
    public boolean isdirect_radiationTableExists() {
        String sql = "SELECT COUNT(*) FROM user_tables WHERE table_name = 'DIRECT_RADIATION'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        if(count != null && count > 0) {
        	return true;
        }
        return false;
    }
    
    private void createdirect_radiationTable() {
    	String isSeqExist = "SELECT count(*) "
    			+ "FROM user_sequences "
    			+ "WHERE sequence_name = 'SEQ_RADI_IDX'";
    	if(jdbcTemplate.queryForObject(isSeqExist, Integer.class) == 0) {
    		jdbcTemplate.execute("create sequence seq_radi_idx");
    	}
    	
        String sql = "CREATE TABLE direct_radiation ("
                + "idx NUMBER PRIMARY KEY, "
                + "latitude NUMBER, "
        		+ "longitude NUMBER, "
        		+ "uv NUMBER, "
        		+ "uv_time varchar2(100))";
        jdbcTemplate.execute(sql);
        
        String isIdxExist = "SELECT count(*) "
        		+ "FROM user_indexes "
        		+ "WHERE index_name = 'IDX_LATLONG_RADI'";
        if(jdbcTemplate.queryForObject(isIdxExist, Integer.class) == 0) {
        	jdbcTemplate.execute("CREATE INDEX idx_latlong_radi ON direct_radiation(latitude, longitude)");
        }
    }

    //@Scheduled(cron = "0 0 0 * * ?") // 매일 자정 실행
    public void fetchAndStoreUVIndex() {
        try {
            // 기존 데이터 삭제
            jdbcTemplate.update("DELETE FROM direct_radiation");
            
            List<CityVO> cities = jdbcTemplate.query("select * from city", 
            		new RowMapper<CityVO>() {
						@Override
						public CityVO mapRow(ResultSet rs, int rowNum) throws SQLException {
							return new CityVO(rs.getInt("idx"),
												  rs.getString("city_name"),
												  rs.getDouble("latitude"),
												  rs.getDouble("longitude"));
						}
					}); 
            
            for (CityVO coordinate : cities) {
                double lat = coordinate.getLatitude();
                double lon = coordinate.getLongitude();

                String urlStr = String.format(apiUrl, lat, lon);
                URL url = new URL(urlStr);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("GET");
                connection.setRequestProperty("x-access-token", apiKey);

                BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String line;
                StringBuilder resultJson = new StringBuilder();

                while ((line = br.readLine()) != null) {
                    resultJson.append(line);
                }
                br.close();
                connection.disconnect();
                
                ObjectMapper om = new ObjectMapper();
                JsonNode rootNode = om.readTree(resultJson.toString());
                JsonNode resultNode = rootNode.path("result");

                for (JsonNode node : resultNode) {
                    double uvIndex = node.path("uv").asDouble();
                    String uvTime = node.path("uv_time").asText();
                    System.out.println(uvIndex + "/" + uvTime);

                    jdbcTemplate.update("INSERT INTO direct_radiation (idx, latitude, longitude, uv, uv_time) VALUES (seq_radi_idx.nextVal, ?, ?, ?, ?)",
                            lat, lon, uvIndex, uvTime);
                }
            }

        } catch (Exception e) {
			e.printStackTrace();
		}
    }
	
}
