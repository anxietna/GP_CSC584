import counseling.bean.CounselorBean;
import counseling.bean.StudentBean;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")

public class LoginServlet extends HttpServlet {

    private String dbURL = "jdbc:derby://localhost:1527/counselingDB";
    private String dbUser = "app";
    private String dbPass = "app";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userRole = request.getParameter("userRole");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            if ("Student".equals(userRole)) {
                String sql = "SELECT * FROM student WHERE usernameStud=? AND passwordStud=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);
                rs = ps.executeQuery();

                if (rs.next()) {
                    StudentBean student = new StudentBean();
                    student.setStudentID(rs.getString("studentID"));
                    student.setNameStud(rs.getString("nameStud"));

                    HttpSession session = request.getSession();
                    session.setAttribute("userID", student.getStudentID());
                    session.setAttribute("userName", student.getNameStud());
                    session.setAttribute("userRole", "Student");

                    response.sendRedirect("DashboardStudentServlet");
                    return;
                }

            } else if ("Counselor".equals(userRole)) {
                String sql = "SELECT * FROM counselor WHERE usernameCouns=? AND passwordCouns=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);
                rs = ps.executeQuery();

                if (rs.next()) {
                    CounselorBean counselor = new CounselorBean();
                    counselor.setCounselorID(rs.getString("counselorID"));
                    counselor.setNameCouns(rs.getString("nameCouns"));

                    HttpSession session = request.getSession();
                    session.setAttribute("userID", counselor.getCounselorID());
                    session.setAttribute("userName", counselor.getNameCouns());
                    session.setAttribute("userRole", "Counselor");

                    response.sendRedirect("dashboardCounselor.jsp");
                    return;
                }

            }

            // Invalid login
            response.sendRedirect("index.jsp?error=invalid");

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
