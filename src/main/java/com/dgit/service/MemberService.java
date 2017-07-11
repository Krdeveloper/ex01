package com.dgit.service;

import java.util.List;

import com.dgit.domain.MemberVO;
import com.dgit.domain.ReplyVO;

public interface MemberService {
	public void addMember(MemberVO vo) throws Exception;
	
	public MemberVO member(String userid) throws Exception;
	
	public void modifyMember(MemberVO vo) throws Exception;
	
	public void removeMember(String userid) throws Exception;
	
	public MemberVO login(String userid, String userpw) throws Exception;
}
