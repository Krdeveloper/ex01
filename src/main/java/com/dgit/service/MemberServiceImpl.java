package com.dgit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.MemberVO;
import com.dgit.persistence.MemberDAO;
@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO dao;
	@Override
	public void addMember(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public MemberVO member(String userid) throws Exception {
		// TODO Auto-generated method stub
		return dao.readMember(userid);
	}

	@Override
	public void modifyMember(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void removeMember(String userid) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public MemberVO login(String userid, String userpw) throws Exception {
		// TODO Auto-generated method stub
		return dao.login(userid, userpw);
	}

}
