<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시글 수정</title>
</head>
<body>
<div>
	<h1>
		게시글 수정
	</h1>
	<div class="mt-3 mb-3">
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
			<div id="vote-container"><div id="vote-flag"></div></div>
			<div class="d-flex">
				<button type="button" id="btn-vote" class="btn btn-dark ms-auto me-2" style="margin-bottom: -20px">투표 추가</button>
			</div>
			<div class="mb-3">
				<label for="summernote">내용:</label>
				<textarea rows="10" name="po_content" id="summernote" class="form-control" required>${post.po_content}</textarea>
			</div>
			
			<button type="submit" class="btn btn-primary col-12 insert-btn">수정 완료</button>
		</form>
	</div>
</div>



<!-- 썸머노트 스크립트-->
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

<!-- 투표 항목 불러오기, 추가 스크립트 -->
<script type="text/javascript">
let count = 0;
let count2 = 0;

$(function(){
	let po_num = ${post.po_num}
	$.ajax({
		url : '<c:url value="/vote/list"/>',
		method : "post",
		data : {
			"po_num" : po_num
		},
		dataType : "json", 
		success : function (data) {
			let voteList = data.voteList;
			let itemList = data.itemList;
			console.log(voteList);
			console.log(itemList);
			if(voteList != null && voteList.length !=0){
				let str = "";
				for(vote of voteList){
					str +=
					`
						<div id="vote-box" class="mb-3 vote-box" data-count="\${count}">
					`
					if(vote.vo_state == 1){
						if(vote.vo_dup){
							str +=
							`
								<div class="d-flex ">
									<label for="vo_dup" class="ms-auto" style="font-size: small;">다중선택 허용: </label>
									<input id="vo_dup" name="vo_list[\${count}].vo_dup" type="checkbox" class="ms-2 me-2" checked>
									<span class="badge bg-success mb-1 me-2"><a href="javascript:void(0);" style="color: white; text-decoration: none;" id="btn-item" data-count="\${count}"><i class="fa-solid fa-plus"></i></a></span>
									<span class="badge bg-danger mb-1"><a href="javascript:void(0);" style="color: white; text-decoration: none;" id="btn-delete-vote" data-count="\${count}" data-num="\${vote.vo_num}">X</a></span>
								</div>	
							`
						}
						else{
							str +=
							`
								<div class="d-flex ">
									<label for="vo_dup" class="ms-auto" style="font-size: small;">다중선택 허용: </label>
									<input id="vo_dup" name="vo_list[\${count}].vo_dup" type="checkbox" class="ms-2 me-2">
									<span class="badge bg-success mb-1 me-2"><a href="javascript:void(0);" style="color: white; text-decoration: none;" id="btn-item" data-count="\${count}"><i class="fa-solid fa-plus"></i></a></span>
									<span class="badge bg-danger mb-1"><a href="javascript:void(0);" style="color: white; text-decoration: none;" id="btn-delete-vote" data-count="\${count}" data-num="\${vote.vo_num}">X</a></span>
								</div>	
							`
						}
						
						str +=
						`
							<div class="container" style="border: 1px solid #aaaaaa; border-radius: 5px;">
								<input name="vo_list[\${count}].vo_num" type="text" style="display: none;" value="\${vote.vo_num}" readonly>
								<input name="vo_list[\${count}].vo_count" type="text" style="display: none;" value="\${count}" readonly>
								<div class="mb-1 input-group mt-1">
									<div class="input-group-prepend">
								    	<span class="input-group-text">투표명</span>
								    </div>
									<input id="vo_title" name="vo_list[\${count}].vo_title" type="text" class="form-control" value="\${vote.vo_title}">
								</div>
								<div class="mb-1 input-group mt-1">
									<div class="input-group-prepend">
								    	<span class="input-group-text">투표기한</span>
								    </div>
								    <input type="datetime-local" name="vo_list[\${count}].vo_date" class="form-control" value="\${vote.vo_date}" required>
								</div>
								<div id="item-box" style="border: 1px solid #aaaaaa; border-radius: 5px;" class="container mb-1">
									
						`
						for(item of itemList){
							if(vote.vo_num == item.it_vo_num){
								str +=
									`
										<div class="mb-1 input-group mt-1 item-box">
											<input name="it_list[\${count2}].it_num"  type="text" style="display: none;" value="\${item.it_num}" readonly>
											<input name="it_list[\${count2}].it_vo_count"  type="text" style="display: none;" value="\${count}" readonly>
											<div class="input-group-prepend">
										    	<span class="input-group-text">항목</span>
										    </div>
											<input id="it_name" name="it_list[\${count2}].it_name" type="text" class="input-group form-control" value="\${item.it_name}" required>
											<button class="btn btn-danger input-group-append btn-delete-item" type="button" data-num="\${item.it_num}">삭제</button>
										</div>
									`
								count2++;
							}
						}
						str +=
						`
										<div id="item-flag"></div>
									</div>
								</div>
							</div>
						`
						count++;
					}
				}
				$('#vote-flag').before(str);
			}
			else{
				
			}
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	})
	
})



$(document).on("click",'#btn-vote',function () {
	let str =
		`
			<div id="vote-box" class="mb-3 vote-box" data-count="\${count}">
				<div class="d-flex ">
					<label for="vo_dup" class="ms-auto" style="font-size: small;">다중선택 허용: </label>
					<input id="vo_dup" name="vo_list[\${count}].vo_dup" type="checkbox" class="ms-2 me-2">
					<span class="badge bg-success mb-1 me-2"><a href="javascript:void(0);" style="color: white; text-decoration: none;" id="btn-item" data-count="\${count}"><i class="fa-solid fa-plus"></i></a></span>
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

<!-- 투표 항목 삭제 스크립트 -->
<script type="text/javascript">
$(document).on("click","#btn-delete-vote", function () {
	$(this).parents(".vote-box").remove()
})

$(document).on("click",".btn-delete-item", function () {
	$(this).parents(".item-box").remove()
})
</script>

<!-- 수정페이지를 벋어날 때 경고문구 스크립트 -->
<script type="text/javascript">
$(window).on("beforeunload", function() {
    return "수정 중인 내용을 잃어버릴 수도 있습니다. 그래도 나가시겠습니까?";
});
$(document).ready(function() {
    $("form").on("submit", function (e) {
        $(window).off("beforeunload");
        return true;
    });
});
</script>
</body>
</html>
