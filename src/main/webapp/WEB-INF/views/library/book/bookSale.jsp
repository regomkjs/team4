<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<body>
	<div class="container mt-5">
		<div class="list">
		    <table class="table table-bordered">
		    	<thead>
		        	<tr>
			          	<th><input type="checkbox"></th>
			          	<th colspan="2">상품명</th>
			          	<th>가격</th>
			          	<th>수량</th>
		        	</tr>
		      	</thead>
		      	<tbody>
		      
		   	  	</tbody>
		    </table>
		</div>
		<div>
			<button>선택한 상품 구매</button>
		</div>
	</div>
	<script type="text/javascript">
		let data=JSON.parse(localStorage.getItem('basket'));
		console.log(data);
		displayView();
		function displayView() {
			let str="";
			for(book of data){
				str+=`
				<tr>
					<td>
						<input type="checkbox">
					</td>
					<td>
						<img alt="\${book.title}" src="\${book.cover}">
					</td>
					<td>\${book.title}</td>
					<td>\${book.priceSales}원</td>
					<td><input type="number" value="1"></td>
				</tr>
				`;
			}
			$(".table>tbody").html(str);
		}
	</script>
</body>