package controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import api.UVAPIBinder;
import dao.UVDAO;
import vo.DirectRadiationVO;

@Controller
public class UVController {

	UVDAO uvdao;
	
	public UVController(UVDAO uvdao) {
		this.uvdao = uvdao;
	}
	
	@RequestMapping(value = {"/", "list.do"})
	public String showUV24All(Model model) {
		List<DirectRadiationVO> list = uvdao.pullList();
		model.addAttribute("uv_list", list);
		return common.Common.Direct_Radiation.VIEW_PATH + "uv_list.jsp";
	}
	
}












