import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DashboardStudentServlet")
public class DashboardStudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");
        String userRole = (String) session.getAttribute("userRole");

        // 1. Security Check
        if (userID == null || !"Student".equals(userRole)) {
            response.sendRedirect("index.jsp?error=login");
            return;
        }

        // 2. Initialize Variables
        int upcomingCount = 0;
        int completedCount = 0;
        int availableCounselors = 0;
        String nextCounselor = "", nextDate = "", nextTime = "", nextLocation = "";

        // Database Credentials
        String dbURL = "jdbc:derby://localhost:1527/counselingDB";
        String dbUser = "app";
        String dbPass = "app";

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {

                // Use a JOIN to get everything at once. 
                // Note: ERD shows officeLocation is in the Counselor table.
                String apptQuery = "SELECT a.statusBooking, a.dateAppointment, a.time, c.nameCouns, c.officeLocation " +
                                   "FROM appointment a " +
                                   "JOIN counselor c ON a.counselorID = c.counselorID " +
                                   "WHERE a.studentID = ? " +
                                   "ORDER BY a.dateAppointment ASC";

                PreparedStatement ps = conn.prepareStatement(apptQuery);
                ps.setString(1, userID);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    String status = rs.getString("statusBooking");

                    if ("Pending".equalsIgnoreCase(status)) {
                        upcomingCount++;
                        // If this is the first pending appointment found, set it as the "Next" one
                        if (nextDate.isEmpty()) {
                            nextDate = rs.getString("dateAppointment");
                            nextTime = rs.getString("time");
                            nextCounselor = rs.getString("nameCouns");
                            nextLocation = rs.getString("officeLocation");
                        }
                    } else if ("Done".equalsIgnoreCase(status) || "Completed".equalsIgnoreCase(status)) {
                        completedCount++;
                    }
                }
                rs.close();
                ps.close();

                // Count all counselors
                PreparedStatement psCount = conn.prepareStatement("SELECT COUNT(*) FROM counselor");
                ResultSet rsCount = psCount.executeQuery();
                if (rsCount.next()) availableCounselors = rsCount.getInt(1);

                rsCount.close();
                psCount.close();
            }
        } catch (Exception e) {
            // This is vital: Check your IDE console/output log to see the specific error!
            e.printStackTrace(); 
        }

        // 3. Set Attributes for the JSP to read
        request.setAttribute("upcomingCount", upcomingCount);
        request.setAttribute("completedCount", completedCount);
        request.setAttribute("availableCounselors", availableCounselors);
        request.setAttribute("nextCounselor", nextCounselor);
        request.setAttribute("nextDate", nextDate);
        request.setAttribute("nextTime", nextTime);
        request.setAttribute("nextLocation", nextLocation);

        // 4. Forward to the JSP
        request.getRequestDispatcher("dashboardStudent.jsp").forward(request, response);
    }
}