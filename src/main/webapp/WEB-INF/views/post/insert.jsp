<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시글 작성</title>
</head>
<body>
<div class="container">
	<h1>
		게시글 작성
	</h1>
	<div class="container mt-3 mb-3">
		<form action='<c:url value="/post/insert"/>' method="post">
			<div class="mb-3 mt-3">
				<label for="category">게시판:</label>
				<select id="category" name="po_ca_num" class="form-control">
					<c:forEach items="${categoryList}" var="category">
						<c:if test='${category.ca_name == "공지" && user.me_gr_num == 0}'>
							<option value="${category.ca_num}" <c:if test="${ca_num == category.ca_num}">selected</c:if>>${category.ca_name}</option>
						</c:if>
						<c:if test='${category.ca_name != "공지"}'>
							<option value="${category.ca_num}" <c:if test="${ca_num == category.ca_num}">selected</c:if>>${category.ca_name}</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			
			<div class="mb-3 mt-3">
				<label for="title">제목:</label>
				<input type="text" class="form-control" id="title" placeholder="제목 입력" name="po_title">
			</div>
			<div class="mb-3">
				<label for="summernote">내용:</label>
				<textarea rows="10" name="po_content" id="summernote" class="form-control"></textarea>
			</div>
			
			<button type="submit" class="btn btn-primary col-12 insert-btn">등록</button>
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

<script type="text/javascript">


window.onunload = ()=>{
	const writer = '${user.me_nick}';
	const category = $("#category").val();
	const title = document.querySelector("#title");
	const content = $('#summernote').summernote('code');
	localStorage.setItem("writer", writer);
	localStorage.setItem("category", category);
	localStorage.setItem("title", title.value);
	localStorage.setItem("content", content);
};

window.onload = ()=>{
	if(localStorage.getItem("writer") != '${user.me_nick}' ||
			(localStorage.getItem("title") == "" && 
			(localStorage.getItem("content") == "" || 
			localStorage.getItem("content") == "<p><br></p>"))){
		localStorage.clear();
	} else{
		if(confirm("최근 작성중인 글을 불러오겠습니까?")){
			$("#category").val(localStorage.getItem("category"));
			document.querySelector("#title").value = localStorage.getItem("title");
			$('#summernote').summernote('code', localStorage.getItem("content"));
		} else{
			localStorage.clear();
		}
	}
}


$("form").on("submit", function (e) {
	localStorage.clear();
	window.onunload = null;
	return true;
});

</script>
</body>
</html>
