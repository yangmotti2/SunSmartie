package controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @RequestMapping(value = {"/", "list.do"})
    public String showUV24All() {
        return common.Common.Direct_Radiation.VIEW_PATH + "get_location_info.jsp";
    }

    @PostMapping("/location")
    @ResponseBody
    public ResponseEntity<String> receiveLocation(Model model, @RequestBody Map<String, Object> locationData) {
    	//json형태로 넘어온 값들은 Number클래스로 받을 수밖에 없다.
    	Number latitude = (Number) locationData.get("latitude");
        Number longitude = (Number) locationData.get("longitude");
        Number accuracy = (Number) locationData.get("accuracy");
        
        //잘 존재하면 Number클래스에서 double로 다운그레이드 시켜주기
        if (latitude != null && longitude != null && accuracy != null) {
            double userlat = latitude.doubleValue();
            double userlon = longitude.doubleValue();
            
            //map으로 하는데 
            Map<Integer, double[]> city_map = uvdao.city_list();
            LocationCalc locationCalc = new LocationCalc();
            int city_idx = locationCalc.findClosestDistrict(city_map, userlat, userlon);
            
            CityVO closeCity = uvdao.selectOneCity(city_idx);
            
            List<DirectRadiationVO> radi_list = 
            		uvdao.direct_radiation_list(closeCity.getLatitude(), closeCity.getLongitude());
            
            model.addAttribute("radi_list", radi_list);

            // 리다이렉트 URL 반환
            return ResponseEntity.ok(common.Common.Direct_Radiation.VIEW_PATH + "uv_list.jsp");
        } else {
            return ResponseEntity.ok(common.Common.Direct_Radiation.VIEW_PATH + "find_location_fail.jsp");
        }
    }
}











