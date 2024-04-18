<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
ol.colorlist {
  list-style: none !important; 
  counter-reset: li !important;
}

.colorlist li::before {
  content: counter(li)!important; 
  color: red !important; 
  display: inline-block!important; 
  width: 1em !important; 
  margin-left: -1em !important;
}

.colorlist li {
  counter-increment: li !important;
}
</style>
<body>
	<div class="container mt-5">
		<div class="main">
			<img alt="${book.bo_title}" src="${book.bo_thumbnail}"/>
			<div>
				<h5>${book.bo_title}</h5>
				<p>출판사:<span>${book.bo_publisher}</span></p>
				<p>저자:<span>${book.bo_au_name}</span></p>
				<p>역자:<span>${book.bo_tr_name}</span></p>
				<p>출판일:<span>${book.bo_date}</span></p>
				<p>ISBN:<span>${book.bo_isbn}</span></p>
			</div>
			<div>
				${bo_contents}
			</div>
			<div>
				<ul>
				<c:forEach items="${code}" var="co">
					<li>${co.bo_code}</li>
		            <button class="btn btn-outline-primary loan-btn" data-bo-num="${co.bo_num}">대출</button>
					<c:forEach items="${loanList }" var="loan">
						<c:if test="${loan.lo_state == 1 && loan.lo_bo_num == co.bo_num}">
							<button class="btn btn-outline-warning reserve-btn" data-bo-num="${co.bo_num}">예약</button>
						</c:if>
				        <c:if test="${loan.lo_state == 1 && loan.lo_me_id == user.me_id && loan.lo_bo_num == co.bo_num}">
				            <button class="btn btn-outline-primary extend-btn" data-bo-num="${co.bo_num}">대출 연장</button>
				            <button class="btn btn-outline-dark return-btn" data-bo-num="${co.bo_num}">반납</button>
						</c:if>
					</c:forEach>
				</c:forEach>
				</ul>
			</div>
			<div>
				<ol class="colorlist">
				  <li>책을 대출할 시 만기일은 대출한 날로부터 1주일 후로 지정됩니다.</li>
				  <li>연장은 만기일까지 3일 남았을 때부터 누를 수 있습니다.</li>
				  <li>책이 예약된 경우 연장을 할 수 없습니다.</li>
				  <li>...</li>
				</ol>
			</div>
		</div>
	</div>
</body>
<!-- 대출 -->
<script type="text/javascript">
$(document).on('click', '.loan-btn', function () {
	if(!checkLogin()){
		return;
	}
	let bookNum = $(this).data('bo-num');
	let book ={
			bo_num : bookNum
	}
	$.ajax({	
		async : true,
		url : '<c:url value="/loan/book"/>', 
		type : 'post',
		data : JSON.stringify(book), 
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("${book.bo_title}책을 대출했습니다.");
				
			}else{
				alert("이미 대출된 책입니다.")
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			
		}
	});
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
<!-- 대출 연장 -->
<script type="text/javascript">
$(document).on('click', '.extend-btn', function () {
	let bookNum = $(this).data('bo-num');
	let book ={
			bo_num : bookNum
	}
	$.ajax({	
		async : true,
		url : '<c:url value="/extend/book"/>', 
		type : 'post',
		data : JSON.stringify(book), 
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("1주일 연장되었습니다.")
			}else{
				alert("본인이 대출한 책이 아니거나 만기일까지 3일 넘게 남았습니다.")
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			
		}
	});
})
</script>
<!-- 예약 -->
<script type="text/javascript">
	
</script>