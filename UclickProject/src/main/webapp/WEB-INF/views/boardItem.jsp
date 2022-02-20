<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
	html {
		height: 100%;
	}
	
	body {
		position: relative;
		width: 100%;
		height: 100%;
	}
	
	ul li {
		list-style-type: none;
		float: left;
		margin-left: 20px;
		display: inline;
	}
	
   	.menu {
   		position: absolute;
   		top: 540px;
   		left: 50%;
   		margin: 100px 0 0 -190px;
   	}
   	
   	td {
   		text-align: center;
   		border-top: 1px solid #DCDCDC;
   		padding: 10px;
   		
   	}
   	
   	th {
   		background-color: #ADD8E6;
   		padding: 10px;
   	}
   	
   	.table1 {
   		margin-top: 30px;
   		border: 1px solid black;
   		border-top: 2px solid #191970;
		border-bottom: 2px solid #191970;
		border-left: none;
		border-right: none;
   		border-collapse: collapse;
   	}
   	
   	#btn1 {
   		margin-top: 10px;
   		margin-left: 580px;
   	}
   	
   	.class1 {
   		width: 50px;
   	}
   	
   	.class2 {
   		width: 400px;
   	}
   	
   	.class3 {
   		width: 150px;
   	}
   	
   	a {
   		color: black;
   		text-decoration: none;
   	}
   	a:hover {
   		color: #0A82FF;
   		text-decoration: underline;
   	}
   	
   	
</style>
</head>
<body>
<center>
	<form method="post">
		<fieldset style="width:630px; border-right:2px solid #ADD8E6; border-left:2px solid #ADD8E6; border-top:2px solid #ADD8E6; border-bottom:2px solid #ADD8E6;">
			<legend>검색</legend>
			검색분류
			<select name="type">
				<option value="typeTitle">제목</option>
				<option value="typeContent">내용</option>
			</select>
				검색
				<input type="text" name="word" placeholder="입력해주세요">
				<input type="submit" formaction="/UclickProject/boardSearch?boardId=${boardId}" value="검색">
		</fieldset>
	</form>
	
   <form>
      <table class="table1">
         <tr>
            <th class="class1">번호</th>
            <th class="class2">제목</th>
            <th class="class3">날짜</th>
         </tr>
         <c:forEach var="boardItem" items="${boardItem2.content}">
         <c:set var="i" value="${i+1}"/>
            <tr>
               <td>${((boardItem2.pageable.pageNumber*boardItem2.size)+i)}</td>
               <td><a href="/UclickProject/boardView?boardId=${boardId}&boardItemId=${boardItem.getId()}">${boardItem.getTitle()}</a></td>
               <td>${boardItem.getDate()}</td>
            </tr>
         </c:forEach>
      </table>
            	
      <input type="button" id="btn1" onclick="location.href='/UclickProject/boardInsert?boardId=${boardId}'" value="신규">
   </form>
   </center>
   		

   <!-- 페이징 영역시작 -->
   <div class="div1">
   	   <ul class="menu">
		   <!-- 이전 -->
		   <c:choose>
		   		<c:when test="${boardItem2.first}"></c:when>
		   		<c:otherwise>
		   			<li><a href="/UclickProject/boardItem?boardId=${boardId}&page=0">처음</a></li>
		   			<li><a href="/UclickProject/boardItem?boardId=${boardId}&page=${boardItem2.number-1}">&larr;</a></li>
		   		</c:otherwise>
		   </c:choose>
		   
		   <!-- 페이지 그룹 -->
		   <c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i">
		   		<c:choose>
			   		<c:when test="${boardItem2.pageable.pageNumber+1 == i}">
			   			<li><a href="/UclickProject/boardItem?boardId=${boardId}&page=${i-1}">${i}</a></li>
			   		</c:when>
			   		<c:otherwise>
			   			<li><a href="/UclickProject/boardItem?boardId=${boardId}&page=${i-1}">${i}</a></li>
			   		</c:otherwise>
		   		</c:choose>
		   </c:forEach>
		   
		   <!-- 다음 -->
		   <c:choose>
		   		<c:when test="${boardItem2.last}"></c:when>
		   		<c:otherwise>
		   			<li><a href="/UclickProject/boardItem?boardId=${boardId}&page=${boardItem2.number+1}">&rarr;</a></li>
		   			<li><a href="/UclickProject/boardItem?boardId=${boardId}&page=${boardItem2.totalPages-1}">마지막</a></li>
		   		</c:otherwise>
		   </c:choose>
	   </ul>
   </div>
   
</body>
</html>