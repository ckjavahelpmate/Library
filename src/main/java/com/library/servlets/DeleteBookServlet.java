package com.library.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.library.utility.DbConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/delete-book")
public class DeleteBookServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	Connection connection;
	PreparedStatement preparedStatement;
	String query;
	ResultSet resultSet;
	RequestDispatcher dispatcher;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		HttpSession session = req.getSession();
		if( session.getAttribute("profile") == null )
		{
			resp.sendRedirect("index.jsp");
		}
		resp.setContentType("text/html");
		ServletContext context = getServletContext() ;
		String driverPath = context.getInitParameter("driverpath");
		String url = context.getInitParameter("url");
		String username = context.getInitParameter("username");
		String password = context.getInitParameter("password");
		int id = Integer.parseInt(req.getParameter("id"));
		
		req.setAttribute("pageno", req.getParameter("pageno"));

		try
		{
			connection = DbConnection.getConnection(driverPath, url, username, password);
			if( connection != null )
			{
				query = "delete from books where id=?" ;
				preparedStatement = connection.prepareStatement(query) ;
				preparedStatement.setInt(1, id);
				int row = preparedStatement.executeUpdate();
				if( row == 0 )
				{
					dispatcher = req.getRequestDispatcher("exception.jsp");
					dispatcher.forward(req, resp);
				}
				else
				{
					String target = req.getParameter("target");
					if( target != null && target.equals("home-display-books"))
					{
						dispatcher = req.getRequestDispatcher("home-display-books");
						dispatcher.forward(req, resp);
					}
					else
					{
						dispatcher = req.getRequestDispatcher("display-books");
						dispatcher.forward(req, resp);
					}
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
