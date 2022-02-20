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
<c:set var="judge" value="${judge}" />
<c:set var="judgeNull" value="${judgeNull}" />
<c:set var="judgePassword" value="${judgePassword}" />
<c:set var="success" value="${success}" />

<c:choose>
	<c:when test="${judgeNull eq 'true'}">
		<c:choose>
			<c:when test="${judgePassword eq 'false'}">
	               <script type="text/javascript">
	                  alert("비밀번호 입력이 필요없습니다.");
	                  window.history.back();
	               </script>
	            </c:when>
	            <c:when test="${success eq 'true'}">
	               <script type="text/javascript">
	                  location.href="/UclickProject/boardWriteNull?boardId=${boardId}&boardItemId=${boardItemId}&title=${title}&content=${content}"
	               </script>
	            </c:when>
            </c:choose>
	</c:when>
	<c:when test="${judgeNull eq 'false'}">
         <c:choose>
	        <c:when test="${judgePassword ne 'false'}">
	           <script type="text/javascript">
	              alert("비밀번호를 입력해주세요.");
	              window.history.back();
	           </script>
	        </c:when>
            <c:when test="${judge eq 'true'}">
               <script type="text/javascript">
                  location.href="/UclickProject/boardWriteNotNull?boardId=${boardId}&boardItemId=${boardItemId}&title=${title}&content=${content}";
               </script>
            </c:when>
            <c:when test="${judge ne 'true'}">
               <script type="text/javascript">
                  alert("비밀번호가 틀립니다.");
                  window.history.back();
               </script>
            </c:when>
         </c:choose>
      </c:when> 
</c:choose>
</body>
</html>