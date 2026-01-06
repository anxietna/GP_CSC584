/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package counseling.bean;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/StudentListServlet")
public class StudentListServlet extends HttpServlet {
    private final String dbURL = "jdbc:derby://localhost:1527/counselingDB";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        List<Map<String, String>> studentList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(dbURL, "app", "app");
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(
                     "SELECT STUDENTID, NAMESTUD, MAJORSTUD, EMAILSTUD FROM STUDENT ORDER BY NAMESTUD ASC")) {

            while (rs.next()) {
                Map<String, String> student = new HashMap<>();
                student.put("STUDENTID", rs.getString("STUDENTID"));
                student.put("NAMESTUD", rs.getString("NAMESTUD"));
                student.put("MAJORSTUD", rs.getString("MAJORSTUD"));
                student.put("EMAILSTUD", rs.getString("EMAILSTUD"));
                studentList.add(student);
            }

            request.setAttribute("studentList", studentList);
            request.getRequestDispatcher("studentList.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
