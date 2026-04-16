package com.quiz.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {

        Connection con = null;

        try {
            // Load Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create Connection
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3307/quiz_db",
                "root",
                "root123"
            );

            System.out.println("DB Connected!");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}