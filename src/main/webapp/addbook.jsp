<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Book</title>
<%
if (session.getAttribute("profile") == null) {
	
	response.sendRedirect("index.jsp");
}
%>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/nav.jsp"%>
<style type="text/css">
.form-label {
	font-size: 18px;
}
#input{
height: 60px;

}
</style>
</head>
<body
	style="background-image: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzssslG5pkcOuO7vTkd9b-ujFPD_PsgQJIpg&amp;usqp=CAU'); background-repeat: no-repeat; background-size: cover;">


	<div class="container">
		<div class="row align-items-center ">

			<form action="add-book" method="post">
				<div class="col-md-6 offset-md-3 mt-5 ">
					<label for="inputEmail4" class="form-label">Book id</label> <input
						type="number" class="form-control" placeholder="Enter Book id" id="input"
						name="book-id" required="required">
				</div>
				<div class="col-md-6 offset-md-3 mt-4">
					<label for="inputAddress" class="form-label">Book Name</label> <input
						type="text" class="form-control" name="book-name" id="input" required="required"
						placeholder="Enter Book name">
				</div>
				<div class="col-md-6 offset-md-3 mt-4">
					<label for="inputAddress2" class="form-label">Book Author</label> <input id="input" required="required"
						type="text" class="form-control" name="book-author"
						placeholder="Enter Book Author name">
				</div>
				<div class="col-md-6 offset-md-3 mt-4">
					<label for="inputCity" class="form-label">Book Price</label> <input id="input" required="required"
						type="number" class="form-control" placeholder="Enter Book Price"
						name="book-price">
				</div>

				<div class="col-md-6 offset-md-5 mt-5">
					<button type="submit" class="btn btn-primary">Add Book</button>
				</div>
			</form>

		</div>

	</div>



	<%@ include file="./includes/footer.jsp"%>

</body>
</html>