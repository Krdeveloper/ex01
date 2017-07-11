package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.dgit.persistence.MemberDAO";
	
	@Override
	public String readTime() throws Exception {
		// TODO Auto-generated method stub
		
		Object object =  sqlSession.selectOne(namespace+".getTime");
		return (String) object;
	}

	@Override
	public void createMember(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace+".insertMember",vo);
	}

	@Override
	public MemberVO readMember(String userid) throws Exception {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne(namespace + ".selectByID",userid);
	}

	@Override
	public MemberVO login(String userid, String userpw) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("userpw", userpw);
		System.out.println("============="+ userid + userpw);
		return  sqlSession.selectOne(namespace + ".login",map);
		
	}

	@Override
	public List<MemberVO> selectAll() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".selectAll");
	}

	@Override
	public void updateMember(MemberVO vo) {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+ ".updateMember",vo);
		
	}

	@Override
	public void deleteMember(String userid) {
		// TODO Auto-generated method stub
		sqlSession.delete(namespace+".deleteMember",userid);
	}

	

}
