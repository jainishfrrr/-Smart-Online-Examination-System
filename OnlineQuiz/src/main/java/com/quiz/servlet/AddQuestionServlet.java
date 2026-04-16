package com.quiz.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.quiz.db.DBConnection;

@WebServlet("/addQuestion")
public class AddQuestionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String question = request.getParameter("question");
        String opt1 = request.getParameter("opt1");
        String opt2 = request.getParameter("opt2");
        String opt3 = request.getParameter("opt3");
        String opt4 = request.getParameter("opt4");
        String correct = request.getParameter("correct");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO questions(question, option1, option2, option3, option4, correct_answer) VALUES (?, ?, ?, ?, ?, ?)"
            );

            ps.setString(1, question);
            ps.setString(2, opt1);
            ps.setString(3, opt2);
            ps.setString(4, opt3);
            ps.setString(5, opt4);
            ps.setString(6, correct);

            ps.executeUpdate();

         // ✅ REDIRECT BACK TO ADMIN PAGE
            response.sendRedirect("admin.jsp?success=1");
        
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}