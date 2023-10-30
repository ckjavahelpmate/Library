
<nav
	class="navbar navbar-expand-lg navbar-light bg-light border  navbar navbar-dark bg-dark">

	<%
	if (session.getAttribute("profile") == null) {
	%>
	<h1>
		<a class="navbar-brand d-flex justify-content-center" href="index.jsp">
			<b>Library App </b>
		</a>
	</h1>
	<%
	} else {
	%>
	<h4 class="navbar-brand ">Library App </h4>
	<a class="btn btn-success  border rounded-circle" role="button"
		href="profile.jsp"><%=session.getAttribute("profile")%> </a>

	<%
	}
	%>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse justify-content-end"
		id="navbarSupportedContent">
		<ul class="navbar-nav ml-auto">

			<%
			if (session.getAttribute("profile") == null) {
			%>
			<li class="nav-item">
				<h4>
					<a class="nav-link" href="index.jsp">Home</a>
				</h4>
			</li>
			<li class="nav-item">
				<h4>
					<a class="nav-link" href="login.jsp">Login</a>
				</h4>
			</li>
			<%
			} else {
			%>
			<li class="nav-item">
				<h4>
					<a class="nav-link" href="home-display-books">Home</a>
				</h4>
			</li>
			<li class="nav-item active"><h4>
					<a class="nav-link" href="addbook.jsp">Add </a>
				</h4></li>
			<li class="nav-item">
				<h4>
					<a class="nav-link" href="display-books">List</a>
				</h4>
			</li>
			<li class="nav-item">
				<h4>
					<a class="nav-link" href="logout.jsp">Logout</a>
				</h4>
			</li>
		</ul>
		<form class="d-flex" action="home-search-book" method="post">
			<input class="form-control me-2" type="search"
				placeholder="Enter Book name" name="search" aria-label="Search">
			<button class="btn btn-outline-success" type="submit">Search</button>
		</form>
		<%
		}
		%>

	</div>


</nav>