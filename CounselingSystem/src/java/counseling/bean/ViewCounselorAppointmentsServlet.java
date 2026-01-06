/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewCounselorAppointmentsServlet")
public class ViewCounselorAppointmentsServlet extends HttpServlet {
    private final String dbURL = "jdbc:derby://localhost:1527/counselingDB";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String appId = request.getParameter("appID");

        try (Connection conn = DriverManager.getConnection(dbURL, "app", "app")) {
            if ("markDone".equals(action) && appId != null) {
                PreparedStatement ps = conn.prepareStatement("UPDATE APPOINTMENT SET STATUSBOOKING = 'Done' WHERE APPOINTMENTID = ?");
                ps.setString(1, appId);
                ps.executeUpdate();
            }
            
            String sql = "SELECT A.APPOINTMENTID, S.NAMESTUD, A.DATEAPPOINTMENT, A.TIME, A.STATUSBOOKING " +
                         "FROM APPOINTMENT A JOIN STUDENT S ON A.STUDENTID = S.STUDENTID ORDER BY A.DATEAPPOINTMENT DESC";
            ResultSet rs = conn.createStatement().executeQuery(sql);
            request.setAttribute("appointments", rs);
            request.getRequestDispatcher("viewAppointmentsCounselor.jsp").forward(request, response);
        } catch (Exception e) { e.printStackTrace(); }
    }
}