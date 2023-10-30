package com.library.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection
{
	private static Connection connection ;

	public static Connection getConnection( String driverPath, String url, String username, String password) 
	{
		try 
		{
			Class.forName(driverPath);
			if( connection == null )
			{
				connection = DriverManager.getConnection(url, username, password);
			}
		} 
		catch (ClassNotFoundException | SQLException e) 
		{
			return connection ;
		}
		return connection;
	}
}
