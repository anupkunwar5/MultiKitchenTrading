<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.multikitchentrading.models.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Profile - MultiKitchen Trading</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f5f8f5;
        }
        .profile-form-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            border-top: 4px solid #2e8b57;
        }
        .profile-image-container {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-image-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #2e8b57;
            cursor: pointer;
        }
        .btn-primary {
            background-color: #2e8b57;
            border-color: #2e8b57;
        }
        .btn-primary:hover {
            background-color: #267349;
            border-color: #267349;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container mt-4">
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= errorMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <% User user = (User) request.getAttribute("user"); %>
        <% if (user != null) { %>
            <div class="profile-form-container">
                <h2 class="mb-4">Update Profile</h2>
                
                <form action="<%= request.getContextPath() %>/profile/update" method="post" enctype="multipart/form-data">
                    <div class="profile-image-container">
                        <img id="profileImagePreview" 
                             src="<%= user.getProfileImage() == null || user.getProfileImage().isEmpty() ? 
                                   "/assets/images/default-profile.jpg" : user.getProfileImage() %>" 
                             alt="Profile Picture" class="profile-image-preview"
                             onclick="document.getElementById('profileImage').click()">
                        <input type="file" id="profileImage" name="profileImage" accept="image/*" 
                               style="display: none;" onchange="previewImage(this)">
                        <div class="mt-2 text-muted">Click image to change</div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="firstName" class="form-label">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" 
                                   value="<%= user.getFirstName() != null ? user.getFirstName() : "" %>">
                        </div>
                        <div class="col-md-6">
                            <label for="lastName" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" 
                                   value="<%= user.getLastName() != null ? user.getLastName() : "" %>">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" 
                               value="<%= user.getEmail() != null ? user.getEmail() : "" %>">
                    </div>
                    
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" class="form-control" id="phone" name="phone" 
                               value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
                    </div>
                    
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <textarea class="form-control" id="address" name="address" rows="3"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                    </div>
                    
                    <div class="d-flex justify-content-between mt-4">
                        <a href="<%= request.getContextPath() %>/user/profile" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>
        <% } else { %>
            <div class="alert alert-danger">
                User profile not found. Please login again.
            </div>
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    document.getElementById('profileImagePreview').src = e.target.result;
                }
                
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>