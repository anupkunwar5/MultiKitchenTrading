<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Category - MultiKitchen Trading</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* Green theme custom styles */
        body {
            background-color: #f9fff9;
        }
        
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }
        
        .card-header {
            background-color: #1e5631;
            color: white;
            font-weight: 500;
            border-radius: 8px 8px 0 0 !important;
        }
        
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        
        .form-control:focus {
            border-color: #28a745;
            box-shadow: 0 0 0 0.25rem rgba(40, 167, 69, 0.25);
        }
        
        /* Custom breadcrumb styling */
        .breadcrumb-container {
            background-color: white;
            border-radius: 8px;
            padding: 10px 15px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .breadcrumb-item a {
            color: #1e5631;
            text-decoration: none;
        }
        
        .breadcrumb-item.active {
            color: #28a745;
        }
        
        /* Helper classes */
        .text-green {
            color: #28a745;
        }
        
        .bg-light-green {
            background-color: #e8f5e9;
        }
    </style>
</head>
<body>
    <!-- Include the sidebar -->
    <jsp:include page="sidebar.jsp" />
    
    <!-- Main content -->
    <div class="main-content">
        <div class="container-fluid py-4">
            <!-- Breadcrumb navigation -->
            <div class="breadcrumb-container mb-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="manage-categories.jsp">Categories</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Add Category</li>
                    </ol>
                </nav>
            </div>
            
            <!-- Page heading -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h3 text-green"><i class="fas fa-folder-plus me-2"></i>Add New Category</h1>
            </div>
            
            <div class="row">
                <div class="col-md-8">
                    <!-- Add Category Form -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Category Information</h5>
                        </div>
                        <div class="card-body">
                            <!-- Display error message if any -->
                            <% if(request.getAttribute("errorMessage") != null) { %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <%= request.getAttribute("errorMessage") %>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            <% } %>
                            
                            <!-- Display success message if any -->
                            <% if(request.getAttribute("successMessage") != null) { %>
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <%= request.getAttribute("successMessage") %>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            <% } %>
                            
                            <form action="${pageContext.request.contextPath}/admin/add-category" method="post" >
                                <div class="mb-3">
                                    <label for="name" class="form-label">Category Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" required>
                                    <div class="form-text">Enter a unique name for the category.</div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="4"></textarea>
                                    <div class="form-text">Provide a clear description of what products fit in this category.</div>
                                </div>
                                
                                <div class="d-flex justify-content-between">
                                    <a href="manage-categories.jsp" class="btn btn-outline-secondary">
                                        <i class="fas fa-arrow-left me-1"></i> Back to Categories
                                    </a>
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-save me-1"></i> Save Category
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <!-- Tips card -->
                    <div class="card bg-light-green">
                        <div class="card-body">
                            <h5 class="card-title text-green"><i class="fas fa-lightbulb me-2"></i>Tips for Categories</h5>
                            <ul class="mb-0">
                                <li>Create clear, descriptive category names</li>
                                <li>Avoid duplicating existing categories</li>
                                <li>Consider the search experience when naming categories</li>
                                <li>Be consistent with naming conventions</li>
                                <li>Use categories to help organize your inventory</li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Quick actions card -->
                    <div class="card mt-4">
                        <div class="card-header">
                            <h5 class="mb-0">Quick Actions</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="list-group list-group-flush">
                                <a href="manage-categories.jsp" class="list-group-item list-group-item-action d-flex align-items-center">
                                    <i class="fas fa-th-list me-2 text-green"></i> View All Categories
                                </a>
                                <a href="add-product.jsp" class="list-group-item list-group-item-action d-flex align-items-center">
                                    <i class="fas fa-plus-circle me-2 text-green"></i> Add New Product
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>