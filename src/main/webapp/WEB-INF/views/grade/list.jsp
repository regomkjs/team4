<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등급 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
    .container {
        width: 90%;
        margin: auto;
        overflow: hidden;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
    }

    th, td {
        padding: 8px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #f2f2f2;
        color: #333;
    }

    tr:hover {
        background-color: #f5f5f5;
    }

    .btn {
        padding: 5px 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-left: 5px;
    }

    .btn-outline-warning {
        color: #ffc107;
        border: 1px solid #ffc107;
    }

    .btn-outline-danger {
        color: #dc3545;
        border: 1px solid #dc3545;
    }

    .btn-outline-success {
        color: #28a745;
        border: 1px solid #28a745;
    }

    .btn-update:hover, .btn-delete:hover, .btn-insert:hover {
        opacity: 0.8;
    }

    .grade-item input[readonly] {
        border: none;
        background-color: transparent;
        color: #333;
    }
</style>
<body>
<div class="container">
	<table class="grade-container table-hover">
		<thead>
			<tr>
				<th></th>
				<th>등급명</th>
				<th>할인율</th>
				<th>대출조건</th>
				<th>게시글조건</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${gradeList}" var="grade" begin="1" end="5" varStatus="status">
				<tr class="grade-list">
					<td>
					<c:choose>
						<c:when test="${status.index == 1}">
							<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABJElEQVR4nO2ZTWoCQRCF+xiWie4kS4/hBXISYQpc6wVcZu/KDFnmDlkY6BZEELfqRvwBEUSs0IREAs6iW5juJu+DWs97U696hi6lAAAgWqrtcY3Y5MR6T2yk3NL7Cuu3aqafvMVXWK/LF27+lNXwwPrR2cD3mw8rnq419DAQIjamKE47nw5ITKVggNEBQYRcCB0ZimGIm92J9N6Xstie0jLQ6s/kdbSR0/kiPyRjYLo6yi2SMVBEMgY2h7MMPtby/DJP00C9M77ZjWQMUEGcYMAVdIARIcEQE06hKzhGXcExyvd/ySn0rwQMMDpggkeH/vEM6HgudzOzdTZglwvBhfNv5c4G7GYkmgVH9tlQPtjNiF0u2Pv58sVr+8zcWzwAAKgy+ALGkks5M3xO2gAAAABJRU5ErkJggg==">
						</c:when>
						<c:when test="${status.index == 2}">
							<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABqUlEQVR4nO2Zy4rCMBSG8yAzy2EeR5JSRQRREZe+gY+gK9F1t4N04VY3Cq7c6ULwBcSFMF4q9vRyhlSm1QHRVmlTJj8cKGlp/+/kJCkJIVJSUlLC6pjJvAOlPZOxHTCGcYZ5/qZ+UtXPyOZNSjdxG4e/IJRuDErfQgPwzCdtHoL4Cg2QRNnA7V7Yhu8BAYzDRUgAkD3AZAmF0v8dxIqCdreL7nKJuN97wa/tTse7JzaAoqAzHuMtOaOR2AB2q4X3ZDeb4gK4s1mQ7cEAoVxGKBTQGQ79dv6MsABoGL5RKBb9dqtWC7rAMMQFgFtRqQQAu136AGxNC0poPk8XgFWtIh6PwSBut1MEkM16Gfezv1oh5HIpAVBVdCaTi0XAQavRiPw+EitAPo/OdHo9/2vaUwkhsQGUSuguFtcrcL//dDmSOACseh3d9fravK4/P5ZYXAvZ4XD3V8Jb5IQFeFAS4BG9om5fGSSskjYMEoAln3WQJcRSPIhNsTZ3v6PMQnrSxuE3KO2FBuAnI6IccJwY+yBRxE9G+OEC359PwPiWZz6yeSkpKSkSh34A766mybHzuzMAAAAASUVORK5CYII=">
						</c:when>
						<c:when test="${status.index == 3}">
							<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABiElEQVR4nO2ZwUrEMBCG8yB6FA824M0XUHwUD+7DKI3C6mW9SvGgfQL1UterNq4rrLRepAvu0ihUSmSKjahUTcU2wfnhh5JL/y8zaUuHEBQKhTJWW9cLs4w7nsvplHEqm7QL9wzpwXZI538Rno6bDs4+e7w5oDPaALDzBoSXr97XBmijbViVQzqpUQEDgvM3IwDDClBsIS3960Psxx0ZizOZ5Y+FYxEUa1YAnCe7skr9ZMdsAD/uyO9UtxKkCQBom1Kj9Fj2hsuFR+mJWo9EYC5AlgsVFIKX673hilrP8tRcAFbhvZtVBSCeE3sAuoMleRityfunSwVwNfHtAfioaXb3rrUYAnwhbCFu4SHObH+MxiJQQeHlBcHBt+mpHS8y/wefEkfRurkAjNPig61K/aRb+5FMmgIoKwGtAmcCDNd1d561AfAXJgjAsQISW0hH1h9i16Cfu27oPGgDwHCh7eBM2fG0AWAyYsqAY+NicY7UEUxGYLgA/+cbDx7CPR2vdngUCoUiTegFU2aJ1Yt8CosAAAAASUVORK5CYII=">
						</c:when>
						<c:when test="${status.index == 4}">
							<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABMUlEQVR4nO2ZTQrCQAyFe4yO1aUIKngYjyYi4g1EPIPSClO3HsG6FPzDTeNERrRaiuAU6UwgD7Lppu97STYTz2OxWCxnhctaA0IxS0NxgkhglZU+/unPMaq1SptPQ39ftXEogPh7lEHdGEAnb9s8vGtqDGBjbOD7OB3NO+CAcfgoBgDugOARMpLtkQHrSyzbiHDCT5ECUNtBzjwtAKnTP9MFUMmwYJ4OQNzJ0leHFT0AlYwyw7dNnxhA3EWES5a+/kYKQO3GufRpAax7iLdrLn1SAGo3KaRPCgCf6f8iNwFQUQdA2gDwA5jTOwAMINzswL/KY4CIO4A8QiYiv8SpW4+7B2MAfVywbRxeFYqZMYC+jDhz4FgETWOAB4QM6vq4oN/nLYzNUSdf2jyLxWJ5VegOSOS+C4MgG8YAAAAASUVORK5CYII=">
						</c:when>
						<c:when test="${status.index == 5}">
							<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABf0lEQVR4nO2ZsUoDQRCG90G00V1S+Qhq7QPIbVDsTKGWWtjamT7BZ5Bw4COIRTq1SOUjCCEmahR27kZG1BVMPHbBvV2cH4ZLFeab+Wfv2BGCxWKxolW2jIuZgp6WZqIVYNCQZpJJyDcb2PBOXkszDJ64+gEy3JK44A5Ala87efUV584AtdhGzY5MmbE7QASJ62/BAJo7AGwhJ/3bIT47LrBKUQPknTJtgKuLxAHuri3AyXaR3gyM7m2lD9YhLYCdFcDyowH0fBwhvk4RB/0S260ifoDDDfjV+3m3jBugc1R9hPp2QoQAmBV7q4A3l3awyU5JAWgFuL9mrTV9ivwY1XMiiffAy7NNkqyTXAcGfet18j0lTnGbygy0W9Wn0Olu5KdQ3p3/LUQfer7/K0IBfHaCrEIzQUG/fSuv6wD4ixAMoLgDyBZyUfpDLOO53NXKPDgD0HKh/sThPeiq3xmANiOxLDiaS6iEj2gzQssFup8PX3Uzpsp7J89isVgihN4AZZD+JaDC0u8AAAAASUVORK5CYII=">
						</c:when>
					</c:choose>
					</td>
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