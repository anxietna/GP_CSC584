<%-- 
    Document   : viewAppointmentCounselor
    Created on : Dec 31, 2025, 2:01:09 PM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String name = (String) session.getAttribute("userName");
    String counselorID = (String) session.getAttribute("userID");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Appointments | Counseling System</title>
    <style>
        :root { 
            --primary: #003366; 
            --accent: #0056b3; 
            --bg: #e9eef2; 
            --sidebar-width: 250px; 
        }
        
        body { 
            margin: 0; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: var(--bg); 
            display: flex; 
            min-height: 100vh; 
        }

        /* --- Sidebar (Matches Student Dashboard) --- */
        .sidebar { 
            width: var(--sidebar-width); 
            background-color: var(--primary); 
            color: white; 
            padding: 20px; 
            display: flex; 
            flex-direction: column; 
            position: fixed; 
            height: 100vh; 
            box-sizing: border-box; 
        }
        
        .sidebar h2 { 
            text-align: center; 
            margin-bottom: 30px; 
            font-size: 1.4em; 
            border-bottom: 1px solid rgba(255,255,255,0.1); 
            padding-bottom: 15px; 
        }
        
        .sidebar a { 
            color: #d1e2f3; 
            text-decoration: none; 
            padding: 12px 15px; 
            margin-bottom: 5px; 
            border-radius: 4px; 
            display: block; 
            transition: 0.2s; 
        }
        
        .sidebar a:hover, .sidebar .active { 
            background-color: var(--accent); 
            color: white; 
        }
        
        .user-info { 
            margin-top: auto; 
            padding-top: 20px; 
            border-top: 1px solid rgba(255,255,255,0.1); 
            font-size: 0.9em; 
        }
        
        .user-info p { margin: 5px 0; color: #d1e2f3; }
        
        .logout-btn { 
            display: block; 
            margin-top: 10px; 
            background-color: #cc0000; 
            color: white; 
            text-align: center; 
            padding: 10px; 
            border-radius: 4px; 
            text-decoration: none; 
            font-weight: bold; 
        }

        /* --- Main Content & Table --- */
        .main-content { 
            flex-grow: 1; 
            padding: 40px; 
            margin-left: var(--sidebar-width); 
        }
        
        .content-card { 
            background: white; 
            padding: 30px; 
            border-radius: 12px; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.1); 
            border-top: 5px solid var(--accent); 
        }

        h1 { color: var(--primary); margin-bottom: 25px; }

        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 10px; 
        }
        
        th, td { 
            padding: 15px; 
            text-align: left; 
            border-bottom: 1px solid #eee; 
        }
        
        th { 
            background-color: #f8f9fa; 
            color: var(--primary); 
            font-weight: 600; 
            text-transform: uppercase; 
            font-size: 0.85em; 
            letter-spacing: 0.5px; 
        }

        /* --- Status & Buttons --- */
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: bold;
        }
        
        .status-done { 
            background-color: #d4edda; 
            color: #155724; 
        }
        
        .status-pending { 
            background-color: #fff3cd; 
            color: #856404; 
        }
        
        .btn-done { 
            background-color: #28a745; 
            color: white; 
            padding: 8px 15px; 
            border-radius: 4px; 
            text-decoration: none; 
            font-size: 0.85em; 
            transition: 0.3s;
        }
        
        .btn-done:hover { background-color: #218838; shadow: 0 2px 4px rgba(0,0,0,0.2); }
    </style>
</head>
<body>

<nav class="sidebar">
    <h2>Counselor Panel</h2>
    <a href="DashboardCounselorServlet">Dashboard</a>
    <a href="ViewCounselorAppointmentsServlet" class="active">Student Appointments</a>
    <a href="StudentListServlet">Student List</a>
    <a href="ViewFeedbackServlet">View Feedback</a>
    <a href="ProfileCounselorServlet">My Profile</a>

    <div class="user-info">
        <p><strong>ID:</strong> <%= counselorID != null ? counselorID : "N/A" %></p>
        <p><strong>Counselor:</strong> <%= name != null ? name : "User" %></p>
        <a href="LogoutServlet" class="logout-btn">Logout</a>
    </div>
</nav>

<main class="main-content">
    <div class="content-card">
        <h1>Appointment List</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Student Name</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    ResultSet rs = (ResultSet)request.getAttribute("appointments");
                    if (rs != null) {
                        while(rs.next()) { 
                            String status = rs.getString("STATUSBOOKING");
                %>
                <tr>
                    <td><%= rs.getString("APPOINTMENTID") %></td>
                    <td><%= rs.getString("NAMESTUD") %></td>
                    <td><%= rs.getDate("DATEAPPOINTMENT") %></td>
                    <td><%= rs.getString("TIME") %></td>
                    <td>
                        <span class="status-badge <%= status.equalsIgnoreCase("Done") ? "status-done" : "status-pending" %>">
                            <%= status %>
                        </span>
                    </td>
                    <td>
                        <% if(status.equalsIgnoreCase("Pending")) { %>
                            <a href="ViewCounselorAppointmentsServlet?action=markDone&appID=<%= rs.getString("APPOINTMENTID") %>" class="btn-done">
                                Mark as Done
                            </a>
                        <% } else { %>
                            <span style="color: #999;">Completed</span>
                        <% } %>
                    </td>
                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr>
                    <td colspan="6" style="text-align: center; padding: 30px; color: #666;">No appointments found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</main>

</body>
</html>