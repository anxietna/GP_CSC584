import counseling.bean.AppointmentBean;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/ViewAppointmentsServlet")
public class ViewAppointmentsServlet extends HttpServlet {

    private String dbURL = "jdbc:derby://localhost:1527/counselingDB";
    private String dbUser = "app";
    private String dbPass = "app";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String studentID = (String) session.getAttribute("userID");
        ArrayList<AppointmentBean> appointments = new ArrayList<>();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "SELECT a.appointmentID, a.dateAppointment, a.time, a.statusBooking, a.reasonBooking, "
                       + "c.nameCouns, c.officeLocation "
                       + "FROM appointment a "
                       + "JOIN counselor c ON a.counselorID = c.counselorID "
                       + "WHERE a.studentID = ? "
                       + "ORDER BY a.dateAppointment ASC";

            ps = conn.prepareStatement(sql);
            ps.setString(1, studentID);
            rs = ps.executeQuery();

            while (rs.next()) {
                AppointmentBean ab = new AppointmentBean();
                ab.setAppointmentID(rs.getString("appointmentID"));
                ab.setDate(rs.getString("dateAppointment"));
                ab.setTime(rs.getString("time"));
                ab.setStatus(rs.getString("statusBooking"));
                ab.setReason(rs.getString("reasonBooking"));
                ab.setCounselorName(rs.getString("nameCouns"));
                ab.setLocation(rs.getString("officeLocation"));

                appointments.add(ab);
            }

            request.setAttribute("appointments", appointments);
            request.getRequestDispatcher("viewAppointments.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=server");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
