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
		width: 100%;
	}
	
	body {
		position: relative;
		width: 100%;
		height: 100%;
	}
	
	.table1 {
		border: 1px solid black;
		border-top: 2px solid #ADD8E6;
		border-bottom: 2px solid #ADD8E6;
		border-left: none;
		border-right: none;
		border-collapse: collapse;
		position: relative;
		
	}
	th, td {
		padding: 10px;
	}
	
	.class1 {
		width: 80px;
		color: #191970;
		border-bottom: 1px solid #DCDCDC;
		
	}
	.div1 {
		margin-top: 10px;
	}
	.class2 {
		width: 300px;
	}
	td {
		border-bottom: 1px solid #DCDCDC;
	}
	.div2 {
		margin-top: 80px;
	}
	.div3 {
		margin-top: 60px;
	}
</style>
</head>
<body>
<c:set var="url" value="${url}"></c:set>
<center>
	<h4>게시글 상세조회</h4>
	<form method="post">
		<table class="table1">
				<input type="hidden" name="boardItemId" value="${boardItemId}">
				<input type="hidden" name="count" value="${count}">
			<tr>
				<th class="class1">제목</th>
				<td class="class2">${title}</td>
			</tr>
			<tr>
				<th class="class1">일자</th>
				<td>${date}</td>
			</tr>
			<tr>
				<th class="class1">내용</th>
				<td>${content}</td>
			</tr>
			<tr>
				<th class="class1">이미지</th>
				<c:choose>
					<c:when test="${empty url}">
						<td>파일이 없습니다.</td>
					</c:when>
					<c:otherwise>
						<td><img src="${path}/resources/upload/${url}" style="width: 200px;"></td>
					</c:otherwise>
				</c:choose>
			</tr>
		</table>
		<div class="div1">
			<input type="button" onclick="location.href='/UclickProject/boardItem?boardId=${boardId}'" value="목록">
			<input type="submit" formaction="/UclickProject/boardUpdate?boardId=${boardId}" value="수정">
		</div>
	</form>
	<div class="div2">
		<h4>댓글입력</h4>
		<form method="post">
			<table>
				<tr>
					<td>
						<textarea cols="70" rows="4" name="comment" placeholder="댓글을 입력해주세요"></textarea>
					</td>
					<td>
						<input type="submit" formaction="/UclickProject/boardComment?boardId=${boardId}&boardItemId=${boardItemId}" value="댓글등록">
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div class="div3">
		<table>
			<tr>
				<th style="width: 600px; background-color: #ADD8E6;">댓글내용</th>
				<th style="background-color: #ADD8E6;">일자</th>
			</tr>
			<c:forEach var="boardItem2" items="${boardItem2}">
				<tr>
					<td style="text-align: left;">${boardItem2.getContent()}</td>
					<td>${boardItem2.getDate()}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</center>
</body>
</html>