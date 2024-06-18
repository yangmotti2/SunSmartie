package util;

import java.util.Map;

public class LocationCalc {

	public double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
		double dLat = lat2 - lat1;
		double dLon = lon2 - lon1;
		return Math.sqrt(dLat * dLat + dLon * dLon);
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
