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
		<li><a href="#" data-toggle="modal" data-target="#reportModal" class="reportModal">신고 관리</a></li>
		<li><a href="#" data-toggle="modal" data-target="#userModal" class="userModal">유저 관리</a></li>
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
	container.attr("hidden",true);
	let ca_num = $(this).data("num");
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
	let ca_name = $(this).parents('.input-update-box').find('.input-update-name').val();
	let ca_num = $(this).data("num");
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
	page : 1
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
					<h4 class="text-center">신고된 경우가 없습니다.</h4>
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
								<span class="detail-link" data-writer="\${report.rp_writer_nick}" data-type="\${report.rp_type}" data-reporter="\${report.rp_me_nick}" data-note="\${report.rp_note}" data-post="\${report.rp_post.po_num}">
									<a class="reportDetailModal" href="#" data-toggle="modal" data-target="#reportDetailModal" ><button class="btn btn-sm btn-secondary" >상세보기</button></a>
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
								<span class="detail-link" data-writer="\${report.rp_writer_nick}" data-type="\${report.rp_type}" data-reporter="\${report.rp_me_nick}" data-note="\${report.rp_note}" data-post="\${report.rp_post.po_num}">
									<a class="reportDetailModal" href="#" data-toggle="modal" data-target="#reportDetailModal" ><button class="btn btn-sm btn-secondary" >상세보기</button></a>
					`
					if(report.rp_comment == null){
						str +=
						`
							<input hidden class="report-post-category" value="\${report.rp_post.ca_name}">
							<input hidden class="report-post-title" value="\${report.rp_post.po_title}">
							<input hidden class="report-post-content" value="\${report.rp_post.po_content}">
							<input hidden class="report-post-id" value="\${report.rp_post.po_me_id}">
						
						`
					}
					else{
						str += 
						`
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
	let writer = $(this).parents(".detail-link").data("writer");
	let type = $(this).parents(".detail-link").data("type");
	let reporter = $(this).parents(".detail-link").data("reporter");
	let note = $(this).parents(".detail-link").data("note");
	let po_num = $(this).parents(".detail-link").data("post");
	let po_ca_name = $(this).parents(".detail-link").find(".report-post-category").val();
	let po_title = $(this).parents(".detail-link").find(".report-post-title").val();
	let po_content = $(this).parents(".detail-link").find(".report-post-content").val();
	let po_me_id = $(this).parents(".detail-link").find(".report-post-id").val();
	let co_content = $(this).parents(".detail-link").find(".report-comment-content").val();
	let co_me_id = $(this).parents(".detail-link").find(".report-comment-id").val();
	let postUrl = '<c:url value="/post/detail?num='+ po_num +'" />';
	str = "";
	
	str +=
	`
		<div>
			<div class="d-flex">
				<div><h5>신고대상</h5></div>
				<div class="mb-1 ml-auto">
					<a href="\${postUrl}" class="btn btn-secondary btn-sm" >게시글로</a>
				</div>
			</div>
			</div>
			<div class="input-group">
				<div class="input-group-prepend"><span class="input-group-text">작성자</span></div>
				<input class="input-group form-control" readonly value="\${writer}" style="background-color: white;">
				<button class="btn btn-danger">활동정지</button>
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
		`
	}
	else{
		str +=
		`
			<div class="input-group mb-3">
				<div class="input-group-prepend"><span class="input-group-text">댓글</span></div>
				<textarea class="input-group form-control" readonly style="background-color: white; min-height: 50px">\${co_content}</textarea>
			</div>
		`
	}
	
	str +=
	`	
			<hr>
			<h5>신고내용</h5>
			<div class="input-group">
				<div class="input-group-prepend"><span class="input-group-text">신고한 회원</span></div>
				<input class="input-group form-control" readonly value="\${reporter}" style="background-color: white; "> 
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


$(document).on("click",".report-delete-btn",function(){
	if(reportArr.length == 0){
		alert("선택한 신고내역이 없습니다.");
		return;
	}
	if(confirm("신고내역 "+reportArr.length+"개를 반려하시겠습니까?")){
		$.ajax({
			url : '<c:url value="/report/delete"/>',
			method : "post",
			data : JSON.stringify(reportArr),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function (data) {
				alert("신고내역 "+data.count+"개가 반려됐습니다.");
				reportArr.splice(0)
				getReportList(cri);
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
