package kr.co.jmena.www.web.home.saleMng.Biz;

import java.util.List;

import javax.annotation.Resource;

import kr.co.jmena.www.web.home.saleMng.Dao.SA012005Dao;
import kr.co.jmena.www.web.home.saleMng.Vo.SA012005VO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class SA012005Biz {
	
	@Resource(name = "SA012005Dao")
	private SA012005Dao SA012005Dao;

	public SA012005Biz() {}
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public List<SA012005VO> selectListSA012005(SA012005VO vo) throws Exception {
		List<SA012005VO> lst = null;

		try {
			lst = SA012005Dao.selectListSA012005(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}

	public List<SA012005VO> selectListSA012005_2(SA012005VO vo) throws Exception {
		List<SA012005VO> lst = null;

		try {
			lst = SA012005Dao.selectListSA012005_2(vo);
		} catch ( Exception e ) {
			throw e;
		}
		
		return lst;
	}
	
}
