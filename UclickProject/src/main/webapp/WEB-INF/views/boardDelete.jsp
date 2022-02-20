<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

   <c:set var="password" value="${password}"/>
   <c:set var="itemPassword" value="${itemPassword}"/>
   <c:set var="judge" value="${judge}"/>
   <c:set var="judgeNull" value="${judgeNull}"/>
   <c:set var="judgePassword" value="${judgePassword}"/>
   <c:set var="success" value="${success}"/>
   <%-- <c:set var="boardItemId" value="${boardItemId }"/> --%>
   <%-- <c:if test="${password eq itemPassword}">
      <p>확인</p>
   </c:if> --%>
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
                  location.href="/UclickProject/boardDeleteNull?boardId=${boardId}&boardItemId=${boardItemId}"
               </script>
            </c:when>
            <%-- <c:otherwise>
               <script type="text/javascript">
                  location.href="/UclickProject/boardDeleteNull?boardId=${boardId}&boardItemId=${boardItemId}"
               </script>
            </c:otherwise> --%>
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
                  location.href="/UclickProject/boardDeleteNotNull?boardId=${boardId}&boardItemId=${boardItemId}";
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