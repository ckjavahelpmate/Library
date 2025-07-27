<%@page import="java.sql.ResultSet"%>
<%@page
	import="jakarta.security.auth.message.callback.PrivateKeyCallback.Request"%>
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

#input {
	height: 60px;
}
</style>
</head>
<body
	style="background-image: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzssslG5pkcOuO7vTkd9b-ujFPD_PsgQJIpg&amp;usqp=CAU'); background-repeat: no-repeat; background-size: cover;">
	<%
	ResultSet rs = (ResultSet) session.getAttribute("books");
	if (rs.next()) {
	%>

	<div class="container">
		<div class="row align-items-center ">

			<form action="update-book" method="post">
				<div class="col-md-6 offset-md-3 mt-5 ">
					<label for="inputEmail4" class="form-label">Book id</label> <input
						type="number" class="form-control" value="<%=rs.getInt("id")%>" id="input"
						name="book-id" readonly="readonly">
				</div>
				<div class="col-md-6 offset-md-3 mt-4">
					<label for="inputAddress" class="form-label">Book Name</label> <input
						type="text" class="form-control" name="book-name" id="input"
						value="<%=rs.getString("name")%>">
				</div>
				<div class="col-md-6 offset-md-3 mt-4">
					<label for="inputAddress2" class="form-label">Book Author</label> <input
						id="input" type="text" class="form-control" name="book-author"
						value="<%= rs.getString("author")%>">
				</div>
				<div class="col-md-6 offset-md-3 mt-4">
					<label for="inputCity" class="form-label">Book Price</label> <input
						id="input" type="number" class="form-control" value="<%= rs.getDouble("price")%>"
						name="book-price">
				</div>

				<div class="col-md-6 offset-md-5 mt-5">
					<button type="submit" class="btn btn-primary">Update Book</button>
				</div>
			</form>

		</div>

	</div>

	<%
	}
	%>

	<%@ include file="./includes/footer.jsp"%>

</body>
</html>