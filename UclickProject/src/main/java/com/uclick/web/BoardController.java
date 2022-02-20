package com.uclick.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.uclick.domain.Board;
import com.uclick.repository.BoardRepository;



@Controller
public class BoardController {
	
	@Autowired
	private BoardRepository boardRepository;
	
	@RequestMapping(value = "/board", method = {RequestMethod.POST, RequestMethod.GET})
	public String board(Model model) {
		List<Board> board = boardRepository.findAll();
		
		model.addAttribute("boards", board);
		
		return "board";
	}

}
