<%-- 
    Document   : dashboardCounselor
    Created on : Dec 31, 2025, 1:36:38 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String name = (String) session.getAttribute("userName");
    String counselorID = (String) session.getAttribute("userID");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counselor Dashboard | Counseling System</title>
    <style>
        :root { --primary: #003366; --accent: #0056b3; --bg: #e9eef2; --sidebar-width: 250px; }
        body { margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: var(--bg); display: flex; min-height: 100vh; }

        .sidebar { width: var(--sidebar-width); background-color: var(--primary); color: white; padding: 20px; display: flex; flex-direction: column; position: fixed; height: 100vh; box-sizing: border-box; }
        .sidebar h2 { text-align: center; margin-bottom: 30px; font-size: 1.4em; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 15px; }
        .sidebar a { color: #d1e2f3; text-decoration: none; padding: 12px 15px; margin-bottom: 5px; border-radius: 4px; display: block; transition: 0.2s; }
        .sidebar a:hover, .sidebar .active { background-color: var(--accent); color: white; }
        
        .user-info { margin-top: auto; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.1); font-size: 0.9em; }
        .user-info p { margin: 5px 0; color: #d1e2f3; }
        .logout-btn { display: block; margin-top: 10px; background-color: #cc0000; color: white; text-align: center; padding: 10px; border-radius: 4px; text-decoration: none; font-weight: bold; }
        .logout-btn:hover { background-color: #a30000; }

        .main-content { flex-grow: 1; padding: 40px; margin-left: var(--sidebar-width); }
        .welcome-card { background: white; padding: 35px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-left: 8px solid var(--accent); }
        h1 { color: var(--primary); margin: 0 0 10px 0; font-size: 2.2em; }
        p { color: #555; font-size: 1.1em; }
    </style>
</head>
<body>

<nav class="sidebar">
    <h2>Counselor Panel</h2>
    <a href="DashboardCounselorServlet" class="active">Dashboard</a>
    <a href="ViewCounselorAppointmentsServlet">Student Appointments</a>
    <a href="StudentListServlet">Student List</a>
    <a href="ViewFeedbackServlet">View Feedback</a>
    <a href="ProfileCounselorServlet">My Profile</a>

    <div class="user-info">
        <p><strong>ID:</strong> <%= (counselorID != null) ? counselorID : "Not Available" %></p>
        <p><strong>Counselor:</strong> <%= (name != null) ? name : "Guest" %></p>
        <a href="LogoutServlet" class="logout-btn">Logout</a>
    </div>
</nav>

<main class="main-content">
    <div class="welcome-card">
        <h1>Welcome back, <%= (name != null) ? name : "Counselor" %>!</h1>
        <p>You have access to manage student appointments, review registration lists, and analyze feedback reports.</p>
    </div>
</main>

</body>
</html>