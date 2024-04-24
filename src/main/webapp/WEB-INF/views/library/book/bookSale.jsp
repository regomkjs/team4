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
						<th><input type="checkbox" class="allChkBtn" /></th>
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
						<td colspan="6" class="total-sale"></td>
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
   				custom_data:data
			}, function(rsp) {
				if (rsp.success) {
					$.ajax({
						async : true,
						url : '<c:url value="/library/sale/insert"/>', 
						type : 'post', 
						data : {uid:rsp.merchant_uid}, 
						dataType : "json", 
						success : function (data){
							if(data.res){
								alert("결제가 되었습니다.");
							}else{
								alert("결제에 실패하였습니다.");
							}
						}, 
						error : function(jqXHR, textStatus, errorThrown){

						}
					});
                } else {
                    alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                }
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
	
	</script>
	<!-- 판매 계산 -->
	<script type="text/javascript">
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
				<td>\${price}</td>
			</tr>
			<tr>
				<td>총 주문 상품수:</td>
				<td>\${count}</td>
			</tr>
			<tr>
				<td>할인된 가격:</td>
				<td>\${Goods.total}</td>
			</tr>
		`;
		$(".total-sale").html(str);
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