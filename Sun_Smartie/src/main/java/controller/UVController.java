package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
	public String receiveLocation(Model model, double latitude, double longitude, Integer level) {
		System.out.println("지도에서 보낸 에이잭스. lat:" + latitude + "lon:" + longitude);
		//*세션에 위도경도 저장		 
		session.setAttribute("lat", latitude);
		session.setAttribute("lon", longitude);
		session.setAttribute("level", level);
		
		//--해당 도시의  
		Map<Integer, double[]> city_map = uvdao.city_list();
		LocationCalc locationCalc = new LocationCalc();
		int city_idx = locationCalc.findClosestDistrict(city_map, latitude, longitude);

		CityVO closeCity = uvdao.selectOneCity(city_idx);

		List<DirectRadiationVO> radi_list = uvdao.direct_radiation_list(closeCity.getLatitude(),
				closeCity.getLongitude());
		
		model.addAttribute("radi_list", radi_list);
		model.addAttribute("city_name", closeCity.getcity_name());
		//--
				
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
	
	//-----------새로 추가한 메서드 ↓-------------//
	
    @RequestMapping("radi_table.do")
    @ResponseBody
    public List<DirectRadiationVO> getNewRadiList(@RequestParam double lat, @RequestParam double lng) {
    	Map<Integer, double[]> city_map = uvdao.city_list();
		LocationCalc locationCalc = new LocationCalc();
		int city_idx = locationCalc.findClosestDistrict(city_map, lat, lng);

		CityVO closeCity = uvdao.selectOneCity(city_idx);

		List<DirectRadiationVO> radi_list = uvdao.direct_radiation_list(closeCity.getLatitude(),
				closeCity.getLongitude());
		
		return radi_list;
    }
	
}













