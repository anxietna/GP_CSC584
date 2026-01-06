/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package counseling.bean;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProfileCounselorServlet")
public class ProfileCounselorServlet extends HttpServlet {

    private final String dbURL = "jdbc:derby://localhost:1527/counselingDB";
    private final String dbUser = "app";
    private final String dbPass = "app";

    // VIEW PROFILE DATA
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("login.jsp?error=login");
            return;
        }

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                String sql = "SELECT * FROM COUNSELOR WHERE COUNSELORID = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, userID);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    request.setAttribute("cName", rs.getString("NAMECOUNS"));
                    request.setAttribute("cEmail", rs.getString("EMAILCOUNS"));
                    request.setAttribute("cPass", rs.getString("PASSWORDCOUNS"));
                    request.setAttribute("cSpec", rs.getString("SPECIALIZATION"));
                    request.setAttribute("cOffice", rs.getString("OFFICELOCATION"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("profileCounselor.jsp").forward(request, response);
    }

    // UPDATE PROFILE DATA
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");
        
        String newName = request.getParameter("name");
        String newEmail = request.getParameter("email");
        String newPass = request.getParameter("password");
        String newSpec = request.getParameter("specialization");
        String newOffice = request.getParameter("office");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                String sql = "UPDATE COUNSELOR SET NAMECOUNS=?, EMAILCOUNS=?, PASSWORDCOUNS=?, SPECIALIZATION=?, OFFICELOCATION=? WHERE COUNSELORID=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, newName);
                ps.setString(2, newEmail);
                ps.setString(3, newPass);
                ps.setString(4, newSpec);
                ps.setString(5, newOffice);
                ps.setString(6, userID);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    session.setAttribute("userName", newName); // Update sidebar name
                    response.sendRedirect("ProfileCounselorServlet?update=success");
                } else {
                    response.sendRedirect("ProfileCounselorServlet?update=error");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ProfileCounselorServlet?update=error");
        }
    }
}