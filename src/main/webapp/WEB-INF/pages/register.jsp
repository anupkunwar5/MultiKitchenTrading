<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<jsp:include page="header.jsp" />
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>
<div class="register-wrapper">
    <div class="register-card">
        <h1>Create Account</h1>
        <p class="subtitle">Sign up to get started</p>

        <form method="post" action="register">
            <input type="text" name="Username" placeholder="Username" required>
            <input type="email" name="Email" placeholder="Email address" required>
            <input type="password" name="Password" placeholder="Password" required>
            <button type="submit">Register</button>
        </form>

        <div class="login-link">
            <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
        </div>

    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
