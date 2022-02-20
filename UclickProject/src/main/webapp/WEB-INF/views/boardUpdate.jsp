 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
		border-bottom: 1px solid #DCDCDC;
	}
	
	.pwd {
		display: flex;
		margin-top:-25px;
		margin-right: 390px;
	}
	
	.delete {
		display: flex;
		margin-top: -23px;
		margin-right: 165px;
	}
	.wr {
		display: flex;
		margin-left: 520px;
		margin-top: -25px;
	}
	.cancel {
		display: flex;
		margin-left: 410px;
		margin-top: 20px;
	}
	
</style>
</head>
<body>
<c:set var="url" value="${url}"/>
<center>
	<h4>게시글 수정</h4>
   <form method="post">
      <table>
            <input type="hidden" name="boardItemId" value="${boardItemId}">
         <tr>
            <th>제목</th>
            <td><input type="text" value="${title}" name="title" ></td>
         </tr>
         <tr>
            <th>일자</th>
            <td>${date}</td>
         </tr>
         <tr>
            <th>내용</th>
            <td><textarea cols="60" rows="10" name="content">${content}</textarea></td>
         </tr>
         <tr>
         	<th>이미지</th>
         	<c:choose>
	         	<c:when test="${empty url}">
	         		<td>
		         		파일이 없습니다.
	         		</td>
	         	</c:when>
	         	<c:otherwise>
	         		<td>
		         		<img src="${path}/resources/upload/${url}" id="pic" style="width: 200px;">
	         		</td>
	         	</c:otherwise>
         	</c:choose>
         </tr>
         
      </table>
      <input type="button" class="cancel" onclick="location.href='/UclickProject/boardItem?boardId=${boardId}'" value="취소">
      <input type="submit" class="wr" formaction="/UclickProject/boardWrite?boardId=${boardId}" value="수정">
      <input type="password" class="pwd" name="password" maxlength="6" placeholder="비밀번호(최대6자)">
      <input type="submit" class="delete" formaction="/UclickProject/boardDelete?boardId=${boardId}&boardItemId=${boardItemId}" value="삭제">
   </form>
   
   <%-- <form  method="post" class="form1">
      <input type="password" class="pwd" name="password" maxlength="6" placeholder="비밀번호(최대6자)">
      <input type="submit" class="delete" formaction="/UclickProject/boardDelete?boardId=${boardId}&boardItemId=${boardItemId}" value="삭제">
   </form> --%>
</center>

</body>
</html>