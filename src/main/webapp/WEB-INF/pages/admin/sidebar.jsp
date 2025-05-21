<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
  String currentPath = request.getRequestURI();
%>

<!-- Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
  .sidebar {
    height: 100vh;
    width: 250px;
    position: fixed;
    top: 0;
    left: 0;
    background-color: #1e5631;
    color: white;
    display: flex;
    flex-direction: column;
    padding-top: 20px;
    font-family: Arial, sans-serif;
    box-shadow: 3px 0 5px rgba(0, 0, 0, 0.1);
    z-index: 1000;
  }
  .sidebar-header {
    text-align: center;
    margin-bottom: 30px;
    padding: 0 15px;
  }
  .sidebar-header h2 {
    margin-bottom: 5px;
    font-weight: bold;
    font-size: 1.5rem;
    color: #ffffff;
  }
  .sidebar-header p {
    font-size: 0.9rem;
    color: #b8e0c5;
    margin: 0;
  }
  .sidebar-nav {
    display: flex;
    flex-direction: column;
    flex-grow: 1;
  }
  .sidebar-nav a {
    padding: 12px 20px;
    text-decoration: none;
    color: white;
    font-size: 1rem;
    border-left: 4px solid transparent;
    transition: background-color 0.3s, border-left-color 0.3s;
    display: flex;
    align-items: center;
    margin: 2px 0;
  }
  .sidebar-nav a:hover {
    background-color: #28a745;
    border-left-color: #fff;
  }
  .sidebar-nav a.active {
    background-color: #218838;
    border-left-color: #fff;
    font-weight: bold;
  }
  .sidebar-nav a i {
    margin-right: 10px;
    width: 20px;
    text-align: center;
  }
  .sidebar-footer {
    margin-top: auto;
    padding: 15px 0;
    border-top: 1px solid #218838;
  }
  .main-content {
    margin-left: 250px;
    padding: 20px;
    background-color: #f9fff9;
  }
  .user-profile {
    display: flex;
    align-items: center;
    padding: 15px 20px;
    margin-top: auto;
    border-top: 1px solid #218838;
    background-color: #194729;
  }
  .user-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #b8e0c5;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 10px;
    font-weight: bold;
    color: #1e5631;
  }
  .user-info {
    font-size: 0.9rem;
  }
  .user-info .user-name {
    font-weight: bold;
  }
  .user-info .user-role {
    font-size: 0.8rem;
    color: #b8e0c5;
  }
  @media (max-width: 768px) {
    .sidebar { width: 60px; padding-top: 10px; }
    .sidebar-header h2, .sidebar-header p, .user-info, .sidebar-nav a span { display: none; }
    .sidebar-nav a i { margin-right: 0; font-size: 1.2rem; }
    .sidebar-nav a { padding: 15px 0; justify-content: center; }
    .user-avatar { margin-right: 0; }
    .user-profile { justify-content: center; }
    .main-content { margin-left: 60px; }
  }
</style>

<div class="sidebar">
  <div class="sidebar-header">
    <h2>MultiKitchen</h2>
    <p>Trading Platform</p>
  </div>

  <div class="sidebar-nav">
    <a href="/multikitchentrading/admin/dashboard" class="<%= currentPath.endsWith("/dashboard") ? "active" : "" %>">
      <i class="fas fa-tachometer-alt"></i> <span>Dashboard</span>
    </a>
    <a href="/multikitchentrading/admin/manage-products" class="<%= currentPath.contains("/manage-products") ? "active" : "" %>">
      <i class="fas fa-boxes"></i> <span>Manage Products</span>
    </a>
    <a href="/multikitchentrading/admin/add-product" class="<%= currentPath.contains("/add-product") ? "active" : "" %>">
      <i class="fas fa-plus-circle"></i> <span>Add Product</span>
    </a>

    <!-- NEW: Category Section -->
    <a href="/multikitchentrading/admin/manage-category" class="<%= currentPath.contains("/manage-category") ? "active" : "" %>">
      <i class="fas fa-tags"></i> <span>Manage Category</span>
    </a>
    <a href="/multikitchentrading/admin/add-category" class="<%= currentPath.contains("/add-category") ? "active" : "" %>">
      <i class="fas fa-plus"></i> <span>Add Category</span>
    </a>

    <a href="/multikitchentrading/admin/manage-users" class="<%= currentPath.contains("/manage-users") ? "active" : "" %>">
      <i class="fas fa-users"></i> <span>Manage Users</span>
    </a>
    <a href="/multikitchentrading/admin/add-user" class="<%= currentPath.contains("/add-user") ? "active" : "" %>">
      <i class="fas fa-user-plus"></i> <span>Add User</span>
    </a>
    <a href="/multikitchentrading/admin/view-orders" class="<%= currentPath.contains("/view-orders") ? "active" : "" %>">
      <i class="fas fa-shopping-cart"></i> <span>View Orders</span>
    </a>
    <a href="/multikitchentrading/admin/reports" class="<%= currentPath.contains("/reports") ? "active" : "" %>">
      <i class="fas fa-chart-bar"></i> <span>Reports</span>
    </a>
    <a href="/multikitchentrading/admin/settings" class="<%= currentPath.contains("/settings") ? "active" : "" %>">
      <i class="fas fa-cog"></i> <span>Settings</span>
    </a>
  </div>

  <div class="user-profile">
    <div class="user-avatar">
      <%= session.getAttribute("username") != null ? session.getAttribute("username").toString().substring(0, 1).toUpperCase() : "U" %>
    </div>
    <div class="user-info">
      <div class="user-name"><%= session.getAttribute("username") != null ? session.getAttribute("username") : "User" %></div>
      <div class="user-role"><%= session.getAttribute("role") != null ? session.getAttribute("role") : "Admin" %></div>
    </div>
  </div>

  <div class="sidebar-footer">
    <a href="/multikitchentrading/logout">
      <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
    </a>
  </div>
</div>
