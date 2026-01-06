<%-- 
    Document   : logout
    Created on : Dec 31, 2025, 3:12:36 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // This removes the user data from the session
    if (session != null) {
        session.invalidate();
    }
    // This redirects back to your login page
    response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logging out...</title>
    </head>
    <body>
        <p>Redirecting to login page...</p>
    </body>
</html>