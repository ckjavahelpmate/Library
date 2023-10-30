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

@WebServlet("/user-login")
public class UserLogin extends HttpServlet 
{

	private static final long serialVersionUID = 1L;
	Connection connection;
	PreparedStatement preparedStatement;
	String query;
	ResultSet resultSet;
	RequestDispatcher dispatcher;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		RequestDispatcher dispatcher = null ;
		HttpSession session = req.getSession();
		String email = req.getParameter("login-email");
		String password = req.getParameter("login-password");
		
		
		ServletContext context = getServletContext() ;
		String driverPath = context.getInitParameter("driverpath");
		String url = context.getInitParameter("url");
		String dbusername = context.getInitParameter("username");
		String dbpassword = context.getInitParameter("password");
		try 
		{
			connection = DbConnection.getConnection(driverPath, url, dbusername, dbpassword);
			if( connection != null )
			{
				query = "select * from users where email=? && password=?" ;
				preparedStatement = connection.prepareStatement(query) ;
				preparedStatement.setString(1, email);
				preparedStatement.setString(2, password);
				resultSet = preparedStatement.executeQuery();
				if( resultSet.next() )
				{
					session.setAttribute("profile", resultSet.getString("name") );
					session.setAttribute("profile-id", resultSet.getString("id") );
					dispatcher = req.getRequestDispatcher("home-display-books");
					dispatcher.forward(req, resp);
				}
				else
				{
					req.setAttribute("failure", "Invalid Email address or password");
					dispatcher = req.getRequestDispatcher("login.jsp");
					dispatcher.include(req, resp);
				}

			}
			else
			{
				dispatcher = req.getRequestDispatcher("exception.jsp");
				dispatcher.forward(req, resp);
			}


		} catch (Exception e) 
		{
			session.setAttribute("e", e);
			dispatcher = req.getRequestDispatcher("exception.jsp");
			dispatcher.forward(req, resp);
		}
	}

}
