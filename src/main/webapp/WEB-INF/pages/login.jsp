<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>MultiKitchenTrading - Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f0f7f0;
        color: #2e5a2e;
    }
    
    .login-container {
        max-width: 400px;
        margin: 100px auto;
        padding: 20px;
        border: 1px solid #c5e1c5;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(40, 167, 69, 0.1);
        background-color: #ffffff;
    }
    
    .btn-primary {
        background-color: #28a745;
        border-color: #28a745;
    }
    
    .btn-primary:hover {
        background-color: #218838;
        border-color: #1e7e34;
    }
    
    h2 {
        color: #28a745;
    }
    
    a {
        color: #28a745;
        text-decoration: none;
    }
    
    a:hover {
        color: #218838;
        text-decoration: underline;
    }
    
    .form-control:focus {
        border-color: #28a745;
        box-shadow: 0 0 0 0.25rem rgba(40, 167, 69, 0.25);
    }
    
    .login-header {
        border-bottom: 2px solid #c5e1c5;
        padding-bottom: 15px;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
<div class="container">
    <div class="login-container">
        <div class="login-header">
            <h2 class="text-center mb-3">MultiKitchen Login</h2>
        </div>

        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger">${errorMessage}</div>
        <% } %>

        <% if (request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success">${successMessage}</div>
        <% } %>

        <form action="login" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>

        <div class="mt-3 text-center">
    		Don't have an account? <a href="${pageContext.request.contextPath}/signup">Sign up</a>
		</div>
    </div>
</div>
</body>
</html>