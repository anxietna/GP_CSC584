<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Registration</title>

    <style>
        /* Base Page Styling */
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4fa;
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
            text-align: center;
            margin-bottom: 8px;
        }

        .welcome-message {
            font-size: 1.05rem;
            color: #444;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Registration Card */
        .register-container {
            background: #ffffff;
            width: 370px;
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
            color: #003366;
            font-weight: 500;
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
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #c7c7c7;
            border-radius: 5px;
            transition: 0.3s;
            box-sizing: border-box;
        }

        input:focus {
            border-color: #0056b3;
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #0056b3;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.25s;
        }

        button:hover {
            background-color: #003f80;
        }

        .login-link {
            margin-top: 20px;
            text-align: center;
            font-size: 0.9rem;
        }

        .login-link a {
            color: #0056b3;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <div class="system-title">Student Counseling Appointment System</div>
    <div class="welcome-message">Create your account to book counseling sessions.</div>

    <div class="register-container">
        <h2>Student Register</h2>

        <form action="RegisterStudentServlet" method="post">

            <div class="form-group">
                <label>Student ID</label>
                <input type="text" name="studentID" required>
            </div>

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="nameStud" required>
            </div>

            <div class="form-group">
                <label>Username</label>
                <input type="text" name="usernameStud" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="passwordStud" required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="emailStud" required>
            </div>

            <div class="form-group">
                <label>Major</label>
                <input type="text" name="majorStud" required>
            </div>

            <button type="submit">Register</button>
        </form>

        <div class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>

</body>
</html>
