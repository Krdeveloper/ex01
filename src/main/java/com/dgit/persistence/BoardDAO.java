package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.BoardVO;
import com.dgit.domain.Criteria;
import com.dgit.domain.SearchCriteria;

public interface BoardDAO {
	public void create(BoardVO vo) throws Exception;
	
	public BoardVO read(Integer bno) throws Exception;
	
	public void update(BoardVO vo) throws Exception;
	
	public void delete(Integer bno) throws Exception;
	
	public List<BoardVO> listAll() throws Exception;
	
	public int updateViewCnt(int bno) throws Exception;
	
	public List<BoardVO> listPage(int page) throws Exception;//for test
	
	public List<BoardVO> listCriteria(Criteria cri) throws Exception;
	
	public int totalCount() throws Exception;
	
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	
	public int searchCount(SearchCriteria cri) throws Exception;
	
	public void updateReplyCnt(int bno, int amount) throws Exception;
	
	public void addAttach(String fullname) throws Exception;
	
	public List<String> getAttach(Integer bno) throws Exception;
	
	public void deleteAttach(Integer bno) throws Exception;
	
	public void replaceAttach(String fileName, Integer bno) throws Exception;
}
