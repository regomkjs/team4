<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등급 관리</title>
</head>
<body>
<div class="container">
	<table class="grade-container">
		<thead>
			<tr>
				<th>등급명</th>
				<th>할인율</th>
				<th>대출조건</th>
				<th>게시글조건</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${gradeList}" var="grade" begin="1" end="5">
				<tr class="grade-list">
					<td class="col-2 grade-item">
						<input type="hidden" class="gr_num" value="${grade.gr_num }">
						<input type="text" readonly value="${grade.gr_name }" style="width: 170px" maxlength="10" class="name">
					</td>
					<td class="col-2 grade-item">
						<input type="text" readonly value="${grade.gr_discount }" style="width: 50px" maxlength="5" class="discount">%
					</td>
					<td class="col-2 grade-item">
						<input type="text" readonly value="${grade.gr_loan_condition }" style="width: 50px" maxlength="5" class="loan">개
					</td>
					<td class="col-2 grade-item">
						<input type="text" readonly value="${grade.gr_post_condition }" style="width: 50px" maxlength="5" class="post">개
					</td>
					<td>
						<button type="submit" class="btn btn-outline-warning btn-update">수정</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="<c:url value="/grade/insert"/>" class="btn btn-outline-success btn-insert">등급 추가</a>
</div>
</body>
<script type="text/javascript">
$(document).on("click", ".btn-update", function () {
    var currentRow = $(this).closest("tr");

    var grNum = currentRow.find('.gr_num').val();
	
    currentRow.find('input').removeAttr('readonly');

    var bodyHtml = '<button type="submit" class="btn btn-outline-warning btn-complete">수정 완료</button>';
    $(this).after(bodyHtml);
    $(this).hide();
});

$(document).on("click", ".btn-complete", function () {
    var currentRow = $(this).closest("tr");

    var grNum = currentRow.find('.gr_num').val();
    
    let grade = {
        gr_num: grNum,
        gr_name: currentRow.find('.name').val(),
        gr_discount: currentRow.find('.discount').val(),
        gr_loan_condition: currentRow.find('.loan').val(),
        gr_post_condition: currentRow.find('.post').val()
    }
    
    $.ajax({
		async : true,
		url : '<c:url value="/grade/update"/>',
		type : 'post', 
		data : JSON.stringify(grade), 
		contentType : "application/json; charset=utf-8",
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert('등급을 수정했습니다.');
			}else{
				alert('등급을 수정하지 못했습니다.');
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){

		}
	});
    $('.btn-update').show();
    $('.btn-complete').remove();
	$('input').attr('readonly', true);
});
</script>
</html>