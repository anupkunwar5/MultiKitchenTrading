<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
</head>
<body>
    <div class="navbar">
        <div class="logo">MySite</div>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
            <li><a href="${pageContext.request.contextPath}/portfolio">Portfolio</a></li>
            <li><a href="${pageContext.request.contextPath}/product">Product</a></li>
            <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
            <li>
                <a href="${pageContext.request.contextPath}/cart" title="Cart">🛒</a>
            </li>
        </ul>
    </div>
</body>
</html>
