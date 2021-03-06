package kr.co.jmena.www.web.home.personMng.Dao;

import java.util.List;

import kr.co.jmena.www.web.home.personMng.Vo.HR012001VO;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class HR012001Dao extends SqlMapClientDaoSupport {

	protected final Logger logger = Logger.getLogger(getClass());
	
	private final String NAME_SPACE = "HR012001.";

	/**
	 * @name 입사자현황 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public List<HR012001VO> selectListHR012001(HR012001VO vo) throws DataAccessException {
		List<HR012001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListHR012001", vo);
		
		return lst;
	}

	public List<HR012001VO> selectListHR012001_2(HR012001VO vo) throws DataAccessException {
		List<HR012001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListHR012001_2", vo);
		
		return lst;
	}

	public List<HR012001VO> selectListHR012001_3(HR012001VO vo) throws DataAccessException {
		List<HR012001VO> lst = null;
		
		lst = getSqlMapClientTemplate().queryForList(NAME_SPACE + "selectListHR012001_3", vo);
		
		return lst;
	}
	
}
