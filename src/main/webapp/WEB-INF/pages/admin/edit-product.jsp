<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.multikitchentrading.models.Product, com.multikitchentrading.models.Category" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product - MultiKitchen Trading</title>
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
        
        /* Image preview */
        .image-preview {
            width: 100%;
            height: 200px;
            border: 1px dashed #ccc;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            background-color: #f8f9fa;
        }
        
        .image-preview img {
            max-width: 100%;
            max-height: 100%;
        }
        
        .image-preview-text {
            color: #6c757d;
            text-align: center;
            padding: 20px;
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
                        <li class="breadcrumb-item"><a href="manage-products">Products</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Edit Product</li>
                    </ol>
                </nav>
            </div>
            
            <!-- Page heading -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h3 text-green"><i class="fas fa-edit me-2"></i>Edit Product</h1>
            </div>
            
            <div class="row">
                <div class="col-md-8">
                    <!-- Edit Product Form -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Product Information</h5>
                        </div>
                        <div class="card-body">
                            <!-- Display error message if any -->
                            <% if(request.getAttribute("errorMessage") != null) { %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <%= request.getAttribute("errorMessage") %>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            <% } %>
                            
                            <% 
                            Product product = (Product) request.getAttribute("product");
                            if (product == null) {
                                response.sendRedirect(request.getContextPath() + "/admin/products");
                                return;
                            }
                            %>
                            
                            <form action="${pageContext.request.contextPath}/admin/edit-product" method="post">
                                <input type="hidden" name="id" value="<%= product.getProductId() %>">
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="name" class="form-label">Product Name <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="name" name="name" 
                                                   value="<%= product.getName() %>" required>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="price" class="form-label">Price <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <span class="input-group-text">$</span>
                                                <input type="number" step="0.01" class="form-control" id="price" 
                                                       name="price" value="<%= product.getPrice() %>" required>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="stock_quantity" class="form-label">Stock Quantity</label>
                                            <input type="number" class="form-control" id="stock_quantity" 
                                                   name="stock_quantity" value="<%= product.getStockQuantity() %>">
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="category_id" class="form-label">Category <span class="text-danger">*</span></label>
                                            <select class="form-select" id="category_id" name="category_id" required>
                                                <option value="">Select a category</option>
                                                <% 
                                                List<Category> categories = (List<Category>) request.getAttribute("categories");
                                                if (categories != null) {
                                                    for (Category category : categories) { 
                                                %>
                                                    <option value="<%= category.getCategoryId() %>" 
                                                        <%= category.getCategoryId() == product.getCategoryId() ? "selected" : "" %>>
                                                        <%= category.getName() %>
                                                    </option>
                                                <% 
                                                    }
                                                } 
                                                %>
                                            </select>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label class="form-label">Status</label>
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="is_active" 
                                                       name="is_active" <%= product.isActive() ? "checked" : "" %>>
                                                <label class="form-check-label" for="is_active">Active</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="4"><%= 
                                        product.getDescription() != null ? product.getDescription() : "" 
                                    %></textarea>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="image_url" class="form-label">Image URL</label>
                                    <input type="text" class="form-control" id="image_url" name="image_url" 
                                           value="<%= product.getImageUrl() != null ? product.getImageUrl() : "" %>" 
                                           placeholder="https://example.com/image.jpg">
                                    
                                    <div class="image-preview mt-2" id="imagePreview">
                                        <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
                                            <img src="<%= product.getImageUrl() %>" alt="Product preview">
                                        <% } else { %>
                                            <div class="image-preview-text">Image preview will appear here</div>
                                        <% } %>
                                    </div>
                                </div>
                                
                                <div class="d-flex justify-content-between">
                                    <a href="manage-products" class="btn btn-outline-secondary">
                                        <i class="fas fa-arrow-left me-1"></i> Back to Products
                                    </a>
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-save me-1"></i> Update Product
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <!-- Product details card -->
                    <div class="card bg-light-green">
                        <div class="card-body">
                            <h5 class="card-title text-green"><i class="fas fa-info-circle me-2"></i>Product Details</h5>
                            <ul class="list-group list-group-flush mb-3">
                                <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent">
                                    <span>Product ID:</span>
                                    <span class="fw-bold"><%= product.getProductId() %></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent">
                                    <span>Created On:</span>
                                    <span class="fw-bold">N/A</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent">
                                    <span>Last Updated:</span>
                                    <span class="fw-bold">N/A</span>
                                </li>
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
                                <a href="manage-products" class="list-group-item list-group-item-action d-flex align-items-center">
                                    <i class="fas fa-th-list me-2 text-green"></i> View All Products
                                </a>
                                <a href="add-product" class="list-group-item list-group-item-action d-flex align-items-center">
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
    <script>
        // Image preview functionality
        document.getElementById('image_url').addEventListener('input', function() {
            const preview = document.getElementById('imagePreview');
            const url = this.value.trim();
            
            if (url) {
                preview.innerHTML = `<img src="${url}" alt="Product preview" onerror="this.onerror=null;this.parentElement.innerHTML='<div class=\'image-preview-text\'>Invalid image URL</div>'">`;
            } else {
                preview.innerHTML = '<div class="image-preview-text">Image preview will appear here</div>';
            }
        });
    </script>
</body>
</html>