package com.quiz.servlet;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.quiz.db.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE username=? AND password=?"
            );

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();
                session.setAttribute("user", username);

                // ✅ COOKIE
                Cookie cookie = new Cookie("username", username);
                cookie.setMaxAge(3600);
                response.addCookie(cookie);

                if (username.equals("admin")) {
                    response.sendRedirect("admin.jsp");
                } else {
                    response.sendRedirect("quiz.jsp");
                }

            } else {
                response.getWriter().println("<h3>Invalid Login ❌</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}