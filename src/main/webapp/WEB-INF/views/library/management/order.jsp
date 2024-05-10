<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>
.order table thead tr{background-color:#ccc;}
.order table tr{text-align: center; line-height: 30px;}
.order table tbody tr td:nth-child(2)  a{
	color: #66c; cursor: pointer;
}
.modal table th{background-color:#eee;}
.modal-body:nth-child(2) table {text-align: center;}
.modal-body:nth-child(2) table tbody tr td{vertical-align: middle;  padding: 20px 0;}
.modal-body:nth-child(2) table tbody tr:last-of-type{line-height: 50px;}
.modal-body:nth-child(2) table tbody tr td img{height: 60px;}
.modal-body:nth-child(2) table tbody tr:last-child td{padding: 0;}

.table-order tr{line-height: 30px;}
.day{width: 40px; line-height: 30px; box-sizing: border-box; padding: 10px;}
</style>
<body>
	<div class="container mt-5">
		<div class="input-group">
			<select class="form-control" name="year">
				
			</select>
			<div class="day">년</div> 
			<select class="form-control" name="month">
				<option value="all">전체</option>
			</select> 
			<div class="day">월</div> 
			<div class="input-group-append">
				<button class="btn btn-success search-btn" type="button">검색</button>
			</div>
		</div>
		<div class="order mt-5">
			<table class="table table-bordered">
				<thead class="table-dark">
					<tr>
						<th>주문일</th>
						<th>주문번호</th>
						<th>구매자</th>
						<th>주문상품</th>
						<th>주문상태</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
			<div class="pagination-box">
				<ul class="pagination justify-content-center pagination-sm""></ul>
			</div>
		</div>
	</div>
	<!-- The Modal -->
	<div class="modal fade " id="myModal">
		<div class="modal-dialog modal-xl ">
      		<div class="modal-content modal-dialog modal-xl">
        	<!-- Modal Header -->
        		<div class="modal-header">
          			<h4 class="modal-title">주문 상세 내용</h4>
          			<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        		</div>
        		<!-- Modal body -->
        		<div class="modal-body">
        			<table class="table table-bordered table-order">
						
					</table>
					<h4> 주문 상품 정보</h4>
					<table class="table table-bordered table-book">
						<thead>
							<tr>								
								<th></th>
								<th>상품정보</th>
								<th>수량</th>
								<th>가격</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
					<h4>결제 정보</h4>
					<table class="table table-bordered table-sale">
						
					</table>
		        </div>
        		<!-- Modal footer -->
        		<div class="modal-footer">
        		
        		</div>
      		</div>
    	</div>
	</div>
	<script type="text/javascript">
		//판매 상세 조회
		$(document).on("click",".receipt-btn",function(){
			let merchant_uid=$(this).parent().parent().data("uid");
			displayDetailOrder(merchant_uid);
		});
		
		$(".search-btn").click(function(){
			displayViewOrder();
		});
		
		$(document).on('click',".page-link",function(){
			cri.page = $(this).data('page');
			 displayViewOrder();
		});
		
		//수정 클릭
		$(document).on('click',".update-btn",function(){
			let merchant_uid=$(this).parent().parent().data("uid");
			$.ajax({
				async : true, 
				url : '<c:url value="/management/order/stateList"/>', 
				type : 'post', 
				data : {merchant_uid}, 
				dataType : "json", 
				success : function (data){
					let str=`<select name=state>`;
					for(state of data.state){
						str+=`
							<option value="\${state.ss_num}">\${state.ss_state}</option>
						`;
					}
					str+=`</select>`;
					$('tr[data-uid='+merchant_uid+']>.event-box').html(str);
					str=`
						<button type="button" class="complate-btn btn btn-success">수정완료</button>
					`;
					$('tr[data-uid='+merchant_uid+']>td:last').html(str);
				}, 
				error : function(jqXHR, textStatus, errorThrown){

				}
			});
		});
		
		//수정완료 클릭
		$(document).on('click',".complate-btn",function(){
			let merchant_uid=$(this).parent().parent().data("uid");
			let num=$('tr[data-uid='+merchant_uid+']>.event-box>select[name=state]').val();
			$.ajax({
				async : true, 
				url : '<c:url value="/management/order/stateUpdate"/>', 
				type : 'post', 
				data : {
					merchant_uid,
					num
				}, 
				dataType : "json", 
				success : function (data){
					if(data.res){
						alert("수정 완료");
						displayViewOrder();
					}else{
						alert("수정 실패");
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){

				}
			});
		});
	</script>
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
				`;
			}
			$("select[name=year]").html(str);
		}
		
		displayViewYear();
		
		$("select[name=year]").change(function(){
			let str=`<option value="all">전체</option>`;
			for(let i=1;i<=12;i++){
				str+=`	
					<option value="\${leftPad(i)}">\${i}</option>
				`;
			}
			$("select[name=month]").html(str);
		});
		
		//주문내역
		let cri={
			page:1,
			year:"all",
			month:"all"
		};
		
		function displayViewOrder() {
			cri.year=$("select[name=year]").val();
			cri.month=$("select[name=month]").val();
			$.ajax({
				async : true,
				url : '<c:url value="/management/order/List"/>', 
				type : 'post', 
				data : cri, 
				dataType : "json", 
				success : function (data){
					console.log(data);
					//toStringFormatting(source)
					let str="";
					for(let i=0;i<data.list.length;i++){
						str+=`
							<tr data-uid="\${data.list[i].sa_merchant_uid}">
								<td>\${toStringFormatting(data.list[i].sa_date)}</td>
								<td><a herf="#" data-bs-toggle="modal" data-bs-target="#myModal"
									class="receipt-btn"
								>\${data.list[i].sa_merchant_uid}</a></td>
								<td>\${data.list[i].sa_nick}</td>
								<td>\${data.list[i].sa_name}</td>
								<td class="event-box">\${data.list[i].sa_state}</td>
							`;
						if(data.list[i].sa_state=="취소" || data.list[i].sa_state=="수령"){
							str+=`<td></td>`;
						}else{
							str+=`<td>
								<button type="button" class="update-btn btn btn-success">수정</button>
							</td>`;
						}
						str+=`
							</tr>
						`;
					}
					$(".order>.table>tbody").html(str);
					
					let pm = data.pm;
					let pmStr = "";
					if(pm.prev){
						pmStr += `
						<li class="page-item">
							<a class="page-link" href="javascript:void(0);" data-page="\${pm.startPage-1}">이전</a>
						</li>
						`;
					}
					for(i = pm.startPage; i<= pm.endPage; i++){
						let active = pm.cri.page == i ? "active" :"";
						pmStr += `
						<li class="page-item \${active}">
							<a class="page-link" href="javascript:void(0);" data-page="\${i}">\${i}</a>
						</li>
						`
					}
					if(pm.next){
						pmStr += `
						<li class="page-item">
							<a class="page-link" href="javascript:void(0);" data-page="\${pm.endPage+1}">다음</a>
						</li>
						`;
					}
					$(".pagination-box>ul").html(pmStr);
				}, error : function(jqXHR, textStatus, errorThrown){
				
				}
			});
		}
		displayViewOrder();
		
		//주문 상세 내역
		function displayDetailOrder(merchant_uid) {
			$.ajax({
				async : true,
				url : '<c:url value="/order/detail"/>', 
				type : 'post', 
				data : {
					merchant_uid
				}, 
				dataType : "json", 
				success : function (data){
					console.log(data);
					//toStringFormatting(source)
					let str=`
						<tr>
							<th>주문 접수일</th>
							<td>\${toStringFormatting(data.info.started_at*1000)}</td>
							<th>결제일</th>
							<td>\${toStringFormatting(data.info.paid_at*1000)}</td>
						</tr>
						<tr>
							<th>주문하신 분</th>
							<td>\${data.info.buyer_name}</td>
							<th>전화번호</th>
							<td>\${data.info.buyer_tel}</td>
						</tr>
					`;
					$(".table-order").html(str);
					str="";
					let customsData=JSON.parse(data.info.custom_data);
					let price=0;
					console.log(customsData);
					for(datas of customsData){
						str+=`
							<tr>
								<td><img alt="\${datas.title}" src="\${datas.cover}"></td>
								<td><li>제목: \${datas.title}</li>
									<li>ISBN: \${datas.isbn}</li>
									<li>ISBN13: \${datas.isbn13}</li></td>
								<td>\${datas.count}</td>
								<td>\${datas.priceStandard}</td>
							</tr>
						`;
						price+=parseInt(`\${datas.priceStandard*datas.count}`);
					}
					str+=`
						<tr>
							<td colspan="2">총결제액</td>
							<td colspan="2">\${price}</td>
						</tr>
					`;
					$(".table-book>tbody").html(str);
					
					str=`
						<tr>
							<th>실 결제 금액</th>
							<td>\${data.info.amount}</td>
						</tr>
						<tr>
							<th>결제수단</th>
							<td>\${data.info.pay_method} (\${data.info.emb_pg_provider})</td>
						</tr>
					`;
					$(".table-sale").html(str);
				}, error : function(jqXHR, textStatus, errorThrown){
				
				}
			});
		}
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