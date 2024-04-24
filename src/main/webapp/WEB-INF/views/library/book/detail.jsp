<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
ol.colorlist {
	list-style: none !important;
	counter-reset: li !important;
}

.colorlist li::before {
	content: counter(li) !important;
	color: red !important;
	display: inline-block !important;
	width: 1em !important;
	margin-left: -1em !important;
}

.colorlist li {
	counter-increment: li !important;
}

#myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform input[type=radio]{
    display: none;
}
#myform label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#myform label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewContents {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}
.star-rating {
      font-size: 20px;
      color: #ffd700;
}
.star-rating .empty-star::after {
    content: "\2606";
    color: #ccc;
}
.star-rating .filled-star::after {
    content: "\2605";
}
</style>
<meta charset="UTF-8">
<body>
	<div class="container mt-5">
		<div class="main">
			<img alt="${book.bo_title}" src="${book.bo_thumbnail}" />
			<div>
				<h5>${book.bo_title}</h5>
				<p>
					출판사:<span>${book.bo_publisher}</span>
				</p>
				<p>
					평점:<span style="font-weight: bold; font-size: 30px">${avgReview.avgScore}</span>
				</p>
				<p>
					저자:<span>${book.bo_au_name}</span>
				</p>
				<p>
					역자:<span>${book.bo_tr_name}</span>
				</p>
				<p>
					출판일:<span>${book.bo_date}</span>
				</p>
				<p>
					ISBN:<span>${book.bo_isbn}</span>
				</p>
			</div>
			<div>${bo_contents}</div>
			<div>
				<ul>
					<c:forEach items="${code}" var="co">
						<li>
							${co.bo_code}
								<c:forEach items="${loanList}" var="loan">
									<c:if test="${loan.lo_state == 1 && loan.lo_bo_num == co.bo_num}"><span style="color:red">대출 중</span></c:if>
								</c:forEach>
						</li>
						<button class="btn btn-outline-primary loan-btn"
							data-bo-num="${co.bo_num}">대출</button>
						<c:forEach items="${loanList }" var="loan">
							<c:if test="${loan.lo_state == 1 && loan.lo_bo_num == co.bo_num}">
								<button class="btn btn-outline-warning reserve-btn"
									data-bo-num="${co.bo_num}">예약</button>
							</c:if>
							<c:if
								test="${loan.lo_state == 1 && loan.lo_me_id == user.me_id && loan.lo_bo_num == co.bo_num}">
								<button class="btn btn-outline-primary extend-btn"
									data-bo-num="${co.bo_num}">대출 연장</button>
							</c:if>
						</c:forEach>
						<c:if test="${user.me_ms_num == 1}">
							<button class="btn btn-outline-dark return-btn"
								data-bo-num="${co.bo_num}">반납</button>
						</c:if>
					</c:forEach>
				</ul>
			</div>
			<div>
				<ol class="colorlist">
					<li>책을 대출할 시 만기일은 대출한 날로부터 1주일 후로 지정됩니다.</li>
					<li>연장은 만기일까지 3일 남았을 때부터 누를 수 있습니다.</li>
					<li>책이 예약된 경우 연장을 할 수 없습니다.</li>
					<li style="color:red; font-weight: bold;">※ 예약은 약속입니다. : 필요한 도서만 예약하고, 예약도서는 꼭 대출해 주시기 바랍니다.</li>
				</ol>
			</div>
			<div class="container-review mt-3 mb-3">
				<h2>
					리뷰(<span class="review-total">2</span>)
				</h2>
				<div class="box-review-list">
					<div class="box-review row">
						<div class="col-3">아이디</div>
						<div class="col-3">별점</div>
						<div class="col-6">내용</div>
					</div>
				</div>
				<div class="box-pagination">
					<ul class="pagination justify-content-center"></ul>
				</div>
				<div class="box-review-insert"></div>
				<div class="input-group mb-3" id="myform">
					<fieldset>
						<input type="radio" name="reviewStar" value="5" id="rate1"><label
							for="rate1">★</label>
						<input type="radio" name="reviewStar" value="4" id="rate2"><label
							for="rate2">★</label>
						<input type="radio" name="reviewStar" value="3" id="rate3"><label
							for="rate3">★</label>
						<input type="radio" name="reviewStar" value="2" id="rate4"><label
							for="rate4">★</label>
						<input type="radio" name="reviewStar" value="1" id="rate5"><label
							for="rate5">★</label>
					</fieldset>
					<textarea class="form-control textarea-review" id="reviewContents"></textarea>
					<button class="btn btn-outline-success btn-review-insert">리뷰 등록</button>
				</div>
				<hr>
			</div>
		</div>
	</div>
</body>
<!-- 대출 -->
<script type="text/javascript">
	$(document).on('click', '.loan-btn', function() {
		if (!checkLogin()) {
			return;
		}
		let bookNum = $(this).data('bo-num');
		let book = {
			bo_num : bookNum
		}
		$.ajax({
			async : true,
			url : '<c:url value="/loan/book"/>',
			type : 'post',
			data : JSON.stringify(book),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("${book.bo_title}책을 대출했습니다.");
				} else {
					alert("이미 대출된 책입니다.")
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {

			}
		});
	});

	function checkLogin() {
		if ('${user.me_id}' != '') {
			return true;
		}

		if (confirm("로그인이 필요한 기능입니다. \n로그인 페이지로 이동하겠습니까?")) {
			location.href = '<c:url value="/login"/>';
		}
		return false;
	}
</script>
<!-- 대출 연장 -->
<script type="text/javascript">
	$(document).on('click', '.extend-btn', function() {
		let bookNum = $(this).data('bo-num');
		let book = {
			bo_num : bookNum
		}
		$.ajax({
			async : true,
			url : '<c:url value="/extend/book"/>',
			type : 'post',
			data : JSON.stringify(book),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("1주일 연장되었습니다.")
				} else {
					alert("예약돼 있거나 만기일까지 3일 넘게 남았습니다.")
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {

			}
		});
	})
</script>
<!-- 예약 -->
<script type="text/javascript">
	$(document).on('click', '.reserve-btn', function() {
		if (!checkLogin()) {
			return;
		}
		let bookNum = $(this).data('bo-num');
		let book = {
			bo_num : bookNum
		}
		$.ajax({
			async : true,
			url : '<c:url value="/reserve/book"/>',
			type : 'post',
			data : JSON.stringify(book),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("${book.bo_title}책을 예약했습니다.");
				} else {
					alert("예약을 못했습니다.")
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("이미 예약한 책입니다.")
			}
		});
	});

	function checkLogin() {
		if ('${user.me_id}' != '') {
			return true;
		}

		if (confirm("로그인이 필요한 기능입니다. \n로그인 페이지로 이동하겠습니까?")) {
			location.href = '<c:url value="/login"/>';
		}
		return false;
	}
</script>
<!-- 반납 -->
<script type="text/javascript">
	$(document).on('click', '.return-btn', function() {
		let bookNum = $(this).data('bo-num');
		let book = {
			bo_num : bookNum
		}
		$.ajax({
			async : true,
			url : '<c:url value="/return/book"/>',
			type : 'post',
			data : JSON.stringify(book),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(data) {
				if (data.result) {
					alert("${book.bo_title}책을 반납했습니다.");

				} else {
					alert("반납 실패.")
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {

			}
		});
	});
</script>
<!-- 리뷰 리스트 -->
<script type="text/javascript">
//댓글 페이지 정보를 가지고 있는 객체를 선언
let cri = {
	page : 1,
	search : "${book.bo_num}"
}

getReviewList(cri);

function getReviewList(cri){
	$.ajax({
		async : true,
		url : '<c:url value="/review/list"/>', 
		type : 'post', 
		data : JSON.stringify(cri),
		//서버로 보낼 데이터 타입
		contentType : "application/json; charset=utf-8",
		//서버에서 보낸 데이터의 타입
		dataType : "json", 
		success : function (data){
			displayReviewList(data.list);
			displayReviewPagination(data.pm);
			$('.review-total').text(data.pm.totalCount);
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
}

function displayReviewList(list){
	let str = '';
	if(list == null || list.length == 0){
		str = '<h3>등록된 리뷰가 없습니다.</h3>';
		$('.box-review-list').html(str);
		return;
	}
	for(item of list){
		let boxBtns =
			`<span class="box-btn float-right">
				<button class="btn btn-outline-warning btn-review-update" data-num="\${item.rv_num}">수정</button>
				<button class="btn btn-outline-danger btn-review-del" data-num="\${item.rv_num}">삭제</button>
			</span>`;
		let btns = '${user.me_id}' == item.rv_me_id ? boxBtns : '';
		 // 별 표시
        let stars = '<div class="star-rating">';
        for(let i = 1; i <= 5; i++){
            stars += i <= item.rv_score ? `<span class="filled-star"></span>` : `<span class="empty-star"></span>`;
        }
        stars += `</div>`;
		str += 
		`
			<div class="box-review input-group">
				<div class="col-3">\${item.me_nick}</div>
				<div class="col-3">\${stars}</div>
				<div class="col-6 clearfix input-group">
					<span class="text-review">\${item.rv_content}</span>
					\${btns}
				</div>
				<span style="font-size: small;" class="mr-4">작성시간 : \${moment(item.rv_date).format('YY/MM/DD HH:mm')}<br />
				<i class="bi bi-hand-thumbs-up btn-up" style="font-size : 20px; cursor:pointer;" data-state="1" data-num="\${item.rv_num}">추천(<span class="text-up">\${item.rv_up}</span>)</i>
				<i class="bi bi-hand-thumbs-down btn-down" style="font-size : 20px; cursor:pointer;" data-state="-1" data-num="\${item.rv_num}">비추천(<span class="text-down">\${item.rv_down}</span>)</i>
			</div>
		`
	}
	$('.box-review-list').html(str);
}
function displayReviewPagination(pm){
    
	let str = '';
	if(pm.prev){
		str += `
		<li class="page-item">
			<a class="page-link" href="javascript:void(0);" data-page="\${pm.startPage - 1}">이전</a>
		</li>`;		
	}
	for(let i = pm.startPage; i<= pm.endPage; i++){
		let active = pm.cri.page == i ? 'active' : '';
		str += `
		<li class="page-item \${active}">
			<a class="page-link" href="javascript:void(0);" data-page="\${i}">\${i}</a>
		</li>`;	
	}
	
	if(pm.next){
		str += `
		<li class="page-item">
			<a class="page-link" href="javascript:void(0);" data-page="\${pm.endPage + 1}">다음</a>
		</li>`;	
	}
	$('.box-pagination>ul').html(str);
}
$(document).on('click','.box-pagination .page-link',function(){
	cri.page = $(this).data('page');
	getReviewList(cri);
})
</script>
<!-- 리뷰 작성 -->
<script type="text/javascript">
$(".btn-review-insert").click(function () {
	if(!checkLogin()){
		return;
	}
	
	let review = {
			rv_content : $('.textarea-review').val(),
			rv_score : $('input[name="reviewStar"]:checked').val(),
			rv_bo_num : '${book.bo_num}'
	}
	if(review.rv_content.length == 0){
		alert('리뷰 내용을 작성하세요.');
		return;
	}
	if(review.rv_score == null){
		alert('별점을 선택하세요.');
		return;
	}
	$.ajax({
		async : true,
		url : '<c:url value="/review/insert"/>',
		type : 'post',
		data : JSON.stringify(review),
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function (data){
			if(data.result){
				alert('리뷰를 등록했습니다.');
				$('.textarea-review').val('');
				$('input[name="reviewStar"]:checked').prop('checked', false);
				cri.page = 1;
				getReviewList(cri);
			}else{
				alert('리뷰를 등록하지 못했습니다.');
			}
		},
		error : function(xhr, textStatus, errorThrown){
			console.log(xhr);
			console.log(textStatus);
		}
	})
});

function checkLogin(){
	if('${user.me_id}' != ''){
		return true;
	}
	if(confirm("로그인이 필요한 기능입니다. \n로그인 페이지로 이동하겠습니까?")){
		location.href = '<c:url value="/login"/>';
	}
	return false;
}
</script>
<!-- 리뷰 삭제 -->
<script type="text/javascript">
$(document).on('click', '.btn-review-del', function(){

	let review = {
			rv_num : $(this).data('num')
	}
	console.log(review)
	//서버로 데이터를 전송
	$.ajax({
		async : true,
		url : '<c:url value="/review/delete"/>', 
		type : 'post',
		data : JSON.stringify(review),
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function (data){
			if(data.result){
				alert('리뷰를 삭제했습니다.');
				getReviewList(cri);
			}else{
				alert('리뷰를 삭제하지 못했습니다.');
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
});
</script>
<!-- 리뷰 수정 -->
<script type="text/javascript">
$(document).on('click', '.btn-review-update', function() {
	initReview();
	let contentBox =  $(this).parents(".box-review").find(".text-review");
	let starBox =  $(this).closest('.box-review').find(".star-rating");
	let content = contentBox.text();
	let str = 
	`
	<div class="input-group mb-3" id="myform">
		<fieldset>
	        <input type="radio" name="reviewStar" value="5" id="rate1"}><label for="rate1">★</label>
	        <input type="radio" name="reviewStar" value="4" id="rate2"}><label for="rate2">★</label>
	        <input type="radio" name="reviewStar" value="3" id="rate3"}><label for="rate3">★</label>
	        <input type="radio" name="reviewStar" value="2" id="rate4"}><label for="rate4">★</label>
	        <input type="radio" name="reviewStar" value="1" id="rate5"}><label for="rate5">★</label>
    	</fieldset>
	</div>
	<textarea class="form-control con-input">\${content}</textarea>
	`
	contentBox.after(str);
	contentBox.hide();
    starBox.hide();
    

	$(this).parents(".box-review").find(".box-btn").hide();

	let rv_num = $(this).data("num");
	
	str = 
	`
	<button class="btn btn-outline-success btn-complete" data-num="\${rv_num}">수정완료</button>
	`;
	$(this).parents(".box-review").find(".box-btn").after(str);
});

$(document).on('click', '.btn-complete', function() {
	let review = {
			rv_content : $('.box-review').find('textarea').val(),
			rv_score : $('input[name="reviewStar"]:checked').val(),
			rv_num : $(this).data("num")
	}
	
	if(review.rv_content.length == 0){
		alert('리뷰 내용을 작성하세요.');
		return;
	}
	if(review.rv_score == null){
		alert('별점을 선택하세요.');
		return;
	}
	$.ajax({
		async : true,
		url : '<c:url value="/review/update"/>', 
		type : 'post',
		data : JSON.stringify(review),
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function (data){
			if(data.result){
				alert('리뷰를 수정했습니다.');
				getReviewList(cri);
			}else{
				alert('리뷰를 수정하지 못했습니다.');
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
});

function initReview() {
	$(".btn-complete").remove();
	$('.box-review').find('textarea').remove();
	$('.box-review').find('#myform').remove();
	$('.box-btn').show();
	$('.text-review').show();
	$('.star-rating').show();
}
</script>
<!-- 리뷰 추천 -->
<script type="text/javascript">
$(document).on("click",".btn-up,.btn-down",function(){
	if(!checkLogin()){
		return;
	}
	let state = $(this).data('state');
	let rv_num = $(this).data('num');
	let opinion = {
			op_state : state,
			op_rv_num : rv_num
	}
	$.ajax({
		url : '<c:url value="/opinion/check"/>',
		method : "post",
		data : JSON.stringify(opinion),
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function (data) {
			switch (data.result) {
			case 1:
				alert("추천 했습니다.")
				break;
			case 0:
				let str = opinion.op_state == 1 ? '추천' : '비추천';
				alert(`\${str}을 취소했습니다.`)
				break;
			case -1:
				alert("비추천 했습니다.")
				break;
			default:
				alert("추천/비추천을 하지 못했습니다.")
			}
			getOpinion()
		},
		error : function (a,b,c) {
			console.error("에러 발생2");
		}
	});
	
	function getOpinion() {
		let rv_num = $(this).data('num');
		let obj = {
				rv_num : num
		}
		
		$.ajax({
			async : true,
			url : '<c:url value="/opinion"/>', 
			type : 'post', 
			data : obj, 
			dataType : "json", 
			success : function (data){
				displayUpdateOpinion(data.review);
				displayOpinion(data.state);
			}, 
			error : function(jqXHR, textStatus, errorThrown){

			}
		});
	}

	function displayUpdateOpinion(review) {
		$(".text-up").text(review.rv_up);
		$(".text-down").text(review.rv_down);
	}

	function displayOpinion(state) {
		$('.btn-up').addClass("bi-hand-thumbs-up");
		$('.btn-up').removeClass("bi-hand-thumbs-up-fill");
		$('.btn-down').addClass("bi-hand-thumbs-down");
		$('.btn-down').removeClass("bi-hand-thumbs-down-fill");
		if(state == 1){
			$('.btn-up').removeClass("bi-hand-thumbs-up");
			$('.btn-up').addClass("bi-hand-thumbs-up-fill");
		}else if(state == -1){
			$('.btn-down').removeClass("bi-hand-thumbs-down");
			$('.btn-down').addClass("bi-hand-thumbs-down-fill");
		}
	}
	getOpinion();
});
</script>