<%-- 
    Document   : feeback
    Created on : Dec 31, 2025, 12:48:00 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userID = (String) session.getAttribute("userID");
    String appID = request.getParameter("appointmentID");

    if (userID == null || appID == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback | Counseling System</title>
    <style>
        :root { --primary:#003366; --accent:#0056b3; --bg:#e9eef2; }
        body { margin:0; font-family:sans-serif; background:var(--bg); display:flex; }
        .main-content { flex-grow:1; padding:40px; }
        .card {
            background:white;
            padding:30px;
            border-radius:12px;
            max-width:500px;
            margin:auto;
            box-shadow:0 4px 10px rgba(0,0,0,0.1);
        }
        .form-group { margin-bottom:15px; display:flex; flex-direction:column; }
        input, select, textarea {
            padding:10px;
            border:1px solid #ccc;
            border-radius:5px;
        }
        .btn {
            background:var(--accent);
            color:white;
            padding:12px;
            border:none;
            border-radius:5px;
            cursor:pointer;
            font-weight:bold;
        }
    </style>
</head>
<body>

<div class="main-content">
    <div class="card">
        <h2>Session Feedback</h2>
        <p>Appointment ID: <strong><%= appID %></strong></p>

        <form action="<%= request.getContextPath() %>/SubmitFeedbackServlet" method="POST">

            <input type="hidden" name="appointmentID" value="<%= appID %>">

            <div class="form-group">
                <label>Rating (1-5)</label>
                <select name="rating" required>
                    <option value="">-- Select Rating --</option>
                    <option value="5">5 - Excellent</option>
                    <option value="4">4 - Good</option>
                    <option value="3">3 - Satisfactory</option>
                    <option value="2">2 - Poor</option>
                    <option value="1">1 - Very Poor</option>
                </select>
            </div>

            <div class="form-group">
                <label>Comment</label>
                <textarea name="comment" rows="4" required></textarea>
            </div>

            <button type="submit" class="btn">Submit Feedback</button>
        </form>
    </div>
</div>

</body>
</html>
