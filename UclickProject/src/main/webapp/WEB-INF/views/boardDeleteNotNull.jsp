<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

   <body onload="setTimeout('nextPage()', 300)">
   
   <script type="text/javascript">
      function nextPage() {
         alert("삭제 완료");
         location = "/UclickProject/boardItem?boardId=${boardId}";
      }
   </script>
</body>
</html>