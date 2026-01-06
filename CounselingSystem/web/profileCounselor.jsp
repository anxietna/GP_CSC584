<%-- 
    Document   : profileCounselor
    Created on : Dec 31, 2025, 3:16:07 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String counselorID = (String) session.getAttribute("userID");
    String name = (String) session.getAttribute("userName");

    String cName = (String) request.getAttribute("cName");
    String cEmail = (String) request.getAttribute("cEmail");
    String cPass = (String) request.getAttribute("cPass");
    String cSpec = (String) request.getAttribute("cSpec");
    String cOffice = (String) request.getAttribute("cOffice");

    if (counselorID == null) {
        response.sendRedirect("login.jsp?error=login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Counseling System</title>
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

        .main-content { 
            flex-grow: 1; 
            padding: 40px; 
            margin-left: var(--sidebar-width); 
        }
        
        .content-card { 
            background: white; 
            padding: 35px; 
            border-radius: 12px; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.1); 
            border-top: 5px solid var(--accent); 
            max-width: 800px;
        }

        h1 { color: var(--primary); margin: 0 0 10px 0; }
        .subtitle { color: #666; margin-bottom: 30px; }

        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-group { margin-bottom: 20px; }
        .full-width { grid-column: span 2; }

        label { display: block; font-weight: bold; color: var(--primary); margin-bottom: 8px; font-size: 0.9em; }
        input { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 1em; box-sizing: border-box; }
        input:focus { border-color: var(--accent); outline: none; }
        input[readonly] { background-color: #f8f9fa; cursor: not-allowed; }

        .btn-save { background-color: var(--accent); color: white; border: none; padding: 15px 30px; border-radius: 6px; font-weight: bold; cursor: pointer; transition: 0.3s; margin-top: 10px; }
        .btn-save:hover { background-color: var(--primary); }

        .status { padding: 15px; border-radius: 6px; margin-bottom: 20px; font-weight: bold; }
        .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>

<nav class="sidebar">
    <h2>Counselor Panel</h2>
    <a href="DashboardCounselorServlet">Dashboard</a>
    <a href="ViewCounselorAppointmentsServlet">Student Appointments</a>
    <a href="StudentListServlet">Student List</a>
    <a href="ViewFeedbackServlet">View Feedback</a>
    <a href="ProfileCounselorServlet" class="active">My Profile</a>

    <div class="user-info">
        <p><strong>ID:</strong> <%= (counselorID != null) ? counselorID : "Not Available" %></p>
        <p><strong>Counselor:</strong> <%= (name != null) ? name : "Guest" %></p>
        <a href="LogoutServlet" class="logout-btn">Logout</a>
    </div>
</nav>

<main class="main-content">
    <div class="content-card">
        <h1>Personal Settings</h1>
        <p class="subtitle">Update your profile information and account credentials.</p>

        <% if ("success".equals(request.getParameter("update"))) { %>
            <div class="status success">✓ Profile updated successfully!</div>
        <% } %>

        <form action="ProfileCounselorServlet" method="POST">
            <div class="form-grid">
                <div class="form-group">
                    <label>Counselor ID</label>
                    <input type="text" value="<%= counselorID %>" readonly>
                </div>

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" value="<%= (cName != null ? cName : "") %>" required>
                </div>

                <div class="form-group full-width">
                    <label>Email Address</label>
                    <input type="email" name="email" value="<%= (cEmail != null ? cEmail : "") %>" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" value="<%= (cPass != null ? cPass : "") %>" required>
                </div>

                <div class="form-group">
                    <label>Specialization</label>
                    <input type="text" name="specialization" value="<%= (cSpec != null ? cSpec : "") %>">
                </div>

                <div class="form-group full-width">
                    <label>Office Location</label>
                    <input type="text" name="office" value="<%= (cOffice != null ? cOffice : "") %>">
                </div>
            </div>

            <button type="submit" class="btn-save">Save Profile Changes</button>
        </form>
    </div>
</main>

</body>
</html>