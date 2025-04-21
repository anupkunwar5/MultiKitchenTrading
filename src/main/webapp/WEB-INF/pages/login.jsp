<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<jsp:include page="header.jsp" />
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
<div class="login-container">
    <div class="login-box">
        <h2>Login</h2>
        <p class="subheading">Access your account</p>

       

        <form method="post" action="${pageContext.request.contextPath}/login">
            <label>Username</label>
            <input type="text" name="Username" required>

            <label>Password</label>
            <input type="password" name="Password" required>

            <button type="submit">Login</button>
        </form>

        <div class="register-link">
            <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register Now</a></p>
        </div>
    </div>
		    <% String status = (String) request.getAttribute("status"); %>
		<% if (status != null) { %>
		    <p style="color:red;"><%= status %></p>
		<% } %>
		    
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
