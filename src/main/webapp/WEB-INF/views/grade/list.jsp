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
    
 	// 할인율 조건
 	var currentDiscountInput = currentRow.find('.discount');
    var currentDiscount = parseFloat(currentDiscountInput.val());
    
    var discountValid = isConditionValid(
        parseFloat(currentRow.find('.discount').val()),
        parseFloat(currentRow.prev('tr').find('.discount').val()),
        parseFloat(currentRow.next('tr').find('.discount').val())
    );

    // 대출 조건
    var currentLoanConditionInput = currentRow.find('.loan');
	var currentLoanCondition = parseFloat(currentLoanConditionInput.val());
	
    var loanValid = isConditionValid(
        parseFloat(currentRow.find('.loan').val()),
        parseFloat(currentRow.prev('tr').find('.loan').val()),
        parseFloat(currentRow.next('tr').find('.loan').val())
    );

    // 게시글 조건
    var currentPostConditionInput = currentRow.find('.post');
    var currentPostCondition = parseFloat(currentPostConditionInput.val());
    
    var postValid = isConditionValid(
        parseFloat(currentRow.find('.post').val()),
        parseFloat(currentRow.prev('tr').find('.post').val()),
        parseFloat(currentRow.next('tr').find('.post').val())
    );

    // 유효성 검사
    if (!discountValid || !loanValid || !postValid) {
        alert("[" + currentRow.find('.name').val() + "] 등급 조건은 이전 값보다 커야 하고 다음 값보다 작아야 합니다.");
        return false;
    }
    
    let grade = {
            gr_num: grNum,
            gr_name: currentRow.find('.name').val(),
            gr_discount: currentDiscount,
            gr_loan_condition: currentLoanCondition,
            gr_post_condition: currentPostCondition
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

function isConditionValid(currentVal, prevVal, nextVal) {
    if (isNaN(prevVal)) { prevVal = -Infinity; }
    if (isNaN(nextVal)) { nextVal = Infinity; }

    return !(currentVal <= prevVal || currentVal >= nextVal);
}
</script>
</html>