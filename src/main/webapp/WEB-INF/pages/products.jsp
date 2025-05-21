<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.multikitchentrading.models.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - MultiKitchen Trading</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Include header styles -->
    <style>
        /* Green theme custom styles */
        body {
            background-color: #f9fff9;
            font-family: Arial, sans-serif;
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 15px;
        }
        
        .page-title {
            color: #1e5631;
            margin-bottom: 20px;
            font-weight: bold;
        }
        
        .product-card {
            border: 1px solid #d1e7dd;
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        
        .product-body {
            padding: 15px;
        }
        
        .product-title {
            color: #1e5631;
            font-weight: bold;
            margin-bottom: 10px;
            height: 50px;
            overflow: hidden;
        }
        
        .product-price {
            color: #28a745;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .product-stock {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .btn-add-to-cart {
            background-color: #28a745;
            color: white;
            border: none;
            width: 100%;
            padding: 8px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        
        .btn-add-to-cart:hover {
            background-color: #218838;
        }
        
        .btn-add-to-cart:disabled {
            background-color: #6c757d;
        }
        
        .sort-options {
            margin-bottom: 20px;
            background-color: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .sort-options label {
            margin-right: 10px;
            font-weight: 500;
            color: #1e5631;
        }
        
        .sort-options select {
            padding: 5px 10px;
            border-radius: 4px;
            border: 1px solid #d1e7dd;
        }
        
        .sort-options button {
            background-color: #1e5631;
            color: white;
            border: none;
            padding: 5px 15px;
            border-radius: 4px;
            margin-left: 10px;
        }
        
        .pagination {
            justify-content: center;
            margin-top: 20px;
        }
        
        .page-item.active .page-link {
            background-color: #1e5631;
            border-color: #1e5631;
        }
        
        .page-link {
            color: #1e5631;
        }
        
        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Include the header -->
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <h1 class="page-title"><i class="fas fa-box-open"></i> Our Products</h1>
        
        <!-- Alert messages -->
        <% if(request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= request.getAttribute("errorMessage") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <% if(request.getAttribute("successMessage") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= request.getAttribute("successMessage") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <!-- Sort options -->
        <div class="sort-options">
            <form action="${pageContext.request.contextPath}/products" method="get" class="row g-3 align-items-center">
                <div class="col-md-4">
                    <label for="sortBy"><i class="fas fa-sort"></i> Sort By:</label>
                    <select name="sortBy" id="sortBy" class="form-select">
                        <option value="name_asc" <%= "name_asc".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Name (A-Z)</option>
                        <option value="name_desc" <%= "name_desc".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Name (Z-A)</option>
                        <option value="price_asc" <%= "price_asc".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Price (Low to High)</option>
                        <option value="price_desc" <%= "price_desc".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Price (High to Low)</option>
                        <option value="newest" <%= "newest".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Newest First</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="category"><i class="fas fa-filter"></i> Filter By Category:</label>
                    <select name="category" id="category" class="form-select">
                        <option value="">All Categories</option>
                        <!-- Categories would be populated here -->
                    </select>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-success">Apply</button>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">Reset</a>
                </div>
            </form>
        </div>
        
        <!-- Products Grid -->
        <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
            <% 
            List<Product> products = (List<Product>) request.getAttribute("products");
            if (products == null || products.isEmpty()) { 
            %>
                <div class="col-12">
                    <div class="alert alert-info">No products found.</div>
                </div>
            <% 
            } else { 
                for (Product product : products) { 
            %>
                <div class="col">
                    <div class="product-card">
                        <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "https://via.placeholder.com/300x200?text=No+Image" %>" 
                             alt="<%= product.getName() %>" class="product-image">
                        <div class="product-body">
                            <h5 class="product-title"><%= product.getName() %></h5>
                            <div class="product-price">$<%= String.format("%.2f", product.getPrice()) %></div>
                            <div class="product-stock">
                                <%= product.getStockQuantity() > 0 ? 
                                    "In Stock (" + product.getStockQuantity() + " available)" : 
                                    "Out of Stock" %>
                            </div>
                            <form action="${pageContext.request.contextPath}/cart/add" method="post" class="mt-3">
                                <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                                <% if (product.getStockQuantity() > 0) { %>
                                    <div class="input-group mb-3">
                                        <input type="number" name="quantity" value="1" min="1" 
                                               max="<%= product.getStockQuantity() %>" class="form-control">
                                        <button type="submit" class="btn btn-add-to-cart">
                                            <i class="fas fa-cart-plus"></i> Add to Cart
                                        </button>
                                    </div>
                                <% } else { %>
                                    <button type="button" class="btn btn-add-to-cart" disabled>
                                        <i class="fas fa-times-circle"></i> Out of Stock
                                    </button>
                                <% } %>
                            </form>
                        </div>
                    </div>
                </div>
            <% 
                } 
            } 
            %>
        </div>
        
        <!-- Pagination -->
        <nav aria-label="Product pagination">
            <ul class="pagination">
                <li class="page-item <%= (Integer)request.getAttribute("currentPage") <= 1 ? "disabled" : "" %>">
                    <a class="page-link" href="?page=<%= (Integer)request.getAttribute("currentPage") - 1 %>&sortBy=<%= request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "" %>" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <% 
                int totalPages = (Integer)request.getAttribute("totalPages");
                for (int i = 1; i <= totalPages; i++) { 
                %>
                    <li class="page-item <%= i == (Integer)request.getAttribute("currentPage") ? "active" : "" %>">
                        <a class="page-link" href="?page=<%= i %>&sortBy=<%= request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "" %>"><%= i %></a>
                    </li>
                <% } %>
                <li class="page-item <%= (Integer)request.getAttribute("currentPage") >= totalPages ? "disabled" : "" %>">
                    <a class="page-link" href="?page=<%= (Integer)request.getAttribute("currentPage") + 1 %>&sortBy=<%= request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "" %>" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Quantity validation
        document.querySelectorAll('input[name="quantity"]').forEach(input => {
            input.addEventListener('change', function() {
                const max = parseInt(this.getAttribute('max'));
                if (this.value > max) {
                    this.value = max;
                } else if (this.value < 1) {
                    this.value = 1;
                }
            });
        });
    </script>
</body>
</html>