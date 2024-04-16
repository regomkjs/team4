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
						<input type="hidden" name="gr_num" class="gr_num edit-input" value="${grade.gr_num }">
						<input type="text" readonly value="${grade.gr_name }" style="width: 170px" maxlength="10" class="name edit-input">
					</td>
					<td class="col-2 grade-item">
						<input type="text" readonly value="${grade.gr_discount }" style="width: 50px" maxlength="5" class="discount edit-input">%
					</td>
					<td class="col-2 grade-item">
						<input type="text" readonly value="${grade.gr_loan_condition }" style="width: 50px" maxlength="5" class="loan edit-input">개
					</td>
					<td class="col-2 grade-item">
						<input type="text" readonly value="${grade.gr_post_condition }" style="width: 50px" maxlength="5" class="post edit-input">개
					</td>
					<td>
						<button type="submit" class="btn btn-outline-warning btn-update">수정</button>
						<button type="submit" class="btn btn-outline-danger btn-delete">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button type="submit" class="btn btn-outline-success btn-insert">등급 추가</button>
	<div class="modal fade" id="gradeAddModal" tabindex="-1" role="dialog" aria-labelledby="gradeAddModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="gradeAddModalLabel">등급 추가</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form id="gradeAddForm">
	          <div class="form-group">
	            <label for="name">등급명</label>
	            <input type="text" class="form-control" id="name" name="gr_name" maxlength="10">
	          </div>
	          <div class="form-group">
	            <label for="discount">할인율(%)</label>
	            <input type="text" class="form-control" id="discount" name="gr_discount" maxlength="5">
	          </div>
	          <div class="form-group">
	            <label for="loan">대출조건(개)</label>
	            <input type="text" class="form-control" id="loan" name="gr_loan_condition" maxlength="5">
	          </div>
	          <div class="form-group">
	            <label for="post">게시글조건(개)</label>
	            <input type="text" class="form-control" id="post" name="gr_post_condition" maxlength="5">
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary grade-insert">추가하기</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
</body>
<!-- 등급 수정 -->
<script type="text/javascript">
$(document).on("click", ".btn-update", function () {
    var currentRow = $(this).closest("tr");

    var grNum = currentRow.find('.gr_num').val();
	
    currentRow.find('.edit-input').removeAttr('readonly');

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
	$('.edit-input').attr('readonly', true);
});

function isConditionValid(currentVal, prevVal, nextVal) {
    if (isNaN(prevVal)) { prevVal = -Infinity; }
    if (isNaN(nextVal)) { nextVal = Infinity; }

    return !(currentVal <= prevVal || currentVal >= nextVal);
}
</script>
<!-- 등급 추가 -->
<script type="text/javascript">
$(document).ready(function() {
    //버튼 클릭 이벤트
    $('.btn-insert').click(function() {
        $('#gradeAddModal').modal('show');
    });

    // 추가하기 버튼 클릭 이벤트
    $('.grade-insert').click(function() {
	  
    	let grade = {
		    gr_name: $("input[name='gr_name']").val(),
		    gr_discount: $("input[name='gr_discount']").val(),
		    gr_loan_condition: $("input[name='gr_loan_condition']").val(),
		    gr_post_condition: $("input[name='gr_post_condition']").val()
		}
    	
    	let isDuplicate = false;
    	let maxDiscount = 0;
        let maxLoanCondition = 0;
        let maxPostCondition = 0;
        $('.grade-list').each(function() {
            let currentName = $(this).find('.name').val();
            let currentDiscount = parseFloat($(this).find('.discount').val().replace('%', ''));
            let currentLoanCondition = parseInt($(this).find('.loan').val().replace('개', ''), 10);
            let currentPostCondition = parseInt($(this).find('.post').val().replace('개', ''), 10);

            if (currentName === grade.gr_name) {
                isDuplicate = true;
                return false;
            }

            if (currentDiscount > maxDiscount) {
                maxDiscount = currentDiscount;
            }
            if (currentLoanCondition > maxLoanCondition) {
                maxLoanCondition = currentLoanCondition;
            }
            if (currentPostCondition > maxPostCondition) {
                maxPostCondition = currentPostCondition;
            }
        });
        if(!isDuplicate && grade.gr_discount > maxDiscount && grade.gr_loan_condition > maxLoanCondition && grade.gr_post_condition > maxPostCondition){
			$.ajax({
				async : true,
				url : '<c:url value="/grade/insert"/>',
				type : 'post', 
				data : JSON.stringify(grade), 
				contentType : "application/json; charset=utf-8",
				dataType : "json", 
				success : function (data){
					if(data.result){
						alert('등급을 추가했습니다.');
						let newGrade = `
									<tr class="grade-list">
						                <td class="col-2 grade-item">
						                    <input type="hidden" class="gr_num" value="${data.grade.gr_num}">
						                    <input type="text" readonly value="${grade.gr_name}" style="width: 170px" maxlength="10" class="name edit-input">
						                </td>
						                <td class="col-2 grade-item">
						                    <input type="text" readonly value="${grade.gr_discount}" style="width: 50px" maxlength="5" class="discount edit-input">%
						                </td>
						                <td class="col-2 grade-item">
						                    <input type="text" readonly value="${grade.gr_loan_condition}" style="width: 50px" maxlength="5" class="loan edit-input">개
						                </td>
						                <td class="col-2 grade-item">
						                    <input type="text" readonly value="${grade.gr_post_condition}" style="width: 50px" maxlength="5" class="post edit-input">개
						                </td>
						                <td>
						                    <button type="submit" class="btn btn-outline-warning btn-update">수정</button>
						                </td>
					            	</tr>
						            `;
		             $(".grade-container tbody").append(newGrade);
					}else{
						alert('등급은 5개까지 추가할 수 있습니다.');
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
		
				}
			});
		}else if (isDuplicate) {
	        alert('이미 존재하는 등급 이름입니다.');
	    } else {
	        alert('할인율, 대출 조건, 게시글 조건은 현재 추가된 등급 조건보다 커야 합니다.');
	    }
        // 모달 창 닫기
        $('#gradeAddModal').modal('hide');
    });
});
</script>
<!-- 등급 삭제 -->
<script type="text/javascript">
$(document).on("click", ".btn-delete", function () {
    let row = $(this).closest('tr');
    console.log(row);
    let gr_num = row.find($('[name="gr_num"]')).val();
    let obj = {
    		gr_num
    }
	$.ajax({
		async : true,
		url : '<c:url value="/grade/delete"/>', 
		type : 'post', 
		data : obj, 
		dataType : "json", 
		success : function (data){
			if(data.result){
				alert("등급을 삭제했습니다.");
				row.remove();
			}else{
				alert("등급을 삭제하지 못했습니다." + error);
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert("해당 등급에 해당하는 회원이 존재해서 삭제하지 못합니다.")
		}
	});
});
</script>
</html>