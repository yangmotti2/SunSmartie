package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;

import java.util.Map;

import java.util.List;

import dao.UVDAO;
import util.LocationCalc;
import vo.CityVO;
import vo.DirectRadiationVO;

@Controller
public class UVController {

	UVDAO uvdao;

	public UVController(UVDAO uvdao) {
		this.uvdao = uvdao;
	}

	@RequestMapping(value = {"/", "list.do"}) public String showUV24All() {
		return Common.Direct_Radiation.VIEW_PATH + "get_location_info.jsp"; 
	}

	@RequestMapping("location.do")
	public String receiveLocation(Model model, double latitude, double longitude) {

		Map<Integer, double[]> city_map = uvdao.city_list();
		LocationCalc locationCalc = new LocationCalc();
		int city_idx = locationCalc.findClosestDistrict(city_map, latitude, longitude);

		CityVO closeCity = uvdao.selectOneCity(city_idx);

		List<DirectRadiationVO> radi_list = uvdao.direct_radiation_list(closeCity.getLatitude(),
				closeCity.getLongitude());

		//15개씩 가져오는지 확인
		System.out.print("리스트사이즈:" + radi_list.size());
		
		model.addAttribute("radi_list", radi_list);

		return Common.Direct_Radiation.VIEW_PATH + "uv_list.jsp";
	}
}













