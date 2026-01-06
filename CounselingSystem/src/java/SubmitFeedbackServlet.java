/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SubmitFeedbackServlet", urlPatterns = {"/SubmitFeedbackServlet"})
public class SubmitFeedbackServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final String dbURL = "jdbc:derby://localhost:1527/counselingDB";
    private final String dbUser = "app";
    private final String dbPass = "app";

    // Handle GET (prevents 405)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Redirect if user tries to access servlet directly
        response.sendRedirect(request.getContextPath() + "/ViewAppointmentsServlet");
    }

    // Handle POST (form submit)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String appID = request.getParameter("appointmentID");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        if (appID == null || ratingStr == null || comment == null) {
            response.sendRedirect("feedback.jsp?appointmentID=" + appID + "&status=error");
            return;
        }

        int rating = Integer.parseInt(ratingStr);
        Date feedbackDate = new Date(System.currentTimeMillis());

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {

                String checkSql = "SELECT FEEDBACKID FROM FEEDBACK WHERE APPOINTMENTID=?";
                PreparedStatement checkPs = conn.prepareStatement(checkSql);
                checkPs.setString(1, appID);
                ResultSet rs = checkPs.executeQuery();

                String sql;
                if (rs.next()) {
                    sql = "UPDATE FEEDBACK SET RATING=?, COMMENT=?, FEEDBACKDATE=? WHERE APPOINTMENTID=?";
                } else {
                    sql = "INSERT INTO FEEDBACK (RATING, COMMENT, FEEDBACKDATE, APPOINTMENTID) VALUES (?, ?, ?, ?)";
                }

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, rating);
                ps.setString(2, comment);
                ps.setDate(3, feedbackDate);
                ps.setString(4, appID);
                ps.executeUpdate();

                response.sendRedirect(request.getContextPath() + "/ViewAppointmentsServlet?status=success");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("feedback.jsp?appointmentID=" + appID + "&status=error");
        }
    }
}
