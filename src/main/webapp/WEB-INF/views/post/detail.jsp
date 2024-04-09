<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시글 상세</title>
</head>
<body>
<div class="container">
	<h1>
		게시글 상세
	</h1>
	<div class="container mt-3 mb-3">
		<div class="mb-3 mt-3">
			<label for="category">게시판:</label>
			<div class="form-control" id="category">${post.ca_name}</div>
		</div>
		
		<div class="mb-3 mt-3">
			<label for="title">제목:</label>
			<div class="form-control" id="title">${post.po_title}</div>
		</div>
		<div class="mb-3 mt-3 d-flex justify-content-between form-control">
			<div>${post.po_datetime}</div>
			<div class="mr-3">조회수 : ${post.po_view}</div> 
		</div>
		
		<div class="mb-3">
			<label for="content">내용:</label>
			<div class="form-control" style="min-height: 250px">${post.po_content}</div>
		</div>
		<div class="mb-3 mt-3 d-flex justify-content-start">
			<button class="btn-heart btn btn-outline-danger mr-3">하트</button> <div style="font: bolder; font-size: x-large;" class="text-heart">${post.po_totalHeart}</div> 
		</div>
	</div>
</div>


<!-- 좋아요 구현 스크립트 -->
<script type="text/javascript">
$(".btn-heart").on("click", function(){
	if('${user.me_id}' == ''){
		if(confirm("로그인이 필요한 서비스 입니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	let po_num = ${post.po_num};
	$.ajax({
		url : '<c:url value="/post/heart"/>',
		method : "post",
		data : {
			"po_num" : po_num
		},
		success : function (data) {
			switch (data.result) {
			case "1":
				alert("게시글을 추천했습니다.");
				break;
			case "0":
				alert("추천을 취소했습니다.");
				break;
			case "-1":
				alert("에러 발생")
				break;
			}
			getHeart();
		},
		error : function (a,b,c) {
			console.error("에러 발생2");
		}
	});
	
});


function getHeart() {
	let po_num = ${post.po_num};
	$.ajax({
		url : '<c:url value="/post/countHeart"/>',
		method : "post",
		data : {
			"po_num" : po_num
		},
		success : function (data) {
			displayHeart(data.result);
			displayUpdateHeart(data.totalCountHeart);
		},
		error : function (a,b,c) {
			console.error("에러 발생1");
		}
	});
}

function displayUpdateHeart(totalCountHeart) {
	$(".text-heart").text(totalCountHeart);
}

function displayHeart(result) {
	$('.btn-heart').addClass("btn-outline-danger");
	$('.btn-heart').removeClass("btn-danger");
	if(result){
		$('.btn-heart').addClass("btn-danger");
		$('.btn-heart').removeClass("btn-outline-danger");
	}else{
		$('.btn-heart').addClass("btn-outline-danger");
		$('.btn-heart').removeClass("btn-danger");
	}
	
}
getHeart();
</script>

</body>
</html>
