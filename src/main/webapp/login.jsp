<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Kodewala Academy Login</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            text-align: center;
        }
        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: #FBC02D;
            font-weight: bold;
            font-size: 14px;
        }
        .input-group input {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            background: rgba(255, 255, 255, 0.05);
            color: white;
            outline: none;
        }
        .input-group input:focus {
            border-color: #FBC02D;
        }
        .error-msg {
            color: #E53935;
            font-size: 13px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>KODEWALA ACADEMY</h1>
    </div>

    <div class="login-container">
        <h2 style="color: white; margin-bottom: 30px;">Admin Login</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-msg"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="login" method="post">
            <div class="input-group">
                <label>Admin ID</label>
                <input type="text" name="adminId" placeholder="Enter Admin ID" required>
            </div>
            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter Password" required>
            </div>
            <button type="submit" class="btn btn-approve" style="width: 100%; margin-top: 10px;">LOGIN</button>
        </form>
    </div>
</body>
</html>
