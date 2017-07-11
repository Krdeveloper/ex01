package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.MemberVO;

public interface MemberDAO {
	public String readTime() throws Exception;
	
	public void createMember(MemberVO vo) throws Exception;
	
	public MemberVO readMember(String userid) throws Exception;
	
	public MemberVO login(String userid, String userpw) throws Exception;
	
	public List<MemberVO> selectAll();
	
	public void updateMember(MemberVO vo);
	
	public void deleteMember(String userid);
	
	
}
