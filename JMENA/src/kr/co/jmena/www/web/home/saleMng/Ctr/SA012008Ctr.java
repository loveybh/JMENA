package kr.co.jmena.www.web.home.saleMng.Ctr;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jmena.www.web.home.saleMng.Biz.SA012008Biz;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012008VO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SA012008Ctr {
	
	@Resource(name = "SA012008Biz")
	private SA012008Biz SA012008Biz;
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public SA012008Ctr() {}
	
	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/SA012008.do")
	public ModelAndView SA012008(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return new ModelAndView("home/saleMng/SA012008");
	}

	/**
	 * @name 매출관리 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/home/selectListSA012008.do")
	public ModelAndView selectListSA012008(HttpServletRequest request, HttpServletResponse response) throws Exception {
		SA012008VO vo = new SA012008VO();
		SA012008VO vo1 = new SA012008VO();
		
		vo.setS_CITYCODE(request.getParameter("S_CITYCODE"));
		vo.setS_BOROUGHCODE(request.getParameter("S_BOROUGHCODE"));
		vo.setS_ADDRESS(request.getParameter("S_ADDRESS"));
		
		JSONArray jCell = new JSONArray();
		JSONObject json = new JSONObject();
		
		if(!(request.getParameter("S_CITYCODE").equals("") && 
				request.getParameter("S_BOROUGHCODE").equals("") && 
				request.getParameter("S_ADDRESS").equals(""))){
		
			List<SA012008VO> lst = SA012008Biz.selectListSA012008(vo);
			
			System.out.println("******************************************");
			System.out.println("size()"+lst.size());
			
			
			for (int i = 0; i < lst.size(); i++) {
				JSONObject obj = new JSONObject();
				
				vo.setBUYID(request.getParameter(lst.get(i).getBUYID()));
	
				List<SA012008VO> lst2 = SA012008Biz.selectListSA012008_2(vo1);
				if(lst2.size() > 0){
					for (int j = 0; j < lst.size(); j++) {
						if(j == 0){
							obj.put("BUYGUBUN",lst.get(i).getBUYGUBUN());
							obj.put("OWNERNAME",lst.get(i).getOWNERNAME());
							obj.put("OWNERJUMINID",lst.get(i).getOWNERJUMINID());
							obj.put("ADDRESS",lst.get(i).getADDRESS());
							obj.put("BUYM2",lst.get(i).getBUYM2());
							obj.put("REGDATE1",lst.get(i).getREGDATE1());
							obj.put("BUYAMT",lst.get(i).getBUYAMT());
							
						}else{
							obj.put("BUYGUBUN","");
							obj.put("OWNERNAME","");
							obj.put("OWNERJUMINID","");
							obj.put("ADDRESS","");
							obj.put("BUYM2","");
							obj.put("REGDATE1","");
							obj.put("BUYAMT","");
							
						}
						obj.put("SELLSEQ",lst.get(i).getSELLSEQ());
						obj.put("CONNAME",lst.get(i).getCONNAME());
						obj.put("CONJUMINID",lst.get(i).getCONJUMINID());
						obj.put("CONM2",lst.get(i).getCONM2());
						obj.put("REGDATE2",lst.get(i).getREGDATE2());
						obj.put("SALEAMT",lst.get(i).getSALEAMT());
						obj.put("REMNM2",lst.get(i).getREMNM2());
						obj.put("REMNAMT",lst.get(i).getREMNAMT());
						
						jCell.add(obj);
					}
				}else{
					obj.put("BUYGUBUN",lst.get(i).getBUYGUBUN());
					obj.put("OWNERNAME",lst.get(i).getOWNERNAME());
					obj.put("OWNERJUMINID",lst.get(i).getOWNERJUMINID());
					obj.put("ADDRESS",lst.get(i).getADDRESS());
					obj.put("BUYM2",lst.get(i).getBUYM2());
					obj.put("REGDATE1",lst.get(i).getREGDATE1());
					obj.put("BUYAMT",lst.get(i).getBUYAMT());
					obj.put("SELLSEQ","");
					obj.put("CONNAME","");
					obj.put("CONJUMINID","");
					obj.put("CONM2","");
					obj.put("REGDATE2","");
					obj.put("SALEAMT","");
					obj.put("REMNM2","");
					obj.put("REMNAMT","");
					
					jCell.add(obj);
				}
				
			}
		}
		
		json.put("rows", jCell);
		
		logger.debug("[selectListSysMst]" + json);
		
		return new ModelAndView("jsonView", json);
	}

}
