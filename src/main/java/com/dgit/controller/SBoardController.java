package com.dgit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgit.domain.BoardVO;
import com.dgit.domain.Criteria;
import com.dgit.domain.PageMaker;
import com.dgit.domain.SearchCriteria;
import com.dgit.service.BoardService;
import com.dgit.util.MediaUtils;
import com.dgit.util.UploadFileUtils;

@Controller
@RequestMapping("/sboard/*")
public class SBoardController {
	private static final Logger logger = LoggerFactory.getLogger(SBoardController.class);
	
	@Autowired
	BoardService service;
	
	@Resource(name="uploadPath")//bean의 id
	String uploadPath;
	
	@RequestMapping(value="listPage", method=RequestMethod.GET)
	public String listPage(@ModelAttribute("cri")SearchCriteria cri, Model model) throws Exception{
		logger.info("-----list----------GET");
		model.addAttribute("list",service.listSearch(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.searchCount(cri));
		model.addAttribute("pageMaker",pageMaker);
		
		
		return "sboard/listPage";
	}
	/*@RequestMapping(value="listAll", method=RequestMethod.GET)
	public String listAll(Model model) throws Exception{
		List<BoardVO> list = service.listAll();
		model.addAttribute("list",list);
		return "sboard/listAll";
	}*/
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public String regsterGet() throws Exception{
		return "sboard/register";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerPost(BoardVO vo, List<MultipartFile> imgFiles) throws Exception{
		logger.info(vo.toString());
		ArrayList<String> list = new ArrayList<>();
		
		for(MultipartFile file : imgFiles){
			logger.info("=============!!!===========filename : " + file.getOriginalFilename());
			
			String thumb = UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
			
			list.add(thumb);
		}
		vo.setFiles(list.toArray(new String[list.size()]));
		service.regist(vo);
		return "redirect:listPage";
	}
	
	@RequestMapping(value="read", method=RequestMethod.GET)
	public String read(int bno,boolean modifyCnt, @ModelAttribute("cri")SearchCriteria cri, Model model) throws Exception{
		BoardVO vo = service.read(bno);
		System.out.println(modifyCnt);
		if(modifyCnt==false){
			service.updateViewCnt(bno);	
		}
		
		
		model.addAttribute("board",vo);
		return "sboard/read";
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(int bno,@ModelAttribute("cri")SearchCriteria cri) throws Exception{
		service.remove(bno);
		return "redirect:listPage?page="+cri.getPage()
		+ "&searchType="+ cri.getSearchType() +"&keyword=" + cri.getKeyword();
	}
	@RequestMapping(value="modify", method=RequestMethod.GET)
	public String modify(int bno, Model model, @ModelAttribute("cri")SearchCriteria cri) throws Exception{
		BoardVO vo = service.read(bno);
		model.addAttribute("board",vo);
		return "sboard/modify";
	}
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(BoardVO vo, RedirectAttributes rttr, SearchCriteria cri) throws Exception{
		
		System.out.println(vo);
		service.modify(vo);
		rttr.addAttribute("modifyCnt", true);
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", cri.getPage() );
		rttr.addAttribute("searchType", cri.getSearchType());	
		rttr.addAttribute("keyword", cri.getKeyword());	
		
		return "redirect:read";
	}
	
	@RequestMapping(value="/getAttach/{bno}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("bno")Integer bno) throws Exception{
		return service.getAttach(bno);
	}
	
	@ResponseBody
	@RequestMapping(value="displayFile") //displayFile?filename=boxing.jpg
	public ResponseEntity<byte[]> displayFile(String fileName) throws IOException{
		ResponseEntity<byte[]> entity = null;
		InputStream in = null;
		
		logger.info("--------displayFile : " + fileName);
		
		try{
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			HttpHeaders header = new HttpHeaders();
			header.setContentType(mType);
			System.out.println(uploadPath +  fileName);
			in = new FileInputStream(uploadPath +  fileName);
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), header, HttpStatus.CREATED);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally{
			in.close();
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteAllFiles", method=RequestMethod.POST)
	public ResponseEntity<String> deleteFile(@RequestParam("files[]") String[] files){
		
		logger.info("-----------------deleteAllFile : " + files);
		
		if(files ==null || files.length ==0){
			return new ResponseEntity<String>("deleted", HttpStatus.OK);
		}
		
		for(String fileName : files){
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			
			MediaType mType = MediaUtils.getMediaType(formatName);
			
			if(mType !=null){
				String front = fileName.substring(0, 12);
				String end = fileName.substring(14);
				new File(uploadPath + (front+end)).delete();
			}
			new File(uploadPath + fileName).delete();
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
		
	}
}
