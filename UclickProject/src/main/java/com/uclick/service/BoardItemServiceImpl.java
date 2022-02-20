package com.uclick.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uclick.repository.BoardItemRepository;

@Service
public class BoardItemServiceImpl implements BoardItemService{

	@Autowired
	private BoardItemRepository boardItemRepository;

	@Override
	public String getDate() {
		// TODO Auto-generated method stub
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		String day = sf.format(date);
		return day;
	}
	
	
}
