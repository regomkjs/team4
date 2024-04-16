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
				</c:forEach>
				</ul>
			</div>
		</div>
		<button class="btn btn-outline-primary loan-btn">대출</button>
	</div>
</body>
<script type="text/javascript">
$('.loan-btn').click(function () {
	$.ajax({
		async : true,
		url : '<c:url value="/loan/book">/', 
		type : 'post', 
		data : JSON.stringify(객체), 
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("대출했습니다.")
			}else{
				alert("이미 대출된 책입니다.")
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
});
</script>