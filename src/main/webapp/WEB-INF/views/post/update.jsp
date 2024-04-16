<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시글 수정</title>
</head>
<body>
<div class="container">
	<h1>
		게시글 수정
	</h1>
	<div class="container mt-3 mb-3">
		<form action='<c:url value="/post/update"/>' method="post">
			<input readonly style="display: none;" value="${post.po_num}" name="po_num">
			<input readonly style="display: none;" value="${post.po_me_id}" name="po_me_id">
			<div class="mb-3 mt-3">
				<label for="category">게시판:</label>
				<select id="category" name="po_ca_num" class="form-control">
					<c:forEach items="${categoryList}" var="category">
						<c:if test='${category.ca_name == "공지" && user.me_gr_num == 0}'>
							<option value="${category.ca_num}" <c:if test="${post.po_ca_num == category.ca_num}">selected</c:if>>${category.ca_name}</option>
						</c:if>
						<c:if test='${category.ca_name != "공지"}'>
							<option value="${category.ca_num}" <c:if test="${post.po_ca_num == category.ca_num}">selected</c:if>>${category.ca_name}</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			
			<div class="mb-3 mt-3">
				<label for="title">제목:</label>
				<input type="text" class="form-control" id="title" name="po_title" value="${post.po_title}" required>
			</div>
			<div class="mb-3">
				<label for="summernote">내용:</label>
				<textarea rows="10" name="po_content" id="summernote" class="form-control" required>${post.po_content}</textarea>
			</div>
			
			<button type="submit" class="btn btn-primary col-12 insert-btn">수정 완료</button>
		</form>
	</div>
</div>



<!-- 썸머노트 -->
<script>
$('#summernote').summernote({
    tabsize: 2,
    height: 200,
    toolbar: [
      ['style', ['style']],
      ['font', ['bold', 'underline', 'clear']],
      ['color', ['color']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['table', ['table']],
      ['insert', ['link', 'picture', 'video']],
      ['view', ['fullscreen', 'codeview', 'help']]
    ]
});
</script>


</body>
</html>
