package com.dgit.ex01;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dgit.domain.BoardVO;
import com.dgit.domain.Criteria;
import com.dgit.persistence.BoardDAO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BoardDAOTest {
	private Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);//log로 찍고 싶으면
	@Autowired
	private BoardDAO dao;
	
	
	
	/*@Test
	public void testCreate() throws Exception{
		BoardVO board = new BoardVO();
		board.setTitle("새로운 글을 넣습니다.");
		board.setContent("새로운 글을 넣습니다.");
		board.setWriter("user00");
		dao.create(board);
	}*/
	/*@Test
	public void testRead() throws Exception{
		System.out.println(dao.read(1).toString());
	}*/
	
	/*@Test
	public void tesetSelectAll() throws Exception{
		System.out.println(dao.listAll());
	}*/
	/*@Test
	public void testUpdate() throws Exception{
		BoardVO board = new BoardVO();
		board.setBno(1);
		board.setTitle("수정된 글입니다.");
		board.setContent("수정 테스트");
		dao.update(board);
	}*/
	/*@Test
	public void testDelete()  throws Exception{
		dao.delete(1);
	}*/
	
	/*@Test
	public void testListPage() throws Exception{
		int page=3;
		List<BoardVO> list = dao.listPage(page);
		for(BoardVO vo : list){
			logger.info(vo.getBno()+ " : " + vo.getTitle());
		}
	}*/
	
	@Test
	public void testListCriteria() throws Exception{
		Criteria cri = new Criteria();
		cri.setPage(1); //page번호
		cri.setPerPageNum(20);//page안의 게시물 갯수
		
		System.out.println(cri.toString());
		
		List<BoardVO> list = dao.listCriteria(cri);
		for(BoardVO vo : list){
			System.out.println(vo.getBno() + " : " + vo.getTitle());
		}
	}
}
