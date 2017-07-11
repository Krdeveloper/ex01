package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.Criteria;
import com.dgit.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.dgit.persistence.ReplyDAO";
	@Override
	public List<ReplyVO> list(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".list" , bno);
	}

	@Override
	public void create(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace + ".create", vo);
	}

	@Override
	public void update(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace + ".update", vo);
	}

	@Override
	public void delete(Integer rno) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete(namespace + ".delete", rno);
	}

	@Override
	public List<ReplyVO> listPage(int bno, Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("cri", cri);
		
		return sqlSession.selectList(namespace +".listPage", map);
	}

	@Override
	public int count(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".count", bno);
	}

	@Override
	public int getBno(int rno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".getBno", rno);
	}

}
