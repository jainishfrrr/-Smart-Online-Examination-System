package com.quiz.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.quiz.db.DBConnection;

@WebServlet("/deleteQuestion")
public class DeleteQuestionServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM questions WHERE id=?"
            );

            ps.setInt(1, id);
            ps.executeUpdate();

            response.sendRedirect("admin.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}