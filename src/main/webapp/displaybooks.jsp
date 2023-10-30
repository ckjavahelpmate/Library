<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Books List</title>
<%
if (session.getAttribute("profile") == null) {

	response.sendRedirect("index.jsp");
}
int start = (int) request.getAttribute("start");
int countPerPage = (int) request.getAttribute("countPerPage");

%>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/nav.jsp"%>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<style type="text/css">
th {
	font-size: 25px;
}

td {
	font-size: 20px;
}

tr {
	height: 85px;
}
</style>
</head>
<body
	style="background-image: url('./images/profile-background-image.jpg'); background-repeat: no-repeat; background-size: cover;">


	<div class="container">
	<% int total = 0 ; %>
		<table class="table table-striped">
			<tr>
				<th>#</th>
				<th>Book id</th>
				<th>Book name</th>
				<th>Author name</th>
				<th>Book Price</th>
				<th>Edit</th>
				<th>Delete</th>
			</tr>
			<%
			ResultSet rs = (ResultSet) session.getAttribute("books");

			boolean b = rs.next();
			if (b) {
				int j = start+1 ;
				while (b) {
			%>

			<tr>
				<td><%=j++%></td>
				<td><%=rs.getInt("id")%></td>
				<td><%=rs.getString("name")%></td>
				<td><%=rs.getString("author")%></td>
				<td><%=rs.getDouble("price")%></td>
				<td><a  class="btn btn-success"
					href="edit-book?id=<%=rs.getInt("id")%>&target=display-books&pageno=<%=start/countPerPage%>">Edit</a></td>
				<td><a  class="btn btn-danger"
					href="delete-book?id=<%=rs.getInt("id")%>&target=display-books&pageno=<%=start/countPerPage%>">Delete</a></td>
			</tr>


			<%
			b = rs.next();
			}
			ResultSet rscount = (ResultSet) session.getAttribute("count");
			if (rscount.next()) {
			 total = rscount.getInt(1);
			%>
			<tr>
				<th colspan="7"><table style="width: 100%">
						<tr>
							<%
							for (int i = 0; i <= total / 5; i++) {
							%>
							<th><a
								href="<%=request.getAttribute("servlet")%>?pageno=<%=i%>"
								class="btn btn-primary"><%=i + 1%> </a></th>
							<%
							}
							%>

						</tr>
					</table></th>
			</tr>
			<%
			}
			} else {
			%>
			<%-- <tr>
				<td colspan="2"></td>
				<td colspan="3">
					<h4 style="color: red; text-align: center; margin-top: 30px">
						Book With name "<%=session.getAttribute("name")%>" is
					</h4>
				</td>
				<td colspan="2"></td>
			</tr> --%>
			<tr>
				<td colspan="3"></td>
				<td colspan="4"><img alt="" src="./images/notavailable.jpg"
					style="border-radius: 50%"></td>
			</tr>
			<%
			}
			%>
		</table>

		<span style="float: left;"><a
			href="<%=request.getAttribute("servlet")%>?pageno=<%=start/countPerPage-1 %>"
			class="btn btn-dark <%= (start==0) ? "disabled" : "" %> ">Previous</a></span>
		<span style="float: right; "><a
			href="<%=request.getAttribute("servlet")%>?pageno=<%=start/countPerPage+1 %>"
			class="btn btn-dark <%= (start+countPerPage > total) ? "disabled" : "" %> ">Next</a></span>
	</div>

	<%@ include file="./includes/footer.jsp"%>
</body>
</html>










