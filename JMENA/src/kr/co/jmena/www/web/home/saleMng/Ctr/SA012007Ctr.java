package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012007Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012007VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA012007Ctr {
	
	@Resource(name = "SA012007Biz")
	private SA012007Biz SA012007Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012007Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012007.do")
	public ModelAndView SA012007(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA012007");
	}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSA012007.do")
	public ModelAndView selectListEnaBuyMstP(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012007VO vo = new SA012007VO();
		
		vo.setS_CITYCODE(request.getParameter("S_CITYCODE"));
		vo.setS_BOROUGHCODE(request.getParameter("S_BOROUGHCODE"));
		vo.setS_ADDRESS(request.getParameter("S_ADDRESS"));

		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();

		if(!(request.getParameter("S_CITYCODE").equals("") && 
				request.getParameter("S_BOROUGHCODE").equals("") && 
				request.getParameter("S_ADDRESS").equals(""))){

			
			List<SA012007VO> lst = SA012007Biz.selectListSA012007(vo);
			
			System.out.println("******************************************");
			System.out.println("size()"+lst.size());
			
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				obj.put("DCODENAME",lst.get(i).getDCODENAME());
				obj.put("CITYNAME",lst.get(i).getCITYNAME());
				obj.put("BOROUGHNAME",lst.get(i).getBOROUGHNAME());
				obj.put("ADDRESS",lst.get(i).getADDRESS());
				obj.put("BUYM2",lst.get(i).getBUYM2());
				obj.put("BUYPY",lst.get(i).getBUYPY());
				obj.put("CONM2",lst.get(i).getCONM2());
				obj.put("CONPY",lst.get(i).getCONPY());
				obj.put("REMNM2",lst.get(i).getREMNM2());
				obj.put("REMNPY",lst.get(i).getREMNPY());
				obj.put("BUYDANGA",lst.get(i).getBUYDANGA());
	
				SA012007VO vo2 = new SA012007VO();
				List<SA012007VO> lst2 = SA012007Biz.selectListSA012007(vo2);
				String OPENBRANCH = "";
				for (int j = 0; j < lst.size(); j++) {
					OPENBRANCH = OPENBRANCH+lst.get(j).getOPENBRANCH() + ",";
				}
				obj.put("OPENBRANCH", OPENBRANCH);
				
				SA012007VO vo3 = new SA012007VO();
				List<SA012007VO> lst3 = SA012007Biz.selectListSA012007(vo3);
				String HOLDING = "";
				for (int k = 0; k < lst.size(); k++) {
					HOLDING = HOLDING+lst.get(k).getHOLDING() + ",";
				}
				obj.put("HOLDING", HOLDING);
				
				jCell.add(obj);
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}
	
}
