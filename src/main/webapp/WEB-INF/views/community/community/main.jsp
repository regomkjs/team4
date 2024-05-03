<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>메인</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<script src="https://kit.fontawesome.com/6830e64ec8.js" crossorigin="anonymous"></script>
	<style type="text/css">
		.order-btn:hover {
			cursor: pointer;
		}
		.hovertext-box{
			position: relative;
		}
		.hovertext {
		    overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
			width: 80px;
			height: 20px;
		}
		
		.hovertext-box:before {
		    content: attr(data-hover);
		    visibility: hidden;
		    opacity: 0;
		    width: max-content;
		    background-color: black;
		    color: #fff;
		    text-align: center;
		    border-radius: 5px;
		    padding: 5px 5px;
		    transition: opacity 1s ease-in-out;
		
		    position: absolute;
		    z-index: 100;
		    left: 0;
		    top: 110%;
		}
		
		.hovertext-box:hover:before {
		    opacity: 1;
		    visibility: visible;
		}
		
		.pagination{
			 z-index: 1;
		}
	</style>
</head>
<body>
<div class="container">
	<h1>
		커뮤니티 관리페이지
	</h1>
	
	<ul>
		<li><a href="#" data-toggle="modal" data-target="#adminModal" class="adminModal">게시판 관리</a></li>
		<li><a href="#" data-toggle="modal" data-target="#reportModal" class="reportModal">신고 관리</a></li>
		<li><a href="#" data-toggle="modal" data-target="#userModal" class="userModal">회원 관리</a></li>
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

<!-- 신고 관리 Modal -->
<div class="modal fade" id="reportModal">
	<div class="modal-dialog modal-xl modal-dialog-scrollable">
		<div class="modal-content">
   
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">신고 관리</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
				<div class="report-container">
				
				</div>
				
				<!-- 신고글 페이지네이션 박스 -->
				<div class="report-pagination">
					<ul class="pagination justify-content-center">
					
					</ul>
				</div>
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
				<h4 class="modal-title">회원 관리</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
				<div class="container col-12">
					<div class="d-flex">
						<!-- Nav tabs -->
						<ul class="nav flex-column nav-pills text-center" role="tablist">
							<li class="nav-item">
								<a class="nav-link active member-tab" data-toggle="tab" href="#all" data-type="all">회원</a>
							</li>
							<li class="nav-item">
								<a class="nav-link member-tab" data-toggle="tab" href="#prison" data-type="prisoner">수감소</a>
							</li>
							<c:if test="${user.me_mr_num == 0}">
								<li class="nav-item">
									<a class="nav-link member-tab" data-toggle="tab" href="#master" data-type="admin">운영진</a>
								</li>
							</c:if>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content" style="min-height: 300px; width: 90%">
							<div id="all" class="container tab-pane active" >
								<h3>이용중인 회원</h3>
								<div class="all-container">
								
								</div>
								
							</div>
							<div id="prison" class="container tab-pane fade">
								<h3>정지된 회원</h3>
								<div class="prisoner-container">
								
								</div>
								
							</div>
							<c:if test="${user.me_mr_num == 0}">
								<div id="master" class="container tab-pane fade">
						 			<h3>운영진 관리</h3>
						 			<div class="admin-container">
								
									</div>
									
								</div>
							</c:if>
						</div>
					</div>
					<div class="member-pagination">
						<ul class="pagination justify-content-center">
						
						</ul>
					</div>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>




<!-- 신고 내용 상세보기 Modal -->
<div class="modal fade" id="reportDetailModal">
	<div class="modal-dialog modal-lg modal-dialog-scrollable">
		<div class="modal-content">
   
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">신고 상세</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body">
				<div class="report-detail-container">
					
				</div>
			
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-success mr-auto complete-report-btn">처리완료</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>






<!-- 게시판 관리 스크립트 -->
<script type="text/javascript">
// 버튼 초기화
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
	let ca_num = $(this).data("num");
	let admin_right = '${user.me_mr_num}';
	
	if(admin_right == 1 && ca_num == 1){
		alert("공지 게시판은 최고 관리자만 수정할 수 있습니다.");
		return;
	}
	container.attr("hidden",true);
	
	let inputBox = $(this).parents(".category-box").find("input").val();
	let str = "";
	str +=
	`
		<div class="input-update-box input-group mb-1">
			<input class="form-control input-update-name" value="\${inputBox}">
			<button class="btn btn-success update-submit-btn col-2" data-num="\${ca_num}">수정완료</button>
		</div>
	`
	container.before(str);
})

$(document).on("click",".update-submit-btn",function(){
	let admin_right = '${user.me_mr_num}';
	let ca_name = $(this).parents('.input-update-box').find('.input-update-name').val();
	let ca_num = $(this).data("num");
	
	if(admin_right == 1 && ca_num == 1){
		alert("공지 게시판은 최고 관리자만 수정할 수 있습니다.");
		return;
	}
	
	$.ajax({
		url : '<c:url value="/category/update"/>',
		method : "post",
		data : {
			"ca_name" : ca_name,
			"ca_num" : ca_num
		},
		dataType : "json", 
		success : function (data) {
			if(data.result){
				alert("게시판이 수정 되었습니다.");
				getCategoryList();
			}
			else{
				alert(data.errorMessage);
			}
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	})
})

//게시판 삭제
$(document).on("click",".category-delete-btn",function(){
	let ca_num = $(this).data("num");
	if(ca_num == 1){
		alert("공지 게시판은 삭제가 불가능 합니다.");
		return;
	}
	
	if(confirm("게시판을 삭제할 경우 해당 게시판 내 게시글이 모두 삭제되게 됩니다. 삭제 하시겠습니까?")){
		$.ajax({
			url : '<c:url value="/category/delete"/>',
			method : "post",
			data : {
				"ca_num" : ca_num
			},
			success : function (data) {
				if(data.result){
					alert("게시판이 삭제 되었습니다.");
					getCategoryList();
				}
				else{
					alert("게시판 삭제에 실패했습니다.");
				}
			},
			error : function (a,b,c) {
				console.error("에러 발생");
			}
		})
	}
	
})

</script>

<!-- 신고 관리 스크립트 -->
<script type="text/javascript">

//체크된 신고 번호를 담을 배열
const reportArr = []

let cri = {
	page : 1,
	perPageNum : 5
}

getReportList(cri)
function getReportList(cri) {
	$.ajax({
		url : '<c:url value="/report/list"/>',
		method : "post",
		data : JSON.stringify(cri),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data) {
			let reportList = data.reportList;
			let pm = data.pm;
			let str ="";
			if(reportList == null){
				str +=
				`
					<h4 class="text-center">신고 내역이 없습니다.</h4>
				`
				
				$(".report-container").html(str);
				
				let pmStr = "";
				$(".report-pagination>ul").html(pmStr);
				return;
			}
			
			let ok = true;
			for(report of reportList){
				if(!reportArr.includes(report.rp_num)){
					ok = false;
				}
			}
			str += 
			`
				<div class="d-flex">
					<div class="mb-1 ml-auto">
						<a href="#" class="btn btn-success btn-sm report-delete-btn">신고반려 : \${reportArr.length}개</a>
					</div>			
				</div>
				<table class="table table-hover text-center">
					<thead>
						<tr>
						
			`
			if(ok){
				str += 
				`
							<th><input type="checkbox" class="check-report-all" checked></th>
				`
			}
			else{
				str += 
				`
							<th><input type="checkbox" class="check-report-all"></th>
				`
			}
			str += 
			`
							<th>글 작성자</th>
							<th>글 유형</th>
							<th>신고항목</th>
							<th>신고자</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
			`
			for(report of reportList){
				if(reportArr.includes(report.rp_num)){
					str +=
					`
						<tr class="report-box">
							<td><input type="checkbox" class="check-report" data-num="\${report.rp_num}" checked></td>
							<td>\${report.rp_writer_nick}</td>
					`
					if(report.rp_comment == null){
						str +=
						`
							
							<td>게시글</td>
						`
					} else{
						str +=
						`
							<td>댓글</td>
						`
					}
					
					str +=
					`
							<td>\${report.rp_type}</td>
							<td>\${report.rp_me_nick}</td>
							<td>
								<span class="detail-link" data-id="\${report.rp_me_id}" data-num="\${report.rp_num}" data-writer="\${report.rp_writer_nick}" data-type="\${report.rp_type}" data-reporter="\${report.rp_me_nick}" data-note="\${report.rp_note}" data-post="\${report.rp_post.po_num}">
									<a class="reportDetailModal" href="#" data-toggle="modal" data-target="#reportDetailModal" ><button class="btn btn-sm btn-secondary" >상세보기</button></a>
					`
					if(report.rp_comment == null){
						str +=
						`
							<input hidden class="report-post-category" value="\${report.rp_post.ca_name}">
							<input hidden class="report-post-title" value="\${report.rp_post.po_title}">
							<input hidden class="report-post-content" value='\${report.rp_post.po_content}'>
							<input hidden class="report-post-id" value="\${report.rp_post.po_me_id}">
						`
					} else{
						str +=
						`
							<input hidden class="report-comment-num" value="\${report.rp_comment.co_num}">
							<input hidden class="report-comment-content" value="\${report.rp_comment.co_content}">
							<input hidden class="report-comment-id" value="\${report.rp_comment.co_me_id}">
						`
					}
					
					
					str +=				
					`
								</span>
							</td>
						</tr>
					
					`
				}
				else{
					str +=
					`
						<tr class="report-box">
							<td><input type="checkbox" class="check-report" data-num="\${report.rp_num}"></td>
							<td>\${report.rp_writer_nick}</td>
					`	
					if(report.rp_comment == null){
					str +=
					`
						<td>게시글</td>
					`
					} else{
						str +=
						`
							<td>댓글</td>
						`
					}
					str +=
							
					`
							<td>\${report.rp_type}</td>
							<td>\${report.rp_me_nick}</td>
							<td>
								<span class="detail-link" data-id="\${report.rp_me_id}" data-num="\${report.rp_num}" data-writer="\${report.rp_writer_nick}" data-type="\${report.rp_type}" data-reporter="\${report.rp_me_nick}" data-note="\${report.rp_note}" data-post="\${report.rp_post.po_num}">
									<a class="reportDetailModal" href="#" data-toggle="modal" data-target="#reportDetailModal" ><button class="btn btn-sm btn-secondary" >상세보기</button></a>
					`
					if(report.rp_comment == null){
						str +=
						`
							<input hidden class="report-post-category" value="\${report.rp_post.ca_name}">
							<input hidden class="report-post-title" value="\${report.rp_post.po_title}">
							<input hidden class="report-post-content" value='\${report.rp_post.po_content}'>
							<input hidden class="report-post-id" value="\${report.rp_post.po_me_id}">
						
						`
					}
					else{
						str += 
						`
							<input hidden class="report-comment-num" value="\${report.rp_comment.co_num}">
							<input hidden class="report-comment-content" value="\${report.rp_comment.co_content}">
							<input hidden class="report-comment-id" value="\${report.rp_comment.co_me_id}">
						`
					}
					str +=				
					`
								</span>
							</td>
						</tr>
					`
				}
			}
			str += 
			`
					</tbody>
				</table>
			`
			$(".report-container").html(str);
			let pmStr = "";
			//이전 버튼 활성화 여부
			if(pm.prev){
				pmStr += 
				`
					<li class="page-item">
						<a class="page-link" href="javascript:void(0);" data-page="\${pm.startPage-1}">이전</a>
					</li>
				`;
			}
			//숫자 페이지
			for(let i = pm.startPage; i<= pm.endPage; i++){
				let active = pm.cri.page == i ? "active" : "";
				pmStr += 
				`
				    <li class="page-item \${active}">
						<a class="page-link" href="javascript:void(0);" data-page="\${i}">\${i}</a>
					</li>
				`
			}
			//다음 버튼 활성화 여부
			if(pm.next){
				pmStr += 
				`
					<li class="page-item">
						<a class="page-link" href="javascript:void(0);" data-page="\${pm.endPage + 1}">다음</a>
					</li>
				`
			}
			$(".report-pagination>ul").html(pmStr);
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	})
}

$(document).on("click", ".report-pagination .page-link", function () {
	cri.page = $(this).data("page");
	getReportList(cri);
})


$(document).on("change", ".check-report-all",function(){
	$(".check-report").prop("checked", $(".check-report-all").prop("checked"))
	let rp_num_list = [];
	let length =  $(".check-report").length;
	for(var i = 0 ; i < length ; i++){
		let num = $(".check-report:eq("+i+")").data("num")
		rp_num_list.push(num);
	}
	if($(this).is(":checked")){
		for(rp_num of rp_num_list){
			if(!reportArr.includes(rp_num)){
				reportArr.push(rp_num);
			}
		}
	}
	else{
		for(rp_num of rp_num_list){
			if(reportArr.includes(rp_num)){
				let i = reportArr.indexOf(rp_num);
				reportArr.splice(i,1);
			}
		}
	}
	getReportList(cri);
})


$(document).on("change", ".check-report",function(){
	let rp_num = $(this).data("num");
	if(reportArr.includes(rp_num)){
		let i = reportArr.indexOf(rp_num);
		reportArr.splice(i,1);
	}
	else{
		reportArr.push(rp_num);
	}
	
	let checked = $(this).prop("checked")
	if(checked){
		//선택된 체크박스 개수
		let checkedCount = $(".check-report:checked").length;
		//전체 체크박스 개수
		let count = $(".check-report").length
		if(count == checkedCount){
			$(".check-report-all").prop("checked", true);
		}
		getReportList(cri);
		return
	}
	$(".check-report-all").prop("checked", false);
	getReportList(cri);
})

$(document).on("click",".reportDetailModal",function(){
	let rp_num = $(this).parents(".detail-link").data("num");
	let rp_me_id = $(this).parents(".detail-link").data("id");
	let writer = $(this).parents(".detail-link").data("writer");
	let type = $(this).parents(".detail-link").data("type");
	let reporter = $(this).parents(".detail-link").data("reporter");
	let note = $(this).parents(".detail-link").data("note");
	let po_num = $(this).parents(".detail-link").data("post");
	let po_ca_name = $(this).parents(".detail-link").find(".report-post-category").val();
	let po_title = $(this).parents(".detail-link").find(".report-post-title").val();
	let po_content = $(this).parents(".detail-link").find(".report-post-content").val();
	let po_me_id = $(this).parents(".detail-link").find(".report-post-id").val();
	let co_num = $(this).parents(".detail-link").find(".report-comment-num").val();
	let co_content = $(this).parents(".detail-link").find(".report-comment-content").val();
	let co_me_id = $(this).parents(".detail-link").find(".report-comment-id").val();
	let postUrl = '<c:url value="/post/detail?num='+ po_num +'" />';
	
	
	
	let popWriterUrl = '<c:url value="/popup/member/punish?nick='+ writer + '" />';
	let popReporterUrl = '<c:url value="/popup/member/punish?nick='+ reporter + '" />';
	
	str = "";
	
	str +=
	`
		<input hidden class="input-report-num" value="\${rp_num}">
		<div>
			<div class="d-flex">
				<div><h5>신고대상</h5></div>
				<div class="mb-1 ml-auto">
					<a href="#" class="btn btn-secondary btn-sm btn-detail-post" data-url="\${postUrl}">게시글로</a>
				</div>
			</div>
			</div>
			<div class="input-group">
				<div class="input-group-prepend"><span class="input-group-text">작성자</span></div>
				<input class="input-group form-control" readonly value="\${writer}" style="background-color: white;">
				<button class="btn btn-danger writer-punish-btn" data-url="\${popWriterUrl}" data-num="\${rp_num}">이용제한</button>
			</div>
			
	`
	if(co_content == null || co_content.length == 0){
		str +=
		`
			<div class="input-group ">
				<div class="input-group-prepend"><span class="input-group-text">게시판</span></div>
				<input class="input-group form-control" readonly value="\${po_ca_name}" style="background-color: white;">
			</div>
			<div class="input-group ">
				<div class="input-group-prepend"><span class="input-group-text">게시글</span></div>
				<input class="input-group form-control" readonly value="\${po_title}" style="background-color: white;">
			</div>
			<div class="form-control mb-3" style="min-height: 100px">\${po_content}</div>
			<button class="btn btn-outline-danger delete-post-btn form-control" data-num="\${po_num}"}>신고된 게시글 삭제</button>
		`
	}
	else{
		str +=
		`
			<div class="input-group mb-3">
				<div class="input-group-prepend"><span class="input-group-text">댓글</span></div>
				<textarea class="input-group form-control" readonly style="background-color: white; min-height: 50px">\${co_content}</textarea>
			</div>
			<button class="btn btn-outline-danger delete-comment-btn form-control" data-num="\${co_num}">신고된 댓글 삭제</button>
		`
	}
	
	str +=
	`	
			<hr>
			<h5>신고내용</h5>
			<div class="input-group">
				<div class="input-group-prepend"><span class="input-group-text">신고한 회원</span></div>
				<input class="input-group form-control" readonly value="\${reporter}" style="background-color: white; "> 
	`
	if(rp_me_id != `${user.me_id}`){
		str += 
		`
			<button class="btn btn-danger reporter-punish-btn" data-url="\${popReporterUrl}" data-num="\${rp_num}">이용제한</button>
		`
	}
	str +=
	`			
			</div>
			<div class="input-group">
				<div class="input-group-prepend"><span class="input-group-text">신고유형</span></div>
				<input class="input-group form-control" readonly value="\${type}" style="background-color: white;">
			</div>
			<div class="input-group">
				<div class="input-group-prepend"><span class="input-group-text">상세내용</span></div>
				<textarea class="input-group form-control" readonly style="background-color: white; min-height: 50px">\${note}</textarea>
			</div>
		</div>
	`
	
	$(".report-detail-container").html(str);
})


$(document).on("click",".btn-detail-post", function(){
	let url = $(this).data("url");
	const options = 'width=1000, height=1000, top=0, left=0, scrollbars=yes'
	
	window.open(url,'_blank',options)
})



$(document).on("click",".report-delete-btn",function(){
	if(reportArr.length == 0){
		alert("선택한 신고내역이 없습니다.");
		return;
	}
	if(confirm("신고내역 "+reportArr.length+"개를 반려하시겠습니까?")){
		$.ajax({
			url : '<c:url value="/report/arr/reject"/>',
			method : "post",
			data : JSON.stringify(reportArr),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function (data) {
				alert("신고내역 "+data.count+"개가 반려됐습니다.");
				reportArr.splice(0);
				cri.page = 1;
				getReportList(cri);
			},
			error : function (a,b,c) {
				console.error("에러 발생");
			}
		})
		
	}
})

$(document).on("click",".complete-report-btn",function(){
	if(confirm("이 신고내역을 반려하시겠습니까?")){
		let rp_num = $(this).parents(".modal-content").find(".input-report-num").val();
		$.ajax({
			url : '<c:url value="/report/reject"/>',
			method : "post",
			data : {
				"rp_num" : rp_num
			},
			success : function (data) {
				if(data.result){
					$("#reportDetailModal").modal("hide");
					reportArr.splice(0);
					cri.page = 1;
					getReportList(cri);
					alert("해당 신고 내역이 반려처리 됐습니다.")
				}
				else{
					
					alert("해당 내역 처리에 실패했습니다.")
				}
				
			},
			error : function (a,b,c) {
				console.error("에러 발생");
			}
		})
		
	}
})

//신고된 게시글 삭제
$(document).on("click",".delete-post-btn",function(){
	let po_num = $(this).data("num");
	let rp_num = $(this).parents(".modal-content").find(".input-report-num").val();
	if(confirm("!게시글을 삭제할 경우 포함된 댓글, 투표 등도 함께 삭제됩니다!\n이 게시글을 삭제하시겠습니까? [수락시 완료로 처리됩니다]")){
		$.ajax({
			url : '<c:url value="/report/post/delete"/>',
			method : "post",
			data : {
				"po_num" : po_num,
				"rp_num" : rp_num
			},
			dataType : "json",
			success : function (data) {
				if(data.result1){
					$("#reportDetailModal").modal("hide");
					reportArr.splice(0);
					cri.page = 1;
					getReportList(cri);
					alert("신고된 게시글이 삭제됐습니다. [신고내역 처리완료]")
				}
				else{
					alert("해당 내역 처리에 실패했습니다.")
				}
				
			},
			error : function (a,b,c) {
				console.error("에러 발생");
			}
		})
	}
	
	
})

//신고된 댓글 삭제
$(document).on("click",".delete-comment-btn",function(){
	let co_num = $(this).data("num");
	let rp_num = $(this).parents(".modal-content").find(".input-report-num").val();
	if(confirm("이 댓글을 삭제하시겠습니까? [수락시 완료로 처리됩니다]")){
		$.ajax({
			url : '<c:url value="/report/comment/delete"/>',
			method : "post",
			data : {
				"co_num" : co_num,
				"rp_num" : rp_num
			},
			dataType : "json",
			success : function (data) {
				if(data.result1){
					$("#reportDetailModal").modal("hide");
					reportArr.splice(0);
					cri.page = 1;
					getReportList(cri);
					alert("신고된 댓글이 삭제됐습니다. [신고내역 처리완료]")
				}
				else{
					alert("해당 내역 처리에 실패했습니다.")
				}
				
			},
			error : function (a,b,c) {
				console.error("에러 발생");
			}
		})
	}
})
</script>

<!-- 커뮤니티 이용 권한 제어 팝업 스트립트 -->
<script type="text/javascript">
var popup_punish;
var popup_forgive;
$(document).on("click",".member-punish-btn",function(){
	let url = $(this).data("url");
	const options = 'width=500, height=300, top=300, left=500, scrollbars=yes'
	
	popup_punish = window.open(url,'_blank',options);
	popup_punish.addEventListener('beforeunload', function() {
		me_cri.page = 1;
		getMemberList(me_cri, where);
	});
})

$(document).on("click",".member-forgive-btn",function(){
	let url = $(this).data("url");
	const options = 'width=500, height=400, top=300, left=500, scrollbars=yes'
	
	popup_forgive = window.open(url,'_blank',options);
	popup_forgive.addEventListener('beforeunload', function() {
		me_cri.page = 1;
		getMemberList(me_cri, where);
	});
})


$(document).on("click",".writer-punish-btn",function(){
	let url = $(this).data("url");
	let rp_num = $(this).data("num");
	const options = 'width=500, height=300, top=300, left=500, scrollbars=yes'
	
	popup_punish = window.open(url,'_blank',options);
	popup_punish.addEventListener('beforeunload', function() {
		$.ajax({
			url : '<c:url value="/report/block/writer"/>',
			method : "post",
			data : {
				"rp_num" : rp_num
			},
			dataType : "json",
			success : function (data) {
				if(data.result){
					$("#reportDetailModal").modal("hide");
					reportArr.splice(0);
					cri.page = 1;
					getReportList(cri);
					alert("해당 신고건이 처리됐습니다.")
				}
				else{
					alert("해당 내역 처리에 실패했습니다.")
				}
				
			},
			error : function (a,b,c) {
				console.error("에러 발생");
			}
		})
	});
})

$(document).on("click",".reporter-punish-btn",function(){
	let url = $(this).data("url");
	let rp_num = $(this).data("num");
	const options = 'width=500, height=300, top=300, left=500, scrollbars=yes'
	
	popup_punish = window.open(url,'_blank',options);
	popup_punish.addEventListener('beforeunload', function() {
		$.ajax({
			url : '<c:url value="/report/block/reporter"/>',
			method : "post",
			data : {
				"rp_num" : rp_num
			},
			dataType : "json",
			success : function (data) {
				if(data.result){
					$("#reportDetailModal").modal("hide");
					reportArr.splice(0);
					cri.page = 1;
					getReportList(cri);
					alert("해당 신고건이 처리됐습니다.")
				}
				else{
					alert("해당 내역 처리에 실패했습니다.")
				}
				
			},
			error : function (a,b,c) {
				console.error("에러 발생");
			}
		})
	});
})
</script>

<!-- 회원 관리 스크립트 -->
<script type="text/javascript">


let me_cri = {
	page : 1,
	perPageNum : 5,
	search : "",
	type : "all",
	order : "right",
	role : "asc"
}

let where = $(".all-container");

setTable(where);
getMemberList(me_cri, where);


function toggleRole(me_cri) {
	if(me_cri.role == "asc"){
		me_cri.role = "desc";
	}else{
		me_cri.role = "asc";
	}
}


function setTable(where){
	me_cri.role = "asc";
	let str = "";
	str +=
	`
		<table class="table table-hover container text-center">
			<thead>
				<tr>
					<th class="order-btn order-right" data-order="right">권한<i class="fa-solid fa-caret-up order-icon ml-1"></i></th>
					<th class="order-btn order-id" data-order="id">아이디</th>
					<th class="order-btn order-nick" data-order="nick">닉네임</th>
					<th class="order-btn order-grade" data-order="grade">등급</th>
					<th class="order-btn order-date" data-order="date">가입일</th>
					<th class="order-btn order-post" data-order="post">게시글</th>
					<th class="order-btn order-loan" data-order="loan">대출</th>
					<th>상태</th>
					<th class="order-btn order-loanBlock" data-order="loanBlock">대출 정지일</th>
					<th class="order-btn order-communityBlock" data-order="communityBlock">커뮤 정지일</th>
					<th></th>
	`
	if(me_cri.type == "all"){
		str +=
		`
			<th></th>
		`
	}
	
	str +=
	`				
				</tr>
			</thead>
			<tbody class="table-body-flag"></tbody>
		</table>
	`
	where.html(str);
}


function addCaret(text, me_cri) {
	$(".order-icon").remove();
	let caret = "";
	if(me_cri.role == "asc"){
		caret += text + `<i class="fa-solid fa-caret-up order-icon ml-1"></i>` 
	}
	else{
		caret += text + `<i class="fa-solid fa-caret-down order-icon ml-1"></i>` 
	}
	$('.order-'+me_cri.order).html(caret);
}


function getMemberList(me_cri, where){
	$.ajax({
		url : '<c:url value="/member/list"/>',
		method : "post",
		data : JSON.stringify(me_cri),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data) {
			let pm = data.pm
			let memberList = data.list
			str = "";
			let right = ${user.me_mr_num}
			if(memberList.length == 0){
				if(pm.cri.type == "all"){
					str +=
					`	
						<tr>
							<td colspan="12">
								<h3 class="text-center">해당 항목의 회원이 없습니다.</h3>
							</td>
						</tr>
					`
				}
				else{
					str +=
					`	
						<tr>
							<td colspan="11">
								<h3 class="text-center">해당 항목의 회원이 없습니다.</h3>
							</td>
						</tr>
					`
				}
				
			}
			else{
				
				for(member of memberList){
					let punishUrl = '<c:url value="/popup/member/punish?nick='+ member.me_nick + '" />';
					let forgiveUrl = '<c:url value="/popup/member/forgive?nick='+ member.me_nick + '" />';
					str += 
					`
						<tr>
							<td>\${member.me_mr_name}</td>
							<td class="small hovertext-box" data-hover="\${member.me_id}"><p class="hovertext">\${member.me_id}</p></td>
							<td class="small">\${member.me_nick}</td>
							<td>\${member.me_gr_name}</td>
							<td class="small">\${member.me_date}</td>
							<td>\${member.me_post_count}</td>
							<td>\${member.me_loan_count}</td>
							<td>\${member.me_ms_name}</td>
					`
					if(member.me_loan_block != null){
						str +=
						`
							<td class="small">\${member.me_loan_block}</td>
						`
					}
					else{
						str +=
						`
							<td class="small">-</td>
						`
					}
					if(member.me_block != null){
						str +=
						`
							<td class="small">\${member.me_block}</td>
						`
					}
					else{
						str +=
						`
							<td class="small">-</td>
						`
					}
					if(pm.cri.type == "all"){
						str +=
						`
							<td><a href="#" class="btn btn-sm btn-danger member-punish-btn" data-url="\${punishUrl}">정지</a></td>
						`
						
						if(right == 0){
							str +=
							`
								<td><a href="#" class="btn btn-sm btn-primary btn-appoint" data-nick="\${member.me_nick}" data-id="\${member.me_id}">임명</a></td>
							`
						}
						else{
							str +=
							`
								<td></td>
							`
						}
					}
					else if(pm.cri.type == "prisoner"){
						if(member.me_block != null){
							str +=
							`
								<td><a href="#" class="btn btn-sm btn-success member-forgive-btn" data-url="\${forgiveUrl}">기한 변경</a></td>
							`
						}
						else{
							str +=
							`
								<td><a href="#" class="btn btn-sm btn-secondary member-forgive-btn" data-url="\${forgiveUrl}">정지 해제</a></td>
							`
						}
					}
					else{
						if(member.me_mr_num == 1 && right == 0){
							str +=
							`
								<td><a href="#" class="btn btn-sm btn-danger btn-dismiss" data-nick="\${member.me_nick}" data-id="\${member.me_id}">임명 해제</a></td>
							`
						}
						else{
							str +=
							`
								<td></td>
							`
						}
					}
					str +=
					`
						</tr>
					`
				}
			}
			
			$(".table-body-flag").html(str);
			
			
			let pmStr = "";
			//이전 버튼 활성화 여부
			if(pm.prev){
				pmStr += 
				`
					<li class="page-item">
						<a class="page-link" href="javascript:void(0);" data-page="\${pm.startPage-1}">이전</a>
					</li>
				`;
			}
			//숫자 페이지
			for(let i = pm.startPage; i<= pm.endPage; i++){
				let active = pm.cri.page == i ? "active" : "";
				pmStr += 
				`
				    <li class="page-item \${active}">
						<a class="page-link" href="javascript:void(0);" data-page="\${i}">\${i}</a>
					</li>
				`
			}
			//다음 버튼 활성화 여부
			if(pm.next){
				pmStr += 
				`
					<li class="page-item">
						<a class="page-link" href="javascript:void(0);" data-page="\${pm.endPage + 1}">다음</a>
					</li>
				`
			}
			
			$(".member-pagination ul").html(pmStr);
			
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	})
	
}

$(document).on("click", ".member-pagination .page-link", function () {
	me_cri.page = $(this).data("page");
	getMemberList(me_cri, where);
})



$(document).on("click",".member-tab", function () {
	let type = $(this).data("type");
	me_cri.page = 1;
	me_cri.type = type;
	
	where = $('.'+ type + '-container');
	setTable(where);
	getMemberList(me_cri, where)
})

$(document).on("click", ".order-btn", function () {
	let order = $(this).data("order");
	let text =  $(this).text();
	console.log(text)
	if(order != me_cri.order){
		me_cri.role = "asc";
		me_cri.order = order;
		console.log(me_cri.order);
		getMemberList(me_cri, where);
	}
	else{
		toggleRole(me_cri);
		getMemberList(me_cri, where);
	}
	
	addCaret(text, me_cri);
})


$(document).on("click", ".btn-appoint", function () {
	let me_id = $(this).data("id");
	let me_nick = $(this).data("nick");
	if(confirm("아이디 : "+ me_id + "\n닉네임 : "+ me_nick+"\n\n위 회원을 운영진으로 임명하시겠습니까?")){
		$.ajax({
			url : '<c:url value="/member/appoint"/>',
			method : "post",
			data : {
				"me_id" : me_id
			},
			dataType : "json",
			success : function (data) {
				if(data.result){
					alert("닉네임 : "+ me_nick+" 회원이 운영진으로 임명됐습니다.")
					me_cri.page = 1;
					getMemberList(me_cri, where);
				}
				else{
					alert("운영진 임명에 실패했습니다.")
				}
				
			},
			error : function (a,b,c) {
				console.error("에러 발생");
			}
		})
	}
	
})


$(document).on("click", ".btn-dismiss", function () {
	let me_id = $(this).data("id");
	let me_nick = $(this).data("nick");
	if(confirm("아이디 : "+ me_id + "\n닉네임 : "+ me_nick+"\n\n위 운영진을 해임하시겠습니까?")){
		$.ajax({
			url : '<c:url value="/member/dismiss"/>',
			method : "post",
			data : {
				"me_id" : me_id
			},
			dataType : "json",
			success : function (data) {
				if(data.result){
					alert("닉네임 : "+ me_nick+" 이 해임됐습니다.")
					me_cri.page = 1;
					getMemberList(me_cri, where);
				}
				else{
					alert("운영진 해임에 실패했습니다.")
				}
				
			},
			error : function (a,b,c) {
				console.error("에러 발생");
			}
		})
	}
	
})

</script>

</body>
</html>
