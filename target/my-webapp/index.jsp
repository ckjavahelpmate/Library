<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Library APP</title>

<%@ include file="includes/header.jsp"%>
<%
	session.removeAttribute("profile");
%>
<%@ include file="includes/nav.jsp"%>

</head>
<body
	style="background-image: url('./images/library-01.png'); background-repeat: no-repeat; background-size: cover;">
	<%@ include file="/includes/footer.jsp"%>
</body>
</html>	