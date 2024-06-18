package controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.UVDAO;
import util.LocationCalc;

@Controller
public class UVController {

	UVDAO uvdao;

	public UVController(UVDAO uvdao) {
		this.uvdao = uvdao;
	}

	//API에서 받아온 리스트를 단순하게 뿌려주는 매핑메서드
	/*@RequestMapping(value = {"/", "list.do"})
	public String showUV24All(Model model) {
		List<DirectRadiationVO> list = uvdao.pullList();
		model.addAttribute("uv_list", list);
		return common.Common.Direct_Radiation.VIEW_PATH + "uv_list.jsp";
	}*/

	@RequestMapping(value = {"/", "list.do"})
	public String showUV24All() {

		return common.Common.Direct_Radiation.VIEW_PATH + "get_location_info.jsp";
	}

	@PostMapping("/location")
	@ResponseBody
	public ResponseEntity<String> receiveLocation(@RequestBody Map<String, Object> locationData) {
		Number latitude = (Number) locationData.get("latitude");
		Number longitude = (Number) locationData.get("longitude");
		Number accuracy = (Number) locationData.get("accuracy");

		if (latitude != null && longitude != null && accuracy != null) {
			double userlat = latitude.doubleValue();
			double userlon = longitude.doubleValue();
			//double acc = accuracy.doubleValue();

			// 위치 정보를 로그로 출력 (또는 다른 처리)
			//System.out.println("Received location: Latitude = " + lat + ", Longitude = " + lon + ", Accuracy = " + acc + " meters");

			Map<Integer, double[]> district_map = uvdao.city_list();
			LocationCalc locationCalc = new LocationCalc();
			int district_idx = locationCalc.findClosestDistrict(district_map, userlat, userlon);
			System.out.println(district_idx);

			// 성공 응답 반환
			return ResponseEntity.ok("Location received successfully.");
		} else {
			return ResponseEntity.badRequest().body("Invalid location data received.");
		}
	}

}












