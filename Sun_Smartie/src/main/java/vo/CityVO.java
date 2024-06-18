package vo;

public class CityVO {
	
	private int idx;
	private String city_name;
	private double latitude, longitude;
	
	public CityVO() {
		// TODO Auto-generated constructor stub
	}
	
	public CityVO(int idx, String city_name, double latitude, double longitude) {
		this.idx = idx;
		this.city_name = city_name;
		this.latitude = latitude;
		this.longitude = longitude;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getcity_name() {
		return city_name;
	}
	public void setcity_name(String city_name) {
		this.city_name = city_name;
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
