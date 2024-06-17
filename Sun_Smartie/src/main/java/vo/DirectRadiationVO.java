package vo;

public class DirectRadiationVO {
	
	private int idx;
	private double latitude, longitude, uv;
	private String uv_time;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
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
	public double getUv() {
		return uv;
	}
	public void setUv(double uv) {
		this.uv = uv;
	}
	public String getUv_time() {
		return uv_time;
	}
	public void setUv_time(String uv_time) {
		this.uv_time = uv_time;
	}
	
}
