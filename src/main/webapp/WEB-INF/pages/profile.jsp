<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.multikitchentrading.models.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile - MultiKitchen Trading</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f8f5;
        }
        .profile-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            border-top: 4px solid #2e8b57;
        }
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }
        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #2e8b57;
            margin-right: 30px;
        }
        .profile-name {
            color: #2e8b57;
        }
        .profile-details {
            margin-top: 20px;
        }
        .btn-primary {
            background-color: #2e8b57;
            border-color: #2e8b57;
        }
        .btn-primary:hover {
            background-color: #267349;
            border-color: #267349;
        }
        .detail-label {
            font-weight: bold;
            color: #666;
        }
        .detail-value {
            padding-left: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container mt-4">
        <!-- Display messages -->
        <% String successMessage = (String) request.getAttribute("successMessage"); %>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        
        <% if (successMessage != null && !successMessage.isEmpty()) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= successMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= errorMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <% User user = (User) request.getAttribute("user"); %>
        <% if (user != null) { %>
            <div class="profile-container">
                <div class="profile-header">
                    <img src="<%= user.getProfileImage() == null || user.getProfileImage().isEmpty() ? 
                                "/assets/images/default-profile.jpg" : user.getProfileImage() %>" 
                         alt="Profile Picture" class="profile-image">
                    <div>
                        <h2 class="profile-name"><%= user.getFirstName() %> <%= user.getLastName() %></h2>
                        <p class="text-muted"><%= user.getUsername() %></p>
                        <a href="<%= request.getContextPath() %>/profile/edit" class="btn btn-primary">
                            <i class="bi bi-pencil"></i> Edit Profile
                        </a>
                    </div>
                </div>
                
                <div class="profile-details">
                    <div class="row mb-3">
                        <div class="col-md-3 detail-label">Email:</div>
                        <div class="col-md-9 detail-value"><%= user.getEmail() %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-3 detail-label">Phone:</div>
                        <div class="col-md-9 detail-value"><%= user.getPhone() %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-3 detail-label">Address:</div>
                        <div class="col-md-9 detail-value"><%= user.getAddress() %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-3 detail-label">Account Type:</div>
                        <div class="col-md-9 detail-value"><%= user.isAdmin() ? "Administrator" : "Customer" %></div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 detail-label">Member Since:</div>
                        <div class="col-md-9 detail-value"><%= user.getCreatedAt() %></div>
                    </div>
                </div>
            </div>
        <% } else { %>
            <div class="alert alert-danger">
                User profile not found.
            </div>
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>