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

@WebServlet("/display-books")
public class DisplayServlet extends HttpServlet {

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
		
		int userid = Integer.parseInt((String)session.getAttribute("profile-id"));
		
		int start = 0 , countPerPage = 5 ;
		
		int pagno = req.getParameter("pageno") == null ? 0 : Integer.parseInt(req.getParameter("pageno")) ;
		start = countPerPage* pagno ;
		req.setAttribute("start", start);
		req.setAttribute("countPerPage", countPerPage);

		try
		{
			connection = DbConnection.getConnection(driverPath, url, username, password);
			if( connection != null )
			{
				query = "select * from books where userid=? limit ?,?" ;
				preparedStatement = connection.prepareStatement(query) ;
				preparedStatement.setInt(1, userid) ;
				preparedStatement.setInt(2, start) ;
				preparedStatement.setInt(3, countPerPage) ;
				resultSet = preparedStatement.executeQuery();
				session.setAttribute("books", resultSet ) ;
				
				connection = DbConnection.getConnection(driverPath, url, username, password);
				query = "select count(*) from books where userid = ?" ;
				preparedStatement = connection.prepareStatement(query) ;
				preparedStatement.setInt(1, userid) ;
				resultSet = preparedStatement.executeQuery();
				session.setAttribute("count", resultSet ) ;
				req.setAttribute("servlet", "display-books" ) ;
				
				dispatcher = req.getRequestDispatcher("displaybooks.jsp");
				dispatcher.forward(req, resp);

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
