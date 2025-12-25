<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | Counseling System</title>
<style>
    /* Base Page Styling */
    body {
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #f0f4fa; /* Light soft blue */
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        padding: 20px;
    }

    .system-title {
        font-size: 2rem;
        font-weight: 600;
        color: #003366;
        margin-bottom: 8px;
        text-align: center;
    }

    .welcome-message {
        font-size: 1.05rem;
        color: #444;
        margin-bottom: 30px;
        text-align: center;
    }

    .login-container {
        background: #ffffff;
        width: 350px;
        padding: 35px 30px;
        border-radius: 10px;
        box-shadow: 0 6px 15px rgba(0,0,0,0.15);
        animation: fadeIn 0.6s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
        font-weight: 500;
        color: #003366;
    }

    .form-group {
        margin-bottom: 18px;
    }

    label {
        font-size: 0.9rem;
        font-weight: 500;
        color: #333;
        display: block;
        margin-bottom: 6px;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #c7c7c7;
        border-radius: 5px;
        transition: 0.3s;
        box-sizing: border-box;
    }

    input:focus {
        outline: none;
        border-color: #0056b3;
    }

    .role-group {
        border: 1px dashed #cccccc;
        padding: 12px;
        border-radius: 5px;
        background: #f9fafc;
        margin-bottom: 20px;
    }

    .role-group label {
        margin-right: 12px;
        font-weight: normal;
    }

    button {
        width: 100%;
        padding: 12px;
        background-color: #0056b3;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: 0.25s;
    }

    button:hover {
        background-color: #003f80;
    }

    .register-link {
        margin-top: 20px;
        text-align: center;
        font-size: 0.9rem;
    }

    .register-link a {
        color: #0056b3;
        text-decoration: none;
        font-weight: 600;
    }

    .register-link a:hover {
        text-decoration: underline;
    }

    .error-message {
        color: #cc0000;
        margin-bottom: 15px;
        text-align: center;
    }
</style>
</head>
<body>

<div class="system-title">Counseling System</div>
<div class="welcome-message">Please log in to continue</div>

<div class="login-container">
    <% String error = request.getParameter("error"); 
       if(error != null) { %>
        <div class="error-message">
            <% if(error.equals("invalid")) { %>
                Invalid username, password, or role!
            <% } else { %>
                Server error. Try again later.
            <% } %>
        </div>
    <% } %>

    <form action="LoginServlet" method="POST">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>

        <div class="role-group">
            <label style="font-weight:bold; display:block; margin-bottom:8px;">Login As:</label>
            <label><input type="radio" name="userRole" value="Student" checked> Student</label>
            <label><input type="radio" name="userRole" value="Counselor"> Counselor</label>
        </div>

        <button type="submit">Log In</button>
    </form>

    <div class="register-link">
        Don't have an account? <a href="register.jsp">Register Here</a>
    </div>
</div>

</body>
</html>
