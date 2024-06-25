package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.UVDAO;
import util.LocationCalc;
import vo.CityVO;
import vo.DirectRadiationVO;

@Controller
public class UVController {

	@Autowired
	HttpSession session;
	
	UVDAO uvdao;

	public UVController(UVDAO uvdao) {
		this.uvdao = uvdao;
	}

	@RequestMapping(value = {"/", "list.do"}) public String showUV24All() {
		return Common.Direct_Radiation.VIEW_PATH + "get_location_info.jsp"; 
	}

	
	@RequestMapping("location.do")
	public String receiveLocation(Model model, Double latitude, Double longitude) {
		Map<Integer, double[]> city_map = uvdao.city_list();
		LocationCalc locationCalc = new LocationCalc();
		int city_idx = locationCalc.findClosestDistrict(city_map, latitude.doubleValue(), longitude.doubleValue());

		CityVO closeCity = uvdao.selectOneCity(city_idx);

		List<DirectRadiationVO> radi_list = uvdao.direct_radiation_list(closeCity.getLatitude(),
				closeCity.getLongitude());

		//15개씩 가져오는지 확인
		System.out.print("리스트사이즈:" + radi_list.size());
		
		model.addAttribute("radi_list", radi_list);
		model.addAttribute("city_name", closeCity.getcity_name());
		
		session.setAttribute("lat", latitude);
		session.setAttribute("lon", longitude);
				
		return Common.Direct_Radiation.VIEW_PATH + "uv_list.jsp";
	}
	
	@RequestMapping("skinSession.do")
	@ResponseBody
	public String skinSession(String color) {
		System.out.println("hello");
		session.setAttribute("skincolor", color);
		System.out.println(session.getAttribute("skincolor"));
		return "ok"; 
	} 
}













