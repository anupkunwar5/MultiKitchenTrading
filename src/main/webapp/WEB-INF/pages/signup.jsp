<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>MultiKitchenTrading - Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f7f0;
            color: #2e5a2e;
        }
        
        .signup-container {
            max-width: 500px;
            margin: 50px auto;
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
        
        .signup-header {
            border-bottom: 2px solid #c5e1c5;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="signup-container">
            <div class="signup-header">
                <h2 class="text-center mb-3">Create Your Account</h2>
            </div>
            
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger">${errorMessage}</div>
            <% } %>
            
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success">${successMessage}</div>
            <% } %>
            
            <form action="signup" method="post" enctype="multipart/form-data">
                <!-- Image Upload -->
    <div class="mb-3 text-center">
        <label for="profileImage" class="form-label">Profile Image</label>
        <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*" onchange="previewImage(event)">
        <img id="imagePreview" src="#" alt="Image Preview" style="display:none; margin-top: 10px; max-width: 100%; height: auto; border-radius: 5px;" />
    </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="firstName" class="form-label">First Name</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                    </div>
                    <div class="col-md-6">
                        <label for="lastName" class="form-label">Last Name</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                    <div class="form-text">This will be your unique login name</div>
                </div>
                
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="tel" class="form-control" id="phone" name="phone">
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                    <div class="form-text">Use a strong password with at least 8 characters</div>
                </div>
                
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <textarea class="form-control" id="address" name="address" rows="2"></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary w-100">Create Account</button>
            </form>
            
            <div class="mt-3 text-center">
                Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login here</a>
            </div>
        </div>
    </div>
    <script>
    function previewImage(event) {
        const file = event.target.files[0];
        const preview = document.getElementById("imagePreview");

        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.style.display = "block";
            }
            reader.readAsDataURL(file);
        } else {
            preview.style.display = "none";
            preview.src = "#";
        }
    }
</script>
</body>
</html>