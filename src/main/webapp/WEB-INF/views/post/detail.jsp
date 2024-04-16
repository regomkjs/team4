<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시글 상세</title>
</head>
<body>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="today">
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />
</c:set>
<input value="${today}" id="today" readonly style="display: none;">
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
			<div id="date-box">${post.po_datetime}</div>
			<div class="mr-3">조회수 : ${post.po_view}</div> 
		</div>
		<div class="mb-3 mt-3">
			<label for="writer">작성자:</label>
			<div class="form-control" id="writer">${post.me_nick}</div>
		</div>
		<c:if test="${voteList.size() != 0 && voteList != null}">
			<c:forEach items="${voteList}" var="vote">
				<c:if test="${vote.vo_dup}">
					<div class="d-flex" style="margin-bottom: 0">
						<label class="ml-auto" style="font-size: small; color: gray;">다중선택 허용</label>
					</div>	
				</c:if>
				<div class="mb-3" style="border: 1px solid #aaaaaa; border-radius: 5px;">
					<div class="container">
						<c:if test="${vote.vo_title != null && vote.vo_title.length() != 0}">
							<div class="input-group">
								<div class="input-group-prepend">
									<label for="vote-title" class="input-group-text">투표명</label>				
								</div>
								<div id="vote-title" class="input-group form-control">${vote.vo_title}</div>
							</div>
						</c:if>
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<label for="vote-date" class="input-group-text">투표기한</label>				
							</div>
							<div id="vote-date" class="input-group form-control">${vote.vo_date}</div>
						</div>
						<div>
							<c:forEach items="${itemList}" var="item">
								<c:if test="${vote.vo_num == item.it_vo_num}">
									<button class="form-control btn btn-outline-secondary mb-1">${item.it_name}</button>
								</c:if>
							</c:forEach>
						</div>
						<c:if test="${post.po_me_id == user.me_id}">
							<button class="btn btn-outline-success form-control mt-2 mb-2">투표 마감</button>
						</c:if>
					</div>
				</div>
			</c:forEach>
			
		</c:if>
		
		<div class="mb-3">
			<label for="content">내용:</label>
			<div class="form-control" style="min-height: 250px">${post.po_content}</div>
		</div>
		<div class="mb-3 mt-3 d-flex">
			<button class="btn-heart btn btn-outline-danger mr-3">하트</button> <div style="font: bolder; font-size: x-large;" class="text-heart mr-auto">${post.po_totalHeart}</div> 
			<c:if test="${user.me_id == post.po_me_id}">
				<c:url value="/post/update" var="updateUrl">
					<c:param name="num"  value="${post.po_num}"/>
				</c:url>
				<a href="${updateUrl}" class="btn btn-success mr-3">수정</a>
				
				<c:url value="/post/delete" var="deleteUrl">
					<c:param name="num"  value="${post.po_num}"/>
				</c:url>
				<a href="${deleteUrl}" class="btn btn-danger">삭제</a>
			</c:if>
		</div>
		
		<div class="mt-3 mb-3 comment-box container">
			<h4>댓글(<span class="comment-total">2</span>)</h4>
			<hr>
			<!-- 댓글 리스트를 보여주는 박스 -->
			<div class="comment-list">
				
			</div>
			<!-- 댓글 페이지네이션 박스 -->
			<div class="comment-pagination">
				<ul class="pagination justify-content-center">
				
				</ul>
			</div>
			<!-- 댓글 입력 박스 -->
			<div class="comment-input-box">
				<div class="input-group">
					<textarea rows="4" class="form-control comment-content"></textarea>
					<button type="button" class="btn btn-outline-success col-2 btn-comment-insert">등록</button>
				</div>
			</div>

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

<!-- 댓글 리스트 출력 스크립트 -->
<script type="text/javascript">
let today = $("#today").val();
let cri = {
	page : 1,
	poNum : '${post.po_num}'
}
getCommentList(cri, today)
function getCommentList(cri, today) {
	$.ajax({
		url : '<c:url value="/comment/list"/>',
		method : "post",
		data : JSON.stringify(cri),
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function(data){
			let commentList = data.list;
			let str = '';
			if(commentList == null || commentList.length == 0){
				str = '<div class="container text-center mb-3 mt-3">아직 등록된 댓글이 없습니다.</div>';
			}
			for(comment of commentList){
				console.log(comment);
				if(comment.co_state != 1 && comment.co_num == comment.co_ori_num){
					str +=
						`
						<div class="comment-container text-center">
							<h1 class="text-center">삭제된 댓글입니다.</h1>
						</div>	
						<hr>
						`
				}
				else{
					let btns = "";
					if('${user.me_id}' == comment.co_me_id){
						btns += 
						`
						<div class="btn-comment-group col-2">
							<button class="btn btn-outline-warning btn-comment-update me-2" data-num="\${comment.co_num}">수정</button>
							<button class="btn btn-outline-danger btn-comment-delete " data-num="\${comment.co_num}">삭제</button>
						</div>
						`
					}
					else if('${user.me_gr_num}' == '0' && '${user}' != null){
						btns += 
						`
						<div class="btn-comment-group col-2 ">
							<button class="btn btn-outline-danger btn-comment-delete " data-num="\${comment.co_num}">삭제</button>
						</div>
						`
					}	
					
					if(comment.co_num == comment.co_ori_num){
						if(today == comment.co_datetime.substring(0,10)){
							str +=
								`
								<div class="comment-container">
									<div class="input-group mb-3 box-comment">
										<div class="col-2"><h5>\${comment.me_nick}<h5></div>
										<div class="co_content col-8">\${comment.co_content}</div>
										\${btns}
									</div>
									<span style="font-size: small;" class="mr-4">작성시간 : \${comment.co_datetime.substring(11,16)}</span>
									<a href="javascript:void(0);" class="reply" data-ori="\${comment.co_ori_num}">답글쓰기</a>
								</div>	
								<hr>
									
								`
						}
						else{
							str +=
								`
								<div class="comment-container">
									<div class="input-group mb-3 box-comment">
										<div class="col-2"><h5>\${comment.me_nick}<h5></div>
										<div class="co_content col-8">\${comment.co_content}</div>
										\${btns}
									</div>
									<span style="font-size: small;" class="mr-4">작성일 : \${comment.co_datetime.substring(0,10)}</span>
									<a href="javascript:void(0);" class="reply" data-ori="\${comment.co_ori_num}">답글쓰기</a>
								</div>	
								<hr>
									
								`
						}
						
					}
					else{
						if(today == comment.co_datetime.substring(0,10)){
							str +=
								`
								<div class="comment-container" style="margin-left: 100px;">
									<div class="input-group mb-3 box-comment">
										<div class="col-2"><h5>\${comment.me_nick}<h5></div>
										<div class="co_content col-8">\${comment.co_content}</div>
										\${btns}
									</div>
									<span style="font-size: small;" class="mr-4">작성시간 : \${comment.co_datetime.substring(11,16)}</span>
									<hr>
								</div>	
									
								`
						}
						else{
							str +=
								`
								<div class="comment-container" style="margin-left: 100px;">
									<div class="input-group mb-3 box-comment">
										<div class="col-2"><h5>\${comment.me_nick}<h5></div>
										<div class="co_content col-8">\${comment.co_content}</div>
										\${btns}
									</div>
									<span style="font-size: small;" class="mr-4">작성일 : \${comment.co_datetime.substring(0,10)}</span>
									<hr>
								</div>	
									
								`
						}
					
					}
				}
			}
			
			$(".comment-list").html(str);
			let pm = data.pm;
			let pmStr = "";
			//이전 버튼 활성화 여부
			if(pm.prev){
				pmStr += `
				<li class="page-item">
					<a class="page-link" href="javascript:void(0);" data-page="\${pm.startPage-1}">이전</a>
				</li>
				`;
			}
			//숫자 페이지
			for(let i = pm.startPage; i<= pm.endPage; i++){
				let active = pm.cri.page == i ? "active" : "";
				pmStr += `
			    <li class="page-item \${active}">
					<a class="page-link" href="javascript:void(0);" data-page="\${i}">\${i}</a>
				</li>
				`
			}
			//다음 버튼 활성화 여부
			if(pm.next){
				pmStr += `
				<li class="page-item">
					<a class="page-link" href="javascript:void(0);" data-page="\${pm.endPage + 1}">다음</a>
				</li>
				`
			}
			$(".comment-pagination>ul").html(pmStr);
			$('.comment-total').text(pm.totalCount);
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	});
}

$(document).on("click", ".comment-pagination .page-link", function () {
	cri.page = $(this).data("page");
	getCommentList(cri, today);
})

</script>

<!-- 댓글 작성 스크립트 -->
<script type="text/javascript">
//댓글 등록 버튼 클릭 이벤트를 등록
$(".btn-comment-insert").click(function () {
	if('${user.me_id}' == ''){
		if(confirm("로그인이 필요한 서비스 입니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	
	let content = $(".comment-content").val();
	let poNum = '${post.po_num}';
	
	$.ajax({
		url : '<c:url value="/comment/insert"/>',
		method : "post",
		data : {
			"content" : content,
			"po_num" : poNum
		},
		success : function (data) {
			if(data.result){
				alert("댓글이 등록되었습니다.");
				cri.page = 1;
				getCommentList(cri, today);
				$(".comment-content").val("");
			}else{
				alert("댓글 등록 실패")
			}
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	});		
});
</script>

<!-- 댓글 수정 스크립트 -->
<script type="text/javascript">
$(document).on("click",".btn-comment-update",function(){
	initComment()
	// 현재 댓글 보여주는 창이 textarea태그로 변경
	// 기존 댓글 창을 감춤
	$(this).parents(".box-comment").find(".co_content").hide();
	let comment = $(this).parents(".box-comment").find(".co_content").text();
	let textarea =
	`
	<textarea rows="3" class="form-control com-input">\${comment}</textarea>
	`
	$(this).parents(".box-comment").find(".co_content").after(textarea);
	// 수정 삭제 버튼 대신 수정 완료 버튼으로 변경
	$(this).parents(".btn-comment-group").hide();
	let num = $(this).data("num");
	let btn = 
	`
	<button class="btn btn-outline-success btn-complete" data-num="\${num}" type="button">수정완료</button>
	`
	$(this).parent().after(btn);
});

$(document).on("click",".btn-complete",function(){
	let num = $(this).data("num");
	let content = $(".com-input").val();
	$.ajax({
		url : '<c:url value="/comment/update"/>',
		method : "post",
		data : {
			"num" : num,
			"content" : content
		},
		success : function (data) {
			if(data.result){
				alert("댓글을 수정했습니다.");
				getCommentList(cri, today);
			}
			else{
				alert("댓글 수정에 실패했습니다.");
			}
		},
		error : function (a, b, c) {
			console.error("에러 발생")
		}
	});
});


function initComment() {
	//감추었던 댓글 내용을 보여줌
	$(".co_content").show();
	$(".reply").show();
	//감추었던 수정 삭제 버튼을 보여줌
	$(".btn-comment-group").show();
	//textarea 삭제
	$(".com-input").remove();
	$(".reply-box").remove();
	//수정 버튼 
	$(".btn-complete").remove();
}

</script>

<!-- 댓글 삭제 스크립트 -->
<script type="text/javascript">
$(document).on("click",".btn-comment-delete",function(){
	if('${user.me_id}' == ''){
		if(confirm("로그인이 필요한 서비스 입니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	
	let num = $(this).data("num");
	$.ajax({
		url : '<c:url value="/comment/delete"/>',
		method : "post",
		data : {
			"num" : num
		},
		success : function (data) {
			if(data.result){
				alert("댓글이 삭제되었습니다.");
				getCommentList(cri, today);
			}
			else{
				alert("댓글 삭제에 실패했습니다.");
			}
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	});
});
</script>

<!-- 대댓글 작성 스크립트 -->
<script type="text/javascript">
$(document).on("click",".reply",function(){
	initComment();
	if('${user.me_id}' == ''){
		if(confirm("로그인이 필요한 서비스 입니다. 로그인으로 이동하시겠습니까?")){
			location.href = "<c:url value='/login'/>"
			return;
		}
		else{
			return;
		}
	}
	
	let ori = $(this).data("ori");
	
	$(this).hide();
	let textarea = 
		`
			<div class="input-group reply-box mt-3 mb-3">
				<textarea rows="3" class="form-control reply-content"></textarea>
				<button type="button" class="btn btn-outline-success col-2 btn-reply-insert" data-ori="\${ori}">등록</button>
			</div>
		`;
	$(this).parent().after(textarea);
});

$(document).on("click",".btn-reply-insert",function(){
	let ori = $(this).data("ori");
	let content = $(".reply-content").val();
	let po_num = '${post.po_num}';
	
	$.ajax({
		url : '<c:url value="/reply/insert"/>',
		method : "post",
		data : {
			"ori" : ori,
			"content" : content,
			"po_num" : po_num
		},
		success : function (data) {
			if(data.result){
				alert("댓글이 등록되었습니다.");
				cri.page = 1;
				initComment();
				getCommentList(cri, today);
			}else{
				alert("댓글 등록 실패")
			}
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	});		
	
});
</script>

<!-- 투표 리스트 출력 스크립트 -->
<script type="text/javascript">
let po_num = ${post.po_num}
getVoteList(po_num);
function getVoteList(po_num) {
	$.ajax({
		url : '<c:url value="/vote/list"/>',
		method : "post",
		data : {
			"po_num" : po_num
		},
		success : function (data) {
			let voteList = data.list
			console.log(data.list);
			if(voteList.length != 0 && voteList != null){
				
			}
		},
		error : function (a,b,c) {
			console.error("에러 발생");
		}
	})
}

</script>

</body>
</html>
