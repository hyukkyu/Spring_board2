<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<body onLoad="setTimeout('nextPage()', 500)">
	<script type="text/javascript">
		function nextPage() {
			alert("게시글 작성 완료")
			location.href="/UclickProject/boardItem?boardId=${boardId}"
		}
	</script>
</body>
</html>