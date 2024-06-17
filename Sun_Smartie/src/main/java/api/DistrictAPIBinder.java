package api;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class DistrictAPIBinder {
	
	private List<Object[]> district_list;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public DistrictAPIBinder(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
		
        if (!isDistrictTableExists()) {
        	createDistrictTable();
            setDistrict_list();
            insertDataIntoUVIndexTable();
        }
	}
	
    public boolean isDistrictTableExists() {
        String sql = "SELECT COUNT(*) FROM user_tables WHERE table_name = 'DISTRICT'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        if(count != null && count > 0) {
        	return true;
        }
        return false;
    }

    public boolean isUVIndexTableNotEmpty() {
        String sql = "SELECT COUNT(*) FROM district";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        if(count != null && count > 0) {
        	return true;
        }
        return false;
    }

    private void createDistrictTable() {
    	String isSeqExist = "SELECT count(*)"
    			+ "FROM user_sequences"
    			+ "WHERE sequence_name = 'SEQ_DISTRICT_IDX'";
    	if(jdbcTemplate.queryForObject(isSeqExist, Integer.class) == 0) {
    		jdbcTemplate.execute("create sequence seq_district_idx");
    	}
    	
        String sql = "CREATE TABLE district ("
                + "idx NUMBER PRIMARY KEY, "
                + "city_name VARCHAR2(100), "
                + "district_name VARCHAR2(100), "
                + "latitude NUMBER, "
                + "longitude NUMBER)";
        jdbcTemplate.execute(sql);
    }
    
    private void insertDataIntoUVIndexTable() {
    	String sql = "INSERT INTO district (idx, city_name, district_name, latitude, longitude) VALUES (seq_district_idx.nextVal, ?, ?, ?, ?)";
    	
    	jdbcTemplate.batchUpdate(sql, district_list);
    }

	public List<Object[]> getDistrict_list() {
		return district_list;
	}

	public void setDistrict_list() {
		district_list = new ArrayList<Object[]>();
		district_list.add(new Object[]{"Seoul", "Gangnam-gu", 37.5172363, 127.0473248});
		district_list.add(new Object[]{"Seoul", "Jongno-gu", 37.5729503, 126.9793579});
		district_list.add(new Object[]{"Seoul", "Seocho-gu", 37.4835959, 127.0326614});
		district_list.add(new Object[]{"Seoul", "Songpa-gu", 37.5145436, 127.1058803});
		district_list.add(new Object[]{"Seoul", "Gwanak-gu", 37.4784062, 126.9516134});
		district_list.add(new Object[]{"Busan", "Haeundae-gu", 35.1586982, 129.1603845});
		district_list.add(new Object[]{"Busan", "Suyeong-gu", 35.1379222, 129.1139636});
		district_list.add(new Object[]{"Busan", "Nam-gu", 35.1365782, 129.0959625});
		district_list.add(new Object[]{"Busan", "Dong-gu", 35.1292881, 129.056139});
		district_list.add(new Object[]{"Incheon", "Namdong-gu", 37.4474648, 126.7311975});
		district_list.add(new Object[]{"Incheon", "Bupyeong-gu", 37.5081635, 126.7215274});
		district_list.add(new Object[]{"Incheon", "Yeonsu-gu", 37.4045395, 126.6878203});
		district_list.add(new Object[]{"Incheon", "Jung-gu", 37.4734019, 126.6214353});
		district_list.add(new Object[]{"Daegu", "Suseong-gu", 35.8586602, 128.6309227});
		district_list.add(new Object[]{"Daegu", "Dalseo-gu", 35.8252073, 128.5328072});
		district_list.add(new Object[]{"Daegu", "Nam-gu", 35.846947, 128.5513155});
		district_list.add(new Object[]{"Daegu", "Dong-gu", 35.8833055, 128.6358006});
		district_list.add(new Object[]{"Daejeon", "Yuseong-gu", 36.3546444, 127.3570871});
		district_list.add(new Object[]{"Daejeon", "Seo-gu", 36.3481872, 127.3848177});
		district_list.add(new Object[]{"Daejeon", "Jung-gu", 36.3252901, 127.3813244});
		district_list.add(new Object[]{"Daejeon", "Dong-gu", 36.3374078, 127.4544254});
		district_list.add(new Object[]{"Gwangju", "Nam-gu", 35.1334899, 126.9023682});
		district_list.add(new Object[]{"Gwangju", "Buk-gu", 35.1731438, 126.9121282});
		district_list.add(new Object[]{"Gwangju", "Dong-gu", 35.1496371, 126.9238748});
		district_list.add(new Object[]{"Gwangju", "Seo-gu", 35.1600876, 126.851048});
		district_list.add(new Object[]{"Suwon", "Paldal-gu", 37.2775263, 127.0422853});
		district_list.add(new Object[]{"Suwon", "Yeongtong-gu", 37.2458067, 127.0579454});
		district_list.add(new Object[]{"Suwon", "Gwonseon-gu", 37.2635724, 126.9896593});
		district_list.add(new Object[]{"Ulsan", "Nam-gu", 35.543354, 129.317425});
		district_list.add(new Object[]{"Ulsan", "Dong-gu", 35.504054, 129.429188});
		district_list.add(new Object[]{"Ulsan", "Buk-gu", 35.582309, 129.36152});
		district_list.add(new Object[]{"Ulsan", "Jung-gu", 35.569672, 129.345168});
		district_list.add(new Object[]{"Jeju", "Jeju-si", 33.4996213, 126.5311884});
		district_list.add(new Object[]{"Jeju", "Seogwipo-si", 33.253077, 126.561707});
		district_list.add(new Object[]{"Seoul", "Dongjak-gu", 37.512455, 126.939574});
		district_list.add(new Object[]{"Seoul", "Eunpyeong-gu", 37.617612, 126.922700});
		district_list.add(new Object[]{"Seoul", "Geumcheon-gu", 37.456878, 126.895778});
		district_list.add(new Object[]{"Seoul", "Guro-gu", 37.495485, 126.887767});
		district_list.add(new Object[]{"Seoul", "Gwanak-gu", 37.478293, 126.951727});
		district_list.add(new Object[]{"Seoul", "Gwangjin-gu", 37.538635, 127.082254});
		district_list.add(new Object[]{"Seoul", "Jongno-gu", 37.573050, 126.979189});
		district_list.add(new Object[]{"Seoul", "Jung-gu", 37.563574, 126.997390});
		district_list.add(new Object[]{"Seoul", "Jungnang-gu", 37.606991, 127.093463});
		district_list.add(new Object[]{"Seoul", "Mapo-gu", 37.566283, 126.901644});
		district_list.add(new Object[]{"Seoul", "Nowon-gu", 37.654264, 127.056294});
		district_list.add(new Object[]{"Seoul", "Seocho-gu", 37.483585, 127.032616});
		district_list.add(new Object[]{"Seoul", "Seodaemun-gu", 37.579325, 126.936957});
		district_list.add(new Object[]{"Seoul", "Seongbuk-gu", 37.589398, 127.016703});
		district_list.add(new Object[]{"Seoul", "Seongdong-gu", 37.561100, 127.037773});
		district_list.add(new Object[]{"Seoul", "Songpa-gu", 37.514544, 127.105879});
		district_list.add(new Object[]{"Seoul", "Yangcheon-gu", 37.523406, 126.856229});
		district_list.add(new Object[]{"Seoul", "Yeongdeungpo-gu", 37.520453, 126.913179});
		district_list.add(new Object[]{"Seoul", "Yongsan-gu", 37.532437, 126.990339});
		district_list.add(new Object[]{"Seoul", "Gangbuk-gu", 37.639619, 127.025267});
		district_list.add(new Object[]{"Seoul", "Gangdong-gu", 37.530202, 127.123763});
        district_list.add(new Object[]{"Busan", "Geumjeong-gu", 35.242018, 129.092761});
        district_list.add(new Object[]{"Busan", "Busanjin-gu", 35.162982, 129.059240});
        district_list.add(new Object[]{"Busan", "Yeonje-gu", 35.187125, 129.079030});
        district_list.add(new Object[]{"Busan", "Dongnae-gu", 35.205042, 129.083571});
        district_list.add(new Object[]{"Busan", "Buk-gu", 35.214415, 129.033703});
        district_list.add(new Object[]{"Busan", "Sasang-gu", 35.150641, 128.990085});
        district_list.add(new Object[]{"Busan", "Saha-gu", 35.104547, 128.973927});
        district_list.add(new Object[]{"Busan", "Gangseo-gu", 35.212238, 128.980823});
        district_list.add(new Object[]{"Busan", "Seo-gu", 35.097566, 129.026287});
        district_list.add(new Object[]{"Incheon", "Seo-gu", 37.560135, 126.676505});
        district_list.add(new Object[]{"Incheon", "Gyeyang-gu", 37.538270, 126.731302});
        district_list.add(new Object[]{"Incheon", "Michuhol-gu", 37.457086, 126.650344});
        district_list.add(new Object[]{"Incheon", "Dong-gu", 37.471017, 126.641328});
        district_list.add(new Object[]{"Incheon", "Jung-gu", 37.473401, 126.621447});
        district_list.add(new Object[]{"Daegu", "Dalseong-gun", 35.774877, 128.431306});
        district_list.add(new Object[]{"Daegu", "Buk-gu", 35.885350, 128.582160});
        district_list.add(new Object[]{"Daegu", "Seo-gu", 35.870899, 128.559782});
        district_list.add(new Object[]{"Daegu", "Jung-gu", 35.869394, 128.606823});
        district_list.add(new Object[]{"Daejeon", "Daedeok-gu", 36.346481, 127.423081});
        district_list.add(new Object[]{"Gwangju", "Gwangsan-gu", 35.139987, 126.793288});
        district_list.add(new Object[]{"Ulsan", "Ulju-gun", 35.577385, 129.235816});
        district_list.add(new Object[]{"Jeju", "Aewol-eup", 33.464998, 126.344783});
        district_list.add(new Object[]{"Jeju", "Seongsan-eup", 33.383929, 126.880822});
	}
	
	
	
}
