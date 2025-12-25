<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    String userID = (String) session.getAttribute("userID");
    String userName = (String) session.getAttribute("userName");
    List<Map<String, String>> counselors = (List<Map<String, String>>) request.getAttribute("counselors");

    // Redirect to Servlet if accessed directly so counselors can be loaded
    if (counselors == null) {
        response.sendRedirect("ScheduleAppointmentServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Schedule Appointment | Counseling System</title>
    <style>
        body { margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #e9eef2; display: flex; min-height: 100vh; }
        .sidebar { width: 220px; background-color: #003366; color: white; padding: 20px; display: flex; flex-direction: column; }
        .sidebar h2 { text-align: center; margin: 0 0 20px 0; font-size: 1.3em; }
        .sidebar a { color: #d1e2f3; text-decoration: none; padding: 10px; margin-bottom: 5px; border-radius: 4px; display: block; }
        .sidebar a:hover, .sidebar .active { background-color: #0056b3; }
        .sidebar .user-info { margin-top: auto; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.2); font-size: 0.9em; }
        .sidebar .user-info a { display: block; margin-top: 10px; background-color: #cc0000; color: white; text-align: center; padding: 8px; border-radius: 4px; text-decoration: none; }
        .main-content { flex-grow: 1; padding: 30px; }
        h1 { color: #003366; margin-bottom: 20px; }
        .appointment-form { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); max-width: 500px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: 500; margin-bottom: 5px; color: #333; }
        input, select, textarea { width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #c7c7c7; box-sizing: border-box; transition: border-color 0.3s; }
        input:focus, select:focus, textarea:focus { outline: none; border-color: #0056b3; }
        textarea { resize: vertical; min-height: 80px; }
        button { width: 100%; padding: 12px; background-color: #0056b3; color: white; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; transition: 0.25s; }
        button:hover { background-color: #003f80; }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2>Student Dashboard</h2>
        <a href="DashboardStudentServlet">Dashboard</a>
        <a href="#" class="active">Schedule Appointment</a>
        <a href="ViewAppointmentsServlet">My Appointments</a>
        <a href="profileStudent.jsp">Profile Student</a>

        <div class="user-info">
            <p>ID: <%= userID %></p>
            <p>Name: <%= userName %></p>
            <a href="index.jsp">Logout</a>
        </div>
    </div>

    <div class="main-content">
        <h1>Schedule Appointment</h1>

        <form action="ScheduleAppointmentServlet" method="POST" class="appointment-form">
            <div class="form-group">
                <label>Choose Counselor</label>
                <select name="counselorID" required>
                    <option value="">-- Select Counselor --</option>
                    <% for (Map<String, String> c : counselors) { %>
                        <option value="<%= c.get("id") %>"><%= c.get("name") %></option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label>Date</label>
                <input type="date" name="dateAppointment" required>
            </div>

            <div class="form-group">
                <label>Time</label>
                <input type="time" name="time" required>
            </div>

            <div class="form-group">
                <label>Reason for Booking</label>
                <textarea name="reasonBooking" required placeholder="Tell us why you'd like to meet..."></textarea>
            </div>

            <button type="submit">Book Appointment</button>
        </form>
    </div>

</body>
</html>