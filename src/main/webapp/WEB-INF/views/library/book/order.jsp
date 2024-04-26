<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<body>
	<div class="container mt-5">
		<div class="input-group">
			<select class="form-control" name="year">
				
			</select>
			년 
			<select class="form-control" name="month">
				<option value="all">전체</option>
				<c:forEach begin="1" end="12" var="i">
					<option value="${i}">${i}</option>
				</c:forEach>
			</select> 
			월
			<div class="input-group-append">
				<button class="btn btn-success search-btn" type="button">검색</button>
			</div>
		</div>
		<div class="Order">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>주문일</th>
						<th>주문번호</th>
						<th>구매자</th>
						<th>주문상품</th>
						<th>주문상태</th>
					</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
		</div>
	</div>
	<!-- The Modal -->
	<div class="modal fade " id="myModal">
		<div class="modal-dialog modal-xl ">
      		<div class="modal-content modal-dialog modal-xl">
        	<!-- Modal Header -->
        		<div class="modal-header">
          			<h4 class="modal-title">주문 상세 내용</h4>
          			<button type="button" class="close" data-dismiss="modal">×</button>
        		</div>
        		<!-- Modal body -->
        		<div class="modal-body">
        			<table class="table table-bordered">
						<tr>
							<th>주문번호</th>
							<td>ㄴㄴㄴ</td>
							<th>배송방법</th>
							<td>sdfs</td>
						</tr>
						<tr>
							<th>주문 접수일</th>
							<td>ㄴㄴㄴ</td>
							<th>결제일</th>
							<td>sdfs</td>
						</tr>
						<tr>
							<th>주문하신 분</th>
							<td>ㄴㄴㄴ</td>
							<th>전화번호</th>
							<td>sdfs</td>
						</tr>
					</table>
					<h4> 주문 상품 정보</h4>
					<table class="table table-bordered">
						<tr>
							<th>주문상품</th>
							<td >ㄴㄴㄴ</td>
						</tr>
					</table>
					<h4>결제 정보</h4>
					<table class="table table-bordered">
						<tr>
							<th>총 결제금액</th>
							<td>ㄴㄴㄴ</td>
						</tr>
						<tr>
							<th>할인 금액</th>
							<td>ㄴㄴㄴ</td>
						</tr>
						<tr>
							<th>결제수단</th>
							<td>ㄴㄴㄴ</td>
						</tr>
					</table>
		        </div>
        		<!-- Modal footer -->
        		<div class="modal-footer">
        		
        		</div>
      		</div>
    	</div>
	</div>
	<!-- 출력 -->
	<script type="text/javascript">
		//년도
		function displayViewYear() {
			let date=new Date();
			const year = date.getFullYear();
			let str=`<option value="all">전체</option>`;
			for(let i=(year-10);i<=year;i++){
				str+=`	
					<option value="\${i}">\${i}</option>
				`
			}
			$("select[name=year]").html(str);
		}
		displayViewYear();
		
		//주문내역
		let cri={
			page:1
		};
		
		function displayViewOrder() {
			$.ajax({
				async : true,
				url : '<c:url value="/order/list"/>', 
				type : 'post', 
				//data : cri, 
				dataType : "json", 
				success : function (data){
					console.log(data);
					//toStringFormatting(source)
					let str="";
					for(let i=0;i<data.order.length;i++){
						str+=`
							<tr>
								<td>\${toStringFormatting(data.order[i].sa_date)}</td>
								<td data-uid="\${data.order[i].sa_uid}"
								><a href="#" data-toggle="modal" data-target="#myModal"
								>\${data.order[i].sa_merchant_uid}</a></td>
								<td>\${data.order[i].sa_nick}</td>
								<td>\${data.order[i].sa_name}</td>
								<td>\${data.order[i].sa_state}</td>
							</tr>
						`;
					}
					$(".Order>.table>tbody").html(str);
				}, error : function(jqXHR, textStatus, errorThrown){
				
				}
			});
		}
		displayViewOrder();
		
		
	</script>
	<!-- 날짜 -->
	<script type="text/javascript">
	function toStringFormatting(source){
		  let milliseconds = source;
	      var  date = new Date(milliseconds);
	      const year = date.getFullYear();
	      const month = leftPad(date.getMonth() + 1);
	      const day = leftPad(date.getDate());
	      return year+"-"+month+"-"+day;
		}
		
	
		function leftPad(value){
			if (Number(value) >= 10) {
				return value;
			}
			return "0" + value;
		}
	</script>
</body>