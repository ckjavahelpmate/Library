<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.library.utility.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<%
if (session.getAttribute("profile") == null) {

	response.sendRedirect("index.jsp");
}
%>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/nav.jsp"%>
<style type="text/css">
th, td {
	font-size: 18px;
}
</style>
</head>
<body
	style="background-image: url('./images/profile-background-image.jpg'); background-repeat: no-repeat; background-size: cover;">

	<div class="container">
		<%
		ServletContext context = getServletContext();
		String driverPath = context.getInitParameter("driverpath");
		String url = context.getInitParameter("url");
		String username = context.getInitParameter("username");
		String password = context.getInitParameter("password");
		RequestDispatcher dispatcher = null;
		
		String profile = (String)session.getAttribute("profile");
		ResultSet rs = null;
		try {
			Connection connection = DbConnection.getConnection(driverPath, url, username, password);
			if (connection != null) {
				String query = "select * from users where name = ?";
				PreparedStatement preparedStatement = connection.prepareStatement(query);
				preparedStatement.setString(1, profile);
				rs = preparedStatement.executeQuery();
				
				rs.next();
		%>
		<table class="table table-striped">
			<tr>
				<th>Id ::</th>
				<td><%=rs.getInt("id")%></td>
			</tr>
			<tr>
				<th>Name ::</th>
				<td><%=rs.getString("name")%></td>
			</tr>
			<tr>
				<th>Email ::</th>
				<td><%=rs.getString("email")%></td>
			</tr>
			<tr>
				<th>Mobile ::</th>
				<td><%=rs.getString("phone")%></td>
			</tr>
			<tr>
				<th>Address ::</th>
				<td><%=rs.getString("address")%></td>
			</tr>
			<tr>
				<th>Photo ::</th>
				<td><img alt="<%=rs.getString("name")%>>"
					src="./images/profile.png" style="border-radius: 50%"></td>
			</tr>

		</table>
		<%
		} else {
		dispatcher = request.getRequestDispatcher("exception.jsp");
		dispatcher.forward(request, response);
		}

		} catch (Exception e) {
		session.setAttribute("e", e);
		dispatcher = request.getRequestDispatcher("exception.jsp");
		dispatcher.forward(request, response);
		}
		%>




	</div>

	<%@ include file="./includes/footer.jsp"%>
</body>
</html>