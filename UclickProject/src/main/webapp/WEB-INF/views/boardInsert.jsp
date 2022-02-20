<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
   th {
      padding: 10px;
      color: #191970;
	  border-bottom: 1px solid #DCDCDC;
   }
   td {
   	  padding: 10px;
   	  border-bottom: 1px solid #DCDCDC;
   }
   .class1 {
      width: 50px;
   }
   
   .class2 {
      width: 200px;
   }
   #btn1 {
   	  margin-top: 10px;
      margin-left: 240px;
   }
   #pic {
   	width: 50%;
   }
</style>
</head>
<body>
<center>
	<h4>게시글 신규등록</h4>
   <form method="post" enctype="multipart/form-data">
      <table>
         <tr>
            <th>번호</th>
            <td>신규</td>
         </tr>
         <tr>
            <th>제목</th>
            <td><input type="text" class="input_text" width="100px" name="title" placeholder="제목을 입력해주세요" maxlength="255"></td>
         </tr>
         <tr>
            <th>일자</th>
            <td>${date}</td>
            <input type="hidden" value="${date}" name="time">
         </tr>
         <tr>
            <th>내용</th>
            <td><textarea name="content" class="input_text" rows="10" cols="60" placeholder="내용을 입력해주세요" maxlength="255"></textarea></td>
         </tr>
         <tr>
         	<th>파일</th>
         	<td>
         		<img src="" id="pic"><br>
         		<input type="file" name="files" onchange="readURL(this);">
         	</td>
         </tr>
      </table>
         <input type="password" name="password" placeholder="비밀번호(최대6자)" maxlength="6">
         <input type="button" id="btn1" onclick="goBack();" value="취소">
         <input type="submit" formaction="/UclickProject/boardShow?boardId=${boardId}" value="쓰기">
   </form>
</center>

<script type="text/javascript">
   function goBack() {
      window.history.back();
   }
   
   function readURL(input) {
	   if (input.files && input.files[0]) {
		   var reader = new FileReader();
		   reader.onload = function (e) {
			   if (!e.target.result.match('image.*')) {
				   alert('이미지 파일만 업로드 가능합니다.');
				   location.reload();
			   } else {
				   $('#pic').attr('src', e.target.result);
			   }
		   }
		   reader.readAsDataURL(input.files[0]);
	   }
   }
   
   #(document).ready(function() {
	   #('.input_text').keyup(function() {
		   if ($(this).val().length > $(this).attr('maxlength')) {
			   alert('제한길이 초과'");
			   $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
		   }
	   });
   });
</script>
</body>
</html>