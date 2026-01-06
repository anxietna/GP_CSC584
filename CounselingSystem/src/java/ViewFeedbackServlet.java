/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewFeedbackServlet")
public class ViewFeedbackServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/counselingDB", "app", "app")) {
            String sql = "SELECT S.NAMESTUD, F.RATING, F.COMMENT, F.FEEDBACKDATE " +
                         "FROM FEEDBACK F JOIN APPOINTMENT A ON F.APPOINTMENTID = A.APPOINTMENTID " +
                         "JOIN STUDENT S ON A.STUDENTID = S.STUDENTID WHERE A.STATUSBOOKING = 'Done'";
            ResultSet rs = conn.createStatement().executeQuery(sql);
            request.setAttribute("feedbacks", rs);
            request.getRequestDispatcher("feedback.jsp").forward(request, response);
        } catch (Exception e) { e.printStackTrace(); }
    }
}