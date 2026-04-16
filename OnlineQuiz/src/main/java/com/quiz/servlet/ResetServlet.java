package com.quiz.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.quiz.db.DBConnection;

@WebServlet("/reset")
public class ResetServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();

            // ✅ CLEAR ALL RESULTS
            stmt.executeUpdate("DELETE FROM result");

            // ✅ OPTIONAL: RESET AUTO INCREMENT
            stmt.executeUpdate("ALTER TABLE result AUTO_INCREMENT = 1");

            response.sendRedirect("admin.jsp?reset=success");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}