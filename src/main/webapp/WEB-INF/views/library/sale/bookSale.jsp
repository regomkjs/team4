<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>
*{margin: 0; padding: 0;}
.container{position: relative;}
.table{text-align: center;}
.table thead th{color:#a5a5a5;}
.list .table thead th:nth-of-type(1){width: 40px;}
.table tbody tr{vertical-align: middle;}
.total-sale{margin: 0 auto;}
.btn-box{position: relative; width: 100%;margin-top: 30px; height: 100px;}
.btn-box #money-btn{position:absolute; left: 30%; }
</style>
<body>
	<div class="container">
		<div id="nav"></div>
		<div class="list mt-5">
			<table class="table table-bordered">
				<thead class="table-dark">
					<tr>
						<th><input type="checkbox" class="allChkBtn" /></th>
						<th colspan="2">상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
			<table class="table table-bordered total-sale w-50">
				<tbody></tbody>
			</table>
		</div>
		<div class="btn-box">

			<button id="money-btn" class="btn btn-primary">선택한 상품 구매</button>
		</div>
	</div>
	<!-- 장바구니 -->
	<script type="text/javascript">
		displayView();
		function displayView() {
			let str="";
			data=JSON.parse(localStorage.getItem(nick));
			let n=0;
			for(book of data){
				str+=`
				<tr data-index="\${n}">
					<td>
					 	<input type="checkbox" class="chkBtn"/>
					</td>
					<td>
						<img alt="\${book.title}" src="\${book.cover}">
					</td>
					<td>\${book.title}</td>
					<td>\${priceToString(book.priceStandard)}</td>
					<td>
						<select class="sale-count">
							<c:forEach begin="1" var="i" end="10">
								<option value='${i}'>${i}</option>
							</c:forEach>
						</select>
					</td>
					<td><button class="del-btn btn btn-warning">삭제</button></td>
				</tr>
				`;
				n++;
			}
			$(".table>tbody").html(str);
		}
	</script>
	<!-- 결제 -->
	<script type="text/javascript">
		var IMP = window.IMP;
		IMP.init("${imp}");   /* imp~ : 가맹점 식별코드*/
		let Goods={
			total:0,
			name:"",
			uid:""
		};
		
		$('#money-btn').click(function() {
			Goods.name=selectedBook.length>1?
					data[selectedBook[0]].title+" 외 "+(selectedBook.length-1)+"개":data[selectedBook[0]].title;
			let str="${user.me_nick}";
			let today = new Date(); 
			Goods.uid=str.substring(0,3)+toStringFormatting(today);
			
			let custom=[];
			for(let i=0;i<selectedBook.length;i++){
				let num=selectedBook[i];
				let sdata={}
				sdata.title=data[selectedBook[i]].title;
				sdata.cover=data[selectedBook[i]].cover;
				sdata.priceStandard=data[selectedBook[i]].priceStandard;
				sdata.isbn=data[selectedBook[i]].isbn;
				sdata.isbn13=data[selectedBook[i]].isbn13;
				sdata.count=Number($(".sale-count").eq(selectedBook[i]).val());
				custom.push(sdata);
			}
	
			IMP.request_pay({
				pg: "html5_inicis",		//KG이니시스 pg파라미터 값
                pay_method: "card",		//결제 방법
                merchant_uid: Goods.uid,//주문번호
                name:Goods.name,		//상품 명
                amount:100, //Goods.total,			//금액
                //주문자 정보
   				buyer_email: "${user.me_email}",
   				buyer_name: "${user.me_nick}",
   				buyer_tel: "${user.me_phone}",
   				//buyer_addr: "서울특별시 강남구 신사동",
   				//buyer_postcode: "01181"
   				custom_data:custom
			}, function(rsp) {
				console.log(rsp);
				$.ajax({
					async : true,
					url : '<c:url value="/library/sale/insert"/>' ,
					type : 'post', 
					data : {
						book_name:rsp.name,
						imp_uid:rsp.imp_uid,
						merchant_uid:rsp.merchant_uid,
						amount: rsp.paid_amount
						}, 
					dataType : "json", 
				}).done(function(data){
					console.log(data);
					if(data.res){
		        		alert("결제 완료");
		        		//화면 불러오기,장바구니내용 삭제
		        		window.localStorage.removeItem(nick);
		        		location.reload(true);
	        		} else {
	        			alert("결제 실패");
	        		}
				});
			});
		});
	</script>
	<!-- 체크박스 -->
	<script type="text/javascript">
	let selectedBook= [];
	
	$(document).on('change','.chkBtn',function(){
		var checked = $(this).is(':checked');
		if(checked){
			$('.allChkBtn').prop('checked',true);
			selectedBook.push($(this).closest("tr").data("index"));
		}else{
			if($(".chkBtn:checked").length==0){
				$('.allChkBtn').prop('checked',false);
			}
			let value=$(this).closest("tr").data("index");
			for(let i = 0; i < selectedBook.length; i++) {
			    if (selectedBook[i] === value) {
			    	selectedBook.splice(i, 1);
			    }
			}
		}
		displaySeleView();
	});
	
	$(document).on("change",".allChkBtn",function() {
		var checked = $(this).is(':checked');
		if(checked){
			$('input:checkbox').prop('checked',true);
			selectedBook=[];
			$(".chkBtn:checked").each(function() {
				selectedBook.push($(this).closest("tr").data("index"));
			  })
		}else{
			$('input:checkbox').prop('checked',false);
			selectedBook=[];
			Goods.name="";
			Goods.total=0;			
		}
		displaySeleView();
	});
	
	//삭제버튼 클릭
	$(document).on("click",".del-btn",function(){
		let value=$(this).closest("tr").data("index");
		for(let i = 0; i < selectedBook.length; i++) {
		    if (selectedBook[i] === value) {
		    	selectedBook.splice(i, 1);
		    }
		}
		data.splice(value, 1);
		basket=data;
		window.localStorage.setItem(nick, JSON.stringify(data));
		$('input:checkbox').prop('checked',false);
		selectedBook=[];
		displayView();
		displaySeleView();
		displayBasketView();
	});
	
	</script>
	<!-- 판매 계산 -->
	<script type="text/javascript">
	$(document).on("change",".sale-count",function(){
		displaySeleView();
	});
	
	function displaySeleView() {
		let price=0;
		let count=0;
		for(let i=0;i<selectedBook.length;i++){
			price+=(data[selectedBook[i]].priceStandard)*($(".sale-count").eq(selectedBook[i]).val());
			count+=Number($(".sale-count").eq(selectedBook[i]).val());
		}
		Goods.total=(price*(100-${grade.gr_discount}))/100;
		let str=`
			<tr>
				<td>총 상품가격:</td>
				<td>\${priceToString(price)}</td>
			</tr>
			<tr>
				<td>총 주문 상품수:</td>
				<td>\${count}개</td>
			</tr>
			<tr>
				<td>할인된 가격:</td>
				<td>\${priceToString(Goods.total)}</td>
			</tr>
		`;
		$(".total-sale > tbody").html(str);
	}
	displaySeleView();
	</script>
	<!-- 날짜 -->
	<script type="text/javascript">
	function toStringFormatting(source){
	      var  date = new Date(source);
	      const year = date.getFullYear();
	      const month = leftPad(date.getMonth() + 1);
	      const day = leftPad(date.getDate());
	      const hours = ('0' + date.getHours()).slice(-2); 
	      const minutes = ('0' + date.getMinutes()).slice(-2);
	      return year+""+month+""+day+""+hours+""+minutes;
		}
		
	
		function leftPad(value){
			if (Number(value) >= 10) {
				return value;
			}
			return "0" + value;
		}
	</script>
</body>