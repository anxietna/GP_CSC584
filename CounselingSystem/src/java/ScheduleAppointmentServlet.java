import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import counseling.bean.AppointmentBean;

@WebServlet("/ScheduleAppointmentServlet")
public class ScheduleAppointmentServlet extends HttpServlet {

    private String dbURL = "jdbc:derby://localhost:1527/counselingDB";
    private String dbUser = "app";
    private String dbPass = "app";

    // GET: Fetches counselor names from database to show in the dropdown menu
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Map<String, String>> counselors = new ArrayList<>();
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                String sql = "SELECT counselorID, nameCouns FROM counselor";
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                
                while (rs.next()) {
                    Map<String, String> counselor = new HashMap<>();
                    counselor.put("id", rs.getString("counselorID"));
                    counselor.put("name", rs.getString("nameCouns"));
                    counselors.add(counselor);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("counselors", counselors);
        request.getRequestDispatcher("scheduleAppointment.jsp").forward(request, response);
    }

    // POST: Receives form data and saves the appointment
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String studentID = (String) session.getAttribute("userID"); // Taken from login session
        String counselorID = request.getParameter("counselorID");
        String dateAppt = request.getParameter("dateAppointment");
        String timeAppt = request.getParameter("time");
        String reason = request.getParameter("reasonBooking");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                // appointmentID is omitted so the database handles auto-increment (1, 2, 3...)
                String sql = "INSERT INTO appointment (studentID, counselorID, dateAppointment, time, statusBooking, reasonBooking) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, studentID);
                ps.setString(2, counselorID);
                ps.setString(3, dateAppt);
                ps.setString(4, timeAppt);
                ps.setString(5, "Pending"); // Default status
                ps.setString(6, reason);
                
                ps.executeUpdate();
            }
            // After saving, redirect to the list view with a success flag
            response.sendRedirect("ViewAppointmentsServlet?status=scheduled");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ScheduleAppointmentServlet?error=fail");
        }
    }
}