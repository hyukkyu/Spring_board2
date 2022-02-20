package com.uclick.web;

import java.io.File;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import com.uclick.domain.Board;
import com.uclick.domain.BoardItem;
import com.uclick.repository.BoardItemRepository;
import com.uclick.repository.BoardRepository;
import com.uclick.service.BoardItemService;

@Controller
public class BoardItemController {

	@Autowired
	private BoardRepository boardRepository;
	
	@Autowired
	private BoardItemRepository boardItemRepository;
	
	@Autowired
	private BoardItemService boardItemService;
	
	@Autowired
	private HttpServletRequest request;
	
	
	@RequestMapping(value = "/boardItem", method = {RequestMethod.POST, RequestMethod.GET})
	public String boardItem(Model model, @RequestParam(value="boardId", required=false) Long boardId,
										 @PageableDefault(size = 10, sort = "id", direction = Sort.Direction.ASC) Pageable pageable) {
		
		List<BoardItem> boardItem = boardItemRepository.findByBoard_id(boardId);
		Page<BoardItem> boardItem2 = boardItemRepository.findAllByBoard_idAndParentIdIsNull(boardId, pageable);
		
		
		int pageNumber = boardItem2.getPageable().getPageNumber();	//현재페이지
		int totalPages = boardItem2.getTotalPages();	//총페이지수
		int pageBlock = 5; //블럭의 수
		int startBlockPage = ((pageNumber) / pageBlock) * pageBlock + 1;	//현재페이지가 7이면  1*5+1=6
		int endBlockPage = startBlockPage + pageBlock -1;	//6+5-1=10. 6,7,8,9,10해서 10.
		endBlockPage = totalPages<endBlockPage? totalPages:endBlockPage;
		
		model.addAttribute("boardItems", boardItem);
		model.addAttribute("boardItem2", boardItem2);
		model.addAttribute("boardId", boardId);
		model.addAttribute("startBlockPage", startBlockPage);
		model.addAttribute("endBlockPage", endBlockPage);
		
		
		return "boardItem";
	}
	
	@RequestMapping(value = "/boardInsert", method = {RequestMethod.POST, RequestMethod.GET})
	   public String boardInsert(Model model, @RequestParam(value="boardId", required=false) Long boardId,
			   								  @RequestParam(value="count", required=false) Integer count) {
	      
	      String date = boardItemService.getDate();
	      
	      model.addAttribute("date", date);
	      model.addAttribute("boardId", boardId);
	      model.addAttribute("count", count);	      
	      return "boardInsert";
	   }
	   
	   @RequestMapping(value = "/boardShow", method = {RequestMethod.POST, RequestMethod.GET})
	   public String boardShow(Model model, @RequestParam(value="boardId", required=false) long boardId,
	                               @RequestParam(name="title", required=false) String title,
	                               @RequestParam(name="time", required=false) String time,
	                               @RequestParam(name="content", required=false) String content,
	                               @RequestParam(name="password", required=false) String password,
	                               @RequestParam(value="files", required=false) MultipartFile file) throws Exception {
		  
	      Board board = boardRepository.findById(boardId);
	      BoardItem boardItem = new BoardItem();
	      
	      UUID uuid = UUID.randomUUID();	//고유 식별자
	      
	      //String rootPath = FileSystemView.getFileSystemView().getHomeDirectory().toString();
	      String basePath = "C:\\Users\\uclick\\Documents\\workspace-spring-tool-suite-4-4.11.0.RELEASE\\UclickProject\\src\\main\\webapp\\resources\\upload";
	      System.out.println("name : " + file.getOriginalFilename());
	      String savedName = "";
	      if (file.getOriginalFilename().isEmpty()) {
	    	  savedName = "";
	      } else {
	    	  savedName = uuid + "-" + file.getOriginalFilename();	    	  
	    	  String filePath = basePath + "\\" + savedName;
	    	  File dest = new File(filePath);
	    	  file.transferTo(dest);
	      }
	      
	      //System.out.println("path : " + request.getContextPath().toString());
	      
//	      String realPath = sc.getRealPath("webapp/resources/upload/") + file.getOriginalFilename();
//	      System.out.println("pathasdf : " + realPath);
	      
	      BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	     
	      String securePw;
	      
	      if (password.equals("")) {
	    	  boardItem.setPassword(password);
	      } else {
	    	  securePw = encoder.encode(password);
	    	  boardItem.setPassword(securePw);
	      }
	      
	      boardItem.setTitle(title);
	      boardItem.setDate(time);
	      boardItem.setContent(content);
	      boardItem.setFileUrl(savedName);
	      //boardItem.setPassword(securePw);
	      boardItem.setBoard(board);
	      
	      List<BoardItem> list = new ArrayList<>();
	      list.add(boardItem);
	      
	      board.setBoardItems(list);
	      
	      boardRepository.save(board);
	      model.addAttribute("boardId", boardId);
	      
	      return "boardShow";
	   }
	   
	   @RequestMapping(value = "/boardView", method = {RequestMethod.POST, RequestMethod.GET})
	   public String boardView(Model model, @RequestParam(value="boardId", required=false) Long boardId,
	                               @RequestParam(value="boardItemId", required=false) Long boardItemId,
	                               @RequestParam(value="count", required=false) Integer count) {
	      
	      BoardItem boardItem = boardItemRepository.getOne(boardItemId);
	      
	      Integer parentId = (int)(long) boardItemId;
	      
	      List<BoardItem> boardItems = boardItemRepository.findAllByParentId(parentId);
	      
	      model.addAttribute("boardItemId", boardItem.getId());
	      model.addAttribute("title", boardItem.getTitle());
	      model.addAttribute("date", boardItem.getDate());
	      model.addAttribute("content", boardItem.getContent());
	      model.addAttribute("url", boardItem.getFileUrl());
	      model.addAttribute("boardId", boardId);
	      model.addAttribute("count", count);
	      model.addAttribute("path", request.getContextPath());
	      
	      model.addAttribute("boardItem2", boardItems);
	      
	      
	      return "boardView";
	   }
	   
	   @RequestMapping(value = "/boardUpdate", method = {RequestMethod.POST, RequestMethod.GET})
	   public String boardUpdate(Model model, @RequestParam(value="boardId", required=false) Long boardId,
	                                 		  @RequestParam(name="boardItemId", required=false) Long boardItemId,
	                                 		  @RequestParam(name="count", required=false) Integer count) {
	      BoardItem boardItem = boardItemRepository.getOne(boardItemId);
	      
	      model.addAttribute("boardItemId", boardItem.getId());
	      model.addAttribute("title", boardItem.getTitle());
	      model.addAttribute("date", boardItem.getDate());
	      model.addAttribute("content", boardItem.getContent());
	      model.addAttribute("path", request.getContextPath());
	      model.addAttribute("url", boardItem.getFileUrl());
	      
	      model.addAttribute("boardId", boardId);
	      model.addAttribute("count", count);
	      
	      return "boardUpdate";
	   }
	   
	   @RequestMapping(value = "/boardWrite", method = {RequestMethod.POST, RequestMethod.GET})
	   public String boardWrite(Model model, @RequestParam(value="boardId", required=false) Long boardId,
	                                @RequestParam(name="boardItemId", required=false) Long boardItemId,
	                                @RequestParam(name="title", required=false) String title,
	                                @RequestParam(name="content", required=false) String content,
	                                @RequestParam(name="count", required=false) Integer count,
	                                @RequestParam(name="password", required=false) String password) {
	      
	      BoardItem boardItem = boardItemRepository.findById(boardItemId).get();
	      
	      BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	      
	      //DB에 저장된 비밀번호와 입력받은 비밀번호 일치여부확인
	      Boolean isMatches = encoder.matches(password, boardItem.getPassword());
	      
	      //DB비밀번호가 있을시 일치여부
	      Boolean judge;
	      if (isMatches) {
	    	  judge = true;
	      } else {
	    	  judge = false;
	      }
	      //DB에 비밀번호 null체크
	      Boolean judgeNull;
	      if (boardItem.getPassword().isEmpty()) {
	    	  judgeNull = true;
	      } else {
	    	  judgeNull = false;
	      }
	      
	      //입력받은 비밀번호 null체크
	      Boolean judgePassword;
	      if (password.isEmpty()) {
	    	  judgePassword = true;
	      } else {
	    	  judgePassword = false;
	      }
	      
	      //DB에 비밀번호 없을시 비밀번호 일치여부
	      Boolean success;
	      if (boardItem.getPassword().equals(password)) {
	    	  success = true;
	      } else {
	    	  success = false;
	      }
	      
//	      String date = boardItemService.getDate();
//	      
//	      boardItem.setTitle(title);
//	      boardItem.setDate(date);
//	      boardItem.setContent(content);
//	      
//	      boardItemRepository.save(boardItem);
	      
	      model.addAttribute("boardItemId", boardItem.getId());
//	      model.addAttribute("title", boardItem.getTitle());
//	      model.addAttribute("date", boardItem.getDate());
//	      model.addAttribute("content", boardItem.getContent());
	      model.addAttribute("boardId", boardId);
	      model.addAttribute("boardItemId", boardItemId);
	      model.addAttribute("title", title);
	      model.addAttribute("content", content);
	      //model.addAttribute("count", count);
//	      model.addAttribute("password", password);
//	      model.addAttribute("itemPassword", boardItem.getPassword());
	      model.addAttribute("judge", judge);
	      model.addAttribute("judgeNull", judgeNull);
	      model.addAttribute("judgePassword", judgePassword);
	      model.addAttribute("success", success);
	      
	      return "boardWrite";
	   }
	   
	   @RequestMapping(value = "/boardWriteNull", method = {RequestMethod.POST, RequestMethod.GET})
	   public String boardWriteNull(Model model, @RequestParam(value="boardId", required=false) Long boardId,
			   									 @RequestParam(value="boardItemId", required=false) Long boardItemId,
			   									 @RequestParam(value="title", required=false) String title,
			   									 @RequestParam(value="content", required=false) String content) {
		   
		   BoardItem boardItem = boardItemRepository.findById(boardItemId).get();
		   
		   String date = boardItemService.getDate();
		   
		   boardItem.setTitle(title);
		   boardItem.setContent(content);
		   boardItem.setDate(date);
		   
		   boardItemRepository.save(boardItem);
		   
		   model.addAttribute("title", boardItem.getTitle());
		   model.addAttribute("content", boardItem.getContent());
		   model.addAttribute("date", boardItem.getDate());
		   model.addAttribute("boardId", boardId);
		   
		   return "boardWriteNull";
	   }
	   
	   @RequestMapping(value = "/boardWriteNotNull", method= {RequestMethod.POST, RequestMethod.GET})
	   public String boardWriteNotNull(Model model, @RequestParam(value="boardId", required=false) Long boardId,
			   										@RequestParam(value="boardItemId", required=false) Long boardItemId,
			   										@RequestParam(value="title", required=false) String title,
			   										@RequestParam(value="content", required=false) String content) {
		   BoardItem boardItem = boardItemRepository.findById(boardItemId).get();
		   
		   String date = boardItemService.getDate();
		   
		   boardItem.setTitle(title);
		   boardItem.setContent(content);
		   boardItem.setDate(date);
		   
		   boardItemRepository.save(boardItem);
		   
		   model.addAttribute("boardId", boardId);
		   model.addAttribute("title", boardItem.getTitle());
		   model.addAttribute("content", boardItem.getContent());
		   model.addAttribute("date", boardItem.getDate());
		   
		   return "boardWriteNotNull";
	   }
	   
	   @RequestMapping(value = "/boardDelete", method = {RequestMethod.POST, RequestMethod.GET})
	   public String boardDelete(Model model, @RequestParam(value="boardId", required=false) Long boardId,
	                                 @RequestParam(name="password", required=false) String password,
	                                 @RequestParam(value="boardItemId", required=false) Long boardItemId) {
	      
	      BoardItem boardItem = boardItemRepository.findById(boardItemId).get();
	      
	      BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	      
	      //DB에 저장된 비밀번호와 입력받은 비밀번호 일치여부확인
	      Boolean isMatches = encoder.matches(password, boardItem.getPassword());
	      
	      //DB비밀번호가 있을시 일치여부
	      Boolean judge;
	      if (isMatches) {
	    	  judge = true;
	      } else {
	    	  judge = false;
	      }
	      //DB에 비밀번호 null체크
	      Boolean judgeNull;
	      if (boardItem.getPassword().isEmpty()) {
	    	  judgeNull = true;
	      } else {
	    	  judgeNull = false;
	      }
	      
	      //입력받은 비밀번호 null체크
	      Boolean judgePassword;
	      if (password.isEmpty()) {
	    	  judgePassword = true;
	      } else {
	    	  judgePassword = false;
	      }
	      
	      //DB에 비밀번호 없을시 비밀번호 일치여부
	      Boolean success;
	      if (boardItem.getPassword().equals(password)) {
	    	  success = true;
	      } else {
	    	  success = false;
	      }
	      
	      model.addAttribute("boardId", boardId);
	      model.addAttribute("boardItemId", boardItemId);
	      model.addAttribute("password", password);
	      model.addAttribute("itemPassword", boardItem.getPassword());
	      model.addAttribute("judge", judge);
	      model.addAttribute("judgeNull", judgeNull);
	      model.addAttribute("judgePassword", judgePassword);
	      model.addAttribute("success", success);
	         
	      return "boardDelete";
	   }
	   
	   @RequestMapping(value = "/boardDeleteNull", method = {RequestMethod.POST, RequestMethod.GET})
	   public String boardDeleteNull(Model model, @RequestParam(value="boardId", required=false) Long boardId,
	                                    @RequestParam(value="boardItemId", required=false) Long boardItemId) {
	      
	      boardItemRepository.deleteById(boardItemId);
	      
	      model.addAttribute("boardId", boardId);
	      model.addAttribute("boardItemId", boardItemId);
	      
	      return "boardDeleteNull";
	   }
	   
	   @RequestMapping(value = "/boardDeleteNotNull", method = {RequestMethod.POST, RequestMethod.GET})
	   public String boardDeleteNotNull(Model model, @RequestParam(value="boardId", required=false) Long boardId,
	                                      @RequestParam(value="boardItemId", required=false) Long boardItemId) {
	      
	      boardItemRepository.deleteById(boardItemId);
	      
	      model.addAttribute("boardId", boardId);
	      model.addAttribute("boardItemId", boardItemId);
	      
	      return "boardDeleteNotNull";
	   }
	   
	   @RequestMapping(value = "/boardSearch", method= {RequestMethod.POST, RequestMethod.GET})
	   public String boardSearch(Model model, @RequestParam(value="type", required=false) String type,
			   								  @RequestParam(name="word", required=false) String word,
			   								  @RequestParam(name="boardId", required=false) Long boardId,
			   								  @PageableDefault(size = 10, sort = "id", direction = Sort.Direction.ASC) Pageable pageable) {
		   
		   Page<BoardItem> boardItem = null;
		   int pageNumber = 0;		//현재페이지
		   int totalPages = 0;		//총페이지수
		   int pageBlock = 5; 		//블럭의 수
		   int startBlockPage = 0;	
		   int endBlockPage = 0;	
		   
		   if (type.equals("typeTitle")) {
			   boardItem = boardItemRepository.findByTitleContaining(word, pageable);
			   pageNumber = boardItem.getPageable().getPageNumber();		//현재페이지
			   totalPages = boardItem.getTotalPages();						//총페이지수
			   pageBlock = 5;
			   startBlockPage = ((pageNumber) / pageBlock) * pageBlock + 1;	//현재페이지가 7이면 1*5+1=6
			   endBlockPage = startBlockPage + pageBlock - 1;
			   endBlockPage = totalPages<endBlockPage? totalPages:endBlockPage;
		   } else if (type.equals("typeContent")) {
			   boardItem = boardItemRepository.findByContentContaining(word, pageable);
			   pageNumber = boardItem.getPageable().getPageNumber();		//현재페이지
			   totalPages = boardItem.getTotalPages();						//총페이지수
			   startBlockPage = ((pageNumber) / pageBlock) * pageBlock + 1;	//현재페이지가 7이면 1*5+1=6
			   pageBlock = 5;
			   endBlockPage = startBlockPage + pageBlock - 1;
			   endBlockPage = totalPages<endBlockPage? totalPages:endBlockPage;
		   }
		   
		   model.addAttribute("type", type);
		   model.addAttribute("word", word);
		   model.addAttribute("boardItems", boardItem);
		   model.addAttribute("startBlockPage", startBlockPage);
		   model.addAttribute("endBlockPage", endBlockPage);
		   model.addAttribute("boardId", boardId);
		   
		   return "boardSearch";
	   }
	   
	   @RequestMapping(value = "/boardComment", method = {RequestMethod.POST, RequestMethod.GET})
	   public String boardComment(Model model, @RequestParam(name="comment", required=false) String comment,
			   								   @RequestParam(value="boardId", required=false) long boardId,
			   								   @RequestParam(value="boardItemId", required=false) Long boardItemId) {
		   
		   Board board = boardRepository.findById(boardId);
		   BoardItem boardItem = new BoardItem();
		   
		   int parentId = (int) (long) boardItemId;
		   String date = boardItemService.getDate();
		   
		   boardItem.setContent(comment);
		   boardItem.setParentId(parentId);
		   boardItem.setDate(date);
		   boardItem.setBoard(board);
		   
		   List<BoardItem> list = new ArrayList<>();
		   list.add(boardItem);
		   
		   board.setBoardItems(list);
		   
		   boardRepository.save(board);
		   
		   model.addAttribute("boardId", boardId);
		   
		   return "boardComment";
	   }
}
