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
<body>
	<%
	if (request.getAttribute("failure") != null) {
	%>
	<h4 style="color: red; text-align: center; margin-top: 30px"> <%= request.getAttribute("failure") %> </h4>
	<%
	}
	%>
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">User Login</div>
			<div class="card-body">
				<form action="user-login" method="post" class="">
					<div class="form-group">
						<div class="row d:flex justify-content-end">

							<div class="col-3">
								<label>Email Address</label>
							</div>
							<div class="col-9">
								<input type="email" class="form-group" name="login-email"
									placeholder="Enter Your Email" required="required" />
							</div>


						</div>


					</div>
					<div class="form-group">
						<div class="row d:flex justify-content-end mt-4">

							<div class="col-3">
								<label>Password</label>

							</div>
							<div class="col-9">
								<input type="password" class="form-group" name="login-password"
									placeholder="**********" required="required">

							</div>


						</div>


					</div>

					<div class="form-group col-7 mt-4 text-center border border-0">
						<button type="submit" class="btn btn-primary"
							style="margin-left: 20px">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>




	<%@ include file="/includes/footer.jsp"%>
</body>
</html>