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
		<form action='<c:url value="/post/insert"/>' method="post" >
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
				<input type="text" class="form-control" id="title" placeholder="제목 입력" name="po_title" required>
			</div>
			<div id="vote-container"><div id="vote-flag"></div></div>
			<div class="d-flex">
				<button type="button" id="btn-vote" class="btn btn-dark ml-auto mr-2" style="margin-bottom: -20px">투표 추가</button>
			</div>
			<label >내용:</label> 
			<textarea rows="10" name="po_content" id="summernote" class="form-control" required></textarea>
			
			<button type="submit" class="btn btn-primary col-12 insert-btn">등록</button>
		</form>
	</div>
</div>
<input style="display: none;"> 


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

<!-- 게시글 임시저장 스크립트 -->
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
		if(confirm("최근 작성중인 글이 있습니다. 글을 불러오겠습니까?")){
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

<!-- 투표, 항목생성 스크립트 -->
<script type="text/javascript">

let count = 0;
let count2 = 0;

$(document).on("click",'#btn-vote',function () {
	
	let str =
		`
			<div id="vote-box" class="mb-3 vote-box" data-count="\${count}">
				<div class="d-flex ">
					<label for="vo_dup" class="ml-auto" style="font-size: small;">다중선택 허용: </label>
					<input id="vo_dup" name="vo_list[\${count}].vo_dup" type="checkbox" class="ml-2 mr-2">
					<span class="badge bg-success mb-1 mr-4"><a href="javascript:void(0);" style="color: white; text-decoration: none;" id="btn-item" data-count="\${count}">항목추가</a></span>
					<span class="badge bg-danger mb-1"><a href="javascript:void(0);" style="color: white; text-decoration: none;" id="btn-delete-vote" data-count="\${count}">X</a></span>
				</div>	
				<div class="container" style="border: 1px solid #aaaaaa; border-radius: 5px;">
					<input name="vo_list[\${count}].vo_count" type="text" style="display: none;" value="\${count}" readonly>
					<div class="mb-1 input-group mt-1">
						<div class="input-group-prepend">
					    	<span class="input-group-text">투표명</span>
					    </div>
						<input id="vo_title" name="vo_list[\${count}].vo_title" type="text" class="form-control">
					</div>
					<div class="mb-1 input-group mt-1">
						<div class="input-group-prepend">
					    	<span class="input-group-text">투표기한</span>
					    </div>
					    <input type="datetime-local" name="vo_list[\${count}].vo_date" class="form-control" required>
					</div>
					<div id="item-box" style="border: 1px solid #aaaaaa; border-radius: 5px;" class="container mb-1"><div id="item-flag"></div></div>
				</div>
			</div>
		`
	$('#vote-flag').before(str);
	count++;
})



$(document).on("click","#btn-item", function (e){
	let vo_count = $(this).data("count");
	console.log(vo_count);
	let str2 = 
		`
			<div class="mb-1 input-group mt-1 item-box">
				<input name="it_list[\${count2}].it_vo_count"  type="text" style="display: none;" value="\${vo_count}" readonly>
				<div class="input-group-prepend">
			    	<span class="input-group-text">항목</span>
			    </div>
				<input id="it_name" name="it_list[\${count2}].it_name" type="text" class="input-group form-control" required>
				<button class="btn btn-danger input-group-append btn-delete-item" type="button">삭제</button>
			</div>
		`
	$(this).parents("#vote-box").find("#item-flag").before(str2);
	count2++;
})

</script>

<!-- 투표, 항목 삭제 스크립트 -->
<script type="text/javascript">
$(document).on("click","#btn-delete-vote", function () {
	$(this).parents(".vote-box").remove()
})

$(document).on("click",".btn-delete-item", function () {
	$(this).parents(".item-box").remove()
})
</script>



</body>
</html>
