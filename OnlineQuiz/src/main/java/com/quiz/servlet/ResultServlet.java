package com.quiz.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.quiz.db.DBConnection;

@WebServlet("/result")
public class ResultServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String user = (String) session.getAttribute("user");

        int score = 0;
        int i = 1;

        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM questions");

            StringBuilder report = new StringBuilder();
            report.append("<table border='1' style='margin:auto;'>");
            report.append("<tr><th>Question</th><th>Status</th></tr>");

            while (rs.next()) {
                String correct = rs.getString("correct_answer");
                String userAns = request.getParameter("q" + i);

                if (correct.equals(userAns)) {
                    score++;
                    report.append("<tr><td>Q" + i + "</td><td>Correct </td></tr>");
                } else {
                    report.append("<tr><td>Q" + i + "</td><td>Wrong </td></tr>");
                }
                i++;
            }

            report.append("</table>");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO result(username, score) VALUES (?, ?)"
            );

            ps.setString(1, user);
            ps.setInt(2, score);
            ps.executeUpdate();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            out.println("<html><head>");
            out.println("<link rel='stylesheet' href='/OnlineQuiz/style.css'>");
            out.println("</head><body>");

            out.println("<div class='container'>");
            out.println("<h2>User: " + user + "</h2>");
            out.println("<h2>Score: " + score + "</h2>");
            out.println(report.toString());

            out.println("<br><a href='leaderboard.jsp'>");
            out.println("<input type='button' value='View Leaderboard'>");
            out.println("</a>");
            
            out.println("<br><a href='history.jsp'>");
            out.println("<input type='button' value='My History'>");
            out.println("</a>");
            
            out.println("<form action='logout'><input type='submit' value='Logout'></form>");
            out.println("</div></body></html>");

            out.println("<script>alert('Result Generated 🎉');</script>");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}