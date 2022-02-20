<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	html {
		height: 100%;
	}
	body {
		position: relative;
		width: 100%;
		height: 100%;
	}
	table {
		border: 1px solid black;
		border-top: 2px solid #191970;
		border-bottom: 2px solid #191970;
		border-left: none;
		border-right: none;
		border-collapse: collapse;
	}
	td {
		border-top: 1px solid #DCDCDC;
		text-align: center;
		padding: 10px;
	}
	
	th {
   		background-color: #ADD8E6;
   		padding: 10px;
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
	#btn1 {
		margin-top: 10px;
		margin-left: 610px;
	}
	
	ul li {
		list-style-type: none;
		float: left;
		margin-left: 20px;
		display: inline;
	}
	
	.menu {
		position: absolute;
		top: 490px;
		left: 50%;
		margin: 30px 0 0 -150px;
	}
	a {
   		color: black;
   		text-decoration: none;
   	}
   	a:hover {
   		color: #0A82FF;
   		text-decoration: underline;
   	}
   	.div2 {
   		margin-top: -45px;
   	}
</style>
</head>
<body>
<center>
<h4>게시글 검색</h4>
<table>
	<tr>
		<th class="class1">번호</th>
		<th class="class2">제목</th>
		<th class="class3">날짜</th>
	</tr>
	<c:forEach var="boardItem" items="${boardItems.content}">
	<c:set var="i" value="${i+1}"/>
		<tr>
			<td>${((boardItems.pageable.pageNumber*boardItems.size)+i)}</td>
			<td><a href="/UclickProject/boardView?boardId=${boardId}&boardItemId=${boardItem.getId()}">${boardItem.getTitle()}</td>
			<td>${boardItem.getDate()}</td>
		</tr>
	</c:forEach>
</table>
<input type="button" id="btn1" onclick="location.href='/UclickProject/boardItem?boardId=${boardId}'" value="목록">
</center>

	<!-- 페이징 영역시작 -->
	<div class="div1">
		<ul class="menu">
			<!-- 이전 -->
			<c:choose>
				<c:when test="${boardItems.first}"></c:when>
				<c:otherwise>
					<li><a href="/UclickProject/boardSearch?boardId=${boardId}&type=${type}&word=${word}&page=0">처음</a></li>
					<li><a href="/UclickProject/boardSearch?boardId=${boardId}&type=${type}&word=${word}&page=${boardItems.number-1}">&larr;</a></li>
				</c:otherwise>
			</c:choose>
			
			<!-- 페이지 그룹 -->
			<c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i">
				<c:choose>
					<c:when test="${boardItems.pageable.pageNumber+1 == i}">
						<li><a href="/UclickProject/boardSearch?boardId=${boardId}&type=${type}&word=${word}&page=${i-1}">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="/UclickProject/boardSearch?boardId=${boardId}&type=${type}&word=${word}&page=${i-1}">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<!-- 다음 -->
			<c:choose>
				<c:when test="${boardItems.last}"></c:when>
				<c:otherwise>
					<li><a href="/UclickProject/boardSearch?boardId=${boardId}&type=${type}&word=${word}&page=${boardItems.number+1}">&rarr;</a></li>
					<li><a href="/UclickProject/boardSearch?boardId=${boardId}&type=${type}&word=${word}&page=${boardItems.totalPages-1}">마지막</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</body>
</html>