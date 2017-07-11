package com.dgit.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dgit.domain.BoardVO;
import com.dgit.domain.Criteria;
import com.dgit.domain.PageMaker;
import com.dgit.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private BoardService service;
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public String regsterGet() throws Exception{
		return "board/register";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerPost(BoardVO vo) throws Exception{
		service.regist(vo);
		return "redirect:listPage";
	}
	
	@RequestMapping(value="listAll", method=RequestMethod.GET)
	public String listAll(Model model) throws Exception{
		List<BoardVO> list = service.listAll();
		model.addAttribute("list",list);
		return "board/listAll";
	}
	
	@RequestMapping(value="listPage", method=RequestMethod.GET)
	public String listPage(Criteria cri, Model model) throws Exception{
		List<BoardVO> list = service.listCriteria(cri);		
		model.addAttribute("list",list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.totalCount());
		
		System.out.println(pageMaker.toString());
		model.addAttribute("pageMaker", pageMaker);
		
		return "board/listPage";
	}
	@RequestMapping(value="read", method=RequestMethod.GET)
	public String read(int bno, @ModelAttribute("cri")Criteria cri, Model model) throws Exception{
		BoardVO vo = service.read(bno);
		
		
		
		model.addAttribute("board",vo);
		return "board/read";
	}
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(int bno,@ModelAttribute("cri")Criteria cri) throws Exception{
		service.remove(bno);
		return "redirect:listPage?page="+cri.getPage();
	}
	@RequestMapping(value="modify", method=RequestMethod.GET)
	public String modify(int bno, Model model, @ModelAttribute("cri")Criteria cri) throws Exception{
		BoardVO vo = service.read(bno);
		model.addAttribute("board",vo);
		return "board/modify";
	}
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(BoardVO vo, Criteria cri, Model model) throws Exception{
		
		System.out.println(vo);
		service.modify(vo);
		
		return "redirect:read?bno=" + vo.getBno() + "&page=" + cri.getPage();
	}
	@RequestMapping(value="modifyCnt", method=RequestMethod.GET)
	public String modifyCnt(int bno, Model model) throws Exception{
		BoardVO vo = service.read(bno);
		model.addAttribute("board",vo);
		return "board/modify";
	}
	@RequestMapping(value="/modifyCnt", method=RequestMethod.POST)
	public String modifyCnt(BoardVO vo) throws Exception{
		System.out.println(vo);
		service.modify(vo);
		return "redirect:listAll";
	}
}
