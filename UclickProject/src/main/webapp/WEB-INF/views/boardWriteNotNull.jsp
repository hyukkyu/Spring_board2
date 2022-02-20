<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		border: 1px solid black;
		border-top: 2px solid #ADD8E6;
		border-bottom: 2px solid #ADD8E6;
		border-left: none;
		border-right: none;
		border-collapse: collapse;
	}
	th, td {
		padding: 10px;
	}
	
	th {
		width: 80px;
		color: #191970;
		border-bottom: 1px solid #DCDCDC;
	}
	
	td {
		width: 300px;
		border-bottom: 1px solid #DCDCDC;
	}
</style>
</head>
<body>
<center>
	<h3>수정완료</h3>
   <table>
      <tr>
         <th>제목</th>
         <td>${title}</td>
      </tr>
      <tr>
         <th>일자</th>
         <td>${date}</td>
      </tr>
      <tr>
         <th>내용</th>
         <td>${content}</td>
      </tr>
      
   </table>
   <input type="button" onclick="location.href='/UclickProject/boardItem?boardId=${boardId}'" value="목록">
</center>
</body>
</html>