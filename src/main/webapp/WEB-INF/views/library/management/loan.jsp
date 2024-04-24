<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<h1>대출한 도서</h1>
	
	<form action="<c:url value="/library/management/loan"/>" method="get" class="input-group" id="searchForm">
		<div class="input-group mb-1">
			<select name="type" class="input-group-prepend" >
				<option value="all" <c:if test='${pm.cri.type == "all"}'>selected</c:if>>전체</option>
				<option value="title" <c:if test='${pm.cri.type == "title"}'>selected</c:if>>제목</option>
				<option value="publisher" <c:if test='${pm.cri.type == "publisher"}'>selected</c:if>>출판사</option>
			</select>
			<input type="text" name="search" class="form-control" value="${pm.cri.search}">
			<button type="submit" class="input-group-append btn btn-outline-success">검색</button>
		</div>
	</form>

	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th class="col-1"><input type="checkbox" id="allCheck" name="allCheck"></th>
				<th class="col-1">번호</th>
				<th class="col-2">이미지</th>
				<th class="col-2">제목</th>
				<th class="col-2">도서코드</th>
				<th class="col-1">대출일</th>
				<th class="col-1">만기일</th>
				<th class="col-1">닉네임</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${loanList}" var="loan" varStatus="vs">
				<c:if test="${loan.bo_num > 0}">
					<tr>
						<td><input type="checkbox" id="check" name="check" data-num="${loan.bo_num}" data-phone="${loan.me_phone}"></td>
				  		<td>${pm.totalCount - vs.index - pm.cri.pageStart}</td>
				  		<td>
					  		<img src="${loan.bo_thumbnail}">
				  		</td>
				  		<td> 
				  			<c:url value="/library/book/detail?num=${loan.bo_num}" var="detailUrl">
				  				<c:param name="num">${loan.bo_num}</c:param>
				  				<c:param name="page" value="${pm.cri.page}"/>
								<c:param name="type" value="${pm.cri.type}"/>
								<c:param name="search" value="${pm.cri.search}"/>
				  			</c:url>
				  			<a href="${detailUrl}">${loan.bo_title}</a>
				  		</td>
				  		<td>${loan.bo_code}</td>
				  		<td>
				  			<fmt:formatDate value="${loan.lo_date}" pattern="yy/MM/dd"/><br/>
			  			</td>
				  		<td>
				  			<fmt:formatDate value="${loan.lo_limit}" pattern="yy/MM/dd"/><br/>
				  		</td>
				  		<td>${loan.me_nick}</td>
					</tr>
				</c:if>
			</c:forEach>
			<button class="btn btn-outline-primary" data-toggle="modal" data-target="#myModal">문자 전송</button>
		</tbody>
		<!-- The Modal -->
		<div class="modal" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">
				
					<!-- Modal Header -->
					<div class="modal-header">
					  <h4 class="modal-title">문자 전송</h4>
					  <button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
				
					<!-- Modal body -->
					<div class="modal-body">
						<textarea rows="20" cols="60" id="mail-content" name="content">반납 만기일까지 X일 남은 책이 있습니다. 연장해주시거나 반납해주시길 바랍니다. ※연체일시 대출에 제한이 생기니 주의 바랍니다.</textarea>
					</div>
				
				    <!-- Modal footer -->
			      	<div class="modal-footer">
			        	<button type="button" class="btn btn-success btn-send">전송</button>
		   	 		</div>
				</div>
			</div>
		</div>
	</table>
	<c:if test="${pm.totalCount == 0}">
		<h1 class="text-center">대출한 책이 없습니다.</h1>
	</c:if>
	<ul class="pagination justify-content-center">
		<c:if test="${pm.prev}">
		    <li class="page-item">
		    	<c:url value="/library/management/loan" var="prev">
		    		<c:param name="type" value="${pm.cri.type}" />
		    		<c:param name="search" value="${pm.cri.search}" />
		    		<c:param name="page" value="${pm.startPage - 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${prev}">이전</a>
	    	</li>
		</c:if>
    	<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
    		<c:url value="/library/management/loan" var="url">
    			<c:param name="type" value="${pm.cri.type}" />
	    		<c:param name="search" value="${pm.cri.search}" />
	    		<c:param name="page" value="${i}"/>
	    	</c:url>
	    	<c:set var="active" value="${pm.cri.page == i ? 'active' : '' }"/>
    		<li class="page-item ${active}">
    			<a class="page-link" href="${url}">${i}</a>
   			</li>
    	</c:forEach>
    	<c:if test="${pm.next}">
			<li class="page-item">
		    	<c:url value="/library/management/loan" var="next">
		    		<c:param name="type" value="${pm.cri.type}" />
		    		<c:param name="search" value="${pm.cri.search}" />
		    		<c:param name="page" value="${pm.endPage + 1}"/>
		    	</c:url>
		    	<a class="page-link" href="${next}">다음</a>
	    	</li>
		</c:if>
	</ul>
</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
    $("#allCheck").click(function(){
        if($(this).is(":checked")){
            $("input[name='check']").prop("checked", true);
        }else{
            $("input[name='check']").prop("checked", false);
        }
    });
});
</script>
<script type="text/javascript">

$(".btn-send").click(function(){
	
	let content = $('#mail-content').val();
	let phones = [];
	 $("input[name='check']:checked").each(function() {
        let phone = $(this).data("phone");
        if(phone) {
            phones.push(phone);
        }
    });
	$(phones).each(function(index, phone) {
		
		$.ajax({
			async : false,
			url : '<c:url value="/mail/send"/>',
			method : "post",
			data : {
				phone : phone,
				content : content
			},
			dataType : "json", 
			success : function (data) {
				alert('문자 메시지가 성공적으로 전송되었습니다.');
			},
			error : function (a,b,c) {
				alert('문자 메시지 전송에 실패하였습니다');
			}
		});
	});
});
</script>
</html>