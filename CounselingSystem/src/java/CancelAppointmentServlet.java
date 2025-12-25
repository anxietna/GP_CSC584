import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CancelAppointmentServlet")
public class CancelAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String appointmentID = request.getParameter("id");
        String dbURL = "jdbc:derby://localhost:1527/counselingDB";
        String dbUser = "app";
        String dbPass = "app";

        if (appointmentID != null && !appointmentID.isEmpty()) {
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                    String sql = "DELETE FROM appointment WHERE appointmentID = ?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, appointmentID);
                    ps.executeUpdate();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Redirect back to the view list with the success flag
        response.sendRedirect("ViewAppointmentsServlet?status=deleted");
    }
}