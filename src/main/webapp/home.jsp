<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Library Home</title>

<%
if (session.getAttribute("profile") == null) {

	response.sendRedirect("index.jsp");
}
int start = (int) request.getAttribute("start");
int countPerPage = (int) request.getAttribute("countPerPage");
%>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/nav.jsp"%>
<style type="text/css">
</style>
</head>
<body style="background-color: gray;">

	<%
	if (request.getAttribute("failure") != null) {
	%>
	<h4 style="color: red; text-align: center; margin-top: 30px">
		<%=request.getAttribute("failure")%>

	</h4>

	<%
	}
	%>

	<div class="d-flex justify-content-center mt-2">


		<video width="30%" autoplay="autoplay">
			<source src="./videos/The Joy of Books.mp4" type="video/mp4">
			<source src="./videos/The Joy of Books.ogg" type="video/ogg">
		</video>

	</div>

	<div align="center">
		<%
		ResultSet rs = (ResultSet) session.getAttribute("books");
		int total = 0;
		boolean b = rs.next();
		if (b) {
		%>
		<div class="row">

			<%
			int j = 1;
			while (b) {
			%>

			<div class="col my-3">
				<div class="card w-80 " style="width: 20em; height: 20em">
					<img class="card-img-top mt-2" height="150px" alt="card image cop"
						src="./images/book.jpg">
					<div class="card-body">
						<h4 class="category">
							Price ::
							<%=rs.getDouble("price")%>
							rs.
						</h4>
						<h6 class="price">
							Book-Name ::
							<%=rs.getString("name")%></h6>

						<h6 class="category">
							Author ::
							<%=rs.getString("author")%></h6>

						<div class="mt-3 d-flex justify-content-between">
							<a href="edit-book?id=<%=rs.getInt("id")%>&target=home-display-books&pageno=<%=start/countPerPage%>"
								class="btn btn-success">Edit</a> <a
								href="delete-book?id=<%=rs.getInt("id")%>&target=home-display-books&pageno=<%=start/countPerPage%>" 
								class="btn btn-danger">delete</a>
						</div>

					</div>



				</div>
			</div>
			<%
			b = rs.next();
			}

			ResultSet rscount = (ResultSet) session.getAttribute("count");
			if (rscount.next()) {
			total = rscount.getInt(1);
			}
			%>
		</div>
		<span style="float: left;"><a style="margin-left: 40px"
			href="<%=request.getAttribute("servlet")%>?pageno=<%=start / countPerPage - 1%>"
			class="btn btn-dark  border rounded-circle <%=(start == 0) ? "disabled" : ""%> ">Previous</a></span><span
			style="float: right;"><a style="margin-right: 40px"
			href="<%=request.getAttribute("servlet")%>?pageno=<%=start / countPerPage + 1%>"
			class="btn btn-dark border rounded-circle <%=(start + countPerPage > total) ? "disabled" : ""%> ">Next</a></span>
		<div class="row">

			<div class="col my-3 mt-1">

				<%
				for (int i = 0; i <= total / 4; i++) {
				%>
				<a href="<%=request.getAttribute("servlet")%>?pageno=<%=i%>"
					class="btn btn-primary"><%=i + 1%> </a>
				<%
				}
				%>
			</div>


		</div>
		<%
		} else {
		%>
		<div class="row">
			<h2 style="color: orange; text-align: center; margin-top: 30px">
				Book With name "<%=session.getAttribute("name")%>" is
			</h2>
			<div>
				<img alt="" src="./images/notavailable.jpg"
					style="border-radius: 50%">
			</div>

		</div>
		<%
		}
		%>
	</div>

	<h1 id="msg" style="display: none;"><%=session.getAttribute("profile")%></h1>
	<h1 id="success" style="display: none;"><%=request.getAttribute("success")%></h1>

	<%@ include file="./includes/footer.jsp"%>



	<script async="false">
		var msg = document.getElementById("msg").textContent
		var str = document.getElementById("success").textContent
		
		if ( str !== "null"  ) {
			window.onload = function() {
				window.alert("Book is Added to " + msg + " database" );
			}
		}
	</script>
</body>
</html>