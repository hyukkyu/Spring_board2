<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta>
<title>Insert title here</title>
<style>
	table {
		border-top: 2px solid #191970;
		border-bottom: 2px solid #191970;
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
		width: 60px;
	}
	
	.class2 {
		width: 380px;
	}
	
	a {
   		color: black;
   		text-decoration: none;
   	}
   	a:hover {
   		text-decoration: underline;
   	}
</style>
</head>
<body>
<center>
	<form method="post">
		<table>
			<tr >
				<th class="class1">번호</th>
				<th class="class2">제목</th>
			</tr>
			<c:forEach var="board" items="${boards}">
				<tr>
					<td>${board.getId()}</td>
					<td><a href="/UclickProject/boardItem?boardId=${board.getId()}">${board.getTitle()}</a></td>
				</tr>
			</c:forEach>
		</table>
	</form>
</center>
</body>
</html>