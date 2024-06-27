package util;

import java.util.Map;

public class LocationCalc {

	public double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
		final int R = 6371; // 지구의 반지름 (단위: km)

	    double dLat = Math.toRadians(lat2 - lat1);
	    double dLon = Math.toRadians(lon2 - lon1);
	    double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
	               Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
	               Math.sin(dLon / 2) * Math.sin(dLon / 2);
	    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	    double distance = R * c; // Distance in km

	    return distance;
	}

	// 가장 가까운 구를 찾는 메서드
	public Integer findClosestDistrict(Map<Integer, double[]> districtCoordinates, double userLat, double userLon) {
		int closestDistrict = 0;
		double minDistance = Double.MAX_VALUE;

		for (Map.Entry<Integer, double[]> entry : districtCoordinates.entrySet()) {
			double[] coords = entry.getValue();
			double distance = calculateDistance(userLat, userLon, coords[0], coords[1]);

			if (distance < minDistance) {
				minDistance = distance;
				closestDistrict = entry.getKey();
			}
		}

		return closestDistrict;
	}

}
