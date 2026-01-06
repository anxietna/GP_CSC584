<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="counseling.bean.AppointmentBean" %>
<%
    List<AppointmentBean> appointments = (List<AppointmentBean>) request.getAttribute("appointments");
    String studentID = (String) session.getAttribute("userID");
    String studentName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Appointments | Counseling System</title>
<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #e9eef2;
        display: flex;
        min-height: 100vh;
    }

    /* Sidebar */
    .sidebar {
        width: 220px;
        background-color: #003366;
        color: white;
        padding: 20px;
        display: flex;
        flex-direction: column;
    }
    .sidebar h2 { text-align: center; margin: 0 0 20px 0; font-size: 1.3em; }
    .sidebar a { color: #d1e2f3; text-decoration: none; padding: 10px; margin-bottom: 5px; border-radius: 4px; display: block; }
    .sidebar a:hover, .sidebar .active { background-color: #0056b3; }
    .sidebar .user-info { margin-top: auto; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.2); font-size: 0.9em; }
    .sidebar .user-info a { display: block; margin-top: 10px; background-color: #cc0000; color: white; text-align: center; padding: 8px; border-radius: 4px; text-decoration: none; }

    /* Main content */
    .main-content { flex-grow: 1; padding: 30px; }
    h1 { color: #003366; margin-bottom: 20px; }

    /* Appointment table */
    table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
    th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd; }
    th { background-color: #0056b3; color: white; }
    tr:hover { background-color: #f1f7ff; }
    .action-btn { background-color: #0056b3; color: white; padding: 6px 10px; border-radius: 4px; text-decoration: none; font-size: 0.9em; }
    .action-btn:hover { background-color: #003f80; }
</style>

<script>
    function confirmCancel(appointmentID) {
        if (confirm("Are you sure you want to cancel the appointment?")) {
            window.location.href = "CancelAppointmentServlet?id=" + appointmentID;
        }
    }

    // This handles the "Success" message 
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('status') === 'deleted') {
            alert("Appointment canceled successfully!");
            window.history.replaceState({}, document.title, "ViewAppointmentsServlet");
        }
    };
</script>

</head>
<body>

<div class="sidebar">
    <h2>Student Dashboard</h2>
    <a href="dashboardStudent.jsp">Dashboard</a>
    <a href="scheduleAppointment.jsp">Schedule Appointment</a>
    <a href="#" class="active">My Appointments</a>
    <a href="ProfileStudentServlet">Profile Student</a>
    <a href="SubmitFeedbackServlet">Feedback</a>

    <div class="user-info">
        <p>ID: <%= studentID %></p>
        <p>Name: <%= studentName %></p>
        <a href="index.jsp">Logout</a>
    </div>
</div>

<div class="main-content">
    <h1>My Appointments</h1>

    <table>
        <thead>
            <tr>
                <th>Counselor</th>
                <th>Date</th>
                <th>Time</th>
                <th>Location</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (appointments != null && !appointments.isEmpty()) {
                for (AppointmentBean ab : appointments) {
        %>
            <tr>
                <td><%= ab.getCounselorName() %></td>
                <td><%= ab.getDate() %></td>
                <td><%= ab.getTime() %></td>
                <td><%= ab.getLocation() %></td>
                <td><%= ab.getReason() %></td>
                <td><%= ab.getStatus() %></td>
                <td>
                    <% if ("Pending".equalsIgnoreCase(ab.getStatus())) { %>
                        <button type="button" class="action-btn" 
                                style="background-color: #cc0000; border: none; cursor: pointer;"
                                onclick="confirmCancel('<%= ab.getAppointmentID() %>')">
                            Cancel
                        </button>
                    <% } else { %>
                        <a href="feedback.jsp" class="action-btn">Feedback</a>
                    <% } %>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="7" style="text-align:center;">No appointments found.</td>
            </tr>
        <%
            }
        %>
        
        
        </tbody>
    </table>
</div>

</body>
</html>
