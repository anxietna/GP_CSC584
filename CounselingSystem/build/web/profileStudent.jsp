<%-- 
    Document   : profileStudent
    Created on : Dec 31, 2025, 12:04:04 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userID = (String) session.getAttribute("userID");
    String userName = (String) session.getAttribute("userName");

    String sName = (String) request.getAttribute("studentName");
    String sEmail = (String) request.getAttribute("studentEmail");
    String sPass = (String) request.getAttribute("studentPassword");

    if (userID == null) {
        response.sendRedirect("index.jsp?error=login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile | Counseling System</title>

    <style>
                :root {
            --primary-blue: #003366;
            --accent-blue: #0056b3;
            --bg-gray: #e9eef2;
        }

        * {
            box-sizing: border-box;
        }

        html, body {
            width: 100%;
            overflow-x: hidden;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-gray);
            display: flex;
            min-height: 100vh;
        }

        /* SIDEBAR */
        .sidebar {
            width: 220px;
            background-color: var(--primary-blue);
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
        }

        .sidebar h2 {
            text-align: center;
            margin: 0 0 20px 0;
            font-size: 1.3em;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            padding-bottom: 15px;
        }

        .sidebar a {
            color: #d1e2f3;
            text-decoration: none;
            padding: 12px;
            margin-bottom: 5px;
            border-radius: 6px;
            display: block;
        }

        .sidebar a:hover,
        .sidebar .active {
            background-color: var(--accent-blue);
            color: white;
        }

        .sidebar .user-info {
            margin-top: auto;
            padding-top: 20px;
            border-top: 1px solid rgba(255,255,255,0.2);
            font-size: 0.9em;
        }

        .sidebar .logout-btn {
            display: block;
            margin-top: 10px;
            background-color: #cc0000;
            color: white;
            text-align: center;
            padding: 10px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
        }

        /* MAIN CONTENT */
        .main-content {
            margin-left: 220px;
            padding: 40px;
            width: calc(100% - 220px);
        }

        /* HEADER */
        .page-header {
            background-color: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            border-left: 6px solid var(--accent-blue);
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .page-header h1 {
            margin: 0;
            color: var(--primary-blue);
            font-size: 1.8em;
        }

        /* CARD */
        .profile-card {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            max-width: 650px;
            width: 100%;
        }

        /* FORM */
        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 20px;
        }

        label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #444;
        }

        input {
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            width: 100%;
        }

        input:focus {
            outline: none;
            border-color: var(--accent-blue);
        }

        input[readonly] {
            background-color: #f8f9fa;
            border-color: #eee;
        }

        .btn-submit {
            background-color: var(--accent-blue);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            transition: 0.3s;
        }

        .btn-submit:hover {
            background-color: var(--primary-blue);
        }

        /* STATUS */
        .status-msg {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-weight: 500;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* RESPONSIVE */
        @media (max-width: 900px) {
            .sidebar {
                width: 180px;
            }

            .main-content {
                margin-left: 180px;
                width: calc(100% - 180px);
                padding: 25px;
            }
        }

        @media (max-width: 700px) {
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
            }

            .main-content {
                margin-left: 0;
                width: 100%;
            }
        }
    </style>
</head>

<body>

<nav class="sidebar">
    <h2>Student Panel</h2>
    <a href="DashboardStudentServlet">Dashboard</a>
    <a href="scheduleAppointment.jsp">Schedule Appointment</a>
    <a href="ViewAppointmentsServlet">My Appointments</a>
    <a href="ProfileStudentServlet" class="active">Profile Settings</a>
    <a href="SubmitFeedbackServlet">Feedback</a>

    <div class="user-info">
        <p>ID: <%= userID %></p>
        <p>Name: <%= userName %></p>
        <a href="index.jsp" class="logout-btn">Sign Out</a>
    </div>
</nav>

<main class="main-content">

    <header class="page-header">
        <h1>Personal Settings</h1>
        <p>Update your profile information and credentials.</p>
    </header>

    <% if ("success".equals(request.getParameter("update"))) { %>
        <div class="status-msg success">
            ✓ Your profile has been updated successfully.
        </div>
    <% } else if ("error".equals(request.getParameter("update"))) { %>
        <div class="status-msg error">
            ⚠ An error occurred during update. Please check database columns.
        </div>
    <% } %>

    <div class="profile-card">
        <form action="ProfileStudentServlet" method="POST">

            <div class="form-group">
                <label>Student ID</label>
                <input type="text" value="<%= userID %>" readonly>
            </div>

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name"
                       value="<%= (sName != null ? sName : "") %>" required>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email"
                       value="<%= (sEmail != null ? sEmail : "") %>" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password"
                       value="<%= (sPass != null ? sPass : "") %>" required>
            </div>

            <button type="submit" class="btn-submit">
                Save Changes
            </button>

        </form>
    </div>

</main>

</body>
</html>
