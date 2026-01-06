/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProfileStudentServlet")
public class ProfileStudentServlet extends HttpServlet {

    private final String dbURL = "jdbc:derby://localhost:1527/counselingDB";
    private final String dbUser = "app";
    private final String dbPass = "app";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("index.jsp?error=login");
            return;
        }

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                String sql = "SELECT * FROM STUDENT WHERE STUDENTID = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, userID);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    request.setAttribute("studentName", rs.getString("NAMESTUD"));
                    request.setAttribute("studentEmail", rs.getString("EMAILSTUD"));
                    request.setAttribute("studentPassword", rs.getString("PASSWORDSTUD"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("profileStudent.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");
        
        String newName = request.getParameter("name");
        String newEmail = request.getParameter("email");
        String newPass = request.getParameter("password");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                // Updated to match your DB column names: NAMESTUD, EMAILSTUD, PASSWORDSTUD
                String sql = "UPDATE STUDENT SET NAMESTUD = ?, EMAILSTUD = ?, PASSWORDSTUD = ? WHERE STUDENTID = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, newName);
                ps.setString(2, newEmail);
                ps.setString(3, newPass);
                ps.setString(4, userID);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    session.setAttribute("userName", newName);
                    response.sendRedirect("ProfileStudentServlet?update=success");
                } else {
                    response.sendRedirect("ProfileStudentServlet?update=error");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ProfileStudentServlet?update=error");
        }
    }
}