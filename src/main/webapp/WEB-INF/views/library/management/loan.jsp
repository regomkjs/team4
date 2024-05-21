<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.mail-btn{ position: relative; float: right;}
</style>
</head>
<body>
<div class="container">
	<h1>대출한 도서</h1>
	<button class="btn btn-outline-primary book" onclick="toggleBooks()">만기 도서</button>
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
				<th class="col-1">D-day</th>
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
				  		<td style="color: red;">
				  			<c:if test="${loan.lo_day == 0 }">
				  				d-day
				  			</c:if>
				  			<c:if test="${loan.lo_day < 0 }">
				  				만기일 지남
				  			</c:if>
				  			<c:if test="${loan.lo_day > 0 }">
					  			${loan.lo_day}일
				  			</c:if>
				  		</td>
				  		<td>${loan.me_nick}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
		<c:if test="${pm.totalCount == 0}">
			<h1 class="text-center">대출한 책이 없습니다.</h1>
		</c:if>
	</table>
	<div class="text-right">
   		<button class="btn btn-primary mail-btn" data-bs-toggle="modal" data-bs-target="#myModal">문자 전송</button>
	</div>
	<!-- The Modal -->
	<div class="modal" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<!-- Modal Header -->
				<div class="modal-header">
				  <h4 class="modal-title">문자 전송</h4>
				  <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
			
				<!-- Modal body -->
				<div class="modal-body">
					<textarea rows="20" cols="60" id="mail-content" name="content">반납 만기일까지 3일 남은 책이 있습니다. 연장해주시거나 반납해주시길 바랍니다.</textarea>
				</div>
			
			    <!-- Modal footer -->
		      	<div class="modal-footer">
		        	<button type="button" class="btn btn-success btn-send">전송</button>
		        	<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
	   	 		</div>
			</div>
		</div>
	</div>
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
	
	let uniquePhones = [...new Set(phones)]; 
	 
	let requests = [];
	 
	$(uniquePhones).each(function(index, phone) {
		let request = $.ajax({
            url: '<c:url value="/mail/send"/>',
            method: "post",
            data: {
                phone: phone,
                content: content
            },
            dataType: "json"
        });

        requests.push(request);
	});
	
	Promise.all(requests).then(function(results) {
        alert('문자 메시지가 성공적으로 전송되었습니다.');
    }).catch(function(error) {
        alert('하나 이상의 문자 메시지 전송에 실패하였습니다');
    });
});
</script>
<script type="text/javascript">
function toggleBooks() {
    document.querySelectorAll('tbody tr').forEach(function(row) {
        const dDayCell = row.querySelector('td:nth-child(8)');
        if (dDayCell) {
            let dDayText = dDayCell.innerText.trim();
            let isVisible = row.getAttribute('data-visible') !== 'false';

            if (dDayText !== 'd-day' && dDayText !== '만기일 지남' && parseInt(dDayText.replace('일', '')) > 3) {
                if (isVisible) {
                    row.style.display = 'none';
                    row.setAttribute('data-visible', 'false');
                } else {
                    row.style.display = '';
                    row.setAttribute('data-visible', 'true');
                }
            } else {
                row.style.display = '';
                row.setAttribute('data-visible', 'true');
            }
        }
    });
}
</script>
</html>