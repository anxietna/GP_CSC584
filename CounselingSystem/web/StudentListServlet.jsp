<%-- 
    Document   : StudentListServlet
    Created on : Dec 31, 2025, 1:55:52 PM
    Author     : Admin
--%>

@WebServlet("/StudentListServlet")
public class StudentListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/counselingDB", "app", "app")) {
            ResultSet rs = conn.createStatement().executeQuery("SELECT STUDENTID, NAMESTUD, EMAILSTUD, MAJORSTUD FROM STUDENT");
            request.setAttribute("studentList", rs);
            request.getRequestDispatcher("studentList.jsp").forward(request, response);
        } catch (Exception e) { e.printStackTrace(); }
    }
}