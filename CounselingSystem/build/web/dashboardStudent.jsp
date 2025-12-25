<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve the values set by the Servlet
    // We use session for user info, but request for the dashboard stats
    String userID = (String) session.getAttribute("userID");
    String userName = (String) session.getAttribute("userName");

    Integer upcomingCount = (Integer) request.getAttribute("upcomingCount");
    Integer completedCount = (Integer) request.getAttribute("completedCount");
    Integer availableCounselors = (Integer) request.getAttribute("availableCounselors");
    
    String nextCounselor = (String) request.getAttribute("nextCounselor");
    String nextDate = (String) request.getAttribute("nextDate");
    String nextTime = (String) request.getAttribute("nextTime");
    String nextLocation = (String) request.getAttribute("nextLocation");
    
    // Safety check: if user visits JSP directly without Servlet, redirect them
    if (upcomingCount == null) {
        response.sendRedirect("DashboardStudentServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard | Counseling System</title>
    <style>
        body { margin:0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color:#e9eef2; display:flex; min-height:100vh; }
        .sidebar { width:220px; background-color:#003366; color:white; padding:20px; display:flex; flex-direction:column; }
        .sidebar h2 { text-align:center; margin:0 0 20px 0; font-size:1.3em; }
        .sidebar a { color:#d1e2f3; text-decoration:none; padding:10px; margin-bottom:5px; border-radius:4px; display:block; }
        .sidebar a:hover, .sidebar .active { background-color:#0056b3; }
        .sidebar .user-info { margin-top:auto; padding-top:20px; border-top:1px solid rgba(255,255,255,0.2); font-size:0.9em; }
        .sidebar .user-info a { display:block; margin-top:10px; background-color:#cc0000; color:white; text-align:center; padding:8px; border-radius:4px; text-decoration:none; }
        .main-content { flex-grow:1; padding:30px; }
        .welcome-section { background-color:white; padding:20px; border-radius:8px; margin-bottom:20px; border-left:5px solid #0056b3; }
        .welcome-section h1 { margin:0 0 10px 0; color:#003366; font-size:1.8em; }
        .summary-grid { display:flex; gap:15px; flex-wrap:wrap; margin-bottom:30px; }
        .stat-card { flex:1 1 200px; background:white; padding:15px; border-radius:8px; text-align:center; box-shadow:0 2px 5px rgba(0,0,0,0.1); }
        .stat-card .value { font-size:2em; color:#0056b3; font-weight:bold; }
        .stat-card .label { color:#555; }
        .appointment { background:white; padding:15px; border-radius:8px; margin-bottom:20px; }
        .appointment ul { padding-left:20px; margin:0; }
        .appointment a { color:#0056b3; text-decoration:none; }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2>Student Dashboard</h2>
        <a href="DashboardStudentServlet" class="active">Dashboard</a>
        <a href="scheduleAppointment.jsp">Schedule Appointment</a>
        <a href="ViewAppointmentsServlet">My Appointments</a>
        <a href="profileStudent.jsp">Profile Student</a>

        <div class="user-info">
            <p>ID: <%= userID %></p>
            <p>Name: <%= userName %></p>
            <a href="index.jsp">Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="welcome-section">
            <h1>Welcome, <%= userName %>!</h1>
            <p>Manage your counseling appointments easily from your dashboard.</p>
        </div>

        <div class="summary-grid">
            <div class="stat-card">
                <div class="value"><%= upcomingCount %></div>
                <div class="label">Upcoming Appointment</div>
            </div>
            <div class="stat-card">
                <div class="value"><%= completedCount %></div>
                <div class="label">Completed Sessions</div>
            </div>
            <div class="stat-card">
                <div class="value"><%= availableCounselors %></div>
                <div class="label">Available Counselors</div>
            </div>
        </div>

        <% if (upcomingCount > 0) { %>
        <div class="appointment">
            <h3>Next Appointment</h3>
            <ul>
                <li>Counselor: <%= nextCounselor %></li>
                <li>Date: <%= nextDate %></li>
                <li>Time: <%= nextTime %></li>
                <li>Location: <%= nextLocation %></li>
            </ul>
            <a href="ViewAppointmentsServlet">View or Cancel</a>
        </div>
        <% } %>
    </div>
</body>
</html>