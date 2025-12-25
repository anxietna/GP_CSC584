import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import counseling.bean.StudentBean;

@WebServlet("/RegisterStudentServlet")

public class RegisterStudentServlet extends HttpServlet {

    private String dbURL = "jdbc:derby://localhost:1527/counselingDB";
    private String dbUser = "app";
    private String dbPass = "app";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Create StudentBean and set properties from form
        StudentBean student = new StudentBean();
        student.setStudentID(request.getParameter("studentID"));
        student.setNameStud(request.getParameter("nameStud"));
        student.setUsernameStud(request.getParameter("usernameStud"));
        student.setPasswordStud(request.getParameter("passwordStud"));
        student.setEmailStud(request.getParameter("emailStud"));
        student.setMajorStud(request.getParameter("majorStud"));

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "INSERT INTO student (studentID, nameStud, usernameStud, passwordStud, emailStud, majorStud) "
                       + "VALUES (?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, student.getStudentID());
            ps.setString(2, student.getNameStud());
            ps.setString(3, student.getUsernameStud());
            ps.setString(4, student.getPasswordStud());
            ps.setString(5, student.getEmailStud());
            ps.setString(6, student.getMajorStud());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                // Registration success
                response.getWriter().println("<script>alert('Registration successful! Please log in.');"
                                           + "window.location='index.jsp';</script>");
            } else {
                response.sendRedirect("register.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=server");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
