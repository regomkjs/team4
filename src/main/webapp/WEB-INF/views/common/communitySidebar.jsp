<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/6830e64ec8.js"
	crossorigin="anonymous"></script>
<style>

	* {
	  margin: 0;
	  padding: 0;
	  list-style: none;
	  text-decoration: none;
	}
	
	.side-tab-navi {
	  display: flex;
	  width: 250px;
	  height: 30px;
	  border: 1px solid #aaa;
	  border-bottom: none;
	  box-sizing: border-box;
	  margin-bottom: 0;
	  padding-bottom: 0;
	 
	}
	
	.side-tab-navi li {
	  width: 100%;
	  cursor: pointer;
	  border-right: 1px solid #aaa;
	  border-bottom: 3px solid rgb(250, 208, 203);
	  box-sizing: border-box;
	  
	}
	
	.side-tab-navi li:last-child {
	  border-right: none;
	}
	
	.side-tab-navi li:hover {
	  background-color: #f3f3f3;
	}
	
	.side-tab-navi li.active {
		background-color: #f5f5f5;
		border-bottom: 3px solid salmon;
		box-sizing: border-box;
	}
	
	.side-tab-contents {
	  width: 250px;
	  height: 200px;
	  border: 1px solid #aaa;
	  border-top: none;
	  box-sizing: border-box;
	  border-radius: 5px;
	}
	
	.side-tab-content {
	  display: none;
	  width: 100%;
	  height: 100%;
	  box-sizing: border-box;
	}
	
	.side-tab-content.active {
	  display: block;
	}
	
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
		width: 70px;
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
	    transition: opacity 0.5s ease-in-out;
	
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
	
	.side-category{
		border: 1px solid #aaa;
		box-sizing: border-box;
		border-radius: 5px;
		padding: 10px;
		margin-bottom: 1px;
	}
	.side-category ul{
		margin: 0;
		text-decoration: none;
		box-sizing: border-box;
	}
	.side-category ul:first-child{
		border-bottom: 1px solid #ccc;
	}
	
	.side-category li{
		line-height: 50px; 
		border-bottom: 1px solid #ccc;
		box-sizing: border-box;
		
	}
	.side-category li:last-child{
		border-bottom: none;
	}
	.side-category li:hover {
		box-sizing: border-box; padding: 0px;
		background-color:#ddd;
		cursor: pointer;
	}
	.select-category{
		font-weight: bolder;
	}
	.dropdown-menu{
		border: 2px solid #bbb; box-sizing: border-box;
	}
	
	.profile-box{
		padding: 5px
	}
	.cafe-info-box{
		padding: 5px
	}
</style>

<div>
	<div class="side-tab">
		<ul class="side-tab-navi">
			<li class="text-center active">카페</li>
			<li class="text-center">회원</li>
		</ul>
		<div class="side-tab-contents">
			<div class="side-tab-content active">
				<div class="cafe-info-box"></div>
			</div>
			<div class="side-tab-content">
				<c:if test="${user == null}">
					<div class="login-box text-center">
						<a href="<c:url value='/login'/>"
							class="btn btn-outline-success login-btn col-8"
							style="margin-top: 60px">로그인</a>
						<div style="width: 100%; font-size: small;" class="mt-4">
							<a href="<c:url value="/find/id"/>" style="color: gray;">아이디찾기</a>
							<span style="color: gray; opacity: 60%">|</span> <a
								href="<c:url value="/find/pw"/>" style="color: gray;">비밀번호찾기</a>
							<span style="color: gray; opacity: 60%">|</span> <a
								href="<c:url value="/signup"/>" style="color: gray;">회원가입</a>
						</div>
					</div>
				</c:if>
				<c:if test="${user != null}">
					<div class="login-box text-center"></div>
				</c:if>
			</div>
		</div>

	</div>
	<div class="side-category"
		style="width: 100%; min-height: calc(100% - 276px); margin-top: 1px">

	</div>
	<c:if test="${user.me_mr_num < 2 }">
		<div class="dropup mb-3" style="width: 100%; height: 35px">
		    <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" style="width: 100%;">
		      관리자 메뉴
		    </button>
			<div class="dropdown-menu" style="width: 100%;">
				<a style="width: 100%;"  href="<c:url value="/grade/list"/>" class="dropdown-item">등급 관리</a>
				<a style="width: 100%;" href="#" data-toggle="modal" data-target="#adminModal" class="adminModal dropdown-item">게시판 관리</a>
				<a style="width: 100%;" href="#" data-toggle="modal" data-target="#reportModal" class="reportModal dropdown-item">신고 관리</a>
				<a style="width: 100%;" href="#" data-toggle="modal" data-target="#userModal" class="userModal dropdown-item">회원 관리</a>
			</div>
		</div>
	</c:if>
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
					<button type="button"
						class="btn btn-primary category-input-btn col-2">입력</button>
				</div>

				<button type="button" class="btn btn-primary form-control"
					id="category-add">추가</button>
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
				<div class="report-container"></div>

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
							<li class="nav-item"><a class="nav-link active member-tab"
								data-toggle="tab" href="#all" data-type="all">회원</a></li>
							<li class="nav-item"><a class="nav-link member-tab"
								data-toggle="tab" href="#prison" data-type="prisoner">수감소</a></li>
							<c:if test="${user.me_mr_num == 0}">
								<li class="nav-item"><a class="nav-link member-tab"
									data-toggle="tab" href="#master" data-type="admin">운영진</a></li>
							</c:if>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content" style="min-height: 300px; width: 90%">
							<div id="all" class="container tab-pane active">
								<h3>이용중인 회원</h3>
								<div class="all-container"></div>

							</div>
							<div id="prison" class="container tab-pane fade">
								<h3>정지된 회원</h3>
								<div class="prisoner-container"></div>

							</div>
							<c:if test="${user.me_mr_num == 0}">
								<div id="master" class="container tab-pane fade">
									<h3>운영진 관리</h3>
									<div class="admin-container"></div>

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
				<div class="report-detail-container"></div>

			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button"
					class="btn btn-success mr-auto complete-report-btn">처리완료</button>
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
				getEverything();
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
				getEverything();
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
					getEverything();
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

let rp_cri = {
	page : 1,
	perPageNum : 5
}

getReportList(rp_cri)
function getReportList(rp_cri) {
	$.ajax({
		url : '<c:url value="/report/list"/>',
		method : "post",
		data : JSON.stringify(rp_cri),
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
	rp_cri.page = $(this).data("page");
	getReportList(rp_cri);
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
	getReportList(rp_cri);
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
		getReportList(rp_cri);
		return
	}
	$(".check-report-all").prop("checked", false);
	getReportList(rp_cri);
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
				rp_cri.page = 1;
				getReportList(rp_cri);
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
					rp_cri.page = 1;
					getReportList(rp_cri);
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
					rp_cri.page = 1;
					getReportList(rp_cri);
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
					rp_cri.page = 1;
					getReportList(rp_cri);
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
					rp_cri.page = 1;
					getReportList(rp_cri);
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
					rp_cri.page = 1;
					getReportList(rp_cri);
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


<!-- 카페, 회원정보 박스 스크립트 -->
<script type="text/javascript">
$(".side-tab-navi li").click(function () {
	let tabIdx = $(this).index();
	$(".side-tab-navi li").removeClass("active");
	$(".side-tab-content").removeClass("active");
	$(".side-tab-navi li").eq(tabIdx).addClass("active");
	$(".side-tab-content").eq(tabIdx).addClass("active");
});
</script>


<!-- 카페,회원정보, 게시판 리스트 스크립트 -->
<script type="text/javascript">

getEverything()
//카페정보, 회원정보, 게시판 리스트 호출 
function getEverything() {
	
	$.ajax({
		url : '<c:url value="/community/sidebar/info"/>',
		method : "post",
		dataType : "json", 
		success : function (data) {
			let memberInfo = data.memberInfo;
			let categoryList = data.categoryList;
			let cafeMemberNum = data.cafeMemberNum;
			let cafePostNum = data.cafePostNum;
			let cafeLentalBook = data.cafeLentalBook;
			let gradeList = data.gradeList;
			if(memberInfo != null){
				let meStr = "";
				meStr +=
				`
					<div class="profile-box text-center">
						<ul style="text-align: left">
							<li> 
				`
				if(memberInfo.me_mr_num == 0){
					meStr +=
					`
						<img width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEnklEQVR4nO2c3UsrRxTAtx8PLeU+9KnQQmn/hNK3vvheaJ8qZs/ZJBrFqBUVPzCLiohexIg+iNpaEY31G4sffdEqFIuIilQULPZB8CsKohaUoMaPucxyM7hxk5ukue7OZg+ch5ydPXPyy8w5s6OzghBBnE7nB6IofgcAPwPAnwDwDyLu8KYA8C8A/AUAPgDIcLlcL4RYJT09/T0AyEVEPyISsykA/AcAlfTHjgrC5XK9AIApvQN+Jl232+2fa4KQJOkjRPzbAEE+p+7abLZPnsBAxN8MEJweupiWlvY+AyGK4rcGCEo3pTmSwQCAVb0D0ln9tHAIGRkZXxggGKK3iqKYJrwuoyTVFQBeUhgNegeCBlAA+JVWkS69A0EDKADM0pHRrXcgaAAFgHkLBlowiDUy0JomxMoZqFMCLSgoICMjI0/U4/EkNePLsqzZD+3fMNWkurqaaMny8nJSYaysrGj2Q/s3PIzb21uSl5eXFBDUTzAY5BcGlf7+/qTAGBwcJJHEsDCCwSDZ399nn/f29pICw+/3M5+Hh4d8wKAyNDREkhlsXV3dW/X/VmFUVFSo5vfc3Nz/8r+wsMB80RHS1NTED4zS0lJV5g8EAiQrKysh3zk5OeT6+pr5GhgYIK2trfzAqKysJM3NzSpbZ2dnQr57enpU1Sk/P5+0t7fzA8Pj8RC73U5OT0+ZbWtrKyHfOzs7zMfq6qpi6+rq4geGLMuKfXp6mtkeHh6U6ROPXwr1sXi9XsXe29vLD4yqqirFXlZWpkAIycTERFx+Z2Zm2L1nZ2fKaKN2mje4gVH9KLjt7W1mp9Mm9IXepJmZmeTy8pLdOzk5ya4NDw/zCaO7u1t1jZbFWHx2dHREnGLcwsjOziZXV1dxP7zRhBsp+XILA8MWTaHyGM1fSUmJKteEl2WuYdTX18f18DY1NRV1wcY1DEQkR0dH7PrBwUFEXw6Hg5yfn0ddynMPY2xsTNWmpqZG01dLS4tmmTYVjMLCQnJ/f8/azM/Pa/paW1tjbehWgFYb7mEgItnY2IiaC+he5t3dHWvj8/nMC6OtrU3VLrxKjI6OxrRlaAoYTqeTXFxcaK4fJEkix8fH7NrS0lLE/kwBAxHJ7Oys5sqyoaFB5aOxsdH8MGRZVrUNPbwtLi4y28nJiTJSTA8DEcnu7i5rS9cUbreb3NzcMNv4+HjU+00Fw+fzqdqvr6+rpk5xcXHqwHC73RH/ILS5ufnG/kwFAxGVp1ctoeU35WB4vd4nIOhmDi2/KQdDkiTVhjEVus0XS3+mg4Fhj+qPN5K5hpGbm6vM9ZDSz7HcV1RUxP7Hoq+vL+b+ysvLE+rvWWCgCdSCgRYMYo0MtKYJsXIGJp5A2/TO5GgM/Z3CkA0QCDGA/kTPm3xvgECI3goARfSE84cAENA7GL1VkqQvQ2daf0nxUfEHO8rpcDg+S9XRAQD3Npvtq/ATzz8g4kMKwpA1z8MjoifFgHQKgvBOxDclAEA6Ip6bfDQEAODHqK+MCAkAfIyITQBwZDIIp3Q02Gy2T4V4pba29l0A+FoURUTEUvoSDg61HADskiR9o5x3jyKvAHbQX3wyaiWpAAAAAElFTkSuQmCC">
					`
				}
				else if(memberInfo.me_mr_num == 1){
					meStr +=
					`
						<img width="18" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEjElEQVR4nO2c30/bVRTAG50vPrmHxcT4D+jr4nxconBvk21OXWZQZ5Ys8cX4YtRoFk0l7t7ya8tKxoSxGbMRo8icgoDcW9rRymSMbaV2bEXK5oAyJrABK4P+OubeFew3pQiY9rb9fk9y3trm3E/OOffce3quybSKNFt2PskofoURfJBRXM0Irss35RQf5wR/wWnxfjt56WnTesVZZn6WE1TPCJrnFEPhKIoxgrj9ENq2JhAdxLyPUxRSb3jmlBEcZwTZnJbtm9KCYAQfVG1oVpWg1r66rU+kgLCT4hJBTLmBWfcSVKMB8Yt1x2ZO8ZRqw5SpFRctw+AEVyo3SK139EoQFovlMUbQuGqDVKudmJ83ddDiF1UbwnNAmRV9kthK1RujWhlFJ02MoA9VG8JzQQlq1V9tQdMpshswqAEDDM+gRpiAkTNoniRQR+VuuPL9ZxBwN0DQy+Du4O/w91Av3LnugtGrrfCn4xR4mkqh6+gbhbubdNlKYORyC0QWQrA2icPsRAAGHSfBVf1m4cDwNJVCeH4WNioCSEHA8J6jEI/HNIuLhh/ChL8bAu4z4OdfwWBnPQx3fytDJTQ1qvWPeAxc1W/lPwz3sX0pYTHqaQfn4df+83sD7TaYvu2V+STz3psFGLd6ftCA+Ovi2XX/hr1sR2HACCW5fPjhHHRW7MrCwnIShhli0cgyDLGFql+0IhidFbs0ITLuc+TAopV5BoZYZHEZxv2Ra/qGMRP0/7tFxqKy8NItjIC7QRMqoo4QuUSXMLpsJbLAShZRbDkPv64/GJxi8LVUpZTX4fkZGDr/DTiP7NEXDE6xPFusJNHwAox5foWLX7+vHxicYrja+DksPpiGdCKS7UCbTR7xCx4GF3cZVa9CwHUGIgsP0kJZDN2XdxrZrVYV3o47KnfDQNtRmBm7kRbK/HQQ+ho+LnwYPEm7aw/Io/zC3FQKEFGb+Jor9AODJ1SEhZ/XpoRQPBaB3tMf6AsGT+hvx/fD7J0hDZB7Iz59wuCJYm0xdE8DxF3zjj5h8BUuhvp/PKRfGP1nv9TAuNFRo18YfQ0faWDcvPCdfmH4mssNz+AJGOJ0myw9p97LX8+w/49bbdF0Eh21JQlNjmTYEzMMw9NUCnMTw7JBdOHEu2v6Tmf5Tvn5WDSs8QpxyMt7GMkiym3RELrV0yR3hj9+LpOL9J4j4LfXQdDLV2xBbqTXkvMw1iviXCKuDbNzTZhhGN21B2AycCmlz7oWCKLHktmEmWUYPKHnj+yR4RBwnYaxfgZTw5dhZnwQ5u7elB03cYyfHO6D25d+kleEmf/7gUIYPC/UgAEGDGp4BhhhQo2cARtMoMZUAV+aKuAUva1+W8PqlaB6E6fmF5QbQnNkEknMqHGKgqqNUa2srOi5R8O9FJXrGsTS9KKcfbdsf0rPc62MmF/Wjn5bzXv1OPHMKTq24iw8J+hTPQFhBLes+jgAl1tt4b+SwCmuamzc+3haEEvCyoue4RSfKDgoBEUZwe0dVrTVtF5pTrys8ih8kE31KykbfVmFUWQRw8xtxLxltQX/AwTfUMDaNhZhAAAAAElFTkSuQmCC">
					`	
				}
				else{
					switch (memberInfo.me_gr_num) {
					case 2:
						meStr +=
						`
							<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABJElEQVR4nO2ZTWoCQRCF+xiWie4kS4/hBXISYQpc6wVcZu/KDFnmDlkY6BZEELfqRvwBEUSs0IREAs6iW5juJu+DWs97U696hi6lAAAgWqrtcY3Y5MR6T2yk3NL7Cuu3aqafvMVXWK/LF27+lNXwwPrR2cD3mw8rnq419DAQIjamKE47nw5ITKVggNEBQYRcCB0ZimGIm92J9N6Xstie0jLQ6s/kdbSR0/kiPyRjYLo6yi2SMVBEMgY2h7MMPtby/DJP00C9M77ZjWQMUEGcYMAVdIARIcEQE06hKzhGXcExyvd/ySn0rwQMMDpggkeH/vEM6HgudzOzdTZglwvBhfNv5c4G7GYkmgVH9tlQPtjNiF0u2Pv58sVr+8zcWzwAAKgy+ALGkks5M3xO2gAAAABJRU5ErkJggg==">
						`		
						break;
					case 3:
						meStr +=
						`
							<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABqUlEQVR4nO2Zy4rCMBSG8yAzy2EeR5JSRQRREZe+gY+gK9F1t4N04VY3Cq7c6ULwBcSFMF4q9vRyhlSm1QHRVmlTJj8cKGlp/+/kJCkJIVJSUlLC6pjJvAOlPZOxHTCGcYZ5/qZ+UtXPyOZNSjdxG4e/IJRuDErfQgPwzCdtHoL4Cg2QRNnA7V7Yhu8BAYzDRUgAkD3AZAmF0v8dxIqCdreL7nKJuN97wa/tTse7JzaAoqAzHuMtOaOR2AB2q4X3ZDeb4gK4s1mQ7cEAoVxGKBTQGQ79dv6MsABoGL5RKBb9dqtWC7rAMMQFgFtRqQQAu136AGxNC0poPk8XgFWtIh6PwSBut1MEkM16Gfezv1oh5HIpAVBVdCaTi0XAQavRiPw+EitAPo/OdHo9/2vaUwkhsQGUSuguFtcrcL//dDmSOACseh3d9fravK4/P5ZYXAvZ4XD3V8Jb5IQFeFAS4BG9om5fGSSskjYMEoAln3WQJcRSPIhNsTZ3v6PMQnrSxuE3KO2FBuAnI6IccJwY+yBRxE9G+OEC359PwPiWZz6yeSkpKSkSh34A766mybHzuzMAAAAASUVORK5CYII=">
						`					
						break;
					case 4:
						meStr +=
						`
							<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABiElEQVR4nO2ZwUrEMBCG8yB6FA824M0XUHwUD+7DKI3C6mW9SvGgfQL1UterNq4rrLRepAvu0ihUSmSKjahUTcU2wfnhh5JL/y8zaUuHEBQKhTJWW9cLs4w7nsvplHEqm7QL9wzpwXZI538Rno6bDs4+e7w5oDPaALDzBoSXr97XBmijbViVQzqpUQEDgvM3IwDDClBsIS3960Psxx0ZizOZ5Y+FYxEUa1YAnCe7skr9ZMdsAD/uyO9UtxKkCQBom1Kj9Fj2hsuFR+mJWo9EYC5AlgsVFIKX673hilrP8tRcAFbhvZtVBSCeE3sAuoMleRityfunSwVwNfHtAfioaXb3rrUYAnwhbCFu4SHObH+MxiJQQeHlBcHBt+mpHS8y/wefEkfRurkAjNPig61K/aRb+5FMmgIoKwGtAmcCDNd1d561AfAXJgjAsQISW0hH1h9i16Cfu27oPGgDwHCh7eBM2fG0AWAyYsqAY+NicY7UEUxGYLgA/+cbDx7CPR2vdngUCoUiTegFU2aJ1Yt8CosAAAAASUVORK5CYII=">
						`
						break;
					case 5:
						meStr +=
						`
							<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABMUlEQVR4nO2ZTQrCQAyFe4yO1aUIKngYjyYi4g1EPIPSClO3HsG6FPzDTeNERrRaiuAU6UwgD7Lppu97STYTz2OxWCxnhctaA0IxS0NxgkhglZU+/unPMaq1SptPQ39ftXEogPh7lEHdGEAnb9s8vGtqDGBjbOD7OB3NO+CAcfgoBgDugOARMpLtkQHrSyzbiHDCT5ECUNtBzjwtAKnTP9MFUMmwYJ4OQNzJ0leHFT0AlYwyw7dNnxhA3EWES5a+/kYKQO3GufRpAax7iLdrLn1SAGo3KaRPCgCf6f8iNwFQUQdA2gDwA5jTOwAMINzswL/KY4CIO4A8QiYiv8SpW4+7B2MAfVywbRxeFYqZMYC+jDhz4FgETWOAB4QM6vq4oN/nLYzNUSdf2jyLxWJ5VegOSOS+C4MgG8YAAAAASUVORK5CYII=">
						`
						break;
					case 6:
						meStr +=
						`
							<img width="25"  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABf0lEQVR4nO2ZsUoDQRCG90G00V1S+Qhq7QPIbVDsTKGWWtjamT7BZ5Bw4COIRTq1SOUjCCEmahR27kZG1BVMPHbBvV2cH4ZLFeab+Wfv2BGCxWKxolW2jIuZgp6WZqIVYNCQZpJJyDcb2PBOXkszDJ64+gEy3JK44A5Ala87efUV584AtdhGzY5MmbE7QASJ62/BAJo7AGwhJ/3bIT47LrBKUQPknTJtgKuLxAHuri3AyXaR3gyM7m2lD9YhLYCdFcDyowH0fBwhvk4RB/0S260ifoDDDfjV+3m3jBugc1R9hPp2QoQAmBV7q4A3l3awyU5JAWgFuL9mrTV9ivwY1XMiiffAy7NNkqyTXAcGfet18j0lTnGbygy0W9Wn0Olu5KdQ3p3/LUQfer7/K0IBfHaCrEIzQUG/fSuv6wD4ixAMoLgDyBZyUfpDLOO53NXKPDgD0HKh/sThPeiq3xmANiOxLDiaS6iEj2gzQssFup8PX3Uzpsp7J89isVgihN4AZZD+JaDC0u8AAAAASUVORK5CYII=">
						`					
						break;
					}
					
				}
				meStr +=
				`
							<span style="font-weight: bold;">\${memberInfo.me_nick}</span> 
				`
				
				if(memberInfo.me_mr_num == 0){
					meStr +=
					`
						<span>(마스터)</span>
					`
				}
				else if(memberInfo.me_mr_num == 1){
					meStr +=
					`
						<span>(운영진)</span>
					`
				}
				else{
					for(grade of gradeList){
						if(grade.gr_num == memberInfo.me_gr_num){
							meStr +=
								`
									<span>(\${grade.gr_name})</span>
								`
						}
					}
					
				}
				meStr +=
				`
							
							</li>
							<li>가입일 : \${memberInfo.me_date}</li>
							<hr>
							<li>내가 쓴 게시글 : ${user.me_post_count}개</li>
							<li>내가 대출한 책 : ${user.me_loan_count}권</li>
						</ul>
						<a href="<c:url value="logout"/>" class="btn btn-outline-success btn-sm col-8 mb-3">로그아웃</a>
					</div>
					
					
				`
				$(".login-box").html(meStr)
				
			}
			
			let caStr = "";
			
			caStr += 
			`
				<ul>
					<li class="category-item"><a class="category-link <c:if test='${pm.cri.ca == 0}'>select-category</c:if>" href='<c:url value="/post/list"/>' style="text-decoration: none; color: black;">전체 게시글</a></li>
					<li class="category-item"><a class="category-link <c:if test='${pm.cri.ca == -1}'>select-category</c:if>" href='<c:url value="/post/popular?ca=-1"/>' style="text-decoration: none; color: black;">인기 게시글 <i class="fa-solid fa-fire" style="color: #ff3333;"></i></a></li>
				</ul>
				<div class="mt-4" style="font-size: small; color: gray"><i class="fa-solid fa-list"></i> 게시판</div>
				<ul>
			`
			if(categoryList != null && categoryList.length != 0){
				for(category of categoryList){
					
					let ca_num = category.ca_num;
					let selected = '';
					if(${pm.cri.ca} == ca_num){
						selected = 'select-category'
					}
					caStr +=
					`
						<li class="category-item">
							<a class="category-link \${selected}" href='<c:url value="/post/list?ca=\${category.ca_num}" />' style="text-decoration: none; color: black;">
								\${category.ca_name}
							</a>
						</li>
					`
				}
			}
			caStr +=
			`
				</ul>
			`
			$(".side-category").html(caStr);
			
			let cfStr = "";
			
			cfStr +=
			`
				<div>
					<ul>
						<li style="font-weight: bold;">
							<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAAMn0lEQVR4nNWZeVDTh7bH0/uefa/tzKud2weExa1qF0uVVcAFSTQgFhQ1WvYlyS8SZRMES4GgKEEWWVoUFMlGVkJCIKwCsoh1AS1SK25YO2iv+t683t6O4kK+bxKq1xYCXqte75k5/2WS7/f8zvnkmwmJ9JLKodRhCulfrRZLVr1DEdC2UAW0XirfU08p9x5w2+E+Mit31mLSq1pcLvdPVKHnciqfJqUKPO9SBZ5w/8odjklucExwgcNWF717hvvDwIbQU+yuyJCgpvi3SK9CUQSrrCgCWhJF4HnFKFrgiYVcdzjGu8Eh3gVOSS76TxVrEFAfClZnJIhOjrFZHZF/JToiRayuyOUkkF57qaK9Cr3+g8L3olP4nrVUvucDo/Aidzhu/3Xa8QvhXkgdoWv9EdFGPBZtqlmdnB9YHZwsdjt7zgsVTjnk9RGV75lFEdBuGUWX0eDMXQL7eFejcKckN/1q1VoEN4VPKpow1R2cHlZ7ZAxxhHj3uYheXrr8baqARlAEnkcNog29eK87nLa5wjHexSh+Rb7nCL0mAMwj7GcX3vn7pxI5THRE1hJdkXSih/jHSeYhoDlQBJ6lFL7nL6PTXgbn1NEVsY93wcLk5zDtzqc008G5GVATGj35tMuWWxoOksqnXX48bd6vB2kQvs0VXmWf6kenvemFCydGjx3rVZ/BZc+iH8YVTVfSX6eUr/ChCmjKxwe5bxmctrsaKWKYtmua64ifmo7Qw4yXIpro5BjX0VeyFk67Xe657/b42S/PL2SMePcvl2/yKKPdfoQ/1wx3OBh2O8EFzgkuWCXx1fvXB4PV/nf8vegOb2FhZbnPQ7sdzve996z6pUSZj7Y2rXrc6dvHON+zj3LWO8YthMPW0XbluY+s02xAeCvzpYkmOjkIrAuFRzEN9ulOCCoIHFHo+DhypObX1u4Y30C0M951Nsea3X7DDrEL9UsLqCMvc02IDg42qAOwOG8ZHHe4IGofB3XNiieEG8VD1VhZYtLA1AXv4ty33Th2shGpsqSH3mLfYW/p6uHAhtAXd5jtkfCT07Ew0w2Ldi1FyqFENLeqfyP6yS6S5WD2Ns4d8rbuPofSniljDFy8cBLfD54xdl9fO4p02Xpfsd8db6nPXUMEeF7CGW1s+Ij94JCxEJRMKvIkmYb9Hld4a6sGdXVyKCoPYVtxDD5JpcB8kwo2vKGbVtzz0b8xcPniqccGHvW5/qMoayjS+4n99V4Vq+FfF/ybLPOPdEhjBFaUroRdujP8ctdCVF0yZk0edUuLGjqdFEJ5MSILWHDmLsL7CXRYMrNglX4J1infwIKjHUWq3WbHm5bU6Th9uu3B7w086oHvvoa89RACZUHwEq/CRl0gmB1PZ8RfGwz3IqrxMEMLg6FpEJsU3tysQk2NBCUVeQjfGwy7NDfM2RoIi/BskBM6YJV0CmS26t4HWxQ/eyTLR5FqF+O01G6z4y23mCVDGfzsG+f6u8c1YeiLAyegaReDoYyAp8gbhqDGbGeP+8VDr/KHa/YSuGS4IbE0Ds2tVSb3u7GxEtXVYuSW78Ia3hrYpi7DjCgCZmHFsErugeW27odktvK+81bZL19WKMYi1YFwmGIf5bTBdstqvVeeNw40FuFsX6dJI4Z103XJQChZoIm8sa56IyJaCYS1sOAj8oNjhguW8SjIFu1Em1HkWOFtbdWor1egsoqP5P0JoGRQMS+ZhumbY2DGEMA6uQ+WsS2wJBTwSZM8lFarJ0eq4cWzP10Kj5IAvb/EH/sb8vHNmQ6TRgYv9+Lw12pEVW7GCuFKzE9zwJpcPxys/HKC/dZAp5NBrNgPTiEB1x2L8X7SOliz0mAeqYb1F9/Aaks9bNgKhO+RQdekHfNeNY2agnENkAklpk5dYESq8LAA1LwN+rXi9citzcSp3hZcvXLapBm1VgRdvdQkUQ4frkJtrRSlkjwE5wbB3rDfcQGwCM8EOa4V1p/3wpJTjdmbK7G1SIbmlvHfx9B5QsWIBUOabdLAk0hVd1VgZeFG+AjXIEObimMnGnHlUs8YAwbcNTWpxnxgU1MltNoK5JRnwC/LsN+L8V5sOMwjCkH+/BSst5+E5SYVbGMVyDykRFtbzYRIlSuF2JLNhxVDcsOkgfGQ2nxCjdUFgfAq/xRcTTI6v9bh4sDfjep0owZGn4AWDQ1KVKkFSClJxIpdNMz7Yjmmb46GWXg5rFPOwiq+A5bsSrh/rkB5pWpSpPKlfIRk8DGLqBixiJBWk5kSB6NocEmvP8gh+dzPISnnhO/Hnz+i4/SpFpOr0n2mHv7FTNDKvJGs3oaWbg0GvjuOhgaFUXRdnQIS5QFEF3Hglr4EHyT5wIZIMuAPNil9sIo5DCt2JdbskKOqrnpSpBYL+KBz+bBhiR6aM6QiC4bsw8cTv8slbbqXSbr9IJcEQ5dFOGJWWAnmM4qwu2A/JkJqb38bWAdiQCldibjKaNQ0VkCiLAWniIAj1wVzE9bBkrELVrGtsE7uhVVULWZyKrElX4amlppJkcor4cMjUYTZbBECs5TnyYRk7M/LoXWke0N+JP1fgt7EbZYZbhEWuJBgPsKLpsKZyIYttxt7q4/hbF+XSSN933UiSpgEyr7V+GT7QszgBOO/wwpATuwCOa7NOPmPYlXYdVCBNhPTbnuEVJUIW/P4WBBdAdstIiSWqH81awKbN/xI8DB7G9/Hzh2+sf41/c+J/z6ir3gfqLTDTyJ7pOyIgtPOdiwqvIRs9TGcOdM1IVJV9bVYFL0frwfJYBFShiWfK7FfppoUqUKZAGG7BZjDkYCyXYIiqeaJY9aiuU5WYtLAgqlTjdjsP67DxbKND+/mvzl8/8u3hvXCWUYjd8V2EPLoWM5Vwn7vFaQoTuJkT8eESFVppKitV5oU/gip+4R8+KUJMYMtwbqdcgg12nHXqrOMi+wg37FJ9JGBJ7F5ru8Izqti9XcKp955UPjGXb1wptHIfakdJNl0rOAq8XHOVcRJenD0eMczIXV3iQCU7WLMZIkRlqN64pjHYlOjPIj2jCD0bTAbm0QfGRgPm9/1d+GcNlX/P0U2+uGCt6AXTAeUC/BQbgddnjdWpx3CBzmD2Cw+jSPd7ZMiVaUWYVuBAI5xEnzMESOpRIPGw1qT2NRWFKE7xReDn02FdKMD3APTxibRQd/XbrJnv4UzvRMn0f7GXPx13yw8yH8dI+XWgHK+8al0FVIQwC3Ah3sugSU8jcbO9jFIrZCLwMwS4v3NUiyKF4Mn1KC1zTQ2a8t5OLGdhsHP3sGBz5bCOWCn6SR6Yy1p6aDva7fO0/9r6Fhx4qRJtL+lGP97wBb386dg5KAFoPjEaKT3K1cQabvwQeYAAsrOorpeA7FciNBMMWZGyrAyTY4DldUTYrN+3xfoi3LCtwGWSPH3w+zgwqdLoiBIU35cQ9rQtGGO/nbSnzFQk4z+SZJo/5GDuH3QHvf3GoyYA7J5GJHMR2+qPeLi0rFg52l8xKkAc28VVHVak9jUqMrRms3GBWIujgfNQUxgCKwjyp8tiVoTcsRS3sP5rBn6n4qnY6A6EWfPtE+IzbNHJfjLoUW4n/cnXI+ciwtfUNEhK5gUm1ppMY7u2IhBxjRUhbjBNygBFs8zifbU5+Mod7b+b0VmuKRk42xP04TY1FUL0FwvmRSbOsEenExehath03AgaAVcA9NfbBIdaPsKJzPm4Jf8t3FVFoC+47pnwmbT/lScTViKgbD3kBuyFvNC9r7cJHrxmBBdGZ/gb7lv4ppkPb7p1kyKTa1agNb8aAxEO+IEYz5iQhmYFnbo+SbRJ4scIblpTKITIPVyTxU6sxfjp+w38IPYB32dsjHYrJaXoosXgUHOx6hnLEFgcIwxff6RJGrFkgyPSaK/LwtCvpTMqLj1HiEa2imoOTcRUq/0NaKjYBVu8f4T18s90FovhFZeimOZofg+8kPIGDRQQ9L/cBIlM2U3zRmy9HGT6LhFlE4xZyo2WLCUx54miQ5+24qvS9bj+93voI9li10hdMwL3vuHk6g5Q3rBjCWLsY5TvkF6pqIr/82a28+x4V0/8xKTqN6cKW8iR8hoJBKe3x9+NlnXF9vwrte+qCRqw5bdM2fKRWaE0pb0Imva7uuLDEbm5VzVP48kasmU/WTBlBdaMcXWpJdZ1lk/2NrwhkRzc649eJYkSmYqLpNZyhjzINE/90/uaTk/zrThDRXO2XPtztMkUQuW4qgFIacb7ov0KtWsnB/NbHjX02dmDf3f75PojE3yETKhqDVjyl1Ir3pN4117Z1rWUOqsnKFrNmzlj2RCmUMmlNP+2bpIr3L9P2BM0mEgjkKRAAAAAElFTkSuQmCC" alt="logo" style="width:40px;"> 
							카페명
						</li>
						<li>가입인원 : \${cafeMemberNum}명</li>
						<li>총 게시글 : \${cafePostNum}</li>
						<li>책 보유현황 : \${cafeLentalBook}권</li>
					</ul>
				</div>
			`
			
			$(".cafe-info-box").html(cfStr);
			
		},
		error : function (a, b, c) {
			console.error("에러 발생")
		}
	});
}

$(document).on("click",".category-item", function () {
	$(this).find(".category-link").get(0).click();
})

</script>
