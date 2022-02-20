package com.uclick.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.uclick.domain.BoardItem;

@Repository
public interface BoardItemRepository extends JpaRepository<BoardItem, Long>, JpaSpecificationExecutor<BoardItem>{
	//@Query("ALTER TABLE board_item AUTO_INCREMENT = 1")
	List<BoardItem> findByBoard_id(Long board_id);
	BoardItem getOne(Long boardItemId);
	Page<BoardItem> findAllByBoard_idAndParentIdIsNull(Long board_id, Pageable pageable);
	Page<BoardItem> findByTitleContaining(String title, Pageable pageable);
	Page<BoardItem> findByContentContaining(String content, Pageable pageable);
	List<BoardItem> findAllByParentId(Integer parentId);
	
}
