package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.BoardVO;
import com.dgit.domain.Criteria;
import com.dgit.domain.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.persistence.BoardDAO";
	
	@Override
	public void create(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".create",vo);
	}

	@Override
	public BoardVO read(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".read",bno);
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".update",vo);
		System.out.println(vo);
	}

	@Override
	public void delete(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace+".delete", bno);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".listAll");
	}

	@Override
	public int updateViewCnt(int bno) throws Exception {
		// TODO Auto-generated method stub
		return session.update(namespace+".cntUpdate",bno);
		
	}

	@Override
	public List<BoardVO> listPage(int page) throws Exception {
		// TODO Auto-generated method stub
		if(page<0){
			page=1;
		}
		page = (page-1)*10; //해당 page의 시작 게시물 index를 구함
		return session.selectList(namespace+".listPage",page);
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".listCriteria", cri);
	}

	@Override
	public int totalCount() throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".totalCount");
	}

	@Override
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public int searchCount(SearchCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".searchCount", cri);
	}

	@Override
	public void updateReplyCnt(int bno, int amount) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("amount", amount);
		session.update(namespace + ".updateReplyCnt", map);
	}

	@Override
	public void addAttach(String fullname) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".addAttach", fullname);
	}

	@Override
	public List<String> getAttach(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".getAttach", bno);
	}

	@Override
	public void deleteAttach(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".deleteAttach", bno);
	}

	@Override
	public void replaceAttach(String fileName, Integer bno) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bno", bno);
		paramMap.put("fullName", fileName);
		
		session.insert(namespace+".replaceAttach", paramMap);
	}

}
