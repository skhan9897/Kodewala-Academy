package com.kodewala.academy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection connection = null;

    // Database Credentials for Clever Cloud
    // Note: Replace [HOST], [USER], and [PASSWORD] with actual details from your Clever Cloud Dashboard
    private static final String HOST = "YOUR_CLEVER_CLOUD_HOST"; // e.g., bxxxx.stackhero-network.com
    private static final String DB_NAME = "kodwalaAcademy-db";
    private static final String USER = "YOUR_CLEVER_CLOUD_USER";
    private static final String PASSWORD = "YOUR_CLEVER_CLOUD_PASSWORD";
    private static final String PORT = "3306"; 

    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME + "?useSSL=true&serverTimezone=UTC";

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                // Load MySQL Driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Establish Connection
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Database Connected Successfully!");
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Database Connection Error: " + e.getMessage());
            e.printStackTrace();
        }
        return connection;
    }
    
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
