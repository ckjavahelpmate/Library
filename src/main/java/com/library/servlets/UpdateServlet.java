package com.library.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.library.utility.DbConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update-book")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection connection;
	PreparedStatement preparedStatement;
	String query;
	int row;
	RequestDispatcher dispatcher;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		ServletContext context = getServletContext();
		String driverPath = context.getInitParameter("driverpath");
		String url = context.getInitParameter("url");
		String username = context.getInitParameter("username");
		String password = context.getInitParameter("password");
		HttpSession session = req.getSession();

		int id = Integer.parseInt(req.getParameter("book-id"));
		String name = req.getParameter("book-name");
		String author = req.getParameter("book-author");
		double price = Double.parseDouble(req.getParameter("book-price"));
		
		String pageno = (String) session.getAttribute("pageno");
		session.removeAttribute(pageno);

		try {
			connection = DbConnection.getConnection(driverPath, url, username, password);
			if (connection != null) {
				query = "Update books set name = ? , author = ? , price = ? where  id = ?";
				preparedStatement = connection.prepareStatement(query);
				preparedStatement.setString(1, name);
				preparedStatement.setString(2, author);
				preparedStatement.setDouble(3, price);
				preparedStatement.setInt(4, id);
				row = preparedStatement.executeUpdate();

				if (row == 0) {
					dispatcher = req.getRequestDispatcher("exception.jsp");
					dispatcher.forward(req, resp);
				} else {
					String target = (String) session.getAttribute("target");
	
					if (target != null && target.equals("home-display-books")) {
						session.removeAttribute(target);
						dispatcher = req.getRequestDispatcher("home-display-books?pageno="+pageno);
						dispatcher.forward(req, resp);
					} else {
						session.removeAttribute(target);
						dispatcher = req.getRequestDispatcher("display-books?pageno="+pageno);
						dispatcher.forward(req, resp);
					}
					
				}
			} else {
				dispatcher = req.getRequestDispatcher("exception.jsp");
				dispatcher.forward(req, resp);
			}

		} catch (Exception e) {
			session.setAttribute("e", e);
			dispatcher = req.getRequestDispatcher("exception.jsp");
			dispatcher.forward(req, resp);
		}

	}

}
