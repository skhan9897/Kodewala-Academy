<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Kodewala Academy</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            /* Using your logo as background with dark overlay */
            background: linear-gradient(rgba(13, 27, 62, 0.9), rgba(13, 27, 62, 0.9)), url('images/kodewala.png');
            background-size: cover;
            background-position: center;
            overflow: hidden;
            font-family: 'Arial', sans-serif;
        }

        .main-container {
            position: relative;
            width: 400px;
            height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: spin 5s linear forwards; /* 5 Second Spin */
        }

        /* Transparent Glass Star */
        .transparent-star {
            position: absolute;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            clip-path: polygon(50% 0%, 61% 35%, 98% 35%, 68% 57%, 79% 91%, 50% 70%, 21% 91%, 32% 57%, 2% 35%, 39% 35%);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 50px rgba(251, 192, 45, 0.2);
        }

        .content {
            position: relative;
            z-index: 10;
            text-align: center;
            /* Keeps text readable during spin */
            animation: unspin 5s linear forwards;
        }

        .logo-img {
            width: 180px;
            height: auto;
            filter: drop-shadow(0 0 15px rgba(251, 192, 45, 0.4));
        }

        @keyframes spin {
            from { transform: rotate(0deg) scale(0.5); opacity: 0; }
            20% { transform: rotate(72deg) scale(1); opacity: 1; }
            100% { transform: rotate(360deg) scale(1); }
        }

        /* This keeps the text upright while the star rotates around it */
        @keyframes unspin {
            from { transform: rotate(0deg); }
            to { transform: rotate(-360deg); }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- The Star Background -->
        <div class="transparent-star"></div>

        <!-- Logo inside the Star -->
        <div class="content">
            <img src="images/logo.png" class="logo-img" alt="Logo">
        </div>
    </div>

    <script>
        // Redirect to Login Page after exactly 5 seconds
        setTimeout(function() {
            window.location.href = "login";
        }, 5000);
    </script>
</body>
</html>
