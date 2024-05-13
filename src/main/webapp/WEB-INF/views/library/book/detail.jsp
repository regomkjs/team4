<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
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
	margin-left: 4px; !important;
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

.bar {border: 2px solid #404040; border-radius: 10px;}

img{ width: 220px;}

.main { background-color: #F7F7F7;}

.media{ position: relative;}

.text-group{ margin: 10px; padding: 10px;}

hr{ margin-top: 45px; margin-bottom: 40px;}

.btn-group{ padding: 5px}

.info{ background: #e72900; color: #fff; width: 150px; border-radius: 5px; text-align: center;}
</style>
<meta charset="UTF-8">
<body>
	<div class="container mt-5 main">
		<h3>상세정보</h3>
		<hr class="bar">
		<div class="main">
			<div class="media">
				<img alt="${book.bo_title}" src="${book.bo_thumbnail}" />
				<div class="text-group">
					<h3>${book.bo_title}</h3>
					<br>
					<p>
						출판사: <span>${book.bo_publisher}</span>
					</p>
					<p>
						평점: <span style="font-weight: bold; font-size: 20px; color: #eb217c;">${avgReview.avgScore}</span>
						<c:if test="${avgReview == null}"><span style="font-weight: bold; font-size: 20px; color: #eb217c;">0</span></c:if>
					</p>
					<p>
						저자: <span>${book.bo_au_name}</span>
					</p>
					<p>
						역자: <span>${book.bo_tr_name}</span>
					</p>
					<p>
						출판일: <span><fmt:formatDate value="${book.bo_date}" pattern="yyyy년 MM월 dd일"/></span>
					</p>
					<p>
						ISBN: <span>${book.bo_isbn}</span>
					</p>
				</div>
			</div>
			<hr class="bar">
			<div>
			<h5>책 소개</h5>
			${book.bo_contents}
			</div>
			<hr class="bar">
			<div>
				<ul>
					<c:forEach items="${code}" var="co">
						<li style="display: flex; align-items: center; justify-content: space-between;">
		               		<div style="display: flex; align-items: center;">
					            <span>${co.bo_code}</span>
					            <c:forEach items="${loanList}" var="loan">
					                <c:if test="${loan.lo_state == 1 && loan.lo_bo_num == co.bo_num}">
					                    <span style="color:red; margin-left: 10px;">대출 중</span>
					                </c:if>
					            </c:forEach>
					        </div>
			                <div class="btn-group">
			                    <button class="btn btn-outline-primary loan-btn" data-bo-num="${co.bo_num}">대출</button>
			                    <c:forEach items="${loanList}" var="loan">
			                        <c:if test="${loan.lo_state == 1 && loan.lo_bo_num == co.bo_num}">
			                            <button class="btn btn-outline-warning reserve-btn" data-bo-num="${co.bo_num}">예약</button>
			                        </c:if>
			                        <c:if test="${loan.lo_state == 1 && loan.lo_me_id == user.me_id && loan.lo_bo_num == co.bo_num}">
			                            <button class="btn btn-outline-primary extend-btn" data-bo-num="${co.bo_num}">대출 연장</button>
			                            <button class="btn btn-outline-dark return-btn" data-bo-num="${co.bo_num}">반납</button>
			                        </c:if>
			                    </c:forEach>
			                </div>
			            </li>
					</c:forEach>
				</ul>
			</div>
			<div>
				<ol class="colorlist">
					<h5 class="info">이용안내</h5>
					<li>책을 대출할 시 만기일은 대출한 날로부터 1주일 후로 지정됩니다.</li>
					<li>연장은 만기일까지 3일 남았을 때부터 누를 수 있습니다.</li>
					<li>책이 예약된 경우 연장을 할 수 없습니다.</li>
					<li>연체일시 대출권 수 X 연체일 수 만큼 대출,예약에 제한이 생깁니다.</li>
					<li style="color:black; font-weight: bold;">반납 기한이 얼마 안 남았거나 예약된 책이 반납된 경우 안내 문자를 드리오니 확인 부탁드립니다.</li>
					<li style="color:red; font-weight: bold;">※ 예약은 약속입니다. : 필요한 도서만 예약하고, 예약도서는 꼭 대출해 주시기 바랍니다.</li>
				</ol>
			</div>
			<hr class="bar">
			<div class="container-review mt-3 mb-3">
				<h3>
					리뷰(<span class="review-total">2</span>)
				</h3>
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
					location.href = location.href;
				} else {
					alert(data.message);
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
					location.href = location.href;
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
					location.href = location.href;
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("에러")
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
					location.href = location.href;
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
		let updateBtn = `<button class="btn btn-outline-warning btn-review-update" data-num="\${item.rv_num}">수정</button>`;
        let deleteBtn = `<button class="btn btn-outline-danger btn-review-del" data-num="\${item.rv_num}">삭제</button>`;
        
        let boxBtns = `<span class="box-btn float-right">`;
        if('${user.me_id}' == item.rv_me_id){
            boxBtns += updateBtn;
        }
        if('${user.me_mr_num}' <= 1 || '${user.me_id}' == item.rv_me_id){
            boxBtns += deleteBtn;
        }
        boxBtns += `</span>`;
		 // 별 표시
        let stars = '<div class="star-rating">';
        for(let i = 1; i <= 5; i++){
            stars += i <= item.rv_score ? `<span class="filled-star"></span>` : `<span class="empty-star"></span>`;
        }
        stars += `</div>`;
        
        let userImage = '';
        userImage += item.me_mr_num == 0 ? `<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEnklEQVR4nO2c3UsrRxTAtx8PLeU+9KnQQmn/hNK3vvheaJ8qZs/ZJBrFqBUVPzCLiohexIg+iNpaEY31G4sffdEqFIuIilQULPZB8CsKohaUoMaPucxyM7hxk5ukue7OZg+ch5ydPXPyy8w5s6OzghBBnE7nB6IofgcAPwPAnwDwDyLu8KYA8C8A/AUAPgDIcLlcL4RYJT09/T0AyEVEPyISsykA/AcAlfTHjgrC5XK9AIApvQN+Jl232+2fa4KQJOkjRPzbAEE+p+7abLZPnsBAxN8MEJweupiWlvY+AyGK4rcGCEo3pTmSwQCAVb0D0ln9tHAIGRkZXxggGKK3iqKYJrwuoyTVFQBeUhgNegeCBlAA+JVWkS69A0EDKADM0pHRrXcgaAAFgHkLBlowiDUy0JomxMoZqFMCLSgoICMjI0/U4/EkNePLsqzZD+3fMNWkurqaaMny8nJSYaysrGj2Q/s3PIzb21uSl5eXFBDUTzAY5BcGlf7+/qTAGBwcJJHEsDCCwSDZ399nn/f29pICw+/3M5+Hh4d8wKAyNDREkhlsXV3dW/X/VmFUVFSo5vfc3Nz/8r+wsMB80RHS1NTED4zS0lJV5g8EAiQrKysh3zk5OeT6+pr5GhgYIK2trfzAqKysJM3NzSpbZ2dnQr57enpU1Sk/P5+0t7fzA8Pj8RC73U5OT0+ZbWtrKyHfOzs7zMfq6qpi6+rq4geGLMuKfXp6mtkeHh6U6ROPXwr1sXi9XsXe29vLD4yqqirFXlZWpkAIycTERFx+Z2Zm2L1nZ2fKaKN2mje4gVH9KLjt7W1mp9Mm9IXepJmZmeTy8pLdOzk5ya4NDw/zCaO7u1t1jZbFWHx2dHREnGLcwsjOziZXV1dxP7zRhBsp+XILA8MWTaHyGM1fSUmJKteEl2WuYdTX18f18DY1NRV1wcY1DEQkR0dH7PrBwUFEXw6Hg5yfn0ddynMPY2xsTNWmpqZG01dLS4tmmTYVjMLCQnJ/f8/azM/Pa/paW1tjbehWgFYb7mEgItnY2IiaC+he5t3dHWvj8/nMC6OtrU3VLrxKjI6OxrRlaAoYTqeTXFxcaK4fJEkix8fH7NrS0lLE/kwBAxHJ7Oys5sqyoaFB5aOxsdH8MGRZVrUNPbwtLi4y28nJiTJSTA8DEcnu7i5rS9cUbreb3NzcMNv4+HjU+00Fw+fzqdqvr6+rpk5xcXHqwHC73RH/ILS5ufnG/kwFAxGVp1ctoeU35WB4vd4nIOhmDi2/KQdDkiTVhjEVus0XS3+mg4Fhj+qPN5K5hpGbm6vM9ZDSz7HcV1RUxP7Hoq+vL+b+ysvLE+rvWWCgCdSCgRYMYo0MtKYJsXIGJp5A2/TO5GgM/Z3CkA0QCDGA/kTPm3xvgECI3goARfSE84cAENA7GL1VkqQvQ2daf0nxUfEHO8rpcDg+S9XRAQD3Npvtq/ATzz8g4kMKwpA1z8MjoifFgHQKgvBOxDclAEA6Ip6bfDQEAODHqK+MCAkAfIyITQBwZDIIp3Q02Gy2T4V4pba29l0A+FoURUTEUvoSDg61HADskiR9o5x3jyKvAHbQX3wyaiWpAAAAAElFTkSuQmCC" alt="image" style="width: 17px;">` : '';
        userImage += item.me_mr_num == 1 ? `<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEMAAABDCAYAAADHyrhzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEjElEQVR4nO2c30/bVRTAG50vPrmHxcT4D+jr4nxconBvk21OXWZQZ5Ys8cX4YtRoFk0l7t7ya8tKxoSxGbMRo8icgoDcW9rRymSMbaV2bEXK5oAyJrABK4P+OubeFew3pQiY9rb9fk9y3trm3E/OOffce3quybSKNFt2PskofoURfJBRXM0Irss35RQf5wR/wWnxfjt56WnTesVZZn6WE1TPCJrnFEPhKIoxgrj9ENq2JhAdxLyPUxRSb3jmlBEcZwTZnJbtm9KCYAQfVG1oVpWg1r66rU+kgLCT4hJBTLmBWfcSVKMB8Yt1x2ZO8ZRqw5SpFRctw+AEVyo3SK139EoQFovlMUbQuGqDVKudmJ83ddDiF1UbwnNAmRV9kthK1RujWhlFJ02MoA9VG8JzQQlq1V9tQdMpshswqAEDDM+gRpiAkTNoniRQR+VuuPL9ZxBwN0DQy+Du4O/w91Av3LnugtGrrfCn4xR4mkqh6+gbhbubdNlKYORyC0QWQrA2icPsRAAGHSfBVf1m4cDwNJVCeH4WNioCSEHA8J6jEI/HNIuLhh/ChL8bAu4z4OdfwWBnPQx3fytDJTQ1qvWPeAxc1W/lPwz3sX0pYTHqaQfn4df+83sD7TaYvu2V+STz3psFGLd6ftCA+Ovi2XX/hr1sR2HACCW5fPjhHHRW7MrCwnIShhli0cgyDLGFql+0IhidFbs0ITLuc+TAopV5BoZYZHEZxv2Ra/qGMRP0/7tFxqKy8NItjIC7QRMqoo4QuUSXMLpsJbLAShZRbDkPv64/GJxi8LVUpZTX4fkZGDr/DTiP7NEXDE6xPFusJNHwAox5foWLX7+vHxicYrja+DksPpiGdCKS7UCbTR7xCx4GF3cZVa9CwHUGIgsP0kJZDN2XdxrZrVYV3o47KnfDQNtRmBm7kRbK/HQQ+ho+LnwYPEm7aw/Io/zC3FQKEFGb+Jor9AODJ1SEhZ/XpoRQPBaB3tMf6AsGT+hvx/fD7J0hDZB7Iz59wuCJYm0xdE8DxF3zjj5h8BUuhvp/PKRfGP1nv9TAuNFRo18YfQ0faWDcvPCdfmH4mssNz+AJGOJ0myw9p97LX8+w/49bbdF0Eh21JQlNjmTYEzMMw9NUCnMTw7JBdOHEu2v6Tmf5Tvn5WDSs8QpxyMt7GMkiym3RELrV0yR3hj9+LpOL9J4j4LfXQdDLV2xBbqTXkvMw1iviXCKuDbNzTZhhGN21B2AycCmlz7oWCKLHktmEmWUYPKHnj+yR4RBwnYaxfgZTw5dhZnwQ5u7elB03cYyfHO6D25d+kleEmf/7gUIYPC/UgAEGDGp4BhhhQo2cARtMoMZUAV+aKuAUva1+W8PqlaB6E6fmF5QbQnNkEknMqHGKgqqNUa2srOi5R8O9FJXrGsTS9KKcfbdsf0rPc62MmF/Wjn5bzXv1OPHMKTq24iw8J+hTPQFhBLes+jgAl1tt4b+SwCmuamzc+3haEEvCyoue4RSfKDgoBEUZwe0dVrTVtF5pTrys8ih8kE31KykbfVmFUWQRw8xtxLxltQX/AwTfUMDaNhZhAAAAAElFTkSuQmCC" alt="image" style="width: 18px;">` : '';
        userImage += item.me_gr_num == 2 && item.me_mr_num == 2 ? `<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABJElEQVR4nO2ZTWoCQRCF+xiWie4kS4/hBXISYQpc6wVcZu/KDFnmDlkY6BZEELfqRvwBEUSs0IREAs6iW5juJu+DWs97U696hi6lAAAgWqrtcY3Y5MR6T2yk3NL7Cuu3aqafvMVXWK/LF27+lNXwwPrR2cD3mw8rnq419DAQIjamKE47nw5ITKVggNEBQYRcCB0ZimGIm92J9N6Xstie0jLQ6s/kdbSR0/kiPyRjYLo6yi2SMVBEMgY2h7MMPtby/DJP00C9M77ZjWQMUEGcYMAVdIARIcEQE06hKzhGXcExyvd/ySn0rwQMMDpggkeH/vEM6HgudzOzdTZglwvBhfNv5c4G7GYkmgVH9tlQPtjNiF0u2Pv58sVr+8zcWzwAAKgy+ALGkks5M3xO2gAAAABJRU5ErkJggg==" alt="image" style="width: 20px;">` : '';
        userImage += item.me_gr_num == 3 && item.me_mr_num == 2 ? `<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABqUlEQVR4nO2Zy4rCMBSG8yAzy2EeR5JSRQRREZe+gY+gK9F1t4N04VY3Cq7c6ULwBcSFMF4q9vRyhlSm1QHRVmlTJj8cKGlp/+/kJCkJIVJSUlLC6pjJvAOlPZOxHTCGcYZ5/qZ+UtXPyOZNSjdxG4e/IJRuDErfQgPwzCdtHoL4Cg2QRNnA7V7Yhu8BAYzDRUgAkD3AZAmF0v8dxIqCdreL7nKJuN97wa/tTse7JzaAoqAzHuMtOaOR2AB2q4X3ZDeb4gK4s1mQ7cEAoVxGKBTQGQ79dv6MsABoGL5RKBb9dqtWC7rAMMQFgFtRqQQAu136AGxNC0poPk8XgFWtIh6PwSBut1MEkM16Gfezv1oh5HIpAVBVdCaTi0XAQavRiPw+EitAPo/OdHo9/2vaUwkhsQGUSuguFtcrcL//dDmSOACseh3d9fravK4/P5ZYXAvZ4XD3V8Jb5IQFeFAS4BG9om5fGSSskjYMEoAln3WQJcRSPIhNsTZ3v6PMQnrSxuE3KO2FBuAnI6IccJwY+yBRxE9G+OEC359PwPiWZz6yeSkpKSkSh34A766mybHzuzMAAAAASUVORK5CYII=" alt="image" style="width: 20px;">` : '';
        userImage += item.me_gr_num == 4 && item.me_mr_num == 2 ? `<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABiElEQVR4nO2ZwUrEMBCG8yB6FA824M0XUHwUD+7DKI3C6mW9SvGgfQL1UterNq4rrLRepAvu0ihUSmSKjahUTcU2wfnhh5JL/y8zaUuHEBQKhTJWW9cLs4w7nsvplHEqm7QL9wzpwXZI538Rno6bDs4+e7w5oDPaALDzBoSXr97XBmijbViVQzqpUQEDgvM3IwDDClBsIS3960Psxx0ZizOZ5Y+FYxEUa1YAnCe7skr9ZMdsAD/uyO9UtxKkCQBom1Kj9Fj2hsuFR+mJWo9EYC5AlgsVFIKX673hilrP8tRcAFbhvZtVBSCeE3sAuoMleRityfunSwVwNfHtAfioaXb3rrUYAnwhbCFu4SHObH+MxiJQQeHlBcHBt+mpHS8y/wefEkfRurkAjNPig61K/aRb+5FMmgIoKwGtAmcCDNd1d561AfAXJgjAsQISW0hH1h9i16Cfu27oPGgDwHCh7eBM2fG0AWAyYsqAY+NicY7UEUxGYLgA/+cbDx7CPR2vdngUCoUiTegFU2aJ1Yt8CosAAAAASUVORK5CYII=" alt="image" style="width: 20px;">` : '';
        userImage += item.me_gr_num == 5 && item.me_mr_num == 2 ? `<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABMUlEQVR4nO2ZTQrCQAyFe4yO1aUIKngYjyYi4g1EPIPSClO3HsG6FPzDTeNERrRaiuAU6UwgD7Lppu97STYTz2OxWCxnhctaA0IxS0NxgkhglZU+/unPMaq1SptPQ39ftXEogPh7lEHdGEAnb9s8vGtqDGBjbOD7OB3NO+CAcfgoBgDugOARMpLtkQHrSyzbiHDCT5ECUNtBzjwtAKnTP9MFUMmwYJ4OQNzJ0leHFT0AlYwyw7dNnxhA3EWES5a+/kYKQO3GufRpAax7iLdrLn1SAGo3KaRPCgCf6f8iNwFQUQdA2gDwA5jTOwAMINzswL/KY4CIO4A8QiYiv8SpW4+7B2MAfVywbRxeFYqZMYC+jDhz4FgETWOAB4QM6vq4oN/nLYzNUSdf2jyLxWJ5VegOSOS+C4MgG8YAAAAASUVORK5CYII=" alt="image" style="width: 20px;">` : '';
        userImage += item.me_gr_num == 6 && item.me_mr_num == 2 ? `<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABf0lEQVR4nO2ZsUoDQRCG90G00V1S+Qhq7QPIbVDsTKGWWtjamT7BZ5Bw4COIRTq1SOUjCCEmahR27kZG1BVMPHbBvV2cH4ZLFeab+Wfv2BGCxWKxolW2jIuZgp6WZqIVYNCQZpJJyDcb2PBOXkszDJ64+gEy3JK44A5Ala87efUV584AtdhGzY5MmbE7QASJ62/BAJo7AGwhJ/3bIT47LrBKUQPknTJtgKuLxAHuri3AyXaR3gyM7m2lD9YhLYCdFcDyowH0fBwhvk4RB/0S260ifoDDDfjV+3m3jBugc1R9hPp2QoQAmBV7q4A3l3awyU5JAWgFuL9mrTV9ivwY1XMiiffAy7NNkqyTXAcGfet18j0lTnGbygy0W9Wn0Olu5KdQ3p3/LUQfer7/K0IBfHaCrEIzQUG/fSuv6wD4ixAMoLgDyBZyUfpDLOO53NXKPDgD0HKh/sThPeiq3xmANiOxLDiaS6iEj2gzQssFup8PX3Uzpsp7J89isVgihN4AZZD+JaDC0u8AAAAASUVORK5CYII=" alt="image" style="width: 20px;">` : '';
     
		str += 
		`
	 		<div class="box-review d-flex justify-content-between align-items-center">
                <div class="review-section">
                    <div style="font-size: 20px">\${item.me_nick} \${userImage}</div>
                    <div style="font-size: 15px">\${stars}</div>
                    <div class="text-review" style="font-size: 20px;">\${item.rv_content}</div>
                    <span style="font-size: medium;">작성시간 : \${moment(item.rv_date).format('YY/MM/DD HH:mm')}<br />
                </div>
                \${boxBtns}
            </div>
            <i class="bi bi-hand-thumbs-up btn-up" style="font-size : 15px; cursor:pointer;" data-state="1" data-num="\${item.rv_num}"><span class="text-up">\${item.rv_up}</span></i>
            <i class="bi bi-hand-thumbs-down btn-down" style="font-size : 15px; cursor:pointer;" data-state="-1" data-num="\${item.rv_num}"><span class="text-down">\${item.rv_down}</span></i>
            <hr>
            <div style="clear: both;"></div>
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
			getOpinion(rv_num)
		},
		error : function (a,b,c) {
			console.error("에러 발생2");
		}
	});
});
	
function getOpinion(rv_num) {
	$.ajax({
		async : true,
		url : '<c:url value="/opinion"/>', 
		type : 'post', 
		data : {rv_num : rv_num}, 
		dataType : "json", 
		success : function (data){
			displayUpdateOpinion(data.review, rv_num);
			displayOpinion(data.state, rv_num);
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
}

function displayUpdateOpinion(review, rv_num) {
	$(`.btn-up[data-num=\${rv_num}]`).text(review.rv_up);
    $(`.btn-down[data-num=\${rv_num}]`).text(review.rv_down);
}
function displayOpinion(state, rv_num) {
    $(`.btn-up[data-num=\${rv_num}]`).addClass("bi-hand-thumbs-up").removeClass("bi-hand-thumbs-up-fill");
    $(`.btn-down[data-num=\${rv_num}]`).addClass("bi-hand-thumbs-down").removeClass("bi-hand-thumbs-down-fill");
    
    if (state == 1) {
        $(`.btn-up[data-num=\${rv_num}]`).removeClass("bi-hand-thumbs-up").addClass("bi-hand-thumbs-up-fill");
    } else if (state == -1) {
        $(`.btn-down[data-num=\${rv_num}]`).removeClass("bi-hand-thumbs-down").addClass("bi-hand-thumbs-down-fill");
    }
}
</script>