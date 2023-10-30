<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Library App</title>
<%
if (session.getAttribute("profile") == null) {

	response.sendRedirect("index.jsp");
}
%>

<%@ include file="./includes/header.jsp"%>
<%@ include file="./includes/nav.jsp"%>
</head>
<body>


	<%
	if (session.getAttribute("e") == null) {
	%>

	<div
		style="background-image: url('./images/something-went-wrong.webp'); background-size: 100% 100%; background-repeat: no-repeat; height: 70vh">


	</div>
	<%
	} else {
	%>
	<div
		style="background-image: url('./images/something-went-wrong.webp'); background-size: 100% 100%; background-repeat: no-repeat; height: 70vh">


	</div>
	<h1 style="color: red; text-align: center;"><%=((Exception) session.getAttribute("e")).getClass().getSimpleName()%></h1>
	<h4 style="color: maroon;; text-align: center;">
		Reason ::
		<%=((Exception) session.getAttribute("e")).getMessage()%></h4>
	<%
	}
	%>

	<%@ include file="./includes/footer.jsp"%>
</body>
</html>