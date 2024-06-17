package vo;

public class DistrictVO {
	
	private int idx;
	private String city_name, district_name;
	private double latitude, longitude;
	
	public DistrictVO(int idx, String city_name, String district_name, double latitude, double longitude) {
		this.idx = idx;
		this.city_name = city_name;
		this.district_name = district_name;
		this.latitude = latitude;
		this.longitude = longitude;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getCity_name() {
		return city_name;
	}
	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}
	public String getDistrict_name() {
		return district_name;
	}
	public void setDistrict_name(String district_name) {
		this.district_name = district_name;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	
	
	
}
