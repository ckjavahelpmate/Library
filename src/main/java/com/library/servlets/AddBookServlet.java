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

@WebServlet("/add-book")
public class AddBookServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	Connection connection ;
	PreparedStatement preparedStatement ;
	String query ;
	int row ;
	RequestDispatcher dispatcher ;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		resp.setContentType("text/html");
		ServletContext context = getServletContext() ;
		String driverPath = context.getInitParameter("driverpath");
		String url = context.getInitParameter("url");
		String username = context.getInitParameter("username");
		String password = context.getInitParameter("password");
		HttpSession session = req.getSession() ;

		int id = Integer.parseInt(req.getParameter("book-id"));
		String name = req.getParameter("book-name");
		String author = req.getParameter("book-author");
		double price = Double.parseDouble(req.getParameter("book-price"));
		int userid = Integer.parseInt((String)session.getAttribute("profile-id"));

		try
		{
			connection = DbConnection.getConnection(driverPath, url, username, password);
			if( connection != null )
			{
				query = "Insert into books values( ?, ?, ?, ?,? )" ;
				preparedStatement = connection.prepareStatement(query) ;
				preparedStatement.setInt(1, id);
				preparedStatement.setString(2, name);
				preparedStatement.setString(3, author);
				preparedStatement.setDouble(4, price);
				preparedStatement.setInt(5, userid);
				row = preparedStatement.executeUpdate();
				
				if( row == 0 )
				{
					req.setAttribute("failure", "Book not Added") ;
					dispatcher = req.getRequestDispatcher("home-display-books");
					dispatcher.include(req, resp);
					
				}
				else
				{
					req.setAttribute("success", "success") ;
					dispatcher = req.getRequestDispatcher("home-display-books");
					dispatcher.include(req, resp);
				}
			}
			else
			{
				dispatcher = req.getRequestDispatcher("exception.jsp");
				dispatcher.forward(req, resp);
			}
			
		}
		catch (Exception e) 
		{
			session.setAttribute("e", e);
			dispatcher = req.getRequestDispatcher("exception.jsp");
			dispatcher.forward(req, resp);
		}

	}



}
