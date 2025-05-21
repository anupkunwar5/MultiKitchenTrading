<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<!-- Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
  .main-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #1e5631;
    padding: 35px 200px;
    color: white;
    font-family: Arial, sans-serif;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  }

  .main-header .logo {
    font-size: 2rem;
    font-weight: bold;
  }

  .main-header .nav-links {
    display: flex;
    gap: 20px;
  }

  .main-header .nav-links a {
    color: white;
    text-decoration: none;
    font-size: 1.2rem;
    display: flex;
    align-items: center;
    transition: color 0.3s;
    gap:10px;
    
  }

  .main-header .nav-links a:hover {
    color: #b8e0c5;
  }

  .main-header .nav-links a i {
    margin-right: 2px;
  }

  @media (max-width: 768px) {
    .main-header {
      flex-direction: column;
      align-items: flex-start;
    }
    .main-header .nav-links {
      flex-direction: column;
      gap: 10px;
      margin-top: 10px;
    }
  }
</style>
<div class="main-header">
  <div class="logo">
    MultiKitchen
  </div>

  <div class="nav-links">
        <a href="/multikitchentrading/home"><i class="fas fa-home"></i>Home</a>
  
    <a href="/multikitchentrading/about"><i class="fas fa-info-circle"></i>About</a>
    <a href="/multikitchentrading/contact"><i class="fas fa-envelope"></i>Contact</a>

    <% if (session.getAttribute("username") != null) { %>
      <a href="/multikitchentrading/cart"><i class="fas fa-shopping-cart"></i>Cart</a>
      <a href="/multikitchentrading/orders"><i class="fas fa-box"></i>Orders</a>
      <a href="/multikitchentrading/profile"><i class="fas fa-user-circle"></i>Profile</a>
      <a href="/multikitchentrading/logout"><i class="fas fa-sign-out-alt"></i>Logout</a>
    <% } else { %>
      <a href="/multikitchentrading/products"><i class="fas fa-box-open"></i>Products</a>
      <a href="/multikitchentrading/login"><i class="fas fa-sign-in-alt"></i>Login</a>
    <% } %>
  </div>
</div>
