package vo;

public class DirectRadiationVO{
	
	private int idx;
	private double latitude, longitude, uv;
	private String uv_time;
	
	private String uv_color;
	private String uv_notice;
	
	public String getUv_color() {
		if(uv >= 0 && uv < 3) {
			return "#558B2F";
		}else if(uv >= 3 && uv < 6) {
			return "#F9A825";
		}else if(uv >= 6 && uv < 8) {
			return "#EF6C00";
		}else if(uv >= 8 && uv < 11) {
			return "#B71C1C";
		}else if(uv >= 11) {
			return "#6A1B9A";
		}else {
			return "수치 값 이상";
		}
		
	}
	
	public String getUv_notice() {
		if(uv >= 0 && uv < 3) {
			return "Cool";
		}else if(uv >= 3 && uv < 6) {
			return "Mild";
		}else if(uv >= 6 && uv < 8) {
			return "Warm";
		}else if(uv >= 8 && uv < 11) {
			return "Hot";
		}else if(uv >= 11) {
			return "Scorching";
		}else {
			return "수치 값 이상";
		}
		
	}
	
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
