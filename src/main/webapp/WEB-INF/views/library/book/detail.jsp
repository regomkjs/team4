<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
					<c:choose>
						<c:when test="${loanList.lo_state == 1 && loanList.lo_me_id == user.me_id}">
							<button class="btn btn-outline-warning reserve-btn">예약</button>
							<button class="btn btn-outline-primary extend-btn">대출 연장</button>
							<button class="btn btn-outline-dark return-btn">반납</button>
						</c:when>
						<c:when test="${loanList.lo_state != 1 || loanList.lo_bo_num != co.bo_num}">
							<button class="btn btn-outline-primary loan-btn" data-bo-num="${co.bo_num}">대출</button>
						</c:when>
					</c:choose>
				</c:forEach>
				</ul>
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
				alert("대출 성공")
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
	let book ={
			bo_num : '${book.bo_num}'
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
				alert("예약된 책이거나 대출한 책이 아닙니다.")
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