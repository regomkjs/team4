<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.basket{position: relative;}
.basket-box{position:absolute; background-color: #fff; width: 250px; min-height: 100px; font-size: 14px; z-index: 10;
display: none; border: 2px solid #333;}
.basket-box li{ box-sizing: border-box; padding: 0px 5px; line-height: 30px;}
.basket-box .bbn{display: inline-block; max-width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
height: 30px;}
.basket-box .bbc{width: 30px;}
.basket:hover .basket-box{
	display: block;
}
.center{text-align: center; margin-top: 30px;}
</style>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<!-- Brand/logo -->
	<a class="navbar-brand" href="<c:url value="/library"/>">
		<img src="<c:url value="/resources/img/bird.jpg"/>" alt="logo" style="width:40px;">
	</a>
	
	<!-- Links -->
	<ul class="navbar-nav">
		<li class="nav-item">
			<a class="nav-link" href="<c:url value="/"/>">메인</a>
		</li>
		<c:if test="${user == null}" >
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/signup"/>">회원가입</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/login"/>">로그인</a>
			</li>
		</c:if>
		<c:if test="${user != null}">
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/logout"/>">로그아웃</a>
			</li>
		</c:if>
		<c:if test="${user != null}" >
			<li class="nav-item dropdown">
		      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
		        마이페이지
		      </a>
		      <div class="dropdown-menu">
		      	<a class="dropdown-item" href="<c:url value="/library/order/list"/>">주문내역</a>
		      	<c:if test='${user.me_mr_name == "마스터"}' >
		      		 <a class="dropdown-item" href="<c:url value="/library/management/order"/>">주문관리</a>
		      	</c:if>
		      </div>
	    	</li>
    	</c:if>
    	<li class="nav-item basket">
			<a class="nav-link" href="<c:url value="/library/book/sale"/>">장바구니</a>
		</li>
	</ul>
</nav>
<!-- 구매,장바구니 -->
<script type="text/javascript">
	let basket=[];
	let nick=${user.me_nick!=null}?"${user.me_nick}":"guest";
	let data=JSON.parse(localStorage.getItem(nick));
	if(data!=null){
		basket=data;
		console.log(basket);
	}
	$(document).on("click",".basket-btn",function(){
		let isbn=$(this).data("isbn");
		for(let i=0;i<basket.length;i++){
			if(basket[i].isbn13==isbn){
				return;
			}
		}
		for(let i=0;i<books.length;i++){
			if(books[i].isbn13==isbn){
				basket.push(books[i]);
			}
		}
		displayBasketView();
		let basketJson=JSON.stringify(basket);
		localStorage.setItem(nick,basketJson);
	});
	
	$(document).on("click",".purchase-btn",function(){
		let isbn=$(this).data("isbn");
		for(let i=0;i<basket.length;i++){
			if(basket[i].isbn13==isbn){
				let basketJson=JSON.stringify(basket);
				localStorage.setItem(nick,basketJson);
				location.href = '<c:url value="/library/book/sale" />';
				return;
			}
		}
		for(let i=0;i<books.length;i++){
			if(books[i].isbn13==isbn){
				basket.push(books[i]);
			}
		}
		let basketJson=JSON.stringify(basket);
		localStorage.setItem(nick,basketJson);
		location.href = '<c:url value="/library/book/sale" />';	
	});
	
	
	function displayBasketView() {
		let i=0;
		let str=`
			<a class="nav-link" href="<c:url value="/library/book/sale"/>">장바구니(\${basket.length})</a>
			<div class="basket-box"><ul>
			`;
			if(basket.length==0){
				str+=`
					<li class="center">장바구니에 담은 상품이 없습니다</li>
				`;
			}else{
				for(baskets of basket){
					
					str+=`
						<li class="cf"><div class="bbn left">\${baskets.title}</div> 
						<div class="bbc right">
							<button type="button" data-index="\${i}" class="close">&times;</button>
						</div></li>
					`;
					i++;
				}
			}
		str+=`</ul></div>`;
		$(".basket").html(str);
	}
	displayBasketView();
	
	$(document).on("click",".close",function(){
		let index=$(this).data("index");
		basket.splice(index,1);
		displayBasketView();
		let basketJson=JSON.stringify(basket);
		localStorage.setItem(nick,basketJson);
	});
</script>
<!-- 가격 표시 -->
<script type="text/javascript">
function priceToString(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"원";
}
</script>