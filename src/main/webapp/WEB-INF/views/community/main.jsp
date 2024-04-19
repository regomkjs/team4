<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>메인</title>
</head>
<body>
<div class="container">
	<h1>
		커뮤니티 관리페이지
	</h1>
	
	<ul>
		<li><a href="#" data-toggle="modal" data-target="#adminModal" class="adminModal">게시판 관리</a></li>
		<li><a href="#" data-toggle="modal" data-target="#userModal" class="userModal">유저 관리</a></li>
		<li><a href="#" data-toggle="modal" data-target="#reportModal" class="reportModal">신고 관리</a></li>
	</ul>
	
	
	
	
</div>


<!-- 커뮤니티 관리 Modal -->
<div class="modal fade" id="adminModal">
	<div class="modal-dialog modal-lg modal-dialog-scrollable">
		<div class="modal-content">
   
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">게시판 관리</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
				<div class="category-container"></div>
			
				<div class="input-group category-input-box" hidden>
					<input type="text" class="form-control">
					<button type="button" class="btn btn-primary category-input-btn col-2">입력</button>
				</div>
				
				<button type="button" class="btn btn-primary form-control" id="category-add">추가</button>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>

<!-- 유저 관리 Modal -->
<div class="modal fade" id="userModal">
	<div class="modal-dialog modal-xl modal-dialog-scrollable">
		<div class="modal-content">
   
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">유저 관리</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
			  Modal body..
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>

<!-- 신고 관리 Modal -->
<div class="modal fade" id="reportModal">
	<div class="modal-dialog modal-xl modal-dialog-scrollable">
		<div class="modal-content">
   
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">신고</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
			  Modal body..
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>



<!-- 게시판 관리 스크립트 -->
<script type="text/javascript">
function initCategory(){
	$(".category-input-box").attr("hidden", true);
	$(".category-input-box").find("input").val("");
	$("#category-add").removeAttr("hidden");
	$(".category-box").removeAttr("hidden");
	$(".input-update-box").remove();
}

// 게시판 불러오기
function getCategoryList() {
	$.ajax({
		url : '<c:url value="/category/list"/>',
		method : "post",
		success : function (data) {
			let categoryList = data.categoryList
			let str ="";
			for(category of categoryList){
				if(category.ca_num == 1){
					str +=
					`
						<div class="category-box input-group mb-1">
							<input class="form-control input-category-name" value="\${category.ca_name}" readonly>
							<button class="btn btn-success category-btn category-update-btn col-2" data-num="\${category.ca_num}">수정</button>
						</div>
					`
				}
				else{
					str +=
					`
						<div class="category-box input-group mb-1">
							<input class="form-control input-category-name" value="\${category.ca_name}" readonly>
							<button class="btn btn-success category-btn category-update-btn col-1" data-num="\${category.ca_num}">수정</button>
							<button class="btn btn-danger category-btn category-delete-btn col-1" data-num="\${category.ca_num}">삭제</button>
						</div>
					`
				}
			}
			$(".category-container").html(str);
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	})
}

$(".adminModal").on("click",function(){
	getCategoryList();
})

//게시판 추가
$("#category-add").click(function () {
	initCategory()
	$(this).attr("hidden",true);
	$(this).parents(".modal-body").find(".category-input-box").removeAttr("hidden");
})

$(".category-input-btn").click(function () {
	let inputBox = $(this).parents(".category-input-box");
	let ca_name = $(this).parents(".category-input-box").find("input").val()
	if(ca_name.length == 0 || ca_name == null){
		alert("게시판 이름은 필수 항목입니다.")
		return;
	}
	$.ajax({
		url : '<c:url value="/category/insert"/>',
		method : "post",
		data : {
			"ca_name" : ca_name
		},
		dataType : "json", 
		success : function (data) {
			if(data.result){
				alert("게시판이 추가 되었습니다.")	
				inputBox.find("input").val("");
				inputBox.attr("hidden",true);
				$("#category-add").removeAttr("hidden");
				getCategoryList()
			}
			else{
				alert(data.errorMessage);
				inputBox.find("input").val("");
			}
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	})
})

//게시판 수정
$(document).on("click",".category-update-btn",function(){
	initCategory()
	let container = $(this).parents(".category-box")
	container.attr("hidden",true);
	let ca_num = $(this).data("num");
	let inputBox = $(this).parents(".category-box").find("input").val();
	let str = 
	`
		<div class="input-update-box input-group mb-1">
			<input class="form-control input-update-name" value="\${inputBox}">
			<button class="btn btn-success update-submit-btn col-2" data-num="\${ca_num}">수정완료</button>
		</div>
	`
	container.before(str);
})

//게시판 삭제


</script>


</body>
</html>
