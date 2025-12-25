package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.List;
import counseling.bean.AppointmentBean;

public final class viewAppointments_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");

    List<AppointmentBean> appointments = (List<AppointmentBean>) request.getAttribute("appointments");
    String studentID = (String) session.getAttribute("userID");
    String studentName = (String) session.getAttribute("userName");

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("<meta charset=\"UTF-8\">\n");
      out.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("<title>My Appointments | Counseling System</title>\n");
      out.write("<style>\n");
      out.write("    body {\n");
      out.write("        margin: 0;\n");
      out.write("        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;\n");
      out.write("        background-color: #e9eef2;\n");
      out.write("        display: flex;\n");
      out.write("        min-height: 100vh;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    /* Sidebar */\n");
      out.write("    .sidebar {\n");
      out.write("        width: 220px;\n");
      out.write("        background-color: #003366;\n");
      out.write("        color: white;\n");
      out.write("        padding: 20px;\n");
      out.write("        display: flex;\n");
      out.write("        flex-direction: column;\n");
      out.write("    }\n");
      out.write("    .sidebar h2 { text-align: center; margin: 0 0 20px 0; font-size: 1.3em; }\n");
      out.write("    .sidebar a { color: #d1e2f3; text-decoration: none; padding: 10px; margin-bottom: 5px; border-radius: 4px; display: block; }\n");
      out.write("    .sidebar a:hover, .sidebar .active { background-color: #0056b3; }\n");
      out.write("    .sidebar .user-info { margin-top: auto; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.2); font-size: 0.9em; }\n");
      out.write("    .sidebar .user-info a { display: block; margin-top: 10px; background-color: #cc0000; color: white; text-align: center; padding: 8px; border-radius: 4px; text-decoration: none; }\n");
      out.write("\n");
      out.write("    /* Main content */\n");
      out.write("    .main-content { flex-grow: 1; padding: 30px; }\n");
      out.write("    h1 { color: #003366; margin-bottom: 20px; }\n");
      out.write("\n");
      out.write("    /* Appointment table */\n");
      out.write("    table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }\n");
      out.write("    th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd; }\n");
      out.write("    th { background-color: #0056b3; color: white; }\n");
      out.write("    tr:hover { background-color: #f1f7ff; }\n");
      out.write("    .action-btn { background-color: #0056b3; color: white; padding: 6px 10px; border-radius: 4px; text-decoration: none; font-size: 0.9em; }\n");
      out.write("    .action-btn:hover { background-color: #003f80; }\n");
      out.write("</style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<div class=\"sidebar\">\n");
      out.write("    <h2>Student Dashboard</h2>\n");
      out.write("    <a href=\"dashboardStudent.jsp\">Dashboard</a>\n");
      out.write("    <a href=\"scheduleAppointment.jsp\">Schedule Appointment</a>\n");
      out.write("    <a href=\"#\" class=\"active\">My Appointments</a>\n");
      out.write("    <a href=\"profileStudent.jsp\">Profile Student</a>\n");
      out.write("\n");
      out.write("    <div class=\"user-info\">\n");
      out.write("        <p>ID: ");
      out.print( studentID );
      out.write("</p>\n");
      out.write("        <p>Name: ");
      out.print( studentName );
      out.write("</p>\n");
      out.write("        <a href=\"index.jsp\">Logout</a>\n");
      out.write("    </div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"main-content\">\n");
      out.write("    <h1>My Appointments</h1>\n");
      out.write("\n");
      out.write("    <table>\n");
      out.write("        <thead>\n");
      out.write("            <tr>\n");
      out.write("                <th>Counselor</th>\n");
      out.write("                <th>Date</th>\n");
      out.write("                <th>Time</th>\n");
      out.write("                <th>Location</th>\n");
      out.write("                <th>Reason</th>\n");
      out.write("                <th>Status</th>\n");
      out.write("                <th>Action</th>\n");
      out.write("            </tr>\n");
      out.write("        </thead>\n");
      out.write("        <tbody>\n");
      out.write("        ");

            if (appointments != null && !appointments.isEmpty()) {
                for (AppointmentBean ab : appointments) {
        
      out.write("\n");
      out.write("            <tr>\n");
      out.write("                <td>");
      out.print( ab.getCounselorName() );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( ab.getDate() );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( ab.getTime() );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( ab.getLocation() );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( ab.getReason() );
      out.write("</td>\n");
      out.write("                <td>");
      out.print( ab.getStatus() );
      out.write("</td>\n");
      out.write("                <td>\n");
      out.write("                    ");
 if ("Pending".equalsIgnoreCase(ab.getStatus())) { 
      out.write("\n");
      out.write("                        <a href=\"#\" class=\"action-btn\">Cancel</a>\n");
      out.write("                    ");
 } else { 
      out.write("\n");
      out.write("                        <a href=\"feedback.jsp\" class=\"action-btn\">Feedback</a>\n");
      out.write("                    ");
 } 
      out.write("\n");
      out.write("                </td>\n");
      out.write("            </tr>\n");
      out.write("        ");

                }
            } else {
        
      out.write("\n");
      out.write("            <tr>\n");
      out.write("                <td colspan=\"7\" style=\"text-align:center;\">No appointments found.</td>\n");
      out.write("            </tr>\n");
      out.write("        ");

            }
        
      out.write("\n");
      out.write("        </tbody>\n");
      out.write("    </table>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
