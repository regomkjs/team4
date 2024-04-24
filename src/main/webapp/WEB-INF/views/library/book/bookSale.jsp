<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<body>
	<div class="container mt-5">
		<div class="list">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th><input type="checkbox" class="allChkBtn"/></th>
						<th colspan="2">상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
				<tfoot>
					<tr>
						<td colspan="6" class="total-sale">				
							
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div>

			<button id="money-btn">선택한 상품 구매</button>
		</div>
	</div>
	<!-- 장바구니 -->
	<script type="text/javascript">
		let data=JSON.parse(localStorage.getItem('basket'));
		console.log(data);
		
		displayView();
		function displayView() {
			let str="";
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
					<td>\${book.priceStandard}원</td>
					<td>
						<select class="sale-count">
							<c:forEach begin="1" var="i" end="10">
								<option value='${i}'>${i}</option>
							</c:forEach>
						</select>
					</td>
					<td><button>삭제</button></td>
				</tr>
				`;
				n++;
			}
			$(".table>tbody").html(str);
		}
	</script>
	<!-- 결제? -->
	<script type="text/javascript">
		var IMP = window.IMP;
		IMP.init("${imp}");   /* imp~ : 가맹점 식별코드*/
		
		$('#money-btn').click(function() {
			IMP.request_pay({
				pg: "html5_inicis",		//KG이니시스 pg파라미터 값
                pay_method: "card",		//결제 방법
                merchant_uid: "1234578",//주문번호
                name: "당근 10kg",		//상품 명
                amount: 200,			//금액
                //주문자 정보
   				buyer_email: "gildong@gmail.com",
   				buyer_name: "이길영",
   				buyer_tel: "010-4242-4242",
   				//buyer_addr: "서울특별시 강남구 신사동",
   				//buyer_postcode: "01181"
			}, function(rsp) {
				console.log(rsp);
		
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
		}
		displaySeleView();
	});
	
	</script>
	<!-- 판매 계산 -->
	<script type="text/javascript">
	function displaySeleView() {
		//data total-sale
		//selectedBook
		let price=0;
		let total=0;
		for(let i=0;i<selectedBook.length;i++){
			price+=(data[selectedBook[i]].priceStandard)*($(".sale-count").eq(selectedBook[i]).val());
			total+=Number($(".sale-count").eq(selectedBook[i]).val());
		}
		
		let sale=(price*(100-${grade.gr_discount}))/100;
		let str=`
			<tr>
				<td>총 상품가격:</td>
				<td>\${price}</td>
			</tr>
			<tr>
				<td>총 주문 상품수:</td>
				<td>\${total}</td>
			</tr>
			<tr>
				<td>할인된 가격:</td>
				<td>\${sale}</td>
			</tr>
		`;
		$(".total-sale").html(str);
	}
	</script>
</body>